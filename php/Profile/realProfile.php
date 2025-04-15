<?php
require_once '../database.php';
require_once 'profileInterface.php';

class RealProfile implements ProfileInterface {
    protected $db;
    protected $userId;
    protected $role;
    
    public function __construct($userId, $role) {
        $this->db = Database::getInstance()->getConnection();
        $this->userId = $userId;
        $this->role = $role;
    }

    public function getUserId() {
        return $this->userId;
    }
    
    public function getProfileData() {
        if ($this->role === 'Teacher') {
            $query = "
                SELECT 
                    p.PersonID, p.FirstName, p.MiddleName, p.LastName, p.Email, p.Username, p.PhoneNumber, 
                    p.HouseNo AS HouseNumber, p.StreetNo AS StreetNumber, p.StreetName, p.PostalCode,
                    t.TeacherID,
                    d.DeptName AS Department
                FROM Persons p
                JOIN teacher t ON p.PersonID = t.P_ID
                LEFT JOIN Department d ON t.D_ID = d.DeptID
                WHERE p.PersonID = ?
            ";
        } else {
            $query = "
                SELECT 
                    p.PersonID, p.FirstName, p.MiddleName, p.LastName, p.Email, p.Username, p.PhoneNumber, 
                    p.HouseNo AS HouseNumber, p.StreetNo AS StreetNumber, p.StreetName, p.PostalCode,
                    s.StudentID, s.CGPA,
                    d.DeptName AS Department,
                    m.MajorName AS Major
                FROM Persons p
                JOIN student s ON p.PersonID = s.P_ID
                LEFT JOIN Department d ON s.D_ID = d.DeptID
                LEFT JOIN Major m ON s.M_ID = m.MajorID
                WHERE p.PersonID = ?
            ";
        }
        
        $stmt = $this->db->prepare($query);
        $stmt->execute([$this->userId]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
    
    public function updateProfile($updates) {
        $this->db->beginTransaction();
        
        try {
            // Updates persons table
            $personFields = [
                'PhoneNumber' => 'PhoneNumber',
                'HouseNumber' => 'HouseNo',
                'StreetNumber' => 'StreetNo',
                'StreetName' => 'StreetName',
                'PostalCode' => 'PostalCode'
            ];
            
            $personUpdates = [];
            $personParams = [':id' => $this->userId];
            
            foreach ($updates as $field => $value) {
                if (array_key_exists($field, $personFields)) {
                    $dbField = $personFields[$field];
                    $personUpdates[] = "$dbField = :$dbField";
                    $personParams[":$dbField"] = $value;
                }
            }
            
            if (!empty($personUpdates)) {
                $query = "UPDATE Persons SET " . implode(', ', $personUpdates) . " WHERE PersonID = :id";
                $stmt = $this->db->prepare($query);
                $stmt->execute($personParams);
            }
            
            // Update department and major tables
            if ($this->role === 'Teacher') {
                if (isset($updates['Department'])) {
                    $deptId = $this->getDepartmentIdByName($updates['Department']);
                    if ($deptId) {
                        $stmt = $this->db->prepare("UPDATE teacher SET D_ID = ? WHERE P_ID = ?");
                        $stmt->execute([$deptId, $this->userId]);
                    }
                }
            } else {
                if (isset($updates['Department'])) {
                    $deptId = $this->getDepartmentIdByName($updates['Department']);
                    if ($deptId) {
                        $stmt = $this->db->prepare("UPDATE student SET D_ID = ? WHERE P_ID = ?");
                        $stmt->execute([$deptId, $this->userId]);
                    }
                }
                
                if (isset($updates['Major'])) {
                    $majorId = $this->getMajorIdByName($updates['Major']);
                    if ($majorId) {
                        $stmt = $this->db->prepare("UPDATE student SET M_ID = ? WHERE P_ID = ?");
                        $stmt->execute([$majorId, $this->userId]);
                    }
                }
            }
            
            $this->db->commit();
            return ['success' => true, 'message' => 'Profile updated successfully'];
        } catch (PDOException $e) {
            $this->db->rollBack();
            throw $e;
        }
    }
    
    public function getDepartments() {
        $stmt = $this->db->query("SELECT DeptName FROM Department ORDER BY DeptName");
        return $stmt->fetchAll(PDO::FETCH_COLUMN, 0);
    }
    
    public function getMajorsByDepartment($deptName) {
        $deptId = $this->getDepartmentIdByName($deptName);
        if (!$deptId) return [];
        
        $stmt = $this->db->prepare("SELECT MajorName FROM Major WHERE D_ID = ? ORDER BY MajorName");
        $stmt->execute([$deptId]);
        return $stmt->fetchAll(PDO::FETCH_COLUMN, 0);
    }
    
    protected function getDepartmentIdByName($deptName) {
        $stmt = $this->db->prepare("SELECT DeptID FROM Department WHERE DeptName = ?");
        $stmt->execute([$deptName]);
        return $stmt->fetchColumn();
    }
    
    protected function getMajorIdByName($majorName) {
        $stmt = $this->db->prepare("SELECT MajorID FROM Major WHERE MajorName = ?");
        $stmt->execute([$majorName]);
        return $stmt->fetchColumn();
    }
}