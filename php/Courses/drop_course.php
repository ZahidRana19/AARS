<?php
header('Content-Type: application/json');
require_once '../database.php';

session_start();
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Not logged in']);
    exit;
}

$db = Database::getInstance()->getConnection();
$data = json_decode(file_get_contents('php://input'), true);
$courseCode = $data['courseCode'] ?? null;
$sectionNo = $data['sectionNo'] ?? null;
$userId = $_SESSION['user_id'];

if (!$courseCode || !$sectionNo) {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
    exit;
}

try {
    $db->beginTransaction();

    $stmt = $db->prepare("SELECT StudentID FROM student WHERE P_ID = ?");
    $stmt->execute([$userId]);
    $studentId = $stmt->fetchColumn();

    if (!$studentId) {
        throw new Exception("Student data not found");
    }
    
    $query = "DELETE FROM enrollment 
              WHERE S_ID = :studentId AND CourseID = :courseCode AND SecID = :sectionNo";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':studentId', $studentId);
    $stmt->bindParam(':courseCode', $courseCode);
    $stmt->bindParam(':sectionNo', $sectionNo);
    $stmt->execute();
    
    if ($stmt->rowCount() === 0) {
        throw new Exception('You are not enrolled in this course');
    }
    
    $query = "DELETE FROM takes 
              WHERE S_ID = :studentId AND CourseID = :courseCode AND SecID = :sectionNo";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':studentId', $studentId);
    $stmt->bindParam(':courseCode', $courseCode);
    $stmt->bindParam(':sectionNo', $sectionNo);
    $stmt->execute();

    $query = "UPDATE section SET SeatsTaken = SeatsTaken - 1 WHERE CourseID = :courseCode AND SectionNo = :sectionNo";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':courseCode', $courseCode);
    $stmt->bindParam(':sectionNo', $sectionNo);
    $stmt->execute();
    
    
    $db->commit();
    
    echo json_encode([
        'status' => 'success',
        'message' => 'Course dropped successfully'
    ]);
    
} catch (Exception $e) {
    $db->rollBack();
    echo json_encode([
        'status' => 'error',
        'message' => 'Failed to drop course: ' . $e->getMessage()
    ]);
}
?>