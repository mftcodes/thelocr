-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 08, 2023 at 10:08 AM
-- Server version: 8.0.35-0ubuntu0.22.04.1
-- PHP Version: 8.1.2-1ubuntu2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `minuchin`
--
CREATE DATABASE IF NOT EXISTS `minuchin` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `minuchin`;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE IF NOT EXISTS `address` (
  `addr_id` int NOT NULL AUTO_INCREMENT,
  `addr_uuid` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `line_1` varchar(100) NOT NULL,
  `line_2` varchar(100) DEFAULT NULL,
  `line_3` varchar(100) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `county` varchar(50) DEFAULT NULL,
  `state` varchar(100) NOT NULL,
  `postal_code` varchar(25) NOT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`addr_id`),
  UNIQUE KEY `uc__addr_uuid` (`addr_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`addr_id`, `addr_uuid`, `line_1`, `line_2`, `line_3`, `city`, `county`, `state`, `postal_code`, `created`, `created_by`, `modified`, `modified_by`) VALUES
(1, 0x18571894777f11ee9556dca63203731c, '4095 Legacy Parkway', 'Suite 500', NULL, 'Lansing', 'Ingham', 'Michigan', '48911-4264', '2023-10-31 13:58:41', 'jeffcodes', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `addr_history`
--

DROP TABLE IF EXISTS `addr_history`;
CREATE TABLE IF NOT EXISTS `addr_history` (
  `addr_hist_id` int NOT NULL AUTO_INCREMENT,
  `addr_uuid` binary(16) NOT NULL,
  `line_1` varchar(100) NOT NULL,
  `line_2` varchar(100) DEFAULT NULL,
  `line_3` varchar(100) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `county` varchar(50) DEFAULT NULL,
  `state` varchar(100) NOT NULL,
  `postal_code` varchar(25) NOT NULL,
  `modified` datetime NOT NULL DEFAULT (now()),
  `modified_by` varchar(50) NOT NULL,
  PRIMARY KEY (`addr_hist_id`),
  KEY `fk__addrhist_addruuid__addr_uuid` (`addr_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `cat_id` int NOT NULL AUTO_INCREMENT,
  `cat_title` varchar(50) NOT NULL,
  `cat_desc` varchar(250) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `uc__cat_title` (`cat_title`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`cat_id`, `cat_title`, `cat_desc`, `created`, `created_by`, `modified`, `modified_by`) VALUES
(1, 'Disability Advocacy', 'Community Advocates for those with disabilities.', '2023-10-31 13:58:41', 'jeffcodes', NULL, NULL),
(2, 'Disability Services', 'Direct Care Services to help those with disabilities.', '2023-10-31 13:58:41', 'jeffcodes', NULL, NULL),
(3, 'Homeless Shelters', 'Homeless Shelters', '2023-10-31 13:58:41', 'jeffcodes', NULL, NULL),
(4, 'Food Insecurity', 'Services to help obtian mails or food for home.', '2023-10-31 13:58:41', 'jeffcodes', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `classification`
--

DROP TABLE IF EXISTS `classification`;
CREATE TABLE IF NOT EXISTS `classification` (
  `class_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL,
  `cat_id` int NOT NULL,
  PRIMARY KEY (`class_id`),
  KEY `fk__class_res_uuid__res_uuid` (`res_uuid`),
  KEY `fk__class_cat_id__cat_id` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `classification`
--

INSERT INTO `classification` (`class_id`, `res_uuid`, `cat_id`) VALUES
(1, 0x40aa8215777e11ee9556dca63203731c, 2),
(2, 0x40aa8215777e11ee9556dca63203731c, 1);

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `con_id` int NOT NULL AUTO_INCREMENT,
  `con_uuid` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `phone_1` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone_2` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone_tty` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`con_id`),
  UNIQUE KEY `uc__con_uuid` (`con_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`con_id`, `con_uuid`, `phone_1`, `phone_2`, `phone_tty`, `fax`, `email`, `created`, `created_by`, `modified`, `modified_by`) VALUES
(1, 0x10b4f40d778011ee9556dca63203731c, '517.487.1755', '800.288.5923', '517.374.4687', '517.487.0827', NULL, '2023-10-31 13:58:41', 'jeffcodes]', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `con_history`
--

DROP TABLE IF EXISTS `con_history`;
CREATE TABLE IF NOT EXISTS `con_history` (
  `con_hist_id` int NOT NULL AUTO_INCREMENT,
  `con_uuid` binary(16) NOT NULL,
  `phone_prime` varchar(25) DEFAULT NULL,
  `phone_second` varchar(25) DEFAULT NULL,
  `phone_tty` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `modified` datetime DEFAULT (now()),
  `modified_by` varchar(50) NOT NULL,
  PRIMARY KEY (`con_hist_id`),
  KEY `fk__conhist_con_uuid__contact_uuid` (`con_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail`
--

DROP TABLE IF EXISTS `detail`;
CREATE TABLE IF NOT EXISTS `detail` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL,
  `addr_uuid` binary(16) DEFAULT NULL,
  `con_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `fk__det_res_uuid__res_uuid` (`res_uuid`),
  KEY `fk__det_addr_uuid__addr_uuid` (`addr_uuid`),
  KEY `fk__det_con_uuid__contact_uuid` (`con_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `detail`
--

INSERT INTO `detail` (`detail_id`, `res_uuid`, `addr_uuid`, `con_uuid`) VALUES
(1, 0x40aa8215777e11ee9556dca63203731c, 0x18571894777f11ee9556dca63203731c, 0x10b4f40d778011ee9556dca63203731c);

-- --------------------------------------------------------

--
-- Table structure for table `edit`
--

DROP TABLE IF EXISTS `edit`;
CREATE TABLE IF NOT EXISTS `edit` (
  `edit_id` int NOT NULL AUTO_INCREMENT,
  `user_uuid` binary(16) NOT NULL,
  `res_uuid` binary(16) NOT NULL,
  PRIMARY KEY (`edit_id`),
  KEY `fk__edit_useruuid__user_uuid` (`user_uuid`),
  KEY `fk__edit_resuuid__res_uuid` (`res_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
CREATE TABLE IF NOT EXISTS `resource` (
  `res_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `res_title` varchar(100) NOT NULL,
  `res_desc` varchar(2000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `is_parent` bit(1) NOT NULL DEFAULT b'1',
  `child_uuid` binary(16) DEFAULT NULL,
  `keyword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `uc__res_uuid` (`res_uuid`),
  UNIQUE KEY `uc__res_title` (`res_title`),
  KEY `idx__res_childuuid` (`child_uuid`),
  KEY `idx__res_keyword` (`keyword`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `resource`
--

INSERT INTO `resource` (`res_id`, `res_uuid`, `res_title`, `res_desc`, `url`, `is_parent`, `child_uuid`, `keyword`, `created`, `created_by`, `modified`, `modified_by`) VALUES
(1, 0x40aa8215777e11ee9556dca63203731c, 'Michigan Protection & Advocacy Services, Inc.', 'Protecting the Rights of Persons With Disabilities. MPAS has experience in addressing problems related to discrimination in education, employment, housing and access to public places. We may also be able to provide assistance regarding abuse and neglect, vocational rehabilitation, Medicaid and Medicare eligibility, Social Security overpayment, Community Mental Health, guardianship, institutional rights and voting accessibility.', 'www.mpas.org', b'1', NULL, 'disability|disabilities|advocacy|advocate|representation', '2023-10-31 13:58:41', 'jeffcodes', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `res_history`
--

DROP TABLE IF EXISTS `res_history`;
CREATE TABLE IF NOT EXISTS `res_history` (
  `res_hist_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL,
  `res_hist_title` varchar(100) NOT NULL,
  `res_hist_desc` varchar(2000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`res_hist_id`),
  KEY `fk__reshist_resuuid__res_uuid` (`res_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_uuid` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `user_email` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `password` char(60) NOT NULL,
  `can_edit` bit(1) NOT NULL DEFAULT b'1',
  `created` datetime NOT NULL DEFAULT (now()),
  `modified` datetime DEFAULT NULL,
  `modified_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uc__uuid` (`user_uuid`),
  UNIQUE KEY `uc__user_email` (`user_email`),
  UNIQUE KEY `uc__username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_uuid`, `user_email`, `username`, `first_name`, `last_name`, `password`, `can_edit`, `created`, `modified`, `modified_by`) VALUES
(1, 0x47c6ccab775c11ee9556dca63203731c, 'jeff@codingtherapist.com', 'jeffcodes', 'Jeff', 'Stewart', 'password', b'1', '2023-10-31 14:13:42', NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addr_history`
--
ALTER TABLE `addr_history`
  ADD CONSTRAINT `fk__addrhist_addruuid__addr_uuid` FOREIGN KEY (`addr_uuid`) REFERENCES `address` (`addr_uuid`);

--
-- Constraints for table `classification`
--
ALTER TABLE `classification`
  ADD CONSTRAINT `fk__class_cat_id__cat_id` FOREIGN KEY (`cat_id`) REFERENCES `category` (`cat_id`),
  ADD CONSTRAINT `fk__class_res_uuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`);

--
-- Constraints for table `con_history`
--
ALTER TABLE `con_history`
  ADD CONSTRAINT `fk__conhist_con_uuid__contact_uuid` FOREIGN KEY (`con_uuid`) REFERENCES `contact` (`con_uuid`);

--
-- Constraints for table `detail`
--
ALTER TABLE `detail`
  ADD CONSTRAINT `fk__det_addr_uuid__addr_uuid` FOREIGN KEY (`addr_uuid`) REFERENCES `address` (`addr_uuid`),
  ADD CONSTRAINT `fk__det_con_uuid__contact_uuid` FOREIGN KEY (`con_uuid`) REFERENCES `contact` (`con_uuid`),
  ADD CONSTRAINT `fk__det_res_uuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`);

--
-- Constraints for table `edit`
--
ALTER TABLE `edit`
  ADD CONSTRAINT `fk__edit_resuuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`),
  ADD CONSTRAINT `fk__edit_useruuid__user_uuid` FOREIGN KEY (`user_uuid`) REFERENCES `user` (`user_uuid`);

--
-- Constraints for table `res_history`
--
ALTER TABLE `res_history`
  ADD CONSTRAINT `fk__reshist_resuuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
