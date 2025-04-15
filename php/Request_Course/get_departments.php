<?php
require_once '../database.php';
header("Content-Type: application/json");

$db = Database::getInstance()->getConnection();

$stmt = $db->query("SELECT DeptID, DeptName FROM department");
$departments = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($departments);