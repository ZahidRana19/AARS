<?php
require_once '../database.php';

class Enrollment {
    private $db;
    private $userId;
    private $roleName;

    public function __construct($db, $userId) {
        $this->db = $db;
        $this->userId = $userId;
        $this->roleName = $_SESSION['role'];
    }

    public function addSelectedSection($courseId, $sectionNo) {
        try {
            if($this->roleName === 'Student') {
                $stmt = $this->db->prepare(
                    "INSERT INTO selectedsections (CourseID, SectionNo, S_ID) 
                     VALUES (?, ?, ?)"
                );
                $stmt->execute([$courseId, $sectionNo, $this->userId]);
            } else if($this->roleName === 'Teacher') {
                $stmt = $this->db->prepare(
                    "INSERT INTO requested_sections (CourseID, SectionNo, T_ID) 
                     VALUES (?, ?, ?)"
                );
                $stmt->execute([$courseId, $sectionNo, $this->userId]);
            }

            return ['status' => 'success'];
        } catch (PDOException $e) {
            return ['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()];
        }
    }

    public function removeSelectedSection($courseId, $sectionNo) {
        try {
            if($this->roleName === 'Student') {
                $stmt = $this->db->prepare(
                    "DELETE FROM selectedsections 
                     WHERE CourseID = ? AND SectionNo = ? AND S_ID = ?"
                );
                $stmt->execute([$courseId, $sectionNo, $this->userId]);
            } else if($this->roleName === 'Teacher') {
                $stmt = $this->db->prepare(
                    "DELETE FROM requested_sections 
                     WHERE CourseID = ? AND SectionNo = ? AND T_ID = ?"
                );
                $stmt->execute([$courseId, $sectionNo, $this->userId]);
            }
            
            return $stmt->rowCount() > 0
                ? ['status' => 'success']
                : ['status' => 'error', 'message' => 'Section not found in selected'];
        } catch (PDOException $e) {
            return ['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()];
        }
    }

    public function confirmEnrollment() {
        $this->db->beginTransaction();

        try {
            $selectedSections = $this->getSelectedSections();
            if (empty($selectedSections)) {
                return ['status' => 'error', 'message' => 'No sections selected'];
            }

            foreach ($selectedSections as $section) {
                $this->addToTakes($section);
                $this->addToEnrollment($section);
                $this->updateSectionSeats($section);
            }

            $this->clearSelectedSections();
            $this->db->commit();
            return ['status' => 'success'];
        } catch (PDOException $e) {
            $this->db->rollBack();
            return ['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()];
        }
    }

    public function sendRequest($personId) {
        $this->db->beginTransaction();
    
        try {
            $teacherId = $this->getTeacherId($personId);
            if (!$teacherId) {
                throw new Exception('No teacher found for this user');
            }
    
            $requestedSections = $this->getRequestedSections();
            if (empty($requestedSections)) {
                throw new Exception('No pending requests found');
            }
    
            $requestsData = [];
            foreach ($requestedSections as $section) {
                $courseInfo = $this->getCourseInformation($section);
                $teacherInfo = $this->getTeacherInformation($personId);
                
                $deptName = 'Unknown Department';
                if (!empty($courseInfo['D_ID'])) {
                    $deptInfo = $this->getDepartmentName($courseInfo['D_ID']);
                    $deptName = $deptInfo['DeptName'] ?? $deptName;
                }
    
                $requestsData[] = [
                    'course_code' => $section['CourseID'],
                    'course_title' => $courseInfo['CourseName'] ?? 'Unknown Course',
                    'section_no' => $section['SectionNo'],
                    'facultyName' => trim(($teacherInfo['FirstName'] ?? '') . ' ' . 
                                      ($teacherInfo['MiddleName'] ?? '') . ' ' . 
                                      ($teacherInfo['LastName'] ?? '')),
                    'department' => $deptName,
                    'teacher_id' => $teacherId
                ];
            }
    
            $this->db->commit();
            return [
                'status' => 'success',
                'requests' => $requestsData
            ];
    
        } catch (Exception $e) {
            $this->db->rollBack();
            return [
                'status' => 'error',
                'message' => $e->getMessage()
            ];
        }
    }
    
    private function getTeacherId($personId) {
        $stmt = $this->db->prepare("SELECT TeacherID FROM teacher WHERE P_ID = ?");
        $stmt->execute([$personId]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result ? $result['TeacherID'] : null;
    }

    private function getCourseInformation($section) {
        $stmt = $this->db->prepare("SELECT * FROM course WHERE CourseCode = ?");
        $stmt->execute([$section['CourseID']]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    private function getTeacherInformation($personId) {
        $stmt = $this->db->prepare("SELECT * FROM persons WHERE PersonID = ?");
        $stmt->execute([$personId]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    private function getDepartmentName($deptID) {
        $stmt = $this->db->prepare("SELECT DeptName FROM department WHERE DeptID = ?");
        $stmt->execute([$deptID]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    private function getSelectedSections() {
        $stmt = $this->db->prepare("SELECT * FROM selectedsections WHERE S_ID = ?");
        $stmt->execute([$this->userId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    private function getRequestedSections() {
        $stmt = $this->db->prepare("SELECT * FROM requested_sections WHERE T_ID = ?");
        $stmt->execute([$this->userId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    private function addToTakes($section) {
        $stmt = $this->db->prepare(
            "INSERT INTO takes (S_ID, CourseID, SecID, EnrollmentDate)
             VALUES (?, ?, ?, CURDATE())"
        );
        $stmt->execute([$this->userId, $section['CourseID'], $section['SectionNo']]);
    }

    private function addToEnrollment($section) {
        $stmt = $this->db->prepare(
            "INSERT INTO enrollment (SecID, CourseID, S_ID)
             VALUES (?, ?, ?)"
        );
        $stmt->execute([$section['SectionNo'], $section['CourseID'], $this->userId]);
    }

    private function updateSectionSeats($section) {
        $stmt = $this->db->prepare(
            "UPDATE section 
             SET SeatsTaken = SeatsTaken + 1
             WHERE CourseID = ? AND SectionNo = ?"
        );
        $stmt->execute([$section['CourseID'], $section['SectionNo']]);
    }

    private function clearSelectedSections() {
        $stmt = $this->db->prepare("DELETE FROM selectedsections WHERE S_ID = ?");
        $stmt->execute([$this->userId]);
    }
    private function clearRequestedSections() {
        $stmt = $this->db->prepare("DELETE FROM requested_sections WHERE T_ID = ?");
        $stmt->execute([$this->userId]);
    }
}
?>