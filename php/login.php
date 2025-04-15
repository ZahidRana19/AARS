<?php
header('Content-Type: application/json');
session_start();

require_once 'database.php';
require_once 'Login/loginContext.php';
require_once 'Login/loginStrategy.php';
require_once 'Login/emailLogin.php';
require_once 'Login/usernameLogin.php';

$response = [
    'success' => false,
    'message' => 'Invalid request',
    'redirect' => null,
    'isValidationError' => false,
    'invalidFields' => []
];

try {
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $identifier = trim($_POST['identifier'] ?? '');
        $password = trim($_POST['login_password'] ?? '');
        $remember = isset($_POST['remember']);

        $strategy = filter_var($identifier, FILTER_VALIDATE_EMAIL) 
            ? new EmailLoginStrategy() 
            : new UsernameLoginStrategy();

        $loginContext = new LoginContext($strategy);
        $result = $loginContext->executeLogin($identifier, $password);

        if ($result['success'] && isset($result['user'])) {
            $_SESSION['user_id'] = $result['user']['PersonID'];
            $_SESSION['username'] = $result['user']['Username'];
            $_SESSION['email'] = $result['user']['Email'];
            $_SESSION['role'] = $result['user']['RoleName'];
        
            $response = [
                'success' => true,
                'message' => $result['message'],
                'redirect' => ($result['user']['RoleName'] === "Student") 
                    ? '../html/dashboard.html' 
                    : '../html/teacher_dashboard.html',
                'userData' => [
                    'id' => $result['user']['PersonID'],
                    'name' => $result['user']['Username'],
                    'role' => $result['user']['RoleName']
                ]
            ];
        } else {
            $response = [
                'success' => false,
                'message' => $result['message'] ?? 'Login failed',
                'isValidationError' => true,
                'invalidFields' => ['identifier', 'password']
            ];
        }
    }
} catch (Exception $e) {
    $response = [
        'success' => false,
        'message' => 'An error occurred during login'
    ];
    error_log("Login error: " . $e->getMessage());
}

echo json_encode($response);
exit;
?>