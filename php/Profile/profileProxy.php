<?php
require_once '../database.php';
require_once 'profileInterface.php';
require_once 'realProfile.php';

class ProfileProxy implements ProfileInterface {
    protected $realSubject;
    protected $db;
    protected $editableFields = [];
    protected $onceEditableFields = [];
    
    public function __construct(ProfileInterface $realSubject, $role) {
        $this->realSubject = $realSubject;
        $this->role = $role;
        $this->db = Database::getInstance()->getConnection();
        
        $this->editableFields = [
            'PhoneNumber',
            'HouseNumber',
            'StreetNumber',
            'StreetName',
            'PostalCode'
        ];
        
        $this->onceEditableFields = ($role === 'Teacher') 
            ? ['Department'] 
            : ['Department', 'Major'];
    }
    
    public function getProfileData() {
        return $this->realSubject->getProfileData();
    }
    
    public function updateProfile($updates) {
        $validUpdates = $this->filterEditableFields($updates);
        
        if (empty($validUpdates)) {
            return ['success' => false, 'message' => 'No valid fields to update'];
        }
        
        try {
            // Phone number duplicate check
            if (isset($validUpdates['PhoneNumber'])) {
                if ($this->isPhoneNumberExists($validUpdates['PhoneNumber'], $this->realSubject->getUserId())) {
                    throw new Exception("Phone number already exists");
                }
            }
            
            // Department/Major validation
            $currentData = $this->getProfileData();
            if (isset($validUpdates['Department']) && !empty($currentData['Department'])) {
                unset($validUpdates['Department']);
            }
            
            if ($this->role === 'Student' && isset($validUpdates['Major']) && !empty($currentData['Major'])) {
                unset($validUpdates['Major']);
            }
            
            return $this->realSubject->updateProfile($validUpdates);
            
        } catch (Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    public function getDepartments() {
        return $this->realSubject->getDepartments();
    }
    
    public function getMajorsByDepartment($deptName) {
        return $this->realSubject->getMajorsByDepartment($deptName);
    }
    
    protected function isPhoneNumberExists($phoneNumber, $excludeUserId) {
        $query = "SELECT COUNT(*) FROM Persons WHERE PhoneNumber = ? AND PersonID != ?";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$phoneNumber, $excludeUserId]);
        return $stmt->fetchColumn() > 0;
    }
    
    protected function filterEditableFields($updates) {
        $filtered = [];
        $currentData = $this->getProfileData();
        
        foreach ($updates as $field => $value) {
            if (in_array($field, $this->editableFields)) {
                $filtered[$field] = $value;
            } elseif (in_array($field, $this->onceEditableFields)) {
                if (empty($currentData[$field])) {
                    $filtered[$field] = $value;
                }
            }
        }
        
        return $filtered;
    }
}