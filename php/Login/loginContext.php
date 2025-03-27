<?php
require_once 'loginStrategy.php';
require_once 'emailLogin.php';
require_once 'usernameLogin.php';

class LoginContext {
    private $strategy;

    public function __construct(LoginStrategy $strategy) {
        $this->strategy = $strategy;
    }

    public function executeLogin(string $identifier, string $password): array {
        return $this->strategy->authenticate($identifier, $password);
    }
}
?>