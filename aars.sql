-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2025 at 06:20 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aars`
--

-- --------------------------------------------------------

--
-- Table structure for table `academicrecord`
--

CREATE TABLE `academicrecord` (
  `S_ID` int(8) NOT NULL,
  `Grade` varchar(5) DEFAULT NULL,
  `CourseID` varchar(10) DEFAULT NULL,
  `SecNo` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assigned_courses`
--

CREATE TABLE `assigned_courses` (
  `CourseID` varchar(10) NOT NULL,
  `SecID` int(3) NOT NULL,
  `T_ID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `SecID` int(3) NOT NULL,
  `CourseID` varchar(10) NOT NULL,
  `S_ID` int(8) NOT NULL,
  `AttendanceDate` date DEFAULT NULL,
  `Status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `CourseCode` varchar(10) NOT NULL,
  `CourseName` varchar(80) NOT NULL,
  `Credits` float NOT NULL,
  `D_ID` int(5) DEFAULT NULL,
  `M_ID` int(5) DEFAULT NULL,
  `PreRequisite` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`CourseCode`, `CourseName`, `Credits`, `D_ID`, `M_ID`, `PreRequisite`) VALUES
('ANT101', 'Introduction to Anthropology', 3, NULL, NULL, NULL),
('ARC111', 'Foundation Design Studio I- Artistic Development', 4.5, 4, 6, NULL),
('ARC112', 'Foundation Design Studio II- Form and Composition', 4.5, 4, 6, 'ARC111'),
('ARC121', 'Graphics I- Basic Drawing', 3, 4, 6, 'ARC111'),
('ARC122', 'Graphics II- Rendering', 3, 4, 6, 'ARC121'),
('ARC133', 'Parameters in Design I- Aesthetic and Design', 1.5, 4, 6, NULL),
('ARC200', 'Art, Craft and Design- observation and documentation', 1, 4, 6, 'ARC121'),
('ARC213', 'Allied Design Studio- Dimension and Product', 4.5, 4, 6, 'ARC122'),
('ARC214', 'Architecture Design Studio I- Function and Analysis', 4.5, 4, 6, 'ARC213'),
('ARC215', 'Architecture Design Studio II- Simple Function', 4.5, 4, 6, 'ARC214'),
('ARC241', 'Architectural Heritage I- World I', 3, 4, 6, NULL),
('ARC242', 'Architectural Heritage II- World II', 3, 4, 6, 'ARC241'),
('ARC251', 'Introduction to Urban Design and Environment Planning', 3, 4, 6, 'ARC445'),
('ARC261', 'Environment and Building System I- Climate and Design', 3, 4, 6, 'ARC445'),
('ARC262', 'Environment and Building System II- Building Physics', 3, 4, 6, 'ARC261'),
('ARC263', 'Environment and Building System III- Building Services', 3, 4, 6, 'ARC262'),
('ARC264', 'Environment and Building System IV- Design Integration', 1, 4, 6, 'ARC214'),
('ARC271', 'Construction I- Materials', 3, 4, 6, 'ARC262'),
('ARC272', 'Construction II- Technology', 3, 4, 6, 'ARC271'),
('ARC273', 'Construction III- Workshop', 1, 4, 6, 'ARC214'),
('ARC281', 'Building Structures I- Basic Principles', 2, 4, 6, 'ARC271'),
('ARC282', 'Building Structures II', 2, 4, 6, 'ARC281'),
('ARC283', 'Building Structures III', 2, 4, 6, 'ARC282'),
('ARC316', 'Professional Studies Studio I- Form and Function', 4.5, 4, 6, 'ARC215'),
('ARC317', 'Professional Studies Studio II- Complex Function', 6, 4, 6, 'ARC316'),
('ARC318', 'Professional Studies Studio III- Complex Function', 6, 4, 6, 'ARC317'),
('ARC324', 'Graphics IV- Working Details', 3, 4, 6, 'ARC273'),
('ARC334', 'Parameters in Design II- Theory and Methods', 1.5, 4, 6, 'ARC133'),
('ARC343', 'Architectural Heritage III- India', 3, 4, 6, 'ARC242'),
('ARC344', 'Architectural Heritage IV- Bengal', 2, 4, 6, 'ARC242'),
('ARC384', 'Building Structures IV', 3, 4, 6, 'ARC283'),
('ARC418', 'Design and Allied Studies Studio I', 6, 4, 6, 'ARC324'),
('ARC419', 'Design and Allied Studies Studio II', 6, 4, 6, 'ARC418'),
('ARC437', 'Professional Practice, Ethics and Society', 1.5, 4, 6, 'ARC535'),
('ARC445', 'Contemporary Design Precedents and Analyses', 2, 4, 6, 'ARC242'),
('ARC500', 'Professional Internship (supervised training)', 1, 4, 6, 'ARC324'),
('ARC510', 'Advanced Studies Studio I', 4.5, 4, 6, 'ARC419'),
('ARC519', 'Advanced Studies Studio II- Thesis Project', 4.5, 4, 6, 'ARC510'),
('ARC535', 'Parameters in Design III- Pedagogy and Discourse', 1.5, 4, 6, 'ARC334'),
('ARC596', 'Thesis Documentation- Research and Development', 4.5, 4, 6, 'ARC519'),
('BIO103', 'Biology I', 3, NULL, NULL, NULL),
('BIO103L', 'Biology I Lab', 3, NULL, NULL, 'CHE407'),
('BIO104', 'Introduction to Biotechnology', 3, 5, 8, 'BIO101'),
('BIO105', 'Fundamentals of Bioengineering', 3, 5, 8, 'BIO101'),
('BIO201', 'Cell Biology', 3, 5, 8, 'BIO104'),
('BIO201L', 'Cell Biology Lab', 1, 5, 8, 'BIO104'),
('BIO203', 'Molecular Biology', 3, 5, 8, 'BIO201'),
('BIO203L', 'Molecular Biology Lab', 1, 5, 8, 'BIO201'),
('BIO301', 'Biochemical Engineering', 3, 5, 8, 'BIO201'),
('BIO302', 'Genetics and Genomics', 3, 5, 8, 'BIO203'),
('BIO303', 'Biomaterials Science', 3, 5, 8, 'BIO105'),
('BIO304', 'Bioreactor Design', 3, 5, 8, 'BIO301'),
('BIO305', 'Principles of Bioinformatics', 3, 5, 8, 'BIO302'),
('BIO306', 'Immunotechnology', 3, 5, 8, 'BIO203'),
('BIO307', 'Metabolic Engineering', 3, 5, 8, 'BIO301'),
('BIO308', 'Biosensors and Instrumentation', 3, 5, 8, 'BIO301'),
('BIO309', 'Tissue Engineering', 3, 5, 8, 'BIO303'),
('BIO310', 'Nanobiotechnology', 3, 5, 8, 'BIO303'),
('BIO401', 'Advanced Topics in Biotechnology', 3, 5, 8, 'BIO305'),
('BIO402', 'Advanced Bioengineering Design', 3, 5, 8, 'BIO308'),
('BIO403', 'Research Methods in Biotechnology', 3, 5, 8, 'BIO302'),
('BIO404', 'Capstone Project in Biotechnology', 3, 5, 8, 'BIO402'),
('CHE101', 'Chemistry I', 3, NULL, NULL, NULL),
('CHE101L', 'Chemistry I Lab', 1, NULL, NULL, NULL),
('CHE201', 'Organic Chemistry I', 3, 5, 7, 'CHE101'),
('CHE201L', 'Organic Chemistry I Lab', 1, 5, 7, 'CHE101'),
('CHE203', 'Biochemistry I', 3, 5, 7, 'CHE101'),
('CHE203L', 'Biochemistry I Lab', 1, 5, 7, 'CHE101'),
('CHE301', 'Organic Chemistry II', 3, 5, 7, 'CHE201'),
('CHE301L', 'Organic Chemistry IIL', 1, 5, 7, 'CHE201'),
('CHE303', 'Bio-organic Chemistry', 3, 5, 7, 'CHE301'),
('CHE304', 'Mechanisms in Bio-organic Reactions', 3, 5, 7, 'CHE301'),
('CHE305', 'Spectroscopic Methods in Organic Chemistry', 3, 5, 7, 'CHE301'),
('CHE306', 'Computational Chemistry', 3, 5, 7, 'CHE303'),
('CHE401', 'Advanced Bio-organic Chemistry', 3, 5, 7, 'CHE303'),
('CHE402', 'Drug Design and Discovery', 3, 5, 7, 'CHE304'),
('CHE403', 'Enzymatic Catalysis and Kinetics', 3, 5, 7, 'CHE304'),
('CHE404', 'Natural Product Synthesis', 3, 5, 7, 'CHE305'),
('CHE405', 'Molecular Biology Techniques', 3, 5, 7, 'CHE204'),
('CHE406', 'Advanced Lab in Bio-organic Chemistry', 2, 5, 7, 'CHE304'),
('CHE407', 'Research Seminar in Bio-organic Chemistry', 3, 5, 7, 'CHE402'),
('CHE499', 'Senior Thesis in Bio-organic Chemistry', 3, 5, 7, 'CHE407'),
('CSE115', 'Programming language I', 3, 1, NULL, NULL),
('CSE115L', 'Programming language I Lab', 1, 1, NULL, NULL),
('CSE173', 'Discrete Mathematics', 3, 1, 1, 'CSE115'),
('CSE215', 'Programming Language II', 3, 1, 1, 'CSE173'),
('CSE215L', 'Programming Language II Lab', 1, 1, 1, 'CSE173'),
('CSE225', 'Data Structures and Algorithms', 3, 1, 1, 'CSE215'),
('CSE225L', 'Data Structures and Algorithms Lab', 0, 1, 1, 'CSE215'),
('CSE231', 'Digital Logic Design', 3, 1, 1, 'CSE173'),
('CSE231L', 'Digital Logic Design Lab', 0, 1, 1, 'CSE173'),
('CSE299', 'Junior Design Course', 1, 1, 1, 'CSE225'),
('CSE311', 'Database Systems', 3, 1, 1, 'CSE225'),
('CSE311L', 'Database Systems Lab', 0, 1, 1, 'CSE225'),
('CSE323', 'Operating Systems Design', 3, 1, 1, 'CSE332'),
('CSE325', 'Concepts of Programming Language', 3, 1, 1, 'CSE327'),
('CSE327', 'Software Engineering', 3, 1, 1, 'CSE311'),
('CSE331', 'Microprocessor Interfacing & Embedded System', 3, 1, 1, 'CSE332'),
('CSE331L', 'Microprocessor Interfacing & Embedded System Lab', 0, 1, 1, 'CSE332'),
('CSE332', 'Computer Organization and Architecture', 3, 1, 1, 'CSE231'),
('CSE332L', 'Computer Organization and Architecture Lab', 0, 1, 1, 'CSE231'),
('CSE373', 'Design and Analysis of Algorithms', 3, 1, 1, 'CSE225'),
('CSE498', 'Internship Research', 0, 1, 1, 'CSE373'),
('CSE499A', 'Senior Design I', 1.5, 1, 1, 'CSE299'),
('CSE499B', 'Senior Design II', 1.5, 1, 1, 'CSE499A'),
('ECO101', 'Introduction to Microeconomics', 3, NULL, NULL, NULL),
('ECO104', 'Introduction to Macroeconomics', 3, NULL, NULL, NULL),
('ECO201', 'Intermediate Microeconomic Theory', 3, 3, 5, 'ECO101'),
('ECO202', 'Intermediate Macroeconomic Theory', 3, 3, 5, 'ECO104'),
('ECO203', 'Quantitative Methods for Economists', 3, 3, 5, 'ECO101'),
('ECO301', 'Game Theory and Strategic Behavior', 3, 3, 5, 'ECO201'),
('ECO302', 'Behavioral Economics', 3, 3, 5, 'ECO201'),
('ECO303', 'Environmental and Resource Economics', 3, 3, 5, 'ECO201'),
('ECO304', 'Economics of Public Policy', 3, 3, 5, 'ECO301'),
('ECO305', 'Industrial Organization', 3, 3, 5, 'ECO301'),
('ECO306', 'Labor Economics', 3, 3, 5, 'ECO305'),
('ECO307', 'Health Economics', 3, 3, 5, 'ECO305'),
('ECO308', 'Experimental Economics', 3, 3, 5, 'ECO307'),
('ECO309', 'Mathematical Economics', 3, 3, 5, 'ECO308'),
('ECO310', 'International Trade', 3, 3, 5, 'ECO309'),
('ECO311', 'Advanced Microeconomic Theory', 3, 3, 5, 'ECO309'),
('ECO312', 'Microeconometrics', 3, 3, 5, 'ECO310'),
('ECO401', 'Applied Microeconomics Research Seminar', 3, 3, 5, 'ECO311'),
('ECO402', 'Topics in Microeconomic Theory', 3, 3, 5, 'ECO311'),
('ECO403', 'Senior Thesis', 3, 3, 5, 'ECO401'),
('EEE111', 'Analog Electronics-I', 3, 1, NULL, 'EEE141'),
('EEE111L', 'Analog Electronics-I Lab', 1, 1, NULL, 'EEE141'),
('EEE141', 'Electrical Circuits I', 3, 1, NULL, 'MAT120'),
('EEE141L', 'Electrical Circuits I Lab', 1, 1, NULL, 'MAT120'),
('EEE154', 'Engineering Drawing', 1, 1, NULL, NULL),
('EEE211', 'Digital Logic Design', 3, 1, 2, 'EEE141'),
('EEE211L', 'Digital Logic Design Lab', 0, 1, 2, 'EEE141'),
('EEE221', 'Signals and Systems', 3, 1, 2, 'MAT350'),
('EEE241', 'Electrical Circuits II', 3, 1, 2, 'EEE141'),
('EEE241L', 'Electrical Circuits II Lab', 1, 1, 2, 'EEE141'),
('EEE299', 'Junior Design Project I', 1, 1, 2, 'EEE111'),
('EEE311', 'Analog Electronics II', 3, 1, 2, 'EEE111'),
('EEE311L', 'Analog Electronics II Lab', 1, 1, 2, 'EEE111'),
('EEE312', 'Power Electronics', 3, 1, 2, 'EEE211'),
('EEE312L', 'Power Electronics Lab', 0, 1, 2, 'EEE211'),
('EEE321', 'Introduction to Communications Systems', 3, 1, 2, 'EEE221'),
('EEE321L', 'Introduction to Communications Systems Lab', 0, 1, 2, 'EEE221'),
('EEE342', 'Control Engineering', 3, 1, 2, 'EEE221'),
('EEE342L', 'Control Engineering Lab', 1, 1, 2, 'EEE221'),
('EEE361', 'Electromagnetic Fields & Waves', 3, 1, 2, 'MAT350'),
('EEE362', 'Power Systems', 3, 1, 2, 'EEE241'),
('EEE362L', 'Power Systems Lab', 0, 1, 2, 'EEE241'),
('EEE363', 'Electrical Machines', 3, 1, 2, 'EEE241'),
('EEE363L', 'Electrical Machines Lab', 1, 1, 2, 'EEE241'),
('EEE452', 'Engineering Economics', 3, 1, NULL, NULL),
('EEE498', 'Co-op Research', 0, 1, 2, 'EEE363'),
('EEE499A', 'Senior Design I', 1.5, 1, 2, 'EEE299'),
('EEE499B', 'Senior Design II', 1.5, 1, 2, 'EEE499A'),
('ENG102', 'Introduction to Composition', 3, NULL, NULL, NULL),
('ENG103', 'Intermediate Composition', 3, NULL, NULL, 'ENG102'),
('ENG111', 'Public Speaking', 3, NULL, NULL, 'ENG103'),
('ENV203', 'Introduction to Bangladesh Geography', 3, NULL, NULL, NULL),
('ETE211', 'Digital Logic Design', 3, 1, 3, 'EEE141'),
('ETE211L', 'Digital Logic Design Lab', 0, 1, 3, 'EEE141'),
('ETE221', 'Signals and Systems', 3, 1, 3, 'MAT350'),
('ETE241', 'Electrical Circuits II', 3, 1, 3, 'EEE141'),
('ETE241L', 'Electrical Circuits II Lab', 1, 1, 3, 'EEE141'),
('ETE299', 'Junior Design Project I', 1, 1, 3, 'EEE111'),
('ETE311', 'Analog Electronics II', 3, 1, 3, 'EEE111'),
('ETE321', 'Introduction to Communications Systems', 3, 1, 3, 'ETE221'),
('ETE321L', 'Introduction to Communications Systems Lab', 0, 1, 3, 'ETE221'),
('ETE331', 'Data Communications & Networks', 3, 1, 3, 'ETE221'),
('ETE331L', 'Data Communications & Networks Lab', 0, 1, 3, 'ETE221'),
('ETE361', 'Electromagnetic Fields & Waves', 3, 1, 3, 'MAT350'),
('ETE422', 'Principles of Digital Communications', 3, 1, 3, NULL),
('ETE424', 'Mobile and Wireless Communication System', 3, 1, 3, 'ETE422'),
('ETE424L', 'Mobile and Wireless Communication System Lab', 1, 1, 3, 'ETE422'),
('ETE426', 'Fiber Optic Communication Systems', 3, 1, 3, 'ETE361'),
('ETE426L', 'Fiber Optic Communication Systems Lab', 1, 1, 3, 'ETE361'),
('ETE471', 'Digital Signal Processing', 3, 1, 3, 'ETE221'),
('ETE471L', 'Digital Signal Processing Lab', 0, 1, 3, 'ETE221'),
('ETE498', 'Directed Research', 0, 1, 3, 'ETE471'),
('ETE499A', 'Senior Design Project I', 1.5, 1, 3, 'ETE299'),
('ETE499B', 'Senior Design Project II', 1.5, 1, 3, 'ETE499A'),
('HIS101', 'Bangladesh Culture and Heritage', 3, NULL, NULL, NULL),
('HIS102', 'Introduction to World Civilization', 3, NULL, NULL, NULL),
('LAW101', 'Introductions to the Legal System & Legal Processes', 3, 2, 4, NULL),
('LAW107', 'The Law of Contract and Restitution', 4, 2, 4, 'LAW101'),
('LAW201', 'The Constitutional Law of Bangladesh', 4, 2, 4, 'LAW101'),
('LAW211', 'Family and property law', 4, 2, 4, 'LAW101'),
('LAW213', 'Law of Crimes', 4, 2, 4, 'LAW201'),
('LAW301', 'Law of Evidence and Medical Jurisprudence', 4, 2, 4, 'LAW213'),
('LAW303', 'Corporate Law', 3, 2, 4, 'LAW311'),
('LAW305', 'Legal Ethics', 4, 2, 4, 'LAW303'),
('LAW306', 'Alternative Dispute Resolution (ADR) Methods', 3, 2, 4, 'LAW305'),
('LAW311', 'Law of criminal Procedure', 4, 2, 4, 'LAW213'),
('LAW314', 'Legal Ethics', 3, 2, 4, 'LAW311'),
('LAW405', 'Labour and Employment Law', 3, 2, 4, 'LAW419'),
('LAW417', 'Property Law and Transfers', 4, 2, 4, 'LAW306'),
('LAW418', 'Legal Drafting (Civil and Criminal) and Conveyance', 4, 2, 4, 'LAW417'),
('LAW419', 'Fiscal and Taxation Law', 3, 2, 4, 'LAW417'),
('LAW420', 'Clinical Legal Education and community Legal Service', 4, 2, 4, 'LAW418'),
('LAW421', 'Public International Law', 3, 2, 4, 'LAW419'),
('MAT116', 'Pre-Calculus', 3, 1, NULL, NULL),
('MAT120', 'Calculus-I', 3, 1, NULL, 'MAT116'),
('MAT125', 'Linear Algebra', 3, 1, NULL, 'MAT116'),
('MAT130', 'Calculus II', 3, 1, NULL, 'MAT120'),
('MAT250', 'Calculus III', 3, 1, NULL, 'MAT130'),
('MAT350', 'Engineering Mathematics', 3, 1, NULL, 'MAT250'),
('MAT361', 'Probability and Statistics', 3, 1, NULL, 'MAT250'),
('PHI101', 'Introduction to Philosophy', 3, NULL, NULL, NULL),
('PHI104', 'Introduction to Ethics', 3, NULL, NULL, NULL),
('PHY107', 'Physics I', 3, 1, NULL, 'MAT120'),
('PHY108', 'Physics II', 3, 1, NULL, 'PHY107'),
('POL101', 'Introduction to Political Science', 3, NULL, NULL, NULL),
('POL104', 'Introduction to Governance', 3, NULL, NULL, NULL),
('SOC101', 'Introduction to Sociology', 3, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `DeptID` int(5) NOT NULL,
  `DeptName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`DeptID`, `DeptName`) VALUES
(1, 'ECE'),
(2, 'Law'),
(3, 'Economics'),
(4, 'Architecture'),
(5, 'Biochemistry');

-- --------------------------------------------------------

--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `SecID` int(3) NOT NULL,
  `CourseID` varchar(10) NOT NULL,
  `S_ID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `major`
--

CREATE TABLE `major` (
  `MajorID` int(5) NOT NULL,
  `MajorName` varchar(80) NOT NULL,
  `D_ID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `major`
--

INSERT INTO `major` (`MajorID`, `MajorName`, `D_ID`) VALUES
(1, 'Computer Science and Engineering', 1),
(2, 'Electrical and Electronic Engineering', 1),
(3, 'Electronics and Telecommunication Engineering', 1),
(4, 'LLB', 2),
(5, 'Microeconomics & Macroeconomics', 3),
(6, 'Architectural Design', 4),
(7, 'Bio-organic Chemistry', 5),
(8, 'Biotechnology and Bioengineering', 5);

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `NotificationID` int(5) NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Message` varchar(1000) DEFAULT NULL,
  `CourseID` varchar(10) NOT NULL,
  `SecID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `persons`
--

CREATE TABLE `persons` (
  `PersonID` int(5) NOT NULL,
  `R_ID` int(5) DEFAULT NULL,
  `Username` varchar(20) NOT NULL,
  `PhoneNumber` int(18) NOT NULL,
  `FirstName` varchar(10) NOT NULL,
  `MiddleName` varchar(25) DEFAULT NULL,
  `LastName` varchar(10) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `HouseNo` varchar(8) DEFAULT NULL,
  `StreetNo` varchar(8) DEFAULT NULL,
  `StreetName` varchar(50) DEFAULT NULL,
  `PostalCode` int(8) DEFAULT NULL,
  `RoleAssignedDate` date DEFAULT NULL,
  `RegCode` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `postcode`
--

CREATE TABLE `postcode` (
  `PostalCode` int(8) NOT NULL,
  `City` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `postcode`
--

INSERT INTO `postcode` (`PostalCode`, `City`) VALUES
(1000, 'Dhaka'),
(1203, 'Dhaka'),
(1204, 'Dhaka'),
(1205, 'Dhaka'),
(1206, 'Dhaka'),
(1207, 'Dhaka'),
(1236, 'Dhaka'),
(3000, 'Sylhet'),
(3001, 'Sylhet'),
(3002, 'Sylhet'),
(3010, 'Sylhet'),
(3020, 'Sylhet'),
(3064, 'Sylhet'),
(3081, 'Sylhet'),
(3401, 'Chittagong'),
(3414, 'Chittagong'),
(3419, 'Chittagong'),
(3452, 'Chittagong'),
(3461, 'Chittagong'),
(3518, 'Chittagong'),
(3521, 'Chittagong'),
(5041, 'Rangpur'),
(5103, 'Rangpur'),
(5130, 'Rangpur'),
(5201, 'Rangpur'),
(5216, 'Rangpur'),
(5226, 'Rangpur'),
(5241, 'Rangpur'),
(5826, 'Rajshahi'),
(5850, 'Rajshahi'),
(5880, 'Rajshahi'),
(5891, 'Rajshahi'),
(5892, 'Rajshahi'),
(5910, 'Rajshahi'),
(5941, 'Rajshahi'),
(7011, 'Khulna'),
(7020, 'Khulna'),
(7031, 'Khulna'),
(7042, 'Khulna'),
(7051, 'Khulna'),
(7052, 'Khulna'),
(7222, 'Khulna'),
(8513, 'Barisal'),
(8523, 'Barisal'),
(8550, 'Barisal'),
(8551, 'Barisal'),
(8562, 'Barisal'),
(8566, 'Barisal'),
(8603, 'Barisal');

-- --------------------------------------------------------

--
-- Table structure for table `prev_taken_courses`
--

CREATE TABLE `prev_taken_courses` (
  `S_ID` int(8) NOT NULL,
  `CourseCode` varchar(10) NOT NULL,
  `Semester` varchar(15) NOT NULL,
  `Year` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receivedby`
--

CREATE TABLE `receivedby` (
  `S_ID` int(8) NOT NULL,
  `Noti_ID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `CourseID` varchar(10) NOT NULL,
  `SectionNo` int(3) NOT NULL,
  `Semester` varchar(15) NOT NULL,
  `Year` int(5) NOT NULL,
  `T_ID` int(8) DEFAULT NULL,
  `AssignedDate` date DEFAULT NULL,
  `TotalSeats` int(5) DEFAULT NULL,
  `SeatsTaken` int(5) DEFAULT NULL,
  `ClassStartTime` varchar(20) DEFAULT NULL,
  `ClassEndTime` varchar(20) DEFAULT NULL,
  `ClassDays` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section`
--

INSERT INTO `section` (`CourseID`, `SectionNo`, `Semester`, `Year`, `T_ID`, `AssignedDate`, `TotalSeats`, `SeatsTaken`, `ClassStartTime`, `ClassEndTime`, `ClassDays`) VALUES
('ANT101', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ANT101', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ANT101', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ARC111', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ARC111', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ARC111', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ARC112', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ARC112', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ARC112', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ARC121', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('ARC121', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ARC121', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ARC122', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ARC122', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ARC122', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC133', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ARC133', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ARC133', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ARC200', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ARC200', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ARC200', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ARC213', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ARC213', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ARC213', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ARC214', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC214', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ARC214', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC215', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ARC215', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC215', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ARC241', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ARC241', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ARC241', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ARC242', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('ARC242', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ARC242', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC251', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ARC251', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ARC251', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ARC261', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ARC261', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC261', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ARC262', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ARC262', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ARC262', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ARC263', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ARC263', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ARC263', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ARC264', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ARC264', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ARC264', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ARC271', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ARC271', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC271', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ARC272', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ARC272', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ARC272', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC273', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ARC273', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ARC273', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('ARC281', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ARC281', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ARC281', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC282', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC282', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ARC282', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ARC283', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ARC283', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ARC283', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ARC316', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ARC316', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ARC316', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC317', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('ARC317', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ARC317', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ARC318', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC318', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ARC318', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ARC324', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ARC324', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('ARC324', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC334', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ARC334', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC334', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ARC343', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC343', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ARC343', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ARC344', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ARC344', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('ARC344', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ARC384', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC384', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ARC384', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ARC418', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ARC418', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ARC418', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ARC419', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ARC419', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ARC419', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ARC437', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ARC437', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ARC437', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC445', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ARC445', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC445', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ARC500', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ARC500', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ARC500', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ARC510', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ARC510', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ARC510', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC519', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ARC519', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ARC519', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ARC535', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ARC535', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ARC535', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ARC596', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ARC596', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ARC596', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('BIO103', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('BIO103', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('BIO103', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('BIO103L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('BIO103L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('BIO103L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('BIO104', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('BIO104', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('BIO104', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('BIO105', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('BIO105', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('BIO105', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('BIO201', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('BIO201', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('BIO201', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('BIO201L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('BIO201L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('BIO201L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('BIO203', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('BIO203', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('BIO203', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('BIO203L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('BIO203L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('BIO203L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('BIO301', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('BIO301', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('BIO301', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('BIO302', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('BIO302', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('BIO302', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('BIO303', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('BIO303', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('BIO303', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('BIO304', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('BIO304', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('BIO304', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('BIO305', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('BIO305', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('BIO305', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('BIO306', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('BIO306', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('BIO306', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('BIO307', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('BIO307', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('BIO307', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('BIO308', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('BIO308', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('BIO308', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('BIO309', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('BIO309', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('BIO309', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('BIO310', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('BIO310', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('BIO310', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('BIO401', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('BIO401', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('BIO401', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('BIO402', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('BIO402', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('BIO402', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('BIO403', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('BIO403', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('BIO403', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('BIO404', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('BIO404', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('BIO404', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('CHE101', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('CHE101', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('CHE101', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CHE101L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('CHE101L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('CHE101L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('CHE201', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('CHE201', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CHE201', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('CHE201L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CHE201L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('CHE201L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('CHE203', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('CHE203', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('CHE203', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CHE203L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('CHE203L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('CHE203L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('CHE301', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('CHE301', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CHE301', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('CHE301L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('CHE301L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('CHE301L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('CHE303', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('CHE303', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('CHE303', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('CHE304', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('CHE304', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('CHE304', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('CHE305', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('CHE305', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('CHE305', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('CHE306', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('CHE306', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('CHE306', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('CHE401', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CHE401', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('CHE401', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('CHE402', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('CHE402', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('CHE402', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CHE403', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('CHE403', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('CHE403', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('CHE404', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('CHE404', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('CHE404', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('CHE405', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('CHE405', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('CHE405', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('CHE406', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('CHE406', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('CHE406', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('CHE407', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('CHE407', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('CHE407', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CHE499', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('CHE499', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('CHE499', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('CSE115', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('CSE115', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('CSE115', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('CSE115L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('CSE115L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('CSE115L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('CSE173', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CSE173', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CSE173', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('CSE215', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('CSE215', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('CSE215', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CSE215L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('CSE215L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('CSE215L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('CSE225', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('CSE225', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('CSE225', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('CSE225L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('CSE225L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('CSE225L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CSE231', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('CSE231', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('CSE231', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CSE231L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('CSE231L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CSE231L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CSE299', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CSE299', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('CSE299', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('CSE311', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('CSE311', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('CSE311', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('CSE311L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('CSE311L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('CSE311L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('CSE323', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('CSE323', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('CSE323', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('CSE325', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('CSE325', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('CSE325', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('CSE327', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('CSE327', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('CSE327', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CSE331', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('CSE331', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CSE331', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('CSE331L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('CSE331L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('CSE331L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('CSE332', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('CSE332', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('CSE332', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('CSE332L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('CSE332L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('CSE332L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('CSE373', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('CSE373', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('CSE373', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('CSE498', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('CSE498', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('CSE498', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('CSE499A', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('CSE499A', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('CSE499A', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('CSE499B', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('CSE499B', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('CSE499B', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ECO101', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ECO101', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ECO101', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ECO104', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ECO104', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ECO104', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ECO201', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('ECO201', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ECO201', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ECO202', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ECO202', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ECO202', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ECO203', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ECO203', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ECO203', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ECO301', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ECO301', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ECO301', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ECO302', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ECO302', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ECO302', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ECO303', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ECO303', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ECO303', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ECO304', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ECO304', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ECO304', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ECO305', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ECO305', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ECO305', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ECO306', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ECO306', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ECO306', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ECO307', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ECO307', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ECO307', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ECO308', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ECO308', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ECO308', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ECO309', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ECO309', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ECO309', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ECO310', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ECO310', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ECO310', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ECO311', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ECO311', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ECO311', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ECO312', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ECO312', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('ECO312', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ECO401', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ECO401', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ECO401', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ECO402', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ECO402', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ECO402', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ECO403', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ECO403', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ECO403', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('EEE111', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('EEE111', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('EEE111', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('EEE111L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('EEE111L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('EEE111L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('EEE141', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('EEE141', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('EEE141', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('EEE141L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('EEE141L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('EEE141L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('EEE154', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('EEE154', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('EEE154', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('EEE211', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('EEE211', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('EEE211', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('EEE211L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('EEE211L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('EEE211L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('EEE221', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('EEE221', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('EEE221', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('EEE241', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('EEE241', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('EEE241', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('EEE241L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('EEE241L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('EEE241L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('EEE299', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('EEE299', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('EEE299', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('EEE311', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('EEE311', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('EEE311', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('EEE311L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('EEE311L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('EEE311L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('EEE312', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('EEE312', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('EEE312', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('EEE312L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('EEE312L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('EEE312L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('EEE321', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('EEE321', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('EEE321', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('EEE321L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('EEE321L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('EEE321L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('EEE342', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('EEE342', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('EEE342', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('EEE342L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('EEE342L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('EEE342L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('EEE361', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('EEE361', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('EEE361', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('EEE362', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('EEE362', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('EEE362', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('EEE362L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('EEE362L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('EEE362L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('EEE363', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('EEE363', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('EEE363', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('EEE363L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('EEE363L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('EEE363L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('EEE452', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('EEE452', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('EEE452', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('EEE498', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('EEE498', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('EEE498', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('EEE499A', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('EEE499A', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('EEE499A', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('EEE499B', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('EEE499B', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('EEE499B', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ENG102', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ENG102', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ENG102', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ENG103', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ENG103', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('ENG103', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ENG111', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ENG111', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ENG111', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ENV203', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ENV203', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ENV203', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ETE211', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ETE211', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ETE211', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ETE211L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ETE211L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ETE211L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('ETE221', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ETE221', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ETE221', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ETE241', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ETE241', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ETE241', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ETE241L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ETE241L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ETE241L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ETE299', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ETE299', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('ETE299', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ETE311', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('ETE311', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ETE311', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ETE321', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ETE321', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ETE321', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ETE321L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ETE321L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ETE321L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ETE331', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ETE331', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ETE331', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ETE331L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ETE331L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ETE331L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('ETE361', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ETE361', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ETE361', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ETE422', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('ETE422', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ETE422', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ETE424', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ETE424', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ETE424', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ETE424L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ETE424L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ETE424L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('ETE426', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ETE426', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('ETE426', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('ETE426L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ETE426L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ETE426L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ETE471', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ETE471', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ETE471', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ETE471L', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('ETE471L', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('ETE471L', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('ETE498', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ETE498', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ETE498', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('ETE499A', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('ETE499A', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('ETE499A', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('ETE499B', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('ETE499B', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('ETE499B', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('HIS101', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('HIS101', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('HIS101', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('HIS102', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('HIS102', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('HIS102', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('LAW101', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('LAW101', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('LAW101', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('LAW107', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('LAW107', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('LAW107', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('LAW201', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('LAW201', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('LAW201', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('LAW211', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('LAW211', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('LAW211', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('LAW213', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('LAW213', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('LAW213', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('LAW301', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('LAW301', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('LAW301', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('LAW303', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('LAW303', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('LAW303', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('LAW305', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('LAW305', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('LAW305', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('LAW306', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('LAW306', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('LAW306', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('LAW311', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('LAW311', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('LAW311', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('LAW314', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('LAW314', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('LAW314', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('LAW405', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'ST'),
('LAW405', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('LAW405', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('LAW417', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('LAW417', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('LAW417', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('LAW418', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('LAW418', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('LAW418', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('LAW419', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('LAW419', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('LAW419', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('LAW420', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('LAW420', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('LAW420', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('LAW421', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('LAW421', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('LAW421', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('MAT116', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('MAT116', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('MAT116', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('MAT120', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('MAT120', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('MAT120', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('MAT125', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('MAT125', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('MAT125', 3, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('MAT130', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('MAT130', 2, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('MAT130', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('MAT250', 1, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'RA'),
('MAT250', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('MAT250', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('MAT350', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'RA'),
('MAT350', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('MAT350', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'RA'),
('MAT361', 1, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'MW'),
('MAT361', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('MAT361', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'ST'),
('PHI101', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('PHI101', 2, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('PHI101', 3, 'Spring', 2025, NULL, NULL, 30, 0, '02:45 PM', '04:15 PM', 'ST'),
('PHI104', 1, 'Spring', 2025, NULL, '2024-12-05', 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('PHI104', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('PHI104', 3, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'RA'),
('PHY107', 1, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'MW'),
('PHY107', 2, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('PHY107', 3, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'ST'),
('PHY108', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('PHY108', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'ST'),
('PHY108', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('POL101', 1, 'Spring', 2025, NULL, NULL, 30, 0, '11:30 AM', '12:45 PM', 'MW'),
('POL101', 2, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA'),
('POL101', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'MW'),
('POL104', 1, 'Spring', 2025, NULL, NULL, 30, 0, '04:30 PM', '05:45 PM', 'MW'),
('POL104', 2, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'RA'),
('POL104', 3, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('SOC101', 1, 'Spring', 2025, NULL, NULL, 30, 0, '01:00 PM', '02:30 PM', 'MW'),
('SOC101', 2, 'Spring', 2025, NULL, NULL, 30, 0, '08:00 AM', '09:30 AM', 'ST'),
('SOC101', 3, 'Spring', 2025, NULL, NULL, 30, 0, '09:45 AM', '11:15 AM', 'RA');

-- --------------------------------------------------------

--
-- Table structure for table `selectedsections`
--

CREATE TABLE `selectedsections` (
  `CourseID` varchar(10) NOT NULL,
  `SectionNo` int(3) NOT NULL,
  `S_ID` int(8) DEFAULT NULL,
  `T_ID` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sentby`
--

CREATE TABLE `sentby` (
  `T_ID` int(8) NOT NULL,
  `Noti_ID` int(5) NOT NULL,
  `DatePosted` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `StudentID` int(8) NOT NULL,
  `P_ID` int(5) DEFAULT NULL,
  `D_ID` int(5) DEFAULT NULL,
  `M_ID` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `takes`
--

CREATE TABLE `takes` (
  `S_ID` int(8) NOT NULL,
  `CourseID` varchar(10) NOT NULL,
  `SecID` int(3) NOT NULL,
  `EnrollmentDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `TeacherID` int(8) NOT NULL,
  `P_ID` int(5) DEFAULT NULL,
  `D_ID` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userrole`
--

CREATE TABLE `userrole` (
  `RoleID` int(5) NOT NULL,
  `RoleName` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userrole`
--

INSERT INTO `userrole` (`RoleID`, `RoleName`) VALUES
(1, 'Student'),
(2, 'Teacher');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academicrecord`
--
ALTER TABLE `academicrecord`
  ADD PRIMARY KEY (`S_ID`),
  ADD KEY `CourseID` (`CourseID`),
  ADD KEY `SecNo` (`SecNo`);

--
-- Indexes for table `assigned_courses`
--
ALTER TABLE `assigned_courses`
  ADD PRIMARY KEY (`CourseID`,`SecID`,`T_ID`),
  ADD KEY `SecID` (`SecID`),
  ADD KEY `T_ID` (`T_ID`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`SecID`,`CourseID`,`S_ID`),
  ADD KEY `CourseID` (`CourseID`),
  ADD KEY `S_ID` (`S_ID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`CourseCode`),
  ADD KEY `D_ID` (`D_ID`),
  ADD KEY `CourseName` (`CourseName`),
  ADD KEY `Credits` (`Credits`),
  ADD KEY `M_ID` (`M_ID`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DeptID`);

--
-- Indexes for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD PRIMARY KEY (`SecID`,`CourseID`,`S_ID`),
  ADD KEY `CourseID` (`CourseID`),
  ADD KEY `S_ID` (`S_ID`);

--
-- Indexes for table `major`
--
ALTER TABLE `major`
  ADD PRIMARY KEY (`MajorID`),
  ADD KEY `D_ID` (`D_ID`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`NotificationID`),
  ADD KEY `CourseID` (`CourseID`),
  ADD KEY `SecID` (`SecID`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`PersonID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `PhoneNumber` (`PhoneNumber`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `R_ID` (`R_ID`),
  ADD KEY `StreetNo` (`StreetNo`),
  ADD KEY `PostalCode` (`PostalCode`);

--
-- Indexes for table `postcode`
--
ALTER TABLE `postcode`
  ADD PRIMARY KEY (`PostalCode`);

--
-- Indexes for table `prev_taken_courses`
--
ALTER TABLE `prev_taken_courses`
  ADD PRIMARY KEY (`S_ID`,`CourseCode`),
  ADD KEY `CourseCode` (`CourseCode`),
  ADD KEY `Semester` (`Semester`),
  ADD KEY `Year` (`Year`);

--
-- Indexes for table `receivedby`
--
ALTER TABLE `receivedby`
  ADD PRIMARY KEY (`S_ID`,`Noti_ID`),
  ADD KEY `Noti_ID` (`Noti_ID`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`CourseID`,`SectionNo`),
  ADD KEY `T_ID` (`T_ID`),
  ADD KEY `SectionNo` (`SectionNo`),
  ADD KEY `Semester` (`Semester`),
  ADD KEY `Year` (`Year`),
  ADD KEY `AssignedDate` (`AssignedDate`),
  ADD KEY `TotalSeats` (`TotalSeats`),
  ADD KEY `SeatsTaken` (`SeatsTaken`),
  ADD KEY `ClassStartTime` (`ClassStartTime`),
  ADD KEY `ClassEndTime` (`ClassEndTime`),
  ADD KEY `ClassDays` (`ClassDays`);

--
-- Indexes for table `selectedsections`
--
ALTER TABLE `selectedsections`
  ADD PRIMARY KEY (`CourseID`,`SectionNo`),
  ADD KEY `SectionNo` (`SectionNo`),
  ADD KEY `S_ID` (`S_ID`),
  ADD KEY `T_ID` (`T_ID`);

--
-- Indexes for table `sentby`
--
ALTER TABLE `sentby`
  ADD PRIMARY KEY (`T_ID`,`Noti_ID`),
  ADD KEY `Noti_ID` (`Noti_ID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`StudentID`),
  ADD KEY `P_ID` (`P_ID`),
  ADD KEY `D_ID` (`D_ID`),
  ADD KEY `M_ID` (`M_ID`);

--
-- Indexes for table `takes`
--
ALTER TABLE `takes`
  ADD PRIMARY KEY (`S_ID`,`CourseID`,`SecID`),
  ADD KEY `CourseID` (`CourseID`),
  ADD KEY `SecID` (`SecID`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`TeacherID`),
  ADD KEY `P_ID` (`P_ID`),
  ADD KEY `D_ID` (`D_ID`);

--
-- Indexes for table `userrole`
--
ALTER TABLE `userrole`
  ADD PRIMARY KEY (`RoleID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `DeptID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `major`
--
ALTER TABLE `major`
  MODIFY `MajorID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `NotificationID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `PersonID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `StudentID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `TeacherID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `userrole`
--
ALTER TABLE `userrole`
  MODIFY `RoleID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `academicrecord`
--
ALTER TABLE `academicrecord`
  ADD CONSTRAINT `academicrecord_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `academicrecord_ibfk_2` FOREIGN KEY (`S_ID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `academicrecord_ibfk_3` FOREIGN KEY (`SecNo`) REFERENCES `section` (`SectionNo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `assigned_courses`
--
ALTER TABLE `assigned_courses`
  ADD CONSTRAINT `assigned_courses_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `assigned_courses_ibfk_2` FOREIGN KEY (`SecID`) REFERENCES `section` (`SectionNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `assigned_courses_ibfk_3` FOREIGN KEY (`T_ID`) REFERENCES `teacher` (`TeacherID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`SecID`) REFERENCES `section` (`SectionNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_ibfk_3` FOREIGN KEY (`S_ID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`D_ID`) REFERENCES `department` (`DeptID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `course_ibfk_2` FOREIGN KEY (`M_ID`) REFERENCES `major` (`MajorID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`SecID`) REFERENCES `section` (`SectionNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `enrollment_ibfk_3` FOREIGN KEY (`S_ID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `major`
--
ALTER TABLE `major`
  ADD CONSTRAINT `major_ibfk_1` FOREIGN KEY (`D_ID`) REFERENCES `department` (`DeptID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`SecID`) REFERENCES `section` (`SectionNo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `persons`
--
ALTER TABLE `persons`
  ADD CONSTRAINT `persons_ibfk_1` FOREIGN KEY (`R_ID`) REFERENCES `userrole` (`RoleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `persons_ibfk_2` FOREIGN KEY (`PostalCode`) REFERENCES `postcode` (`PostalCode`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `prev_taken_courses`
--
ALTER TABLE `prev_taken_courses`
  ADD CONSTRAINT `prev_taken_courses_ibfk_1` FOREIGN KEY (`S_ID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prev_taken_courses_ibfk_2` FOREIGN KEY (`CourseCode`) REFERENCES `course` (`CourseCode`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `prev_taken_courses_ibfk_5` FOREIGN KEY (`Semester`) REFERENCES `section` (`Semester`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `prev_taken_courses_ibfk_6` FOREIGN KEY (`Year`) REFERENCES `section` (`Year`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `receivedby`
--
ALTER TABLE `receivedby`
  ADD CONSTRAINT `receivedby_ibfk_1` FOREIGN KEY (`S_ID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `receivedby_ibfk_2` FOREIGN KEY (`Noti_ID`) REFERENCES `notification` (`NotificationID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `section_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `section_ibfk_2` FOREIGN KEY (`T_ID`) REFERENCES `teacher` (`TeacherID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `selectedsections`
--
ALTER TABLE `selectedsections`
  ADD CONSTRAINT `selectedsections_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `selectedsections_ibfk_2` FOREIGN KEY (`SectionNo`) REFERENCES `section` (`SectionNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `selectedsections_ibfk_3` FOREIGN KEY (`S_ID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `selectedsections_ibfk_4` FOREIGN KEY (`T_ID`) REFERENCES `teacher` (`TeacherID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sentby`
--
ALTER TABLE `sentby`
  ADD CONSTRAINT `sentby_ibfk_1` FOREIGN KEY (`T_ID`) REFERENCES `teacher` (`TeacherID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sentby_ibfk_2` FOREIGN KEY (`Noti_ID`) REFERENCES `notification` (`NotificationID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`P_ID`) REFERENCES `persons` (`PersonID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_ibfk_2` FOREIGN KEY (`D_ID`) REFERENCES `department` (`DeptID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `student_ibfk_3` FOREIGN KEY (`M_ID`) REFERENCES `major` (`MajorID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `takes`
--
ALTER TABLE `takes`
  ADD CONSTRAINT `takes_ibfk_1` FOREIGN KEY (`S_ID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `takes_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `takes_ibfk_3` FOREIGN KEY (`SecID`) REFERENCES `section` (`SectionNo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`P_ID`) REFERENCES `persons` (`PersonID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`D_ID`) REFERENCES `department` (`DeptID`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
