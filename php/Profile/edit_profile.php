<?php
header('Content-Type: application/json');
session_start();

require_once '../database.php';
require_once 'realProfile.php';
require_once 'teacherProxy.php';
require_once 'studentProxy.php';

// authentication check
if (!isset($_SESSION['user_id']) || !isset($_SESSION['role'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Unauthorized',
        'redirect' => '../html/login.html'
    ]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
}

// Get input data
$input = json_decode(file_get_contents('php://input'), true);
$updates = $input['updates'] ?? [];

if (empty($updates)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'No updates provided']);
    exit;
}

try {
    $realSubject = new RealProfile($_SESSION['user_id'], $_SESSION['role']);
    
    if ($_SESSION['role'] === 'Teacher') {
        $proxy = new TeacherProfileProxy($realSubject);
    } else {
        $proxy = new StudentProfileProxy($realSubject);
    }
    
    $result = $proxy->updateProfile($updates);
    echo json_encode($result);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}