<?php
require_once '../database.php';
header("Content-Type: application/json");

$db = Database::getInstance()->getConnection();

$input = json_decode(file_get_contents('php://input'), true);

error_log("Received input: " . print_r($input, true));

$decision = $input['decision'] ?? null;
$courseCode = $input['course_code'] ?? null;
$sectionNo = $input['section_no'] ?? null;
$teacherId = $input['teacher_id'] ?? null;

if (!$decision || !$courseCode || !$sectionNo || !$teacherId) {
    error_log("Missing required fields");
    echo json_encode([
        'status' => 'error', 
        'message' => 'Invalid input',
        'received_data' => $input
    ]);
    exit;
}

try {
    $db->beginTransaction();
    
    if($decision === 'decline') {
        $stmt = $db->prepare("
            DELETE FROM requested_sections 
            WHERE CourseID = ? AND SectionNo = ? AND T_ID = ?
        ");
        $stmt->execute([$courseCode, $sectionNo, $teacherId]);
    }

    if ($decision === 'approve') {
        $insertStmt = $db->prepare("
            INSERT INTO assigned_courses (CourseID, SecID, T_ID)
            VALUES (?, ?, ?)
        ");
        $insertStmt->execute([$courseCode, $sectionNo, $teacherId]);
        
        if ($insertStmt->rowCount() === 0) {
            throw new PDOException("Failed to assign course");
        }

        $stmt = $db->prepare("
            DELETE FROM requested_sections 
            WHERE CourseID = ? AND SectionNo = ? AND T_ID = ?
        ");
        $stmt->execute([$courseCode, $sectionNo, $teacherId]);
    }

    $db->commit();
    echo json_encode([
        'status' => 'success',
        'action' => $decision,
        'course' => $courseCode,
        'section' => $sectionNo
    ]);
    
} catch (PDOException $e) {
    $db->rollBack();
    error_log("Database error: " . $e->getMessage());
    echo json_encode([
        'status' => 'error', 
        'message' => 'Database operation failed',
        'error_details' => $e->getMessage()
    ]);
}