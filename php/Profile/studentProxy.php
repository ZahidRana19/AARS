<?php
require_once 'profileProxy.php';

class StudentProfileProxy extends ProfileProxy {
    public function __construct(ProfileInterface $realSubject) {
        parent::__construct($realSubject, 'Student');
    }
    
    public function updateProfile($updates) {
        if (isset($updates['Major']) && !isset($updates['Department'])) {
            $currentData = $this->getProfileData();
            if (empty($currentData['Department'])) {
                return ['success' => false, 'message' => 'Department must be set before Major'];
            }
        }
        
        return parent::updateProfile($updates);
    }
}