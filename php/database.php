<?php
    class Database {
        private static $instance = null;
        private $conn;
    
        private $host = "localhost";
        private $username = "root";
        private $password = "";
        private $database = "aars";
    
        private function __construct() {
            try {
                $dsn = "mysql:host={$this->host};dbname={$this->database};charset=utf8mb4";
                $this->conn = new PDO($dsn, $this->username, $this->password);
                $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            } catch (PDOException $e) {
                die("Database connection error! Please try again later.");
            }
        }

        public static function getInstance() {
            static $instance = null;
            if ($instance === null) {
                $instance = new self();
            }
            return $instance;
        }
    
        public function getConnection() {
            return $this->conn;
        }
    
        private function __clone() {}
    
        public function __wakeup() {
            throw new Exception("Cannot unserialize database connection!!");
        }
    }
?>