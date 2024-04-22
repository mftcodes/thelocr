-- MySQL dump 10.13  Distrib 8.2.0, for Linux (x86_64)
--
-- Host: localhost    Database: minuchin
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addr_history`
--

DROP TABLE IF EXISTS `addr_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addr_history` (
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
  KEY `fk__addrhist_addruuid__addr_uuid` (`addr_uuid`),
  CONSTRAINT `fk__addrhist_addruuid__addr_uuid` FOREIGN KEY (`addr_uuid`) REFERENCES `address` (`addr_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addr_history`
--

LOCK TABLES `addr_history` WRITE;
/*!40000 ALTER TABLE `addr_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `addr_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (10,_binary 'ÂŸ`qîµB¬\0','4095 Legacy Parkway','Suite 500',NULL,'Lansing','Ingham','Michigan','48911-4264','2023-11-12 15:40:09','jeffcodes',NULL,NULL),(11,_binary 'Ö pîµB¬\0','123 Main St NE','Suite 100',NULL,'Grand Rapids','Kent','MI','49546','2023-11-12 17:26:33','jeffcodes',NULL,NULL),(12,_binary '>eT€ºî¢£B¬\0','675 Corner St NE','',NULL,'Grand Rapids','Kent','MI','49525','2023-11-13 00:19:00','jeffcodes',NULL,NULL),(13,_binary 'zG%þ\î\ÚB¬\0','379 First Ave',NULL,NULL,'Mount Pleasant','Isabella','MI','48858','2023-11-14 18:13:14','system',NULL,NULL),(14,_binary 'zL:\à\î\ÚB¬\0','82837 Stevens Ave',NULL,NULL,'Mount Pleasant','Isabella','MI','48858','2023-11-14 18:13:14','system',NULL,NULL),(15,_binary 'zPÔ\î\ÚB¬\0','987 Bridge St',NULL,NULL,'Mount Pleasant','Isabella','MI','48858','2023-11-14 18:13:14','system',NULL,NULL),(16,_binary 'zTZv\î\ÚB¬\0','3420 Main St',NULL,NULL,'Shepherd','Isabella','MI','48853','2023-11-14 18:13:14','system',NULL,NULL),(17,_binary '§G\æ\î\ÚB¬\0','3498 Main St',NULL,NULL,'Mount Pleasant','Isabella','MI','48858','2023-11-14 18:14:29','system',NULL,NULL),(18,_binary 'nJÑ\Û\î¶B¬\0','9887 Saginaw St',NULL,NULL,'Flint','Genesee','MI','48503','2023-11-15 17:21:36','system',NULL,NULL),(19,_binary '\à\Üy\ð\Ý\î¶B¬\0','2299 Center Road','#9393',NULL,'Burton','Genesee','MI','48519','2023-11-15 17:39:07','system',NULL,NULL),(20,_binary '\à\à¿\Ý\î¶B¬\0','7421 Main St',NULL,NULL,'Flushing','Genesee','MI','48433','2023-11-15 17:39:07','system',NULL,NULL),(21,_binary '\à\ä\ä2\Ý\î¶B¬\0','8080 Paul Fortino Dr',NULL,NULL,'Swartz Creek','Genesee','MI','48473','2023-11-15 17:39:07','system',NULL,NULL);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `cat_id` int NOT NULL AUTO_INCREMENT,
  `cat_title` varchar(50) NOT NULL,
  `cat_desc` varchar(250) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `uc__cat_title` (`cat_title`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'TEST CATEGORY','JUST A TEST','2023-11-14 17:52:38','jeffcodes',NULL,NULL),(8,'Disability Advocacy','Advocate service to work on behalf of this with disabilities.','2023-11-12 15:39:50','jeffcodes',NULL,NULL),(9,'Disability Services','Services to help those with disabilities.','2023-11-12 15:39:50','jeffcodes',NULL,NULL),(10,'Food Insecurity','Services to help obtian mails or food for home.','2023-11-12 15:39:50','jeffcodes',NULL,NULL),(11,'Homelessness General','Services to help those currently homless or facing potential homelessness','2023-11-12 15:39:50','jeffcodes',NULL,NULL),(12,'Homeless Shelters','Homeless Shelters','2023-11-12 15:39:50','jeffcodes',NULL,NULL),(13,'Substance Use and Abuse Treatment','Locations to recieve help with addiction and substance use disorders','2023-11-12 15:39:50','jeffcodes',NULL,NULL),(14,'Legal Aid','Legal aid for low income, imigrants, or otherwide disadvantaged.','2023-11-13 00:10:25','jeffcodes',NULL,NULL),(15,'Mental Health','Mental Health Services.','2023-11-15 17:00:35','jeffcodes',NULL,NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classification`
--

DROP TABLE IF EXISTS `classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classification` (
  `class_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL,
  `cat_id` int NOT NULL,
  PRIMARY KEY (`class_id`),
  KEY `fk__class_res_uuid__res_uuid` (`res_uuid`),
  KEY `fk__class_cat_id__cat_id` (`cat_id`),
  CONSTRAINT `fk__class_cat_id__cat_id` FOREIGN KEY (`cat_id`) REFERENCES `category` (`cat_id`),
  CONSTRAINT `fk__class_res_uuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classification`
--

LOCK TABLES `classification` WRITE;
/*!40000 ALTER TABLE `classification` DISABLE KEYS */;
INSERT INTO `classification` VALUES (12,_binary 'Âž\î,qîµB¬\0',9),(13,_binary '\ÒpîµB¬\0',10),(14,_binary '>c>ßºî¢£B¬\0',14),(15,_binary 'zE\ö=\î\ÚB¬\0',9),(16,_binary 'zKJ\î\ÚB¬\0',10),(17,_binary 'zP0Ò\î\ÚB¬\0',10),(18,_binary 'zSª\ä\î\ÚB¬\0',10),(19,_binary '§G\â\î\ÚB¬\0',8),(20,_binary 'nHE\Û\î¶B¬\0',15),(21,_binary '\à\ÛZÃ\Ý\î¶B¬\0',15),(22,_binary '\à\à·\Ý\î¶B¬\0',15),(23,_binary '\à\ä7\á\Ý\î¶B¬\0',15);
/*!40000 ALTER TABLE `classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `con_history`
--

DROP TABLE IF EXISTS `con_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `con_history` (
  `con_hist_id` int NOT NULL AUTO_INCREMENT,
  `con_uuid` binary(16) NOT NULL,
  `phone_1` varchar(25) DEFAULT NULL,
  `phone_2` varchar(25) DEFAULT NULL,
  `phone_tty` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `modified` datetime DEFAULT (now()),
  `modified_by` varchar(50) NOT NULL,
  PRIMARY KEY (`con_hist_id`),
  KEY `fk__conhist_con_uuid__contact_uuid` (`con_uuid`),
  CONSTRAINT `fk__conhist_con_uuid__contact_uuid` FOREIGN KEY (`con_uuid`) REFERENCES `contact` (`con_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `con_history`
--

LOCK TABLES `con_history` WRITE;
/*!40000 ALTER TABLE `con_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `con_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (9,_binary '\Â\Â;DqîµB¬\0','517.487.1755','800.288.5923','517.374.4687','517.487.0827',NULL,'2023-11-12 15:40:09','jeffcodes',NULL,NULL),(10,_binary 'Û«PîµB¬\0','616.666.0909','','','','info@foodbankbyjeff.com','2023-11-12 17:26:33','jeffcodes',NULL,NULL),(11,_binary '>gH«ºî¢£B¬\0','616.834.3245','','','','info@legalaidforyou.com','2023-11-13 00:19:00','jeffcodes',NULL,NULL),(12,_binary 'zH>²\î\ÚB¬\0','989.777.3252',NULL,'989.776.1231','989.777.2532',NULL,'2023-11-14 18:13:14','system',NULL,NULL),(13,_binary 'zL\ã[\î\ÚB¬\0','989.774.2828',NULL,NULL,NULL,'john.smith@aol.coml','2023-11-14 18:13:14','system',NULL,NULL),(14,_binary 'zQt±\î\ÚB¬\0','989.779.8888',NULL,NULL,NULL,'isabellasoupkitchen@gmail.com','2023-11-14 18:13:14','system',NULL,NULL),(15,_binary 'zU#\â\î\ÚB¬\0','989.998.3737','989.887.7777',NULL,'989.887.7788','info@mmsubtx.org','2023-11-14 18:13:14','system',NULL,NULL),(16,_binary '§H\î\ÚB¬\0','989.777.1234',NULL,NULL,'989.777.5678',NULL,'2023-11-14 18:14:29','system',NULL,NULL),(17,_binary 'nKSÅ\Û\î¶B¬\0','810.555.3444','810.555.9088','810.555.3455','810.555.3449','info@bewellflint.org','2023-11-15 17:21:36','system',NULL,NULL),(18,_binary '\à\Ý60\Ý\î¶B¬\0','810.555.7888',NULL,NULL,'810.555.7890','info@bewellflint.org','2023-11-15 17:39:07','system',NULL,NULL),(19,_binary '\à\á@\Ý\î¶B¬\0','810.555.1232',NULL,NULL,'810.555.1210','info@bewellflint.org','2023-11-15 17:39:07','system',NULL,NULL),(20,_binary '\à\åyº\Ý\î¶B¬\0','810.555.0001',NULL,NULL,'810.555.1000','info@bewellflint.org','2023-11-15 17:39:07','system',NULL,NULL);
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail`
--

DROP TABLE IF EXISTS `detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detail` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL,
  `addr_uuid` binary(16) DEFAULT NULL,
  `con_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `fk__det_res_uuid__res_uuid` (`res_uuid`),
  KEY `fk__det_addr_uuid__addr_uuid` (`addr_uuid`),
  KEY `fk__det_con_uuid__contact_uuid` (`con_uuid`),
  CONSTRAINT `fk__det_addr_uuid__addr_uuid` FOREIGN KEY (`addr_uuid`) REFERENCES `address` (`addr_uuid`),
  CONSTRAINT `fk__det_con_uuid__contact_uuid` FOREIGN KEY (`con_uuid`) REFERENCES `contact` (`con_uuid`),
  CONSTRAINT `fk__det_res_uuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail`
--

LOCK TABLES `detail` WRITE;
/*!40000 ALTER TABLE `detail` DISABLE KEYS */;
INSERT INTO `detail` VALUES (9,_binary 'Âž\î,qîµB¬\0',_binary 'ÂŸ`qîµB¬\0',_binary '\Â\Â;DqîµB¬\0'),(10,_binary '\ÒpîµB¬\0',_binary 'Ö pîµB¬\0',_binary 'Û«PîµB¬\0'),(11,_binary '>c>ßºî¢£B¬\0',_binary '>eT€ºî¢£B¬\0',_binary '>gH«ºî¢£B¬\0'),(12,_binary 'zE\ö=\î\ÚB¬\0',_binary 'zG%þ\î\ÚB¬\0',_binary 'zH>²\î\ÚB¬\0'),(13,_binary 'zKJ\î\ÚB¬\0',_binary 'zL:\à\î\ÚB¬\0',_binary 'zL\ã[\î\ÚB¬\0'),(14,_binary 'zP0Ò\î\ÚB¬\0',_binary 'zPÔ\î\ÚB¬\0',_binary 'zQt±\î\ÚB¬\0'),(15,_binary 'zSª\ä\î\ÚB¬\0',_binary 'zTZv\î\ÚB¬\0',_binary 'zU#\â\î\ÚB¬\0'),(16,_binary '§G\â\î\ÚB¬\0',_binary '§G\æ\î\ÚB¬\0',_binary '§H\î\ÚB¬\0'),(17,_binary 'nHE\Û\î¶B¬\0',_binary 'nJÑ\Û\î¶B¬\0',_binary 'nKSÅ\Û\î¶B¬\0'),(18,_binary '\à\ÛZÃ\Ý\î¶B¬\0',_binary '\à\Üy\ð\Ý\î¶B¬\0',_binary '\à\Ý60\Ý\î¶B¬\0'),(19,_binary '\à\à·\Ý\î¶B¬\0',_binary '\à\à¿\Ý\î¶B¬\0',_binary '\à\á@\Ý\î¶B¬\0'),(20,_binary '\à\ä7\á\Ý\î¶B¬\0',_binary '\à\ä\ä2\Ý\î¶B¬\0',_binary '\à\åyº\Ý\î¶B¬\0');
/*!40000 ALTER TABLE `detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edit`
--

DROP TABLE IF EXISTS `edit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edit` (
  `edit_id` int NOT NULL AUTO_INCREMENT,
  `user_uuid` binary(16) NOT NULL,
  `res_uuid` binary(16) NOT NULL,
  PRIMARY KEY (`edit_id`),
  KEY `fk__edit_useruuid__user_uuid` (`user_uuid`),
  KEY `fk__edit_resuuid__res_uuid` (`res_uuid`),
  CONSTRAINT `fk__edit_resuuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`),
  CONSTRAINT `fk__edit_useruuid__user_uuid` FOREIGN KEY (`user_uuid`) REFERENCES `user` (`user_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edit`
--

LOCK TABLES `edit` WRITE;
/*!40000 ALTER TABLE `edit` DISABLE KEYS */;
/*!40000 ALTER TABLE `edit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_history`
--

DROP TABLE IF EXISTS `res_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_history` (
  `res_hist_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL,
  `res_hist_title` varchar(100) NOT NULL,
  `res_hist_desc` varchar(2000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT b'0',
  `parent_uuid` binary(16) DEFAULT NULL,
  `is_statewide` bit(1) DEFAULT b'0',
  `is_nationwide` bit(1) DEFAULT b'0',
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`res_hist_id`),
  KEY `fk__reshist_resuuid__res_uuid` (`res_uuid`),
  CONSTRAINT `fk__reshist_resuuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_history`
--

LOCK TABLES `res_history` WRITE;
/*!40000 ALTER TABLE `res_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resource` (
  `res_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `res_title` varchar(100) NOT NULL,
  `res_desc` varchar(2000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `is_parent` bit(1) NOT NULL DEFAULT b'1',
  `parent_uuid` binary(16) DEFAULT NULL,
  `is_statewide` bit(1) DEFAULT b'0',
  `is_nationwide` bit(1) DEFAULT b'0',
  `keyword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `uc__res_uuid` (`res_uuid`),
  UNIQUE KEY `uc__res_title` (`res_title`),
  KEY `idx__res_keyword` (`keyword`),
  KEY `idx__is_statewide` (`is_statewide`),
  KEY `idx__is_nationwide` (`is_nationwide`),
  KEY `idx__res_parent_uuid` (`parent_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource`
--

LOCK TABLES `resource` WRITE;
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
INSERT INTO `resource` VALUES (13,_binary 'Âž\î,qîµB¬\0','Michigan Protection & Advocacy Services, Inc.','Protecting the Rights of Persons With Disabilities. MPAS has experience in addressing problems related to discrimination in education, employment, housing and access to public places. We may also be able to provide assistance regarding abuse and neglect, vocational rehabilitation, Medicaid and Medicare eligibility, Social Security overpayment, Community Mental Health, guardianship, institutional rights and voting accessibility.','www.mpas.org',_binary '',NULL,_binary '',_binary '\0','disability|disabilities|advocacy|advocate|representation','2023-11-12 15:40:09','jeffcodes',NULL,NULL),(15,_binary '\ÒpîµB¬\0','TEST Jeffs Food Bank','TEST Place to get food.','www.foodbankbyjeff.com',_binary '',NULL,_binary '\0',_binary '\0','food|food bank|food insecurity','2023-11-12 17:26:33','jeffcodes',NULL,NULL),(16,_binary '>c>ßºî¢£B¬\0','TEST Amanda\'s Legal Aid','TEST Low cost or free legal aid for those in need.','www.legalaidforyou.com',_binary '',NULL,_binary '',_binary '\0','legal|legal aid','2023-11-13 00:19:00','jeffcodes',NULL,NULL),(17,_binary 'zE\ö=\î\ÚB¬\0','AAA Disability Services','Disability Services.','www.aaads.com',_binary '',NULL,_binary '\0',_binary '\0','disability|disability servcies|disabilities','2023-11-14 18:13:14','system',NULL,NULL),(18,_binary 'zKJ\î\ÚB¬\0','MTP Food Bank','Low cost and free food based on income and need.',NULL,_binary '',NULL,_binary '\0',_binary '\0','food|food insecurity|food bank','2023-11-14 18:13:14','system',NULL,NULL),(19,_binary 'zP0Ò\î\ÚB¬\0','Isabella Soup Kitchen','Soup kitchen serving 2 meals a day, lunch and dinner.',NULL,_binary '',NULL,_binary '\0',_binary '\0','food|food insecurity|soup kitchen|meals','2023-11-14 18:13:14','system',NULL,NULL),(20,_binary 'zSª\ä\î\ÚB¬\0','Mid-Michigan Substance Treatment','Substance use disorder treatment for Mid-Michigan.','www.mmsubtx.org',_binary '',NULL,_binary '\0',_binary '\0','sud|substance|treatment','2023-11-14 18:13:14','system',NULL,NULL),(21,_binary '§G\â\î\ÚB¬\0','A1 Disability Advocacy Services','Disability Advocacy Services.','www.a1das.com',_binary '',NULL,_binary '\0',_binary '\0','disability|disability servcies|disability advocate|disabilities','2023-11-14 18:14:29','system',NULL,NULL),(22,_binary 'nHE\Û\î¶B¬\0','Be Well Services (Main Office)','Therapy, psychiatry, SUD, testing, chilren, families... you name it, we got it covered!','www.bewellflint.org',_binary '',NULL,_binary '\0',_binary '\0','MH|MI|mental health|mental illness|therapy|psychiatry|testing','2023-11-15 17:21:36','system',NULL,NULL),(23,_binary '\à\ÛZÃ\Ý\î¶B¬\0','Be Well Services (Burton Office)','Therapy, psychiatry, SUD, testing, chilren, families... you name it, we got it covered!','www.bewellflint.org',_binary '\0',_binary 'nHE\Û\î¶B¬\0',_binary '\0',_binary '\0','MH|MI|mental health|mental illness|therapy|psychiatry|testing','2023-11-15 17:39:07','system',NULL,NULL),(24,_binary '\à\à·\Ý\î¶B¬\0','Be Well Services (Flushing Office)','Therapy, psychiatry, SUD, testing, chilren, families... you name it, we got it covered!','www.bewellflint.org',_binary '\0',_binary 'nHE\Û\î¶B¬\0',_binary '\0',_binary '\0','MH|MI|mental health|mental illness|therapy|psychiatry|testing','2023-11-15 17:39:07','system',NULL,NULL),(25,_binary '\à\ä7\á\Ý\î¶B¬\0','Be Well Services (Swartz Creek Office)','Therapy, psychiatry, SUD, testing, chilren, families... you name it, we got it covered!','www.bewellflint.org',_binary '\0',_binary 'nHE\Û\î¶B¬\0',_binary '\0',_binary '\0','MH|MI|mental health|mental illness|therapy|psychiatry|testing','2023-11-15 17:39:07','system',NULL,NULL);
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,_binary '\ÍXoîµB¬\0','jeff.codes@pm.me','jeffcodes','Jeff','Stewart','projectbowengo',_binary '','2023-11-12 15:23:59',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-15 17:59:54