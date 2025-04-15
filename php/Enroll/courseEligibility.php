<?php
require_once '../database.php';

class CourseEligibility {
    private $db;
    private $userId;
    private $roleName;

    public function __construct($db, $userId) {
        $this->db = $db;
        $this->userId = $userId;
        $this->roleName = $_SESSION['role'];
    }

    public function getEligibleCourses() {
        if($this->roleName === 'Student') {
            $studentInfo = $this->getStudentInfo();

            $dId = $studentInfo['D_ID'] ?? null;
            $mId = $studentInfo['M_ID'] ?? null;
        } else if($this->roleName === 'Teacher') {
            $teacherInfo = $this->getTeacherInfo();

            $dId = $teacherInfo['D_ID'] ?? null;
            $mId = 0;
        }

        $query = "SELECT c.* FROM course c WHERE ";
        $conditions = ["(c.D_ID IS NULL AND c.M_ID IS NULL)"];
        $params = [];
        
        if ($dId) {
            $conditions[] = "(c.D_ID = ? AND c.M_ID IS NULL)";
            $params[] = $dId;
            
            if ($mId) {
                $conditions[] = "(c.D_ID = ? AND c.M_ID = ?)";
                array_push($params, $dId, $mId);
            } else if($mId === 0) {
                $conditions[] = "(c.D_ID = ?)";
                array_push($params, $dId);
            }
        }
        
        $query .= implode(" OR ", $conditions) . " ORDER BY c.CourseCode";
        $stmt = $this->db->prepare($query);
        $stmt->execute($params);
        
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    private function getStudentInfo() {
        $stmt = $this->db->prepare("SELECT D_ID, M_ID FROM student WHERE StudentID = ?");
        $stmt->execute([$this->userId]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    private function getTeacherInfo() {
        $stmt = $this->db->prepare("SELECT D_ID FROM teacher WHERE TeacherID = ?");
        $stmt->execute([$this->userId]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>