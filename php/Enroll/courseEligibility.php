<?php
require_once '../database.php';

class CourseEligibility {
    private $db;
    private $studentId;

    public function __construct($db, $studentId) {
        $this->db = $db;
        $this->studentId = $studentId;
    }

    public function getEligibleCourses() {
        $studentInfo = $this->getStudentInfo();
        $dId = $studentInfo['D_ID'] ?? null;
        $mId = $studentInfo['M_ID'] ?? null;

        $query = "SELECT c.* FROM course c WHERE ";
        $conditions = ["(c.D_ID IS NULL AND c.M_ID IS NULL)"];
        $params = [];
        
        if ($dId) {
            $conditions[] = "(c.D_ID = ? AND c.M_ID IS NULL)";
            $params[] = $dId;
            
            if ($mId) {
                $conditions[] = "(c.D_ID = ? AND c.M_ID = ?)";
                array_push($params, $dId, $mId);
            }
        }
        
        $query .= implode(" OR ", $conditions) . " ORDER BY c.CourseCode";
        $stmt = $this->db->prepare($query);
        $stmt->execute($params);
        
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    private function getStudentInfo() {
        $stmt = $this->db->prepare("SELECT D_ID, M_ID FROM student WHERE StudentID = ?");
        $stmt->execute([$this->studentId]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>