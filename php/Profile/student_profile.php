<?php
header('Content-Type: application/json');
session_start();

require_once '../database.php';
require_once 'realProfile.php';
require_once 'studentProxy.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'Student') {
    echo json_encode([
        'success' => false,
        'message' => 'Access denied',
        'redirect' => '../html/login.html'
    ]);
    exit;
}

try {
    $realSubject = new RealProfile($_SESSION['user_id'], 'Student');
    $proxy = new StudentProfileProxy($realSubject);
    
    $studentData = $proxy->getProfileData();

    if (!$studentData) {
        throw new Exception("Student data not found");
    }
    
    $response = [
        'success' => true,
        'student' => $studentData
    ];

    if (empty($studentData['Department'])) {
        $response['departments'] = $proxy->getDepartments();
    }
    
    if (!empty($studentData['Department']) && empty($studentData['Major'])) {
        $response['majors'] = $proxy->getMajorsByDepartment($studentData['Department']);
    }

} catch (Exception $e) {
    $response = [
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ];
    error_log("Student Profile Error: " . $e->getMessage());
}

echo json_encode($response);
exit;