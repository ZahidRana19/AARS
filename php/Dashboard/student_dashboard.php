<?php
header('Content-Type: application/json');
session_start();

require_once '../database.php';

if (!isset($_SESSION['user_id'])) {
    echo json_encode([
        'success' => false,
        'message' => 'User not authenticated',
        'redirect' => '../html/login.html'
    ]);
    exit;
}

if ($_SESSION['role'] !== 'Student') {
    echo json_encode([
        'success' => false,
        'message' => 'Access denied - Students only',
        'redirect' => '../html/login.html'
    ]);
    exit;
}

try {
    $db = Database::getInstance()->getConnection();
    $userId = $_SESSION['user_id'];
    
    $stmt = $db->prepare("
        SELECT 
            p.PersonID, p.FirstName, p.MiddleName, p.LastName, p.Email, p.Username,
            s.StudentID, s.CGPA,
            d.DeptName,
            COUNT(e.S_ID) as enrolledCourses
        FROM Persons p
        JOIN student s ON p.PersonID = s.P_ID
        LEFT JOIN Department d ON s.D_ID = d.DeptID
        LEFT JOIN enrollment e ON s.StudentID = e.S_ID
        WHERE p.PersonID = ?
        GROUP BY p.PersonID
    ");
    $stmt->execute([$userId]);
    $userData = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$userData) {
        throw new Exception("Student data not found");
    }

    $coursesStmt = $db->prepare("
        SELECT c.CourseCode, c.CourseName, c.Credits, 
               sec.SectionNo
        FROM enrollment e
        JOIN section sec ON e.SecID = sec.SectionNo AND e.CourseID = sec.CourseID
        JOIN course c ON sec.CourseID = c.CourseCode
        WHERE e.S_ID = ?
    ");
    $coursesStmt->execute([$userData['StudentID']]);
    $enrolledCourses = $coursesStmt->fetchAll(PDO::FETCH_ASSOC);

    $response = [
        'success' => true,
        'userData' => [
            'id' => $userData['PersonID'],
            'name' => trim("{$userData['FirstName']} {$userData['MiddleName']} {$userData['LastName']}"),
            'email' => $userData['Email'],
            'username' => $userData['Username'],
            'studentId' => $userData['StudentID'],
            'department' => $userData['DeptName'],
            'cgpa' => $userData['CGPA'],
            'enrolledCourses' => $userData['enrolledCourses'],
            'courses' => $enrolledCourses
        ]
    ];

} catch (Exception $e) {
    $response = [
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ];
    error_log("Student Dashboard Error: " . $e->getMessage());
}

echo json_encode($response);
exit;
?>