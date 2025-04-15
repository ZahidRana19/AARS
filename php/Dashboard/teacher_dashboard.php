<?php
header('Content-Type: application/json');
session_start();

require_once '../database.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'Teacher') {
    echo json_encode([
        'success' => false,
        'message' => 'Access denied - Teachers only',
        'redirect' => '../html/login.html'
    ]);
    exit;
}

try {
    $db = Database::getInstance()->getConnection();
    $userId = $_SESSION['user_id'];
    
    // Get teacher profile
    $stmt = $db->prepare("
        SELECT 
            p.PersonID, p.FirstName, p.MiddleName, p.LastName, p.Email, p.Username,
            t.TeacherID,
            d.DeptName
        FROM Persons p
        JOIN teacher t ON p.PersonID = t.P_ID
        LEFT JOIN Department d ON t.D_ID = d.DeptID
        WHERE p.PersonID = ?
    ");
    $stmt->execute([$userId]);
    $teacher = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$teacher) {
        throw new Exception("Teacher profile not found");
    }

    // Get assigned courses
    $stmt = $db->prepare("
        SELECT 
            c.CourseCode, c.CourseName, ac.SecID,
            COUNT(e.S_ID) as StudentCount
        FROM assigned_courses ac
        JOIN Course c ON ac.CourseID = c.CourseCode
        LEFT JOIN Enrollment e ON ac.CourseID = e.CourseID 
            AND ac.SecID = e.SecID
        WHERE ac.T_ID = ?
        GROUP BY c.CourseCode, c.CourseName, ac.SecID
    ");
    $stmt->execute([$teacher['TeacherID']]);
    $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Get pending requests
    $stmt = $db->prepare("
        SELECT COUNT(*) as pendingRequests 
        FROM requested_sections 
        WHERE T_ID = ?
    ");
    $stmt->execute([$teacher['TeacherID']]);
    $pending = $stmt->fetch(PDO::FETCH_ASSOC);

    $response = [
        'success' => true,
        'userData' => [
            'id' => $teacher['PersonID'],
            'name' => trim("{$teacher['FirstName']} {$teacher['MiddleName']} {$teacher['LastName']}"),
            'email' => $teacher['Email'],
            'username' => $teacher['Username'],
            'teacherId' => $teacher['TeacherID'],
            'department' => $teacher['DeptName'],
            'assignedCourses' => count($courses),
            'pendingRequests' => $pending['pendingRequests'] ?? 0,
            'courses' => $courses
        ]
    ];

} catch (Exception $e) {
    $response = [
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ];
    error_log("Teacher Dashboard Error: " . $e->getMessage());
}

echo json_encode($response);
exit;
?>