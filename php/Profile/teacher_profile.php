<?php
header('Content-Type: application/json');
session_start();

require_once '../database.php';
require_once 'realProfile.php';
require_once 'teacherProxy.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'Teacher') {
    echo json_encode([
        'success' => false,
        'message' => 'Access denied',
        'redirect' => '../html/login.html'
    ]);
    exit;
}

try {
    $realSubject = new RealProfile($_SESSION['user_id'], 'Teacher');
    $proxy = new TeacherProfileProxy($realSubject);
    
    $teacherData = $proxy->getProfileData();

    if (!$teacherData) {
        throw new Exception("Teacher data not found");
    }
    
    $response = [
        'success' => true,
        'teacher' => $teacherData
    ];

    if (empty($teacherData['Department'])) {
        $response['departments'] = $proxy->getDepartments();
    }

} catch (Exception $e) {
    $response = [
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ];
    error_log("Teacher Profile Error: " . $e->getMessage());
}

echo json_encode($response);
exit;