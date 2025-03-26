<?php
    interface User {
        public function validate(): array;
        public function save(): bool;
        public function getRole(): int;
    }
?>