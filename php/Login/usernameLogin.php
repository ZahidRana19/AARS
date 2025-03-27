<?php
require_once 'loginStrategy.php';
require_once 'database.php';

class UsernameLoginStrategy implements LoginStrategy {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }

    public function authenticate(string $username, string $password): array {
        $result = [
            'success' => true,
            'message' => ''
        ];

        try {
            $query = $this->db->prepare("
                SELECT p.*, r.RoleName 
                FROM persons p
                JOIN userrole r ON p.R_ID = r.RoleID
                WHERE p.Username = ?
            ");
            $query->execute([$username]);
            
            $user = $query->fetch(PDO::FETCH_ASSOC);
        
            if (!$user) {
                return [
                    'success' => false,
                    'message' => 'Invalid Username',
                    'isValidationError' => true
                ];
            }

            if (!password_verify($password, $user['Password'])) {
                return [
                    'success' => false,
                    'message' => 'Invalid Password',
                    'isValidationError' => true
                ];
            }

            return [
                'success' => true,
                'message' => 'Login successful',
                'user' => $user
            ];
            
        } catch (PDOException $e) {
            error_log("Login error: " . $e->getMessage());
            return [
                'success' => false,
                'message' => 'Login failed. Please try again.'
            ];
        }
    }
}
?>