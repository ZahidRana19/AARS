<?php
header('Content-Type: application/json');
require_once '../database.php';
require_once 'ProfileProxy.php';

if (!isset($_GET['department'])) {
    echo json_encode(['success' => false, 'message' => 'Department not specified']);
    exit;
}

try {
    $proxy = new StudentProfileProxy(0, 'Student');
    $majors = $proxy->getMajorsByDepartment($_GET['department']);
    
    echo json_encode([
        'success' => true,
        'majors' => $majors
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ]);
}