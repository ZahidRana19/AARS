<?php
    require_once 'user.php';
    require_once 'student.php';
    require_once 'teacher.php';

    class UserCreator {
        public static function createUser(string $type, array $data): User {
            return match(strtolower($type)) {
                'student' => new Student($data),
                'teacher' => new Teacher($data),
                default => throw new InvalidArgumentException("Invalid user type: $type")
            };
        }
    }
?>