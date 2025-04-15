<?php
header('Content-Type: application/json');
session_start();

require_once '../database.php';

try {
    $db = Database::getInstance()->getConnection();
    $userId = $_SESSION['user_id'];
    
    $stmt = $db->prepare("SELECT s.StudentID FROM student s WHERE P_ID = ?");
    $stmt->execute([$userId]);
    $studentId = $stmt->fetchColumn();

    if (!$studentId) {
        throw new Exception("Student data not found");
    }
    
    $stmt = $db->prepare(
        "SELECT s.* FROM selectedsections ss
         JOIN section s ON ss.CourseID = s.CourseID AND ss.SectionNo = s.SectionNo
         WHERE ss.S_ID = ?"
    );
    $stmt->execute([$studentId]);
    $sections = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode($sections);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
?>