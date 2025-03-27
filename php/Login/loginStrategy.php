<?php
interface LoginStrategy {
    public function authenticate(string $identifier, string $password): array;
}
?>