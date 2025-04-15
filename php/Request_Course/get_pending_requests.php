<?php
require_once '../database.php';
header("Content-Type: application/json");

$db = Database::getInstance()->getConnection();
$departmentFilter = $_GET['department'] ?? 'all';

$sql = "SELECT rs.CourseID AS course_code, c.CourseName AS course_title, rs.SectionNo AS section_no, 
        p.FirstName as facultyName, d.DeptName AS department, rs.T_ID AS teacher_id
        FROM requested_sections AS rs 
        LEFT JOIN course AS c ON rs.CourseID = c.CourseCode
        LEFT JOIN teacher AS t ON rs.T_ID = t.TeacherID
        LEFT JOIN persons AS p ON t.P_ID = p.PersonID
        LEFT JOIN department AS d ON t.D_ID = d.DeptID";

if ($departmentFilter !== 'all') {
    $sql .= " WHERE d.DeptID = ?";
    $stmt = $db->prepare($sql);
    $stmt->execute([$departmentFilter]);
} else {
    $stmt = $db->prepare($sql);
    $stmt->execute();
}

$requests = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($requests);