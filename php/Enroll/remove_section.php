<?php
header('Content-Type: application/json');
session_start();

require_once 'enrollmentFacade.php';
require_once '../database.php';

try {
    $data = json_decode(file_get_contents('php://input'), true);
    $db = Database::getInstance()->getConnection();
    $userId = $_SESSION['user_id'];
    $roleName = $_SESSION['role'];
    
    if($roleName === 'Student') {
        $stmt = $db->prepare("SELECT StudentID FROM student WHERE P_ID = ?");
        $stmt->execute([$userId]);
        $studentId = $stmt->fetchColumn();

        if (!$studentId) {
            throw new Exception("Student data not found");
        }
        
        $facade = new EnrollmentFacade($studentId);
    } else if($roleName === 'Teacher') {
        $stmt = $db->prepare("SELECT TeacherID FROM teacher WHERE P_ID = ?");
        $stmt->execute([$userId]);
        $teacherId = $stmt->fetchColumn();

        if (!$teacherId) {
            throw new Exception("Teacher data not found");
        }
        
        $facade = new EnrollmentFacade($teacherId);
    }
    
    $result = $facade->removeSection($data['sectionCode'], $data['sectionNo']);
    
    echo json_encode($result);
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>