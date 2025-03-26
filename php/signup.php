<?php
    header('Content-Type: application/json');
    session_start();
    require_once 'database.php';
    require_once 'User/userCreator.php';

    $response = [
        'success' => false,
        'message' => '',
        'redirect' => null
    ];

    try {
        $userRole = null;
        
        if($_SERVER["REQUEST_METHOD"] == "POST") {
            $userData = [
                'first_name' => $_POST['first_name'],
                'middle_name' => $_POST['middle_name'] ?? null,
                'last_name' => $_POST['last_name'],
                'username' => $_POST['username'],
                'phone_number' => $_POST['phone_number'],
                'email' => $_POST['email'],
                'password' => $_POST['password'],
                'reg_code' => $_POST['reg_code']
            ];
    
            if (preg_match('/^T(?=.*[0-9].*[0-9])[A-Za-z0-9]{5}s$/', $_POST['reg_code'])) {
                $userRole = 'Student';
            } else if(preg_match('/^R(?=.*[0-9].*[0-9])[A-Za-z0-9]{7}t$/', $_POST['reg_code'])) {
                $userRole = 'Teacher';
            } else {
                throw new Exception("Invalid registration code!");
            }
        }
        $user = UserCreator::createUser($userRole, $userData);

        $validation = $user->validate();
        if (!$validation['success']) {
            echo json_encode([
                'success' => false,
                'message' => $validation['message'],
                'duplicateFields' => $validation['duplicateFields'],
                'isValidationError' => true
            ]);
            exit;
        }
        
        if ($user->save()) {
            $_SESSION['RoleID'] = $user->getRole();
            $_SESSION['Username'] = $userData['username'];

            echo json_encode([
                'success' => true,
                'message' => 'Account created successfully!',
                'redirect' => '../html/login.html'
            ]);
            exit;
        } else {
            throw new Exception('Failed to save user');
        }
        
    } catch (Exception $e) {
        echo json_encode([
            'success' => false,
            'message' => $e->getMessage()
        ]);
        exit;
    }
?>