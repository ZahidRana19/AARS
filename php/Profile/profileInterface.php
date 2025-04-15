<?php
interface ProfileInterface {
    public function getProfileData();
    public function updateProfile($updates);
    public function getDepartments();
    public function getMajorsByDepartment($deptName);
}