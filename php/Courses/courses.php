<?php
header('Content-Type: application/json');
require_once '../database.php';

session_start();
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Not logged in']);
    exit;
}

$db = Database::getInstance()->getConnection();
$userId = $_SESSION['user_id'];

try {
    $stmt = $db->prepare("SELECT StudentID FROM student WHERE P_ID = ?");
    $stmt->execute([$userId]);
    $studentId = $stmt->fetchColumn();

    if (!$studentId) {
        throw new Exception("Student data not found");
    }

    $stmt = $db->prepare("
    SELECT 
        c.CourseCode,
        c.CourseName,
        c.Credits,
        e.SecID AS SectionNo,
        CONCAT(p.FirstName, ' ', COALESCE(p.MiddleName, ''), ' ', p.LastName) AS InstructorName
    FROM 
        enrollment e
    LEFT JOIN 
        course c ON e.CourseID = c.CourseCode
    LEFT JOIN 
        assigned_courses ac ON e.CourseID = ac.CourseID AND e.SecID = ac.SecID
    LEFT JOIN 
        teacher t ON ac.T_ID = t.TeacherID
    LEFT JOIN 
        persons p ON t.P_ID = p.PersonID
    WHERE 
        e.S_ID = ?
    ");
    $stmt->execute([$studentId]);
    
    $courses = [];
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $row['InstructorName'] = preg_replace('/\s+/', ' ', trim($row['InstructorName']));
        $courses[] = $row;
    }
    
    echo json_encode([
        'status' => 'success',
        'courses' => $courses
    ]);
    
} catch (PDOException $e) {
    echo json_encode([
        'status' => 'error',
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
?>