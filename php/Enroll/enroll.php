<?php
require_once '../database.php';

class Enrollment {
    private $db;
    private $studentId;

    public function __construct($db, $studentId) {
        $this->db = $db;
        $this->studentId = $studentId;
    }

    public function addSelectedSection($courseId, $sectionNo) {
        try {
            $stmt = $this->db->prepare(
                "INSERT INTO selectedsections (CourseID, SectionNo, S_ID) 
                 VALUES (?, ?, ?)"
            );
            $stmt->execute([$courseId, $sectionNo, $this->studentId]);
            return ['status' => 'success'];
        } catch (PDOException $e) {
            return ['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()];
        }
    }

    public function removeSelectedSection($courseId, $sectionNo) {
        try {
            $stmt = $this->db->prepare(
                "DELETE FROM selectedsections 
                 WHERE CourseID = ? AND SectionNo = ? AND S_ID = ?"
            );
            $stmt->execute([$courseId, $sectionNo, $this->studentId]);
            
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

    private function getSelectedSections() {
        $stmt = $this->db->prepare("SELECT * FROM selectedsections WHERE S_ID = ?");
        $stmt->execute([$this->studentId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    private function addToTakes($section) {
        $stmt = $this->db->prepare(
            "INSERT INTO takes (S_ID, CourseID, SecID, EnrollmentDate)
             VALUES (?, ?, ?, CURDATE())"
        );
        $stmt->execute([$this->studentId, $section['CourseID'], $section['SectionNo']]);
    }

    private function addToEnrollment($section) {
        $stmt = $this->db->prepare(
            "INSERT INTO enrollment (SecID, CourseID, S_ID)
             VALUES (?, ?, ?)"
        );
        $stmt->execute([$section['SectionNo'], $section['CourseID'], $this->studentId]);
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
        $stmt->execute([$this->studentId]);
    }
}
?>