<?php
require_once 'courseEligibility.php';
require_once 'sectionValidation.php';
require_once 'enroll.php';
require_once '../database.php';

class EnrollmentFacade {
    private $eligibility;
    private $validation;
    private $enrollment;

    public function __construct($userId) {
        $db = Database::getInstance()->getConnection();
        $this->eligibility = new CourseEligibility($db, $userId);
        $this->validation = new SectionValidation($db, $userId);
        $this->enrollment = new Enrollment($db, $userId);
    }

    public function getAvailableCourses() {
        return $this->eligibility->getEligibleCourses();
    }

    public function addSection($courseId, $sectionNo) {
        $validationStatus = $this->validation->validateSection($courseId, $sectionNo);
        return $validationStatus['status'] === 'success'
            ? $this->enrollment->addSelectedSection($courseId, $sectionNo)
            : $validationStatus;
    }

    public function removeSection($courseId, $sectionNo) {
        return $this->enrollment->removeSelectedSection($courseId, $sectionNo);
    }

    public function confirmEnrollment() {
        return $this->enrollment->confirmEnrollment();
    }

    public function sendRequest($personId) {
        return $this->enrollment->sendRequest($personId);
    }
}
?>