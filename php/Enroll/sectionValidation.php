<?php
require_once '../database.php';

class SectionValidation {
    private $db;
    private $studentId;

    public function __construct($db, $studentId) {
        $this->db = $db;
        $this->studentId = $studentId;
    }

    public function validateSection($courseId, $sectionNo) {
        $errors = [];
        
        if (!$this->sectionExists($courseId, $sectionNo)) {
            $errors[] = 'Section not found';
        } elseif ($this->isSectionFull($courseId, $sectionNo)) {
            $errors[] = 'No seats available';
        } elseif ($this->isAlreadyEnrolled($courseId)) {
            $errors[] = 'Already enrolled in this course';
        } elseif (!$this->checkPrerequisites($courseId)) {
            $errors[] = 'Prerequisite not satisfied';
        } elseif ($this->hasTimeConflict($courseId, $sectionNo)) {
            $errors[] = 'Time conflict with existing schedule';
        } elseif ($this->hasMaxCourseLimit()) {
            $errors[] = 'Maximum 5 courses allowed';
        }

        return empty($errors) 
            ? ['status' => 'success']
            : ['status' => 'error', 'message' => implode(', ', $errors)];
    }

    private function sectionExists($courseId, $sectionNo) {
        $stmt = $this->db->prepare("SELECT 1 FROM section WHERE CourseID = ? AND SectionNo = ?");
        $stmt->execute([$courseId, $sectionNo]);
        return (bool)$stmt->fetchColumn();
    }

    private function isSectionFull($courseId, $sectionNo) {
        $stmt = $this->db->prepare(
            "SELECT SeatsTaken >= TotalSeats FROM section 
             WHERE CourseID = ? AND SectionNo = ?"
        );
        $stmt->execute([$courseId, $sectionNo]);
        return (bool)$stmt->fetchColumn();
    }

    private function isAlreadyEnrolled($courseId) {
        $stmt = $this->db->prepare(
            "SELECT COUNT(*) FROM selectedsections 
             WHERE S_ID = ? AND CourseID = ?"
        );
        $stmt->execute([$this->studentId, $courseId]);
        return $stmt->fetchColumn() > 0;
    }

    private function checkPrerequisites($courseId) {
        $stmt = $this->db->prepare("SELECT PreRequisite FROM course WHERE CourseCode = ?");
        $stmt->execute([$courseId]);
        $prerequisite = $stmt->fetchColumn();

        if (!$prerequisite) return true;

        $stmt = $this->db->prepare(
            "SELECT COUNT(*) FROM prev_taken_courses 
             WHERE S_ID = ? AND CourseCode = ?"
        );
        $stmt->execute([$this->studentId, $prerequisite]);
        return $stmt->fetchColumn() > 0;
    }

    private function hasTimeConflict($courseId, $sectionNo) {
        $newSection = $this->getSectionInfo($courseId, $sectionNo);
        if (!$newSection) return false;

        $sections = $this->getCurrentSections();
        foreach ($sections as $section) {
            if ($this->schedulesConflict($newSection, $section)) {
                return true;
            }
        }
        return false;
    }

    private function getSectionInfo($courseId, $sectionNo) {
        $stmt = $this->db->prepare("SELECT * FROM section WHERE CourseID = ? AND SectionNo = ?");
        $stmt->execute([$courseId, $sectionNo]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    private function getCurrentSections() {
        $stmt = $this->db->prepare(
            "SELECT s.* FROM selectedsections ss
             JOIN section s ON ss.CourseID = s.CourseID AND ss.SectionNo = s.SectionNo
             WHERE ss.S_ID = ?"
        );
        $stmt->execute([$this->studentId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    private function schedulesConflict($section1, $section2) {
        return $section1['ClassDays'] === $section2['ClassDays'] &&
               $section1['ClassStartTime'] === $section2['ClassStartTime'];
    }

    private function hasMaxCourseLimit() {
        $stmt = $this->db->prepare("SELECT COUNT(*) FROM selectedsections WHERE S_ID = ?");
        $stmt->execute([$this->studentId]);
        return $stmt->fetchColumn() >= 5;
    }
}
?>