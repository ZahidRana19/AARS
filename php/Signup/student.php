<?php
    require_once 'user.php';

    class Student implements User {
        private $data;
        private $db;
        private $roleID;

        public function __construct(array $data) {
            $this->data = $data;
            $this->db = Database::getInstance()->getConnection();
        }

        public function validate(): array {
            $result = [
                'success' => true,
                'message' => '',
                'duplicateFields' => []
            ];

            try {
                $normalizedPhone = ltrim($this->data['phone_number'], '0');

                // Duplicate Credentials Check
                $query_duplicate = $this->db->prepare("
                    SELECT Username, PhoneNumber, Email, RegCode
                    FROM `persons` 
                    WHERE Username = ? OR PhoneNumber = ? OR Email = ? OR RegCode = ?
                ");
        
                $query_duplicate->execute([
                    $this->data['username'],
                    $this->data['phone_number'],
                    $this->data['email'],
                    $this->data['reg_code']
                ]);
        
                // Duplication check
                if ($existing = $query_duplicate->fetch(PDO::FETCH_ASSOC)) {
                    $duplicateFields = [];
                    $errorMessages = [];
                    
                    if ($existing['Username'] === $this->data['username']) {
                        $duplicateFields[] = 'username';
                        $errorMessages[] = 'Username';
                    }
                    if (ltrim($existing['PhoneNumber'], '0') === $normalizedPhone) {
                        $duplicateFields[] = 'phone_number';
                        $errorMessages[] = 'Phone Number';
                    }
                    if ($existing['Email'] === $this->data['email']) {
                        $duplicateFields[] = 'email';
                        $errorMessages[] = 'Email';
                    }
                    if ($existing['RegCode'] === $this->data['reg_code']) {
                        $duplicateFields[] = 'reg_code';
                        $errorMessages[] = 'Registration Code';
                    }
        
                    $result['success'] = false;
                    $result['message'] = implode(', ', $errorMessages) . ' Already Exists!';
                    $result['duplicateFields'] = $duplicateFields;
                    return $result;
                }
        
            } catch (PDOException $e) {
                $result['success'] = false;
                $result['message'] = 'Validation error: ' . $e->getMessage();
            }
            return $result;
        }

        public function save(): bool {
            $this->db->beginTransaction();

            try {
                $normalizedPhone = ltrim($this->data['phone_number'], '0');

                // Get roleID from database
                $query_roleID = $this->db->prepare("SELECT RoleID FROM `userrole` WHERE RoleName = ?");
                $query_roleID->execute(['Student']);
                $roleArr = $query_roleID->fetch();
                if(!$roleArr) {
                    throw new PDOException("Role Not Found!!");
                } else {
                    $this->roleID = $roleArr['RoleID'];
                }

                // Insert into persons table
                $insertQuery_persons = $this->db->prepare("
                    INSERT INTO `persons` 
                    (R_ID, Username, PhoneNumber, FirstName, MiddleName, LastName, Email, Password, RoleAssignedDate, RegCode)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)
                ");
                $insertQuery_persons->execute([
                    $this->roleID,
                    $this->data['username'],
                    $normalizedPhone,
                    $this->data['first_name'],
                    $this->data['middle_name'],
                    $this->data['last_name'],
                    $this->data['email'],
                    password_hash($this->data['password'], PASSWORD_BCRYPT),
                    $this->data['reg_code'],
                ]);

                // Get P_ID(PersonID) From persons table
                $query_personID = $this->db->prepare("SELECT PersonID FROM `persons` WHERE Username = ?");
                $query_personID->execute([$this->data['username']]);
                $personArr = $query_personID->fetch();
                $personID;
                if(!$personArr) {
                    throw new PDOException("User Not Found!!");
                } else {
                    $personID = $personArr['PersonID'];
                }
        
                // Insert into student table
                $insertQuery_student = $this->db->prepare("
                    INSERT INTO student 
                    (P_ID)
                    VALUES (?)
                ");
                $insertQuery_student->execute([$personID]);

                $this->db->commit();
                return true;
        
            } catch (PDOException $e) {
                $this->db->rollBack();
                error_log("Registration failed: " . $e->getMessage());
                return false;
            }
        }

        public function getRole(): int {
            return $this->roleID;
        }
    }
?>