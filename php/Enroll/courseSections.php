<?php
header('Content-Type: application/json');

require_once '../database.php';

try {
    $courseCode = $_GET['courseCode'] ?? '';
    
    $db = Database::getInstance()->getConnection();
    $stmt = $db->prepare(
        "SELECT * FROM section 
         WHERE CourseID = ?
         ORDER BY SectionNo"
    );
    $stmt->execute([$courseCode]);
    $sections = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode($sections);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
?>