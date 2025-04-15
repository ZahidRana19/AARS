<?php
header('Content-Type: application/json');
session_start();

require_once 'enrollmentFacade.php';
require_once '../database.php';

try {
    $db = Database::getInstance()->getConnection();
    $userId = $_SESSION['user_id'];
    
    $stmt = $db->prepare("SELECT StudentID FROM student WHERE P_ID = ?");
    $stmt->execute([$userId]);
    $studentId = $stmt->fetchColumn();

    if (!$studentId) {
        throw new Exception("Student data not found");
    }
    
    $facade = new EnrollmentFacade($studentId);
    $courses = $facade->getAvailableCourses();
    
    echo json_encode($courses);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
?>