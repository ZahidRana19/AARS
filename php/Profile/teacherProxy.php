<?php
require_once 'profileProxy.php';

class TeacherProfileProxy extends ProfileProxy {
    public function __construct(ProfileInterface $realSubject) {
        parent::__construct($realSubject, 'Teacher');
    }
}