-- MySQL dump 10.13  Distrib 5.7.15, for Linux (x86_64)
--
-- Host: localhost    Database: JNH
-- ------------------------------------------------------
-- Server version	5.7.15-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admission_schedule`
--

DROP TABLE IF EXISTS `admission_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission_schedule` (
  `admission_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(30) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `remarks` varchar(255) NOT NULL,
  `admission_type` tinyint(4) DEFAULT NULL,
  `admission_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `adm_date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bed` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`admission_id`),
  KEY `fk_Patient_admission` (`patient_id`),
  KEY `adm_typr_fk` (`admission_type`),
  KEY `bed_adm_fk` (`bed`),
  CONSTRAINT `adm_typr_fk` FOREIGN KEY (`admission_type`) REFERENCES `admission_type` (`type_id`),
  CONSTRAINT `bed_adm_fk` FOREIGN KEY (`bed`) REFERENCES `beds` (`bed_id`),
  CONSTRAINT `fk_Patient_admission` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_schedule`
--

LOCK TABLES `admission_schedule` WRITE;
/*!40000 ALTER TABLE `admission_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `admission_schedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_addmission_stats` AFTER UPDATE ON `admission_schedule` FOR EACH ROW BEGIN
	
	insert ignore into discharge_schedule(patient_id,admission_id)
    select patient_id,admission_id from admission_schedule
    where status = 2; 
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `admission_type`
--

DROP TABLE IF EXISTS `admission_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission_type` (
  `type_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) NOT NULL,
  `type_description` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `type_name` (`type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_type`
--

LOCK TABLES `admission_type` WRITE;
/*!40000 ALTER TABLE `admission_type` DISABLE KEYS */;
INSERT INTO `admission_type` VALUES (1,'ER','Emergency Room Admittance'),(2,'OR','Operating Room Admittance'),(3,'ICU','ICU Admittance'),(4,'Private','Private Room Admittance'),(5,'Ward','Ward Room Admittance');
/*!40000 ALTER TABLE `admission_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admitting_diagnosis`
--

DROP TABLE IF EXISTS `admitting_diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admitting_diagnosis` (
  `diagnosis_id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_name` varchar(255) NOT NULL,
  `diagnosis_desc` varchar(255) NOT NULL,
  `patient_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`diagnosis_id`),
  KEY `fk_Patient` (`patient_id`),
  CONSTRAINT `fk_Patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admitting_diagnosis`
--

LOCK TABLES `admitting_diagnosis` WRITE;
/*!40000 ALTER TABLE `admitting_diagnosis` DISABLE KEYS */;
/*!40000 ALTER TABLE `admitting_diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admitting_resident`
--

DROP TABLE IF EXISTS `admitting_resident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admitting_resident` (
  `resident_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL DEFAULT '0',
  `patient_id` varchar(30) DEFAULT NULL,
  `user_id_fk` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resident_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_Patient_admitting` (`patient_id`),
  KEY `fk_userid_1` (`user_id_fk`),
  CONSTRAINT `fk_Patient_admitting` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_userid_1` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admitting_resident`
--

LOCK TABLES `admitting_resident` WRITE;
/*!40000 ALTER TABLE `admitting_resident` DISABLE KEYS */;
INSERT INTO `admitting_resident` VALUES (1,'USER-00016','PTNT-000001','USER-00016'),(2,'USER-00016','PTNT-000351','USER-00016');
/*!40000 ALTER TABLE `admitting_resident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attending_physician`
--

DROP TABLE IF EXISTS `attending_physician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attending_physician` (
  `attending_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL DEFAULT '0',
  `patient_id` varchar(30) DEFAULT NULL,
  `user_id_fk` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`attending_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_Patient_attending` (`patient_id`),
  KEY `fk_userid_2` (`user_id_fk`),
  CONSTRAINT `fk_Patient_attending` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_userid_2` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attending_physician`
--

LOCK TABLES `attending_physician` WRITE;
/*!40000 ALTER TABLE `attending_physician` DISABLE KEYS */;
/*!40000 ALTER TABLE `attending_physician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_bill_seq`
--

DROP TABLE IF EXISTS `bed_bill_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_bill_seq` (
  `bed_bill_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`bed_bill_seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_bill_seq`
--

LOCK TABLES `bed_bill_seq` WRITE;
/*!40000 ALTER TABLE `bed_bill_seq` DISABLE KEYS */;
INSERT INTO `bed_bill_seq` VALUES (2),(3),(4),(5),(6),(12),(13),(14),(15),(16),(17),(18),(19),(20);
/*!40000 ALTER TABLE `bed_bill_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_billing`
--

DROP TABLE IF EXISTS `bed_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_billing` (
  `bed_bill_id` varchar(30) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT 'Beds',
  `bill_name` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `bed_bill_status` tinyint(4) DEFAULT '0',
  `patient_id` varchar(30) NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `admission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bed_bill_id`),
  KEY `fk_bed_patient` (`patient_id`),
  KEY `adm_id` (`admission_id`),
  CONSTRAINT `adm_id` FOREIGN KEY (`admission_id`) REFERENCES `admission_schedule` (`admission_id`),
  CONSTRAINT `fk_bed_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_billing`
--

LOCK TABLES `bed_billing` WRITE;
/*!40000 ALTER TABLE `bed_billing` DISABLE KEYS */;
INSERT INTO `bed_billing` VALUES ('BED-BLL-000020','sample','sample',6500,0,'PTNT-000001','2017-01-07 00:19:20','2017-01-06 08:16:22',NULL);
/*!40000 ALTER TABLE `bed_billing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_bed_bill` BEFORE INSERT ON `bed_billing` FOR EACH ROW BEGIN
  INSERT INTO bed_bill_seq VALUES (NULL);
  SET NEW.bed_bill_id = CONCAT('BED-BLL-', LPAD(LAST_INSERT_ID(), 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bed_prices`
--

DROP TABLE IF EXISTS `bed_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_prices` (
  `bed_price_id` int(11) NOT NULL AUTO_INCREMENT,
  `bed_price` float(10,2) NOT NULL,
  PRIMARY KEY (`bed_price_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_prices`
--

LOCK TABLES `bed_prices` WRITE;
/*!40000 ALTER TABLE `bed_prices` DISABLE KEYS */;
INSERT INTO `bed_prices` VALUES (1,500.00);
/*!40000 ALTER TABLE `bed_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_sequence`
--

DROP TABLE IF EXISTS `bed_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_sequence` (
  `bed_sequence_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`bed_sequence_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_sequence`
--

LOCK TABLES `bed_sequence` WRITE;
/*!40000 ALTER TABLE `bed_sequence` DISABLE KEYS */;
INSERT INTO `bed_sequence` VALUES (1);
/*!40000 ALTER TABLE `bed_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beds`
--

DROP TABLE IF EXISTS `beds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beds` (
  `bed_id` varchar(30) NOT NULL,
  `bed_roomid` int(11) NOT NULL,
  `bed_maintenance` tinyint(4) NOT NULL DEFAULT '0',
  `bed_patient` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`bed_id`),
  KEY `fk_bed_pat` (`bed_patient`),
  KEY `fk_room_id` (`bed_roomid`),
  CONSTRAINT `fk_bed_pat` FOREIGN KEY (`bed_patient`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_room_id` FOREIGN KEY (`bed_roomid`) REFERENCES `rooms` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beds`
--

LOCK TABLES `beds` WRITE;
/*!40000 ALTER TABLE `beds` DISABLE KEYS */;
INSERT INTO `beds` VALUES ('BED-0001',1,0,'PTNT-000001');
/*!40000 ALTER TABLE `beds` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_bed_seq` BEFORE INSERT ON `beds` FOR EACH ROW BEGIN
  INSERT INTO bed_sequence VALUES (NULL);
  SET NEW.bed_id = CONCAT('BED-', LPAD(LAST_INSERT_ID(), 4, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing` (
  `transaction_id` varchar(30) NOT NULL,
  `patient_id` varchar(30) NOT NULL,
  `room_billing_ids` text NOT NULL,
  `pharm_billing_ids` text NOT NULL,
  `lab_billing_ids` text NOT NULL,
  `rad_billing_ids` text NOT NULL,
  `csr_billing_ids` text NOT NULL,
  `professional_fee` text NOT NULL,
  `total_bill` float NOT NULL,
  `bill_status` tinyint(4) NOT NULL DEFAULT '0',
  `date_submitted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `room_price` float DEFAULT NULL,
  `pharm_price` float DEFAULT NULL,
  `lab_price` float DEFAULT NULL,
  `rad_price` float DEFAULT NULL,
  `csr_price` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing`
--

LOCK TABLES `billing` WRITE;
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
INSERT INTO `billing` VALUES ('BLL-000002','PTNT-000001','BED-BLL-000009,BED-BLL-000010,BED-BLL-000011','','LAB-BLL-000002','RAD-BLL-000006,RAD-BLL-000007','CSR-BLL-000004','',5670,0,'2017-01-01 05:56:02',NULL,NULL,NULL,NULL,NULL),('BLL-000003','PTNT-000001','BED-BLL-000009,BED-BLL-000010,BED-BLL-000011','','LAB-BLL-000002','RAD-BLL-000006,RAD-BLL-000007','CSR-BLL-000004','',5670,0,'2017-01-01 05:56:22',NULL,NULL,NULL,NULL,NULL),('BLL-000004','PTNT-000001','BED-BLL-000009,BED-BLL-000010,BED-BLL-000011','','LAB-BLL-000002','RAD-BLL-000006,RAD-BLL-000007','CSR-BLL-000004','',5670,0,'2017-01-01 05:57:31',NULL,NULL,NULL,NULL,NULL),('BLL-000005','PTNT-000001','BED-BLL-000009,BED-BLL-000010,BED-BLL-000011','','LAB-BLL-000002','RAD-BLL-000006,RAD-BLL-000007','CSR-BLL-000004','',5670,0,'2017-01-01 05:57:46',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_billing` BEFORE INSERT ON `billing` FOR EACH ROW BEGIN
  INSERT INTO billing_seq VALUES (NULL);
  SET NEW.transaction_id = CONCAT('BLL-', LPAD(LAST_INSERT_ID(), 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `billing_percentage`
--

DROP TABLE IF EXISTS `billing_percentage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_percentage` (
  `perc_idd` int(11) NOT NULL AUTO_INCREMENT,
  `item_code_fk` varchar(30) DEFAULT NULL,
  `opd_cash` float(12,2) NOT NULL,
  `ward` float(12,2) NOT NULL,
  `semi_private` float(12,2) NOT NULL,
  `private_er` float(12,2) NOT NULL,
  `deluxe_nicu` float(12,2) NOT NULL,
  `icu_isolation` float(12,2) NOT NULL,
  `exec_suite` float(12,2) NOT NULL,
  `presidential` float(12,2) NOT NULL,
  `hmo_opd_cash` float(12,2) NOT NULL,
  `hmo_ward` float(12,2) NOT NULL,
  `hmo_semi_private` float(12,2) NOT NULL,
  `hmo_private_er` float(12,2) NOT NULL,
  `hmo_isolation_icu` float(12,2) NOT NULL,
  `hmo_exec_suite` float(12,2) NOT NULL,
  `hmo_presidential` float(12,2) NOT NULL,
  PRIMARY KEY (`perc_idd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_percentage`
--

LOCK TABLES `billing_percentage` WRITE;
/*!40000 ALTER TABLE `billing_percentage` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_percentage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_seq`
--

DROP TABLE IF EXISTS `billing_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_seq` (
  `bill_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`bill_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_seq`
--

LOCK TABLES `billing_seq` WRITE;
/*!40000 ALTER TABLE `billing_seq` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_request`
--

DROP TABLE IF EXISTS `change_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_request` (
  `change_id` varchar(30) NOT NULL,
  `users_id` varchar(30) NOT NULL,
  `date_req` datetime NOT NULL,
  `change_stat` tinyint(4) NOT NULL,
  PRIMARY KEY (`change_id`),
  KEY `fk_usersid` (`users_id`),
  CONSTRAINT `fk_usersid` FOREIGN KEY (`users_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_request`
--

LOCK TABLES `change_request` WRITE;
/*!40000 ALTER TABLE `change_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_request` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_change` BEFORE INSERT ON `change_request` FOR EACH ROW BEGIN
  INSERT INTO change_sequence VALUES (NULL);
  SET NEW.change_id = CONCAT('CHNGE-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `change_sequence`
--

DROP TABLE IF EXISTS `change_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_sequence` (
  `changeseq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`changeseq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_sequence`
--

LOCK TABLES `change_sequence` WRITE;
/*!40000 ALTER TABLE `change_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csr_bill_seq`
--

DROP TABLE IF EXISTS `csr_bill_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csr_bill_seq` (
  `csr_bill_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`csr_bill_seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csr_bill_seq`
--

LOCK TABLES `csr_bill_seq` WRITE;
/*!40000 ALTER TABLE `csr_bill_seq` DISABLE KEYS */;
INSERT INTO `csr_bill_seq` VALUES (1),(2),(3);
/*!40000 ALTER TABLE `csr_bill_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csr_billing`
--

DROP TABLE IF EXISTS `csr_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csr_billing` (
  `csr_bill_id` varchar(30) CHARACTER SET latin1 NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 NOT NULL,
  `bill_name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `price` float DEFAULT NULL,
  `csr_bill_status` tinyint(4) NOT NULL DEFAULT '0',
  `patient_id` varchar(30) NOT NULL,
  PRIMARY KEY (`csr_bill_id`),
  KEY `fk_csr_req_patient` (`patient_id`),
  CONSTRAINT `fk_csr_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_csr_req_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csr_billing`
--

LOCK TABLES `csr_billing` WRITE;
/*!40000 ALTER TABLE `csr_billing` DISABLE KEYS */;
INSERT INTO `csr_billing` VALUES ('CSR-BLL-000003','','Syringe',20,0,'PTNT-000351');
/*!40000 ALTER TABLE `csr_billing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_csr_bill` BEFORE INSERT ON `csr_billing` FOR EACH ROW BEGIN
  INSERT INTO csr_bill_seq VALUES (NULL);
  SET NEW.csr_bill_id = CONCAT('CSR-BLL-', LPAD(LAST_INSERT_ID(), 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `csr_inventory`
--

DROP TABLE IF EXISTS `csr_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csr_inventory` (
  `csr_id` varchar(30) NOT NULL DEFAULT '0',
  `item_name` varchar(255) NOT NULL,
  `item_desc` varchar(255) NOT NULL,
  `item_stock` int(11) NOT NULL,
  `item_price` float NOT NULL,
  PRIMARY KEY (`csr_id`),
  UNIQUE KEY `item_name` (`item_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csr_inventory`
--

LOCK TABLES `csr_inventory` WRITE;
/*!40000 ALTER TABLE `csr_inventory` DISABLE KEYS */;
INSERT INTO `csr_inventory` VALUES ('CSR-00001','Syringe','Syringe',2,20),('CSR-00002','Cotton','Cotton',25,5);
/*!40000 ALTER TABLE `csr_inventory` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_csr` BEFORE INSERT ON `csr_inventory` FOR EACH ROW BEGIN
  INSERT INTO csr_sequence VALUES (NULL);
  SET NEW.csr_id = CONCAT('CSR-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `csr_request`
--

DROP TABLE IF EXISTS `csr_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csr_request` (
  `csr_req_id` varchar(30) NOT NULL,
  `nurse_id` varchar(30) NOT NULL DEFAULT '0',
  `csr_item_id` varchar(30) NOT NULL,
  `item_quant` int(11) NOT NULL,
  `csr_status` tinyint(4) NOT NULL DEFAULT '0',
  `date_altered_status` datetime DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`csr_req_id`),
  KEY `fk_nurse_csr` (`nurse_id`),
  KEY `fk_csr_item` (`csr_item_id`),
  CONSTRAINT `fk_csr_item` FOREIGN KEY (`csr_item_id`) REFERENCES `csr_inventory` (`csr_id`),
  CONSTRAINT `fk_users_csr` FOREIGN KEY (`nurse_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csr_request`
--

LOCK TABLES `csr_request` WRITE;
/*!40000 ALTER TABLE `csr_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `csr_request` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_csrreq` BEFORE INSERT ON `csr_request` FOR EACH ROW BEGIN
  INSERT INTO nurse_req_sequence VALUES (NULL);
  SET NEW.csr_req_id = CONCAT('CSR-REQ-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `csr_sequence`
--

DROP TABLE IF EXISTS `csr_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csr_sequence` (
  `csr_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`csr_seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csr_sequence`
--

LOCK TABLES `csr_sequence` WRITE;
/*!40000 ALTER TABLE `csr_sequence` DISABLE KEYS */;
INSERT INTO `csr_sequence` VALUES (1),(2);
/*!40000 ALTER TABLE `csr_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_sequence`
--

DROP TABLE IF EXISTS `department_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_sequence` (
  `dept_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`dept_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_sequence`
--

LOCK TABLES `department_sequence` WRITE;
/*!40000 ALTER TABLE `department_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `dept_id` varchar(30) NOT NULL DEFAULT '0',
  `dept_name` varchar(255) NOT NULL,
  `dept_desc` varchar(255) NOT NULL,
  `dept_head` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_departments` BEFORE INSERT ON `departments` FOR EACH ROW BEGIN
  INSERT INTO department_sequence VALUES (NULL);
  SET NEW.dept_id = CONCAT('DEPT-', LPAD(LAST_INSERT_ID(), 4, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `discharge_schedule`
--

DROP TABLE IF EXISTS `discharge_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discharge_schedule` (
  `discharge_id` int(11) NOT NULL AUTO_INCREMENT,
  `admission_id` int(11) NOT NULL,
  `patient_id` varchar(30) DEFAULT NULL,
  `discharge_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remarks` varchar(255) NOT NULL,
  PRIMARY KEY (`discharge_id`),
  UNIQUE KEY `patient_id` (`patient_id`),
  KEY `fk_Patient_discharge` (`patient_id`),
  KEY `admission_id_fk` (`admission_id`),
  CONSTRAINT `admission_id_fk` FOREIGN KEY (`admission_id`) REFERENCES `admission_schedule` (`admission_id`),
  CONSTRAINT `fk_Patient_discharge` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discharge_schedule`
--

LOCK TABLES `discharge_schedule` WRITE;
/*!40000 ALTER TABLE `discharge_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `discharge_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disposition_status`
--

DROP TABLE IF EXISTS `disposition_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disposition_status` (
  `disposition_stat_id` int(11) NOT NULL AUTO_INCREMENT,
  `disposition_id` int(11) NOT NULL,
  `status_name` varchar(255) NOT NULL,
  `status_desc` varchar(255) NOT NULL,
  PRIMARY KEY (`disposition_stat_id`),
  KEY `disposition_id` (`disposition_id`),
  CONSTRAINT `disposition_status_ibfk_1` FOREIGN KEY (`disposition_id`) REFERENCES `final_disposition` (`disposition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disposition_status`
--

LOCK TABLES `disposition_status` WRITE;
/*!40000 ALTER TABLE `disposition_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `disposition_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_information`
--

DROP TABLE IF EXISTS `doctor_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_information` (
  `doctor_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL DEFAULT '0',
  `room_assignment` varchar(255) NOT NULL,
  `spec_id` int(11) DEFAULT NULL,
  `default_PF` varchar(30) DEFAULT NULL,
  `schedules` int(11) DEFAULT NULL,
  PRIMARY KEY (`doctor_id`),
  KEY `user_id` (`user_id`),
  KEY `spec_id` (`spec_id`),
  KEY `schedule_fk` (`schedules`),
  CONSTRAINT `doctor_information_ibfk_2` FOREIGN KEY (`spec_id`) REFERENCES `doctor_specializations` (`spec_id`),
  CONSTRAINT `schedule_fk` FOREIGN KEY (`schedules`) REFERENCES `doctor_schedules` (`ds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_information`
--

LOCK TABLES `doctor_information` WRITE;
/*!40000 ALTER TABLE `doctor_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_schedules`
--

DROP TABLE IF EXISTS `doctor_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_schedules` (
  `ds_id` int(11) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(4) DEFAULT '1',
  `day` varchar(10) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  PRIMARY KEY (`ds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_schedules`
--

LOCK TABLES `doctor_schedules` WRITE;
/*!40000 ALTER TABLE `doctor_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_specializations`
--

DROP TABLE IF EXISTS `doctor_specializations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_specializations` (
  `spec_id` int(11) NOT NULL AUTO_INCREMENT,
  `spec_name` varchar(255) NOT NULL,
  `spec_desc` varchar(255) NOT NULL,
  PRIMARY KEY (`spec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_specializations`
--

LOCK TABLES `doctor_specializations` WRITE;
/*!40000 ALTER TABLE `doctor_specializations` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_specializations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drugs`
--

DROP TABLE IF EXISTS `drugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drugs` (
  `drug_code` varchar(255) NOT NULL,
  `drug_name` varchar(255) NOT NULL,
  `generic_code` varchar(45) DEFAULT NULL,
  `generic_name` varchar(45) DEFAULT NULL,
  `strength_code` varchar(45) DEFAULT NULL,
  `strength_desc` varchar(45) DEFAULT NULL,
  `form_code` varchar(45) DEFAULT NULL,
  `form_desc` varchar(255) DEFAULT NULL,
  `packaging_code` varchar(45) DEFAULT NULL,
  `packaging_desc` varchar(255) DEFAULT NULL,
  `brand_code` varchar(45) DEFAULT NULL,
  `brand_name` varchar(45) DEFAULT NULL,
  `manufacturer_name` varchar(45) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `drug_price` float NOT NULL,
  `drug_quantity` int(11) NOT NULL,
  PRIMARY KEY (`drug_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='for drugs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drugs`
--

LOCK TABLES `drugs` WRITE;
/*!40000 ALTER TABLE `drugs` DISABLE KEYS */;
INSERT INTO `drugs` VALUES ('PARAC500MGTAB49BPXXX001870','Paracetamol , 500 mg , Tablet , DOCTORS PHARMACEUTICALS INC.','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','BPXXX','Blister pack','','','Doctors Pharmaceuticals Inc.',0,0,0),('PARAC500MGTAB49BPXXX001890','Paracetamol , 500 mg , Tablet , LLOYD LAB. INC.','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','BPXXX','Blister pack','','','Lloyd Lab. Inc.',0,0,0),('PARAC500MGTAB49BPXXX001894','Paracetamol , 500 mg , Tablet , MEFORAGESIC','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','BPXXX','Blister pack','M0060','Meforagesic','',0,0,0),('PARAC500MGTAB49BPXXX001896','Paracetamol , 500 mg , Tablet , MOLDREX','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','BPXXX','Blister pack','M0130','Moldrex','',0,0,0),('PARAC500MGTAB49BPXXX001902','Paracetamol , 500 mg , Tablet , NEKTOL','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','BPXXX','Blister pack','N0014','Nektol','',0,0,0),('PARAC500MGTAB49BPXXX001910','Paracetamol , 500 mg , Tablet , PRC','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','BPXXX','Blister pack','P0092','PRC','',0,0,0),('PARAC500MGTAB49BPXXX001932','Paracetamol , 500 mg , Tablet , WESTAMOL','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','BPXXX','Blister pack','W0001','Westamol','',0,0,0),('PARAC500MGTAB49FS10X001865','Paracetamol , 500 mg , Tablet , CHERRYPYRENE','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','FS10X','Foil strip by 10\'s (Box of 100\'s)','C0073','Cherrypyrene','',0,0,0),('PARAC500MGTAB49FS10X001900','Paracetamol , 500 mg , Tablet , NAPALGIN','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','FS10X','Foil strip by 10\'s (Box of 100\'s)','N0001','Napalgin','',0,0,0),('PARAC500MGTAB49FS4CX001855','Paracetamol , 500 mg , Tablet , AMINOFEBRIN','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','FS4CX','Foil Strip by 4\'s (Box of 100\'s)','A0093','Aminofebrin','',0,0,0),('PARAC500MGTAB49PVC10001924','Paracetamol , 500 mg , Tablet , SYDENHAM LABORATORIES INC.','PARAC','Paracetamol','500MG','500 mg','TAB49','Tablet','PVC10','PVC blister pack by 10s (Box of 100s)','','','Sydenham Laboratories Inc.',0,0,0),('PERM15WWXXLOTI130MLB002385','Permethin , 5% w/w , Lotion , A SCABS','PERM1','PERMETHIN','5WWXX','5% w/w','LOTI1','LOTION','30MLB','30 mL bottle','A0242','A Scabs','Hoe Pharma\'l Sdn Bhd',0,0,0),('PETHI50MGMSOL1400742011245','Pethidine , 50 mg/mL , Solution For Injection , DELGIN , 30 mL Clear Glass Vial','PETHI','Pethidine','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00742','30 mL Clear Glass Vial','D0025','Delgin','Hospira Inc',0,0,0),('PETHI50MGMSOL1400742011246','Pethidine , 50 mg/mL , Solution For Injection , DELTAXONE , 30 mL Clear Glass Vial','PETHI','Pethidine','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00742','30 mL Clear Glass Vial','D2019','Deltaxone','Hospira Inc',0,0,0),('PHEN1125M5POW20BP351003004','Phenoxymethylpenicillin , 125 mg/5 mL , Powder For Oral Suspension , SUMAPEN, Blister pack x 10\'s (box of 100\'s )','PHEN1','Phenoxymethylpenicillin','125M5','125 mg/5 mL','POW20','POWDER FOR ORAL SUSPENSION','BP351','Blister pack x 10\'s (box of 100\'s )','S0097','Sumapen','Asian Antibiotics',0,0,0),('PHEN1250M5POW2001106006533','Phenoxymethylpenicillin , 250 mg/5 mL , Powder For Oral Suspension , SUMAPEN, 75 mL Amber Bottle','PHEN1','Phenoxymethylpenicillin','250M5','250 mg/5 mL','POW20','POWDER FOR ORAL SUSPENSION','01106','75 mL Amber Bottle','S0097','Sumapen','Asian Antibiotics',0,0,0),('PHEN1500MGCAPSUBP351004983','Phenoxymethylpenicillin , 500 mg , Capsule , SCHEELE','PHEN1','Phenoxymethylpenicillin','500MG','500 mg','CAPSU','CAPSULE','BP351','Blister pack x 10\'s (box of 100\'s )','','','Scheele',0,0,0),('PHENO60MGXTAB49AM100004981','Phenobarbital , 60 mg , Tablet , GENERAL DRUG & CHEM','PHENO','Phenobarbital','60MGX','60 mg','TAB49','TABLET','AM100','Amber bottle of 100s','','','General Drug & Chem',0,0,0),('PHENO90MGXTAB49AM100004982','Phenobarbital , 90 mg , Tablet , AMHERST','PHENO','Phenobarbital','90MGX','90 mg','TAB49','TABLET','AM100','Amber bottle of 100s','','','Amherst',0,0,0),('PHENY10MGMSOL1460AMB002699','Phenylephrine , 10 mg/mL , Solution For Injection , NEOSTAN , 60 mL Amber bottle','PHENY','Phenylephrine','10MGM','10 mg/mL','SOL14','SOLUTION FOR INJECTION','60AMB','60 mL Amber bottle','N0025','Neostan','Hospira',0,0,0),('PHENY5MG5MSYRUP00348011248','Phenylephrine , 5 mg/5mL , Syrup , HIZON LABORATORIES, INC. , 120 mL Amber bottle','PHENY','Phenylephrine','5MG5M','5 mg/5mL','SYRUP','SYRUP','120AM','120 mL Amber bottle','','','Hizon Laboratories, Inc.',0,0,0),('PHENY5MG5MSYRUP00982011249','Phenylephrine , 5 mg/5mL , Syrup , HIZON LABORATORIES, INC. , 60 mL Amber bottle','PHENY','Phenylephrine','5MG5M','5 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','','','Hizon Laboratories, Inc.',0,0,0),('PHENY5MG5MSYRUP00982011250','Phenylephrine , 5 mg/5mL , Syrup , COLDASER , 60 mL Amber bottle','PHENY','Phenylephrine','5MG5M','5 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','C2101','Coldaser','San Marino Labs Corp',0,0,0),('PHEY11255MDROPS00415011253','Phenylpropanolamine , 12.5 mg/5 mL , Drops , MYREX ETHICA , 15 mL Boston Amber bottle','PHEY1','Phenylpropanolamine','1255M','12.5 mg/5 mL','DROPS','DROPS','00415','15 mL Boston Amber bottle','','','Myrex Ethica',0,0,0),('PHEY11255MSYRUP00394011252','Phenylpropanolamine , 12.5 mg/5 mL , Syrup , HIZON , 15 mL Amber bottle','PHEY1','Phenylpropanolamine','1255M','12.5 mg/5 mL','SYRUP','SYRUP','00394','15 mL Amber bottle','','','Hizon',0,0,0),('PHEY11255MSYRUP00394011256','Phenylpropanolamine , 12.5 mg/5 mL , Syrup , DECILONE , 15 mL Amber bottle','PHEY1','Phenylpropanolamine','1255M','12.5 mg/5 mL','SYRUP','SYRUP','00394','15 mL Amber bottle','D2010','Decilone','United Lab',0,0,0),('PHEY11255MSYRUP00416011254','Phenylpropanolamine , 12.5 mg/5 mL , Syrup , AD-DRUGSTEL PHARMA\'L LABS., INC , 15 mL Boston Round Amber bottle','PHEY1','Phenylpropanolamine','1255M','12.5 mg/5 mL','SYRUP','SYRUP','00416','15 mL Boston Round Amber bottle','','','Ad-Drugstel Pharma\'l Labs., Inc',0,0,0),('PHEY11255MSYRUP120AM004984','Phenylpropanolamine , 12.5 mg/5 mL , Syrup , AD DRUGSTEL , 120 mL Amber bottle','PHEY1','Phenylpropanolamine','1255M','12.5 mg/5 mL','SYRUP','SYRUP','120AM','120 mL Amber bottle','','','AD Drugstel',0,0,0),('PHEY11255MSYRUP60AMB003850','Phenylpropanolamine , 12.5 mg/5 mL , Syrup , DERMOVATE , 60 mL Amber bottle','PHEY1','Phenylpropanolamine','1255M','12.5 mg/5 mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','D2035','Dermovate','Novagen Pharma\'l CO., Inc',0,0,0),('PHEY11255MSYRUP60AMB003851','Phenylpropanolamine , 12.5 mg/5 mL , Syrup , DESOTAP , 60 mL Amber bottle','PHEY1','Phenylpropanolamine','1255M','12.5 mg/5 mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','D2036','Desotap','Novagen',0,0,0),('PHEY11255MSYRUP60AMB003897','Phenylpropanolamine , 12.5 mg/5 mL , Syrup , DISTIN , 60 mL Amber bottle','PHEY1','Phenylpropanolamine','1255M','12.5 mg/5 mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','D2084','Distin','United Lab',0,0,0),('PHEY11255MSYRUP60AMB004985','Phenylpropanolamine , 12.5 mg/5 mL , Syrup , AD DRUGSTEL , 60 mL Amber bottle','PHEY1','Phenylpropanolamine','1255M','12.5 mg/5 mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','AD Drugstel',0,0,0),('PHEY1625MMDROPS00394011251','Phenylpropanolamine , 6.25 mg/mL , Drops , MYREX ETHICA , 15 mL Amber bottle','PHEY1','Phenylpropanolamine','625MM','6.25 mg/mL','DROPS','DROPS','00394','15 mL Amber bottle','','','Myrex Ethica',0,0,0),('PHEY1625MMDROPS120AM004986','Phenylpropanolamine , 6.25 mg/mL , Drops , HIZON , 120 mL Amber bottle','PHEY1','Phenylpropanolamine','625MM','6.25 mg/mL','DROPS','DROPS','120AM','120 mL Amber bottle','','','Hizon',0,0,0),('PHEY1625MMDROPS60AMB004987','Phenylpropanolamine , 6.25 mg/mL , Drops , HIZON , 60 mL Amber bottle','PHEY1','Phenylpropanolamine','625MM','6.25 mg/mL','DROPS','DROPS','60AMB','60 mL Amber bottle','','','Hizon',0,0,0),('PHEY1625MMSYRUP00982006297','Phenylpropanolamine , 6.25 mg/mL , Syrup , DISTIN , 60 mL Amber bottle','PHEY1','Phenylpropanolamine','625MM','6.25 mg/mL','SYRUP','SYRUP','00982','60 mL Amber bottle','D2084','Distin','United Lab',0,0,0),('PHEY1625MMSYRUP00982011255','Phenylpropanolamine , 6.25 mg/mL , Syrup , AD DRUGSTEL , 60 mL Amber bottle','PHEY1','Phenylpropanolamine','625MM','6.25 mg/mL','SYRUP','SYRUP','00982','60 mL Amber bottle','','','AD Drugstel',0,0,0),('PHEY4125M5SUS14120AM003886','Phenytoin , 125 mg/5 mL , Suspension , DILAHEX , 120 mL Amber bottle','PHEY4','Phenytoin','125M5','125 mg/5 mL','SUS14','SUSPENSION','120AM','120 mL Amber bottle','D2066','Dilahex','Interphil Labs., Inc',0,0,0),('PHEY450MGMSOL1400462011257','Phenytoin , 50 mg/mL , Solution For Injection , AMHERST LABS INC , 2 mL Amber coloured Type II glass ampul (Box by 10\'s)','PHEY4','Phenytoin','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00462','2 mL Amber coloured Type II glass ampul (Box by 10\'s)','','','Amherst Labs Inc',0,0,0),('PHEY450MGMSOL1400486005849','Phenytoin , 50 mg/mL , Solution For Injection , EPI-GENTA , 2 mL Clear Type I Glass ampul (Box of 10\'s)','PHEY4','Phenytoin','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00486','2 mL Clear Type I Glass ampul (Box of 10\'s)','E2062','Epi-Genta','Vaso Biotech Pvt Ltd',0,0,0),('PHEY450MGMSOL1400538011258','Phenytoin , 50 mg/mL , Solution For Injection , SAMARTH PHARMA PVT LTD INDIA , 2 mL USP Type I Amber glass ampul (Box of 10\'s)','PHEY4','Phenytoin','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00538','2 mL USP Type I Amber glass ampul (Box of 10\'s)','','','Samarth Pharma Pvt Ltd India',0,0,0),('PHEY450MGMSOL1401785007453','Phenytoin , 50 mg/mL , Solution For Injection , DILANTIN , Box of 10 ampul x 2 mL','PHEY4','Phenytoin','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','01785','Box of 10 ampul x 2 mL','D0066','Dilantin','Actavis Italy S.P.A',0,0,0),('PHEY5100MGCAPSU01495011640','Phenytoin (As Sodium) , 100 mg , Capsule  , DILANTIN','PHEY5','Phenytoin (as Sodium)','100MG','100 mg','CAPSU','CAPSULE','01495','Amber Bottle of 100\'s','D0066','Dilantin','Pfizer Ltd.',0,0,0),('PHEY5100MGCAPSU02833011641','Phenytoin Sodium , 100 mg , Capsule  , DILANTIN','PHEY5','Phenytoin Sodium','100MG','100 mg','CAPSU','CAPSULE','02833','HDPE Bottle x 200 Capsules','D0066','Dilantin','Pfizer Pty. Ltd.',0,0,0),('PHYTO10MGMSOL1400003011262','Phytomenadione , 10 mg/mL , Solution For Injection , CYCLOTRAX , 0.5 mL USP Type I amber glass ampul','PHYTO','Phytomenadione','10MGM','10 mg/mL','SOL14','SOLUTION FOR INJECTION','00003','0.5 mL USP Type I amber glass ampul','C2160','Cyclotrax','Rotexmedica GmbH',0,0,0),('PHYTO10MGMSOL1402421011259','Phytomenadione , 10 mg/mL , Solution For Injection , CHINA CHEMICAL PHARMA\'L CO., LTD , Type I Glass amber ampul (Box of 10\'s)','PHYTO','Phytomenadione','10MGM','10 mg/mL','SOL14','SOLUTION FOR INJECTION','02421','Type I Glass amber ampul (Box of 10\'s)','','','China Chemical Pharma\'l Co., Ltd',0,0,0),('PHYTO10MGMSOL1402480008225','Phytomenadione , 10 mg/mL , Solution For Injection , DYLARAN , USP Type I amber ampul (Box of 10\'s)','PHYTO','Phytomenadione','10MGM','10 mg/mL','SOL14','SOLUTION FOR INJECTION','02480','USP Type I amber ampul (Box of 10\'s)','D2147','Dylaran','Aarya Lifesciences Pvt Ltd',0,0,0),('PHYTO10MGMSOL14AMPUL003818','Phytomenadione , 10 mg/mL , Solution For Injection , CYCLODINE , Ampul','PHYTO','Phytomenadione','10MGM','10 mg/mL','SOL14','SOLUTION FOR INJECTION','AMPUL','Ampul','C2159','Cyclodine','Rotexmedica',0,0,0),('PHYTO10MGMSOL39AGM50002412','Phytomenadione , 10mg/mL , Solution For Injection (Im/Iv) , PYTIGEN, Amber glass ampul , Type I box of 10 and 50 ampoules','PHYTO','Phytomenadione','10MGM','10mg/mL','SOL39','SOLUTION FOR INJECTION (IM/IV)','AGM50','Amber glass ampul , Type I box of 10 and 50 ampoules','P0175','Pytigen','',0,0,0),('PIOGL30MGXTAB49BPX30002387','Pioglitazone (As Hydrochloride , 30 mg , Tablet , PPAR','PIOGL','PIOGLITAZONE (as Hydrochloride','30MGX','30 mg','TAB49','TABLET','BPX30','Blister Pack of 10s (Box of 30s)','P0159','PPAR','Beximo Pharml Ltd',0,0,0),('PIPE12G250POW2802905011700','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For (I.V.) Infusion , PEPRASAN-T , USP Type I Clear Glass Vial in 15 mL + Ampul in 10 mL Diluent (Box of 2\'s)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW28','POWDER FOR (I.V.) INFUSION','02905','USP Type I Clear Glass Vial in 15 mL + Ampul in 10 mL Diluent (Box of 2\'s)','P0050','Peprasan-T','SRS Pharmaceuticals Pvt. Ltd.',0,0,0),('PIPE12G250POW2901771011712','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 2 g/250 mg , Powder For Injection (I.V.) , CARTAZ , Box of 1 USP Type I Clear Glass Vial','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','01771','Box of 1 USP Type I Clear Glass Vial','C2164','Cartaz','Venus Remedies Limited',0,0,0),('PIPE12G250POW2901771011736','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 2 g/250 mg , Powder For Injection (I.V.) , ZOBAC , Box of 1 USP Type I Clear Glass Vial','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','01771','Box of 1 USP Type I Clear Glass Vial','Z1609','Zobac','Venus Remedies Limited',0,0,0),('PIPE12G250POW2902430011740','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 2 g/250 mg , Powder For Injection (I.V./I.M.) , PERABACTAM , Type II Clear and Colorless Glass Vial (Box of 10\'s)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V./I.M.)','02430','Type II Clear and Colorless Glass Vial (Box of 10\'s)','P1607','Perabactam','Laboratorio Reig Jofre, S.A.',0,0,0),('PIPE12G250POW2902667011709','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 2 g/250 mg , Powder For Injection ,  , 30 mL USP Type I Tubular Vials with 20mm Grey Bromobutyl Rubber Stopper w/ 20mm Violet Color Aluminum Flip-off Seal','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION','02667','30 mL USP Type I Tubular Vials with 20mm Grey Bromobutyl Rubber Stopper w/ 20mm Violet Color Aluminum Flip-off Seal','','','Aurobino Pharma Ltd.',0,0,0),('PIPE12G250POW2902881011718','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 2 g/250 mg , Powder For Injection (I.V.) , PIZOBAC , Type I Colorless Borosilicate Glass Vial (Box of 10\'s)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02881','Type I Colorless Borosilicate Glass Vial (Box of 10\'s)','P1611','Pizobac','Penmix Ltd.',0,0,0),('PIPE12G250POW2902885011724','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For Injection (I.V.) , TAZOCIN , Type I Flint Tubing Glass Vial (2.25 g)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02885','Type I Flint Tubing Glass Vial (2.25 g)','T0010','Tazocin','Wyeth Piperacillin Division of Wyeth Holdings',0,0,0),('PIPE12G250POW2902910011729','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 2 g/250 mg , Powder For Injection (I.V.) , TAZOPEN , USP Type II Clear and Colorless Glass Vial + 10 mL Diluent (Water for Injection) in Translucent LDPE Vial in box','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02910','USP Type II Clear and Colorless Glass Vial + 10 mL Diluent (Water for Injection) in Translucent LDPE Vial in box','T1614','Tazopen','Singapore Pharmawealth Lifesciences, Inc.',0,0,0),('PIPE12G250POW2902915011717','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For Injection (I.V.) , PIPER-TAZO , USP Type III Clear Glass Vial in 20 mL (Box of 1 Vial)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02915','USP Type III Clear Glass Vial in 20 mL (Box of 1 Vial)','P0069','Piper-Tazo','Plethico Pharmaceuticals Ltd.',0,0,0),('PIPE12G250POW2902915011720','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For Injection (I.V.) , PLETZOLYN , USP Type III Clear Glass Vial in 20 mL (Box of 1 Vial)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02915','USP Type III Clear Glass Vial in 20 mL (Box of 1 Vial)','P0078','Pletzolyn','Plethico Pharmaceuticals Ltd.',0,0,0),('PIPE12G250POW2902915011731','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For Injection (I.V.) , TAZORIN , USP Type III Clear Glass Vial in 20 mL (Box of 1 Vial)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02915','USP Type III Clear Glass Vial in 20 mL (Box of 1 Vial)','T1615','Tazorin','Plethico Pharmaceuticals Ltd.',0,0,0),('PIPE12G250POW2902915011735','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For Injection (I.V.) , TAZOZAN , USP Type III Clear Glass Vial in 20 mL (Box of 1 Vial)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02915','USP Type III Clear Glass Vial in 20 mL (Box of 1 Vial)','T1619','Tazozan','Plethico Pharmaceuticals Ltd.',0,0,0),('PIPE12G250POW2902916011722','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For Injection (I.V.) , TAZOBAK , USP Type III Clear Glass Vial, Box of 1 Vial + 10 mL Diluent','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02916','USP Type III Clear Glass Vial, Box of 1 Vial + 10 mL Diluent','T0009','Tazobak','Swiss Parenterals Pvt. Ltd.',0,0,0),('PIPE12G250POW2902917011728','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For Injection (I.V.) , TAZOMAX , USP Type III Clear Glass Vial, Box of 1 Vial + 10 mL Diluent','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02917','USP Type III Clear Glass Vial, Box of 1 Vial + 10 mL Diluent','T1613','Tazomax','Swiss Parenterals Pvt. Ltd.',0,0,0),('PIPE12G250POW3602787011744','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For Injection (I.V./I.V. Infusion) , TEBRANIC , Box of 12\'s (Pack of 12 vials)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW36','POWDER FOR INJECTION (I.V./I.V. INFUSION)','02787','Box of 12\'s (Pack of 12 vials)','T1592','Tebranic','Aurobino Pharma Ltd.',0,0,0),('PIPE12G250POW3602790011745','Piperacillin Sodium + Tazobactam Sodium , 2 g/250 mg , Powder For Injection (I.V./I.V. Infusion) , TEBRANIC , Box of 1\'s (Pack of 1 vial)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW36','POWDER FOR INJECTION (I.V./I.V. INFUSION)','02790','Box of 1\'s (Pack of 1 vial)','T1593','Tebranic','Aurobino Pharma Ltd.',0,0,0),('PIPE145GXXPOW2902883011723','Piperacillin Sodium + Tazobactam Sodium , 4.5 g   , Powder For Injection (I.V.) , TAZOCIN , Type I Colorless Glass Vial with Butyl Rubber Plug and Purple Flip-off Cap (Box of 1\'s)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45GXX','4.5 g','POW29','POWDER FOR INJECTION (I.V.)','02883','Type I Colorless Glass Vial with Butyl Rubber Plug and Purple Flip-off Cap (Box of 1\'s)','T0010','Tazocin','Wyeth Lederle SpA',0,0,0),('PIPE145GXXPOW2902911011701','Piperacillin Sodium + Tazobactam Sodium , 4.5 g per vial , Powder For (I.V.) Injection  , TANZO , USP Type II Clear Glass Vial of 4.5 g with 2 x 10 mL Clear Colorless Ampul Diluent (Box of 1\'s)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45GXX','4.5 g per vial','POW29','POWDER FOR (I.V.) INJECTION','02911','USP Type II Clear Glass Vial of 4.5 g with 2 x 10 mL Clear Colorless Ampul Diluent (Box of 1\'s)','T1609','Tanzo','Basch Pharmaceuticals Pvt. Ltd.',0,0,0),('PIPE145GXXPOW2902912011711','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4.5 g , Powder For Injection (I.V. Infusion) , TAZOVIT , USP Type II Glass Vial x 4 g/500 mg (Box of 1 vial)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45GXX','4.5 g','POW29','POWDER FOR INJECTION (I.V. INFUSION)','02912','USP Type II Glass Vial x 4 g/500 mg (Box of 1 vial)','T1618','Tazovit','Votrofarma S.A.',0,0,0),('PIPE145HMGPOW1002440011682','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Lyophilized Powder For Injection (I.V.) , PIRACIL , Type III Clear & Colorless Glass Vial (Box of 10\'s)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW10','LYOPHILIZED POWDER FOR INJECTION (I.V.)','02440','Type III Clear & Colorless Glass Vial (Box of 10\'s)','P0071','Piracil','Zhuhai United Laboratories Co. Ltd.',0,0,0),('PIPE145HMGPOW1002441011683','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Lyophilized Powder For Injection (I.V.) , PIRACIL , Type III Clear & Colorless Glass Vial (Box of 1\'s)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW10','LYOPHILIZED POWDER FOR INJECTION (I.V.)','02441','Type III Clear & Colorless Glass Vial (Box of 1\'s)','P0071','Piracil','Zhuhai United Laboratories Co. Ltd.',0,0,0),('PIPE145HMGPOW2902558011734','Piperacillin Sodium + Tazobactam Sodium , 4 g/500 mg , Powder For Injection (I.V.) , TAZOZAN , USP Type III Clear Glass Vial (Box of 1\'s)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02558','USP Type III Clear Glass Vial (Box of 1\'s)','T1619','Tazozan','Plethico Pharmaceuticals Ltd.',0,0,0),('PIPE145HMGPOW2902576011732','Piperacillin Sodium + Tazobactam Sodium , 4 g/500 mg , Powder For Injection (I.V.) , TAZORIN , USP Type III Glass Vial (Box of 1\'s)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02576','USP Type III Glass Vial (Box of 1\'s)','T1615','Tazorin','Plethico Pharmaceuticals Ltd.',0,0,0),('PIPE145HMGPOW2902668011733','Piperacillin Sodium + Tazobactam Sodium , 4 g/500 mg , Powder For Injection (I.V.) , TAZOTAZ , 30 mL USP Type III Clear Glass Vial x 1\'s','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02668','30 mL USP Type III Clear Glass Vial x 1\'s','T1616','Tazotaz','Sherrington Pharmaceuticals Pvt. Ltd.',0,0,0),('PIPE145HMGPOW2902670011710','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Powder For Injection ,  , 40 mL USP Type I Tubular Vials with 20mm Grey Bromobutyl Rubber Stopper w/ 20mm Red Color Flip-off Seal','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION','02670','40 mL USP Type I Tubular Vials with 20mm Grey Bromobutyl Rubber Stopper w/ 20mm Red Color Flip-off Seal','','','Aurobino Pharma Ltd.',0,0,0),('PIPE145HMGPOW2902822011726','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Powder For Injection (I.V.) , TAZODIN , Diluent: Type II Ampul x (2) 10 mL per Box','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02822','Diluent: Type II Ampul x (2) 10 mL per Box','T1612','Tazodin','SRS Pharmaceuticals Pvt. Ltd.',0,0,0),('PIPE145HMGPOW2902851011727','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Powder For Injection (I.V.) , TAZODIN , Powder: USP Type III Glass Vial','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02851','Powder: USP Type III Glass Vial','T1612','Tazodin','SRS Pharmaceuticals Pvt. Ltd.',0,0,0),('PIPE145HMGPOW2902876011739','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Powder For Injection (I.V./I.M.) , CARTAZ , Type I Clear and Colorless Glass Vial (in Individual Box)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V./I.M.)','02876','Type I Clear and Colorless Glass Vial (in Individual Box)','C2164','Cartaz','Venus Remedies Limited',0,0,0),('PIPE145HMGPOW2902876011741','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Powder For Injection (I.V./I.M.) , PISA , Type I Clear and Colorless Glass Vial (in Individual Box)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V./I.M.)','02876','Type I Clear and Colorless Glass Vial (in Individual Box)','P1610','Pisa','Venus Remedies Limited',0,0,0),('PIPE145HMGPOW2902876011742','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Powder For Injection (I.V./I.M.) , ZOBAC , Type I Clear and Colorless Glass Vial (in Individual Box)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V./I.M.)','02876','Type I Clear and Colorless Glass Vial (in Individual Box)','Z1609','Zobac','Venus Remedies Limited',0,0,0),('PIPE145HMGPOW2902881011719','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Powder For Injection (I.V.) , PIZOBAC , Type I Colorless Borosilicate Glass Vial (box of 10\'s)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02881','Type I Colorless Borosilicate Glass Vial (box of 10\'s)','P1611','Pizobac','Penmix Ltd.',0,0,0),('PIPE145HMGPOW2902886011725','Piperacillin Sodium + Tazobactam Sodium , 4 g/500 mg , Powder For Injection (I.V.) , TAZOCIN , Type I Flint Tubing Glass Vial (4.5 g)','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02886','Type I Flint Tubing Glass Vial (4.5 g)','T0010','Tazocin','Wyeth Piperacillin Division of Wyeth Holdings',0,0,0),('PIPE145HMGPOW2902889011708','Piperacillin Sodium + Tazobactam Sodium , 4 g/500 mg , Powder For Injection , TAZOVEX , Type II Glass Vial (25 mL )','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION','02889','Type II Glass Vial (25 mL )','T1617','Tazovex','NCPC Northbest Co. Ltd.',0,0,0),('PIPE145HMGPOW2902913011730','Piperacillin (As Sodium) + Tazobactam (As Sodium) , 4 g/500 mg , Powder For Injection (I.V.) , TAZOPEN , USP Type II Vial (1 vial + 2 Vials of 10 mL Diluent in Individual Box)','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02913','USP Type II Vial (1 vial + 2 Vials of 10 mL Diluent in Individual Box)','T1614','Tazopen','Singapore Pharmawealth Lifesciences, Inc.',0,0,0),('PIPER2G250POW1300567005909','Piperacillin + Tazobactam , 2 g/250 mg , Powder For Injection Solution , VIGOCID','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','2G250','2 g/250 mg','LPOW3','LYOPHILIZED STERILE POWDER FOR INJECTION (I.V.) INFUSION','03058','Type III Clear Glass Vial, 20 mL','V0054','Vigocid','YSS Laboratories Co., Inc.',0,0,0),('PIPER2G250POW1302455011264','Piperacillin + Tazobactam , 2 g/250 mg , Powder For Injection Solution , BACIPRO','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.M./I.V.)','02437','Type III Glass Vial','B2003','Bactaz','PSA International',0,0,0),('PIPER2G250POW1302552008308','Piperacillin + Tazobactam , 2 g/250 mg , Powder For Injection Solution , TAPIMYCIN','PIPE1','Piperacillin Sodium + Tazobactam Sodium','2G250','2 g/250 mg','POW29','POWDER FOR INJECTION (I.V.)','02502','USP Type I glass vial (Box of 10\'s)','T0115','Tapimycin','Yung Shin Pharmaceuticals Ind. Co. Ltd',0,0,0),('PIPER2G250POW13VIALX001938','Piperacillin + Tazobactam , 2 g/250 mg , Powder For Injection Solution , PIRACIL','PIPER','Piperacillin + Tazobactam','2G250','2 g/250 mg','POW13','Powder For Injection Solution','VIALX','vial','P0071','Piracil','',0,0,0),('PIPER2G250POW2902666011702','Piperacillin + Tazobactam , 2 g/250 mg , Powder For (I.V.) Injection  , TAZROBIDA , 30 mL Colorless USP Type I Glass Vial','PIPER','Piperacillin + Tazobactam','2G250','2 g/250 mg','POW29','POWDER FOR (I.V.) INJECTION','02666','30 mL Colorless USP Type I Glass Vial','T1620','Tazrobida','M/S Strides Arcolab Limited',0,0,0),('PIPER45HMGPOW10GVIAL001939','Piperacillin + Tazobactam , 4 g/500 mg , Powder For Injection Lyophilized , VIGOCID','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','LPOW2','LYOPHILIZED STERILE POWDER FOR INJECTION (I.V.)','03022','Colorless Type III Glass Vial w/ Bromo Butyl Rubber Stopper and Aluminum Seal','V0054','Vigocid','YSS Laboratories Co., Inc.',0,0,0),('PIPER45HMGPOW1302408008169','Piperacillin + Tazobactam , 4 g/500 mg , Powder For Injection Solution , PISAMOR','PIPER','Piperacillin + Tazobactam','45HMG','4 g/500 mg','POW13','POWDER FOR INJECTION SOLUTION','02408','Type I Clear and colorless glass vial (for the powder) + two (2) Type I clear and colorless glass ampul (fpr the diluent)','P0072','Pisamor','Penmix Ltd',0,0,0),('PIPER45HMGPOW1302455008206','Piperacillin + Tazobactam , 4 g/500 mg , Powder For Injection Solution , PIRACIL','PIPE1','Piperacillin (as Sodium) + Tazobactam (as Sod','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02408','Type I Clear and colorless glass vial (for the powder) + two (2) Type I clear and colorless glass ampul (fpr the diluent)','','Piracilin','Clesstra Healthcare Pvt. Ltd. India',0,0,0),('PIPER45HMGPOW1302552008309','Piperacillin + Tazobactam , 4 g/500 mg , Powder For Injection Solution , TAZOBAK','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02916','USP Type III Clear Glass Vial, Box of 1 Vial + 10 mL Diluent','T0009','Tazobak','Swiss Parenterals Pvt Ltd',0,0,0),('PIPER45HMGPOW13GVIAL001940','Piperacillin + Tazobactam , 4 g/500 mg , Powder For Injection Solution , PEPRASAN-T','PIPER','Piperacillin + Tazobactam','45HMG','4 g/500 mg','POW13','Powder For Injection Solution','GVIAL','Glass Vial','P0050','Peprasan-T','',0,0,0),('PIPER45HMGPOW13GVIAL001941','Piperacillin + Tazobactam , 4 g/500 mg , Powder For Injection Solution , PLETZOLYN','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02576','USP Type III Glass Vial (Box of 1\'s)','P0078','Pletzolyn','Plethico Pharmaceuticals Ltd.',0,0,0),('PIPER45HMGPOW13GVIAL002774','Piperacillin + Tazobactam , 4 g/500 mg , Powder For Injection Solution , PEP-BLOC','PIPER','Piperacillin + Tazobactam','45HMG','4 g/500 mg','POW13','POWDER FOR INJECTION SOLUTION','GVIAL','Glass Vial','P0049','Pep-Bloc','SRS Pharml Pvt Ltd',0,0,0),('PIPER45HMGPOW2902888011716','Piperacillin + Tazobactam , 4 g/500 mg , Powder For Injection (I.V.) , PAIZU , Type II Glass Infusion Bottle x 100 mL (Box of 1\'s)','PIPER','Piperacillin + Tazobactam','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','02888','Type II Glass Infusion Bottle x 100 mL (Box of 1\'s)','P1606','Paizu','Sandoz GmbH',0,0,0),('PIPER500MGPOW1002427008184','Piperacillin + Tazobactam , 500 mg , Powder For Injection Solution Lyophilized , VIGOCID','PIPER','Piperacillin + Tazobactam','500MG','500 mg','POW10','POWDER FOR INJECTION SOLUTION LYOPHILIZED','02427','Type I vial','V0054','Vigocid','YSS Labs.Co. Inc.',0,0,0),('PIPER500MGPOW1302457008212','Piperacillin + Tazobactam , 500 mg , Powder For Injection Solution , TAZOSID','PIPE1','Piperacillin Sodium + Tazobactam Sodium','45HMG','4 g/500 mg','POW29','POWDER FOR INJECTION (I.V.)','03071','USP Type I Glass Vial Sealed w/ Grey Butyl Rubber Stopper Sealed w/ Blue Flip off Aluminum Seal','T0116','Tazosid','Karnataka Antibiotics & Pharmaceuticals Ltd',0,0,0),('PIRAC2HMGLSOL3200423005793','Piracetam , 200 mg/mL , Solution , PIRACIL , 15 mL Clear glass ampul','PIRAC','Piracetam','2HMGL','200 mg/mL','SOL32','SOLUTION','00423','15 mL Clear glass ampul','P0071','Piracil','SRS Pharmaceutical Pvt Ltd',0,0,0),('PIRAC400MGCAPSUBP351004005','Piracetam , 400 mg , Capsule , ETOPUL','PIRAC','Piracetam','400MG','400 mg','CAPSU','CAPSULE','BP351','Blister pack x 10\'s (box of 100\'s )','E2096','Etopul','Lloyd Laboratories Inc.',0,0,0),('PIRAC800MGTAB2401146006564','Piracetam , 800 mg , Tablet Film Coated , EUCET','PIRAC','Piracetam','800MG','800 mg','TAB24','TABLET FILM COATED','01146','Alu Foil Strip 6\'s x 10\'s (Box of 60\'s)','E2097','Eucet','Lloyd Laboratories Inc.',0,0,0),('PIRAC800MGTAB2401151011268','Piracetam , 800 mg , Tablet Film Coated , CAXLEM','PIRAC','Piracetam','800MG','800 mg','TAB24','TABLET FILM COATED','01151','Alu PVC Blister pack x 10\'s (Box of 30\'s)','C2019','Caxlem','Walter-Ritter GmbH',0,0,0),('PIRAC800MGTAB2402350011269','Piracetam , 800 mg , Tablet Film Coated , CAXLEM','PIRAC','Piracetam','800MG','800 mg','TAB24','TABLET FILM COATED','02350','Strip foil pack x 10\'s (Box of 50\'s)','C2019','Caxlem','Walter-Ritter GmbH Co.',0,0,0),('PIRAC800MGTAB49B10SH002269','Piracetam , 800mg , Tablet , NULL','PIRAC','Piracetam','800MG','800mg','TAB49','TABLET','B10SH','Blister pack of 10s (Box of 100s)','','','Korea United Pharma',0,0,0),('PIZOT500MCCAPSUAMBOT004990','Pizotifen Hydrogen Maleate , 500 mcg , Capsule , DRUGMAKERS','PIZOT','Pizotifen Hydrogen Maleate','500MC','500 mcg','CAPSU','CAPSULE','AMBOT','Amber bottle','','','Drugmakers',0,0,0),('POTA1150MMSOL1400316011272','Potassium Chloride , 150 mg/mL , Solution For Injection , ATLANTIC ,100 mL Viaflex bag','POTA1','Potassium Chloride','150MM','150 mg/mL','SOL14','SOLUTION FOR INJECTION','00316','100 mL Viaflex bag','','','Atlantic',0,0,0),('POTA1150MMSOL1400927011278','Potassium Chloride , 150 mg/mL , Solution For Injection , ATLANTIC , 50 mL Viaflex bag','POTA1','Potassium Chloride','150MM','150 mg/mL','SOL14','SOLUTION FOR INJECTION','00927','50 mL Viaflex bag','','','Atlantic',0,0,0),('POTA12HMEQSOL35AM50S004139','Potassium Chloride , 200 mEq/L , Solution For Infusion , FONGITAR LIQUID , Amber bottle of 50s','POTA1','Potassium Chloride','2HMEQ','200 mEq/L','SOL35','SOLUTION FOR INFUSION','AM50S','Amber bottle of 50s','F2149','Fongitar Liquid','Baxter Healthcare phils',0,0,0),('POTA12MCGXSOL1400614011275','Potassium Chloride , 2 mcg /mL , Solution For Injection , EL LAB , 20 mL LDPE vial w/ rubber stopper','POTA1','Potassium Chloride','2MCGX','2 mcg /mL','SOL14','SOLUTION FOR INJECTION','00614','20 mL LDPE vial w/ rubber stopper','','','EL Lab',0,0,0),('POTA12MEQXSOL1400619011276','Potassium Chloride , 2 mEq/mL , Solution For Injection , EURO-MED , 20 mL Plastic vial','POTA1','Potassium Chloride','2MEQX','2 mEq/mL','SOL14','SOLUTION FOR INJECTION','00619','20 mL Plastic vial','','','Euro-Med',0,0,0),('POTA140MEQSOL1400316011270','Potassium Chloride , 40 mEq/20 mL , Solution For Injection , HIZON , 100 mL Viaflex bag','POTA1','Potassium Chloride','40MEQ','40 mEq/20 mL','SOL14','SOLUTION FOR INJECTION','00316','100 mL Viaflex bag','','','Hizon',0,0,0),('POTA14HMEQSOL3500316011271','Potassium Chloride , 400 meq/L , Solution For Infusion , BAXTER HEALTHCARE PHILS INC , 100 mL Viaflex bag','POTA1','Potassium Chloride','4HMEQ','400 meq/L','SOL35','SOLUTION FOR INFUSION','00316','100 mL Viaflex bag','','','Baxter Healthcare Phils Inc',0,0,0),('POTA14HMEQSOL3500316011273','Potassium Chloride , 400 mEq/L , Solution For Infusion , BAXTER HEALTHCARE , 100 mL Viaflex bag','POTA1','Potassium Chloride','4HMEQ','400 mEq/L','SOL35','SOLUTION FOR INFUSION','00316','100 mL Viaflex bag','','','Baxter Healthcare',0,0,0),('POTA14HMEQSOL3500927011277','Potassium Chloride , 400 meq/L , Solution For Infusion , BAXTER HEALTHCARE PHILS INC , 50 mL Viaflex bag','POTA1','Potassium Chloride','4HMEQ','400 meq/L','SOL35','SOLUTION FOR INFUSION','00927','50 mL Viaflex bag','','','Baxter Healthcare Phils Inc',0,0,0),('POTA14HMEQSOL3500927011279','Potassium Chloride , 400 mEq/L , Solution For Infusion , BAXTER HEALTHCARE , 50 mL Viaflex bag','POTA1','Potassium Chloride','4HMEQ','400 mEq/L','SOL35','SOLUTION FOR INFUSION','00927','50 mL Viaflex bag','','','Baxter Healthcare',0,0,0),('POVID10XXXSOL32120MB001944','Povidone Iodine , 10% , Solution , ALLIED PHARMACEUTICAL LAB. INC. , 120 mL bottle','POVID','Povidone Iodine','10XXX','10%','SOL32','Solution','120MB','120 mL bottle','','','Allied Pharmaceutical Lab. Inc.',0,0,0),('POVID10XXXSOL3215MLB001945','Povidone Iodine , 10% , Solution , ALLIED PHARMACEUTICAL LAB. INC. , 15 mL bottle','POVID','Povidone Iodine','10XXX','10%','SOL32','Solution','15MLB','15 mL bottle','','','Allied Pharmaceutical Lab. Inc.',0,0,0),('POVID10XXXSOL3235MLB001946','Povidone Iodine , 10% , Solution , ALLIED PHARMACEUTICAL LAB. INC. , 35 mL bottle','POVID','Povidone Iodine','10XXX','10%','SOL32','Solution','35MLB','35 mL bottle','','','Allied Pharmaceutical Lab. Inc.',0,0,0),('POVID10XXXSOL3260MLB001947','Povidone Iodine , 10% , Solution , ALLIED PHARMACEUTICAL LAB. INC. , 60 mL bottle','POVID','Povidone Iodine','10XXX','10%','SOL32','Solution','60MLB','60 mL bottle','','','Allied Pharmaceutical Lab. Inc.',0,0,0),('POVID10XXXSOL3260MLB001948','Povidone Iodine , 10% , Solution , BRANDS WORLDWIDE MANUFACTURING CORP. , 60 mL bottle','POVID','Povidone Iodine','10XXX','10%','SOL32','Solution','60MLB','60 mL bottle','','','Brands Worldwide Manufacturing Corp.',0,0,0),('POVID7P5XXSOL3200322011280','Povidone Iodine , 0.075 , Solution , BACTAZ , 1000 mL','POVID','Povidone Iodine','7P5XX','0.075','SOL32','SOLUTION','00322','1000 mL','B2003','Bactaz','Euro-Med',0,0,0),('POVID7P5XXSOL3200640011281','Povidone Iodine , 0.075 , Solution , BACTAZ , 200 mL','POVID','Povidone Iodine','7P5XX','0.075','SOL32','SOLUTION','00640','200 mL','B2003','Bactaz','Euro-Med',0,0,0),('POVID7P5XXSOL3202096011282','Povidone Iodine , 0.075 , Solution , BACTAZ , gallon','POVID','Povidone Iodine','7P5XX','0.075','SOL32','SOLUTION','02100','gallon','B2003','Bactaz','Euro-Med',0,0,0),('PRAVA10MGXTAB4901176006584','Pravastatin , 10 mg , Tablet , DISFLATYL','PRAVA','Pravastatin','10MGX','10 mg','TAB49','TABLET','01176','Alu/Alu Blister pack 10\'s (Box of 30\'s)','D2083','Disflatyl','Torrent',0,0,0),('PRAVA20MGXTAB4901422006871','Pravastatin , 20 mg , Tablet , DISFLATYL','PRAVA','Pravastatin','20MGX','20 mg','TAB49','TABLET','01422','Aluminum Flexible Foil x 6\'s (Box of 30\'s)','D2083','Disflatyl','Torrent',0,0,0),('PRAVA20MGXTAB4901422011283','Pravastatin , 20 mg , Tablet , EMCURE PHARMACEUTICALS LTD.','PRAVA','Pravastatin','20MGX','20 mg','TAB49','TABLET','01422','Aluminum Flexible Foil x 6\'s (Box of 30\'s)','','','Emcure Pharmaceuticals Ltd.',0,0,0),('PRAZI600MGTAB2401959011284','Praziquantel , 600 mg , Tablet Film Coated , CIPLA','PRAZI','Praziquantel','600MG','600 mg','TAB24','TABLET FILM COATED','01959','Cold Form Blister pack x 10\'s (Box of 30\'s)','','','Cipla',0,0,0),('PRAZI600MGTAB4902142011285','Praziquantel , 600 mg , Tablet , SHIN POONG','PRAZI','Praziquantel','600MG','600 mg','TAB49','TABLET','02142','HDPE Bottle x 500\'s','','','Shin Poong',0,0,0),('PRED210MG5GRAN601432006878','Prednisone , 10 mg/5 mL , Granule For Oral Suspension , PRC , Aluminum Foil Strip x 10\'s (Box of 100\'s)','PRED2','Prednisone','10MG5','10 mg/5 mL','GRAN6','GRANULE FOR ORAL SUSPENSION','01432','Aluminum Foil Strip x 10\'s (Box of 100\'s)','P0092','Prc','Lloyd Labs Inc',0,0,0),('PRED210MGXTAB24BF100004991','Prednisone , 10 mg , Tablet Film Coated , LLOYD LABS. INC.','PRED2','Prednisone','10MGX','10 mg','TAB24','TABLET FILM COATED','BF100','Blister foil by 100s','','','Lloyd Labs. Inc.',0,0,0),('PRED220MGXTAB4900797006071','Prednisone , 20 mg , Tablet , QUALISONE','PRED2','Prednisone','20MGX','20 mg','TAB49','TABLET','00797','5 Blister pack x 20\'s (Box of 100\'s)','Q0010','Qualisone','Lloyd Labs Inc',0,0,0),('PRED220MGXTAB4902055007796','Prednisone , 20 mg , Tablet , ORABETIC','PRED2','Prednisone','20MGX','20 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','O0020','Orabetic','Lloyd',0,0,0),('PRED25MGXXTAB4901318011291','Prednisone , 5 mg , Tablet , DRUGMAKER\'S LABS INC','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','01318','Alu/Alu Strip Foil x 10\'s (Box of 100\'s)','','','Drugmaker\'s Labs Inc',0,0,0),('PRED25MGXXTAB4901684011292','Prednisone , 5 mg , Tablet , LLOYD LABS INC','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','01684','Blister pack x 20\'s (Box of 100\'s)','','','Lloyd Labs Inc',0,0,0),('PRED25MGXXTAB4901684011303','Prednisone , 5 mg , Tablet , BIOSONE','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','01684','Blister pack x 20\'s (Box of 100\'s)','B0070','Biosone','Lloyd Laboratories',0,0,0),('PRED25MGXXTAB4901688011293','Prednisone , 5 mg , Tablet , LLOYD LABS INC','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','01688','Blister pack x 20\'s (Box of 500\'s)','','','Lloyd Labs Inc',0,0,0),('PRED25MGXXTAB4902015011294','Prednisone , 5 mg , Tablet , LLOYD','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','02015','Foil strip 100\'s','','','Lloyd',0,0,0),('PRED25MGXXTAB4902055007836','Prednisone , 5 mg , Tablet , ZAREP','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','Z0012','Zarep','Lloyd Lab inc.',0,0,0),('PRED25MGXXTAB4902055011295','Prednisone , 5 mg , Tablet , DRUGMAKER\'S LAB., INC','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','','','Drugmaker\'s Lab., Inc',0,0,0),('PRED25MGXXTAB49BF100004992','Prednisone , 5 mg , Tablet , DRUGMAKERS','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','BF100','Blister foil by 100s','','','Drugmakers',0,0,0),('PRED25MGXXTAB49BP205004993','Prednisone , 5 mg , Tablet , INTERPHIL','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','BP205','Blister pack of 20s (Box of 5s)','','','Interphil',0,0,0),('PRED25MGXXTAB49BP20H003926','Prednisone , 5 mg , Tablet , DOXAR','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','BP20H','Blister pack of 20s (Box of 100s)','D2119','Doxar','Lloyd Laboratories Inc.',0,0,0),('PRED25MGXXTAB49BP351003778','Prednisone , 5 mg , Tablet , CORPUGEN','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','C0222','Corpugen','Lloyd',0,0,0),('PRED25MGXXTAB49BPX30003442','Prednisone , 5 mg , Tablet , BIOSONE','PRED2','Prednisone','5MGXX','5 mg','TAB49','TABLET','BPX30','Blister pack of 10s (Box of 30s)','B0070','Biosone','Drugmaker\'s Labs Inc',0,0,0),('PREDN155MLSYRUP02187011288','Prednisolone , 15 mg/5mL , Syrup , DRUGMAKERS BIOTECH , Plastic bottle by 200\'s','PREDN','Prednisolone','155ML','15 mg/5mL','SYRUP','SYRUP','02187','Plastic bottle by 200\'s','','','Drugmakers Biotech',0,0,0),('PROC2143MCMDIXXACA5M002362','Procaterol Hydrochloride , 143 mcg/g , Metered Dose Inhaler (Cfc-Free) , MEPTIN AIR , Aluminum container + activator x 5ml','PROC2','PROCATEROL Hydrochloride','143MC','143 mcg/g','MDIXX','Metered Dose Inhaler (CFC-Free)','ACA5M','Aluminum container + activator x 5ml','M0167','Meptin Air','Otsuka Pharml Co Ltd',0,0,0),('PROPO10MGXTAB4902343008102','Propofol , 10 mg , Tablet , INCREPH','PROPO','Propofol','10MGX','10 mg','TAB49','TABLET','02343','Strip foil of 10\'s (Box of 100\'s)','I0013','Increph','AstraZeneca',0,0,0),('PYRAN125M5SUS1400160011307','Pyrantel , 125 mg/5 mL , Suspension , SCHEELE , 10 mL Amber glass bottle','PYRAN','Pyrantel','125M5','125 mg/5 mL','SUS14','SUSPENSION','00160','10 mL Amber glass bottle','','','Scheele',0,0,0),('PYRAN125M5SUS1400394011314','Pyrantel , 125 mg/5 mL , Suspension , COMBANTRIN , 15 mL Amber bottle','PYRAN','Pyrantel','125M5','125 mg/5 mL','SUS14','SUSPENSION','00394','15 mL Amber bottle','C2108','Combantrin','Interphil',0,0,0),('PYRAN125M5SUS1400728011311','Pyrantel , 125 mg/5 mL , Suspension , ASPIDON , 30 mL Amber bottle','PYRAN','Pyrantel','125M5','125 mg/5 mL','SUS14','SUSPENSION','00728','30 mL Amber bottle','A2196','Aspidon','Pascual',0,0,0),('PYRAN125M5SUS14AM100004182','Pyrantel , 125 mg/5 mL , Suspension , GELASTAN , Amber bottle of 100s','PYRAN','Pyrantel','125M5','125 mg/5 mL','SUS14','SUSPENSION','AM100','Amber bottle of 100s','G0009','Gelastan','Diamond',0,0,0),('PYRAN250M5SUS1400144011306','Pyrantel , 250 mg/5 mL , Suspension , DIAMOND , 10 mL Amber bottle','PYRAN','Pyrantel','250M5','250 mg/5 mL','SUS14','SUSPENSION','00144','10 mL Amber bottle','','','Diamond',0,0,0),('PYRAN250M5SUS1400982011308','Pyrantel , 250 mg/5 mL , Suspension , DIAMOND , 60 mL Amber bottle','PYRAN','Pyrantel','250M5','250 mg/5 mL','SUS14','SUSPENSION','00982','60 mL Amber bottle','','','Diamond',0,0,0),('PYRAN250MGTAB4901624011313','Pyrantel , 250 mg , Tablet , COLVAN','PYRAN','Pyrantel','250MG','250 mg','TAB49','TABLET','01624','Blister pack of 4 (Box of 100\'s)','C2107','Colvan','PT Pfizer Indonesia',0,0,0),('PYRAZ125M5SUS14AMBOT002848','Pyrazinamide , 125 mg/5 mL , Suspension , PYRAMIN , Amber bottle','PYRAZ','Pyrazinamide','125M5','125 mg/5 mL','SUS14','SUSPENSION','AMBOT','Amber bottle','P0146','Pyramin','Drugmakers',0,0,0),('PYRAZ250M5SUS14120AM002851','Pyrazinamide , 250 mg/5 mL , Suspension , PZA-CIBA , 120 mL Amber bottle','PYRAZ','Pyrazinamide','250M5','250 mg/5 mL','SUS14','SUSPENSION','120AM','120 mL Amber bottle','P0151','Pza-Ciba','Interphil',0,0,0),('PYRAZ250M5SUS14AM100003356','Pyrazinamide , 250 mg/5 mL , Suspension , ZYNAPHAR , Amber bottle of 100s','PYRAZ','Pyrazinamide','250M5','250 mg/5 mL','SUS14','SUSPENSION','AM100','Amber bottle of 100s','Z0092','Zynaphar','J.M. Tolmann Labs. Inc.',0,0,0),('PYRAZ500MGTAB49B10SH 002852','Pyrazinamide , 500 mg , Tablet , PZA-CIBA','PYRAZ','Pyrazinamide','500MG','500 mg','TAB49','TABLET','B10SH','Blister pack of 10s (Box of 100s)','P0151','Pza-Ciba','Interphil Labs Inc',0,0,0),('PYRAZ500MGTAB49BP351003893','Pyrazinamide , 500 mg , Tablet , DIOVAN','PYRAZ','Pyrazinamide','500MG','500 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','D2079','Diovan','Doctors',0,0,0),('PYRAZ500MGTAB49BP351004997','Pyrazinamide , 500 mg , Tablet , LUMAR PHARMA\'L LABS','PYRAZ','Pyrazinamide','500MG','500 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','','','Lumar Pharma\'l Labs',0,0,0),('PYRAZ500MGTAB49BPT35004996','Pyrazinamide , 500 mg , Tablet , J.M. TOLMANN LABS., INC','PYRAZ','Pyrazinamide','500MG','500 mg','TAB49','TABLET','BPT35','Blister pack x 10 (Box of 50\'s)','','','J.M. Tolmann Labs., Inc',0,0,0),('PYRID60MGMTAB2401631011324','Pyridostigmine , 60 mg/mL , Tablet Film Coated , ASTHATOR-5','PYRID','Pyridostigmine','60MGM','60 mg/mL','TAB24','TABLET FILM COATED','01631','Blister pack of one ethambutol tablet (Box of 15 Blister pack)','A2201','Asthator-5','Samarth Life Sciences Pvt Ltd',0,0,0),('PYRID60MGMTAB2401632011325','Pyridostigmine , 60 mg/mL , Tablet Film Coated , ASTHATOR-5','PYRID','Pyridostigmine','60MGM','60 mg/mL','TAB24','TABLET FILM COATED','01632','Blister pack of one Isoniaziz tablet (Box of 15 Blister pack)','A2201','Asthator-5','Samarth Life Sciences Pvt Ltd',0,0,0),('PYRID60MGMTAB2401633011326','Pyridostigmine , 60 mg/mL , Tablet Film Coated , ASTHATOR-5','PYRID','Pyridostigmine','60MGM','60 mg/mL','TAB24','TABLET FILM COATED','01633','Blister pack of one rifampicin capsule (Box of 15 Blister pack)','A2201','Asthator-5','Samarth Life Sciences Pvt Ltd',0,0,0),('PYRID60MGMTAB2401634011327','Pyridostigmine , 60 mg/mL , Tablet Film Coated , ASTHATOR-5','PYRID','Pyridostigmine','60MGM','60 mg/mL','TAB24','TABLET FILM COATED','01634','Blister pack of two pyrazinamide tablets (Box of 15 Blister pack)','A2201','Asthator-5','Samarth Life Sciences Pvt Ltd',0,0,0),('PYRIT200MGTAB49BP351003972','Pyritinol , 200 mg , Tablet , ENCEPHABOL','PYRIT','Pyritinol','200MG','200 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','E2046','Encephabol','P.T. Merck Indonesia',0,0,0),('QUIN1250MMSOL1400506011330','Quinine Dihydrochloride , 250 mg/mL , Solution For Injection , QUINOSIL , 2 mL Type I Amber ampul (Plastic Container x 30\'s)','QUIN1','Quinine Dihydrochloride','250MM','250 mg/mL','SOL14','SOLUTION FOR INJECTION','00506','2 mL Type I Amber ampul (Plastic Container x 30\'s)','','','Quinosil',0,0,0),('QUIN13HMGXTAB4900330005629','Quinine Dihydrochloride , 300 mg , Tablet , FLACERANT','QUIN1','Quinine Dihydrochloride','3HMGX','300 mg','TAB49','TABLET','00330','100\'s Amber bottle','F0032','Flacerant','Flamingo',0,0,0),('RALOX60MGXTAB2402184011331','Raloxifene , 60 mg , Tablet Film Coated , AMHERST LABS INC','RALOX','Raloxifene','60MGX','60 mg','TAB24','TABLET FILM COATED','02184','PET/Alu/LLDPE sachets (Box of 10\'s)','','','Amherst Labs Inc',0,0,0),('RALOX60MGXTAB4901438006886','Raloxifene , 60 mg , Tablet , EVATOCIN','RALOX','Raloxifene','60MGX','60 mg','TAB49','TABLET','01438','Aluminum Foil strip x 6\'s (Box of 30\'s)','E2124','Evatocin','Eli lilly Co. Ltd',0,0,0),('RAMIP10MGXTAB4901204011332','Ramipril , 10 mg , Tablet , HIZON LABS INC','RAMIP','Ramipril','10MGX','10 mg','TAB49','TABLET','01204','Alu/Alu Blister pack x 10\'s (Box of 100\'s)','','','Hizon Labs Inc',0,0,0),('RAMIP5MGXXCAPSU01174006581','Ramipril , 5 mg , Capsule , EBETREXAT','RAMIP','Ramipril','5MGXX','5 mg','CAPSU','CAPSULE','01174','Alu/Alu Blister pack 10\'s (Box of 100\'s)','E2002','Ebetrexat','Torrent Pharmaceuticals Ltd',0,0,0),('RAMIP5MGXXCAPSU01654011336','Ramipril , 5 mg , Capsule , WINDLAS BIOTECH LTD.','RAMIP','Ramipril','5MGXX','5 mg','CAPSU','CAPSULE','01654','Blister pack x 10\'s (Box of 30\'s)','','','Windlas Biotech Ltd.',0,0,0),('RAMIP5MGXXTAB4901365011335','Ramipril , 5 mg , Tablet , HIZON LABS INC','RAMIP','Ramipril','5MGXX','5 mg','TAB49','TABLET','01365','Alu/PVC Blister pack x 10\'s (Box of 100\'s)','','','Hizon Labs Inc',0,0,0),('RANI1150MGTAB4901974012030','Ranitidine Hydrochloride , 150 mg , Tablet , ZANTAC','RANI1','Ranitidine Hydrochloride','150MG','150 mg','TAB49','TABLET','01974','Double Foil Blister Pack x 10\'s (Box of 60\'s)','Z0008','Zantac','GlaxoSmithKline (Tianjin) Pty. Ltd.',0,0,0),('RANI1150MGTAB4901991011994','Ranitidine (As Hydrochloride) , 150 mg , Tablet , RAXIDE','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','01991','Foil Strip x 4\'s (Box of 100\'s)','R0028','Raxide','Hizon Laboratories, Inc.',0,0,0),('RANI1150MGTAB4902055012022','Ranitidine Hydrochloride , 150 mg , Tablet , ULCIN','RANI1','Ranitidine Hydrochloride','150MG','150 mg','TAB49','TABLET','02055','Foil Strip x 10\'s (Box of 100\'s)','U0011','Ulcin','Biolab Co. Ltd.',0,0,0),('RANI1150MGTAB4902062012023','Ranitidine Hydrochloride , 150 mg , Tablet , ULCIN','RANI1','Ranitidine Hydrochloride','150MG','150 mg','TAB49','TABLET','02062','Foil Strip x 10\'s (Box of 30\'s)','U0011','Ulcin','Biolab Co. Ltd.',0,0,0),('RANI125MGMSOL38002396','Ranitidine (As Hydrochloride) , 25 mg/mL , Solution For Injection (Iv) , RENTSAN , USP Type I Clear glass ampul x 2ml (box of 10\'s)','RANI1','RANITIDINE (as Hydrochloride)','25MGM','25 mg/mL','SOL38','SOLUTION FOR INJECTION (IV)','03099','USP Type I Clear glass ampul x 2 mL (Box of 10\'s)','R0043','Rentsan','',0,0,0),('RANIT15015TAB4902055007768','Ranitidine , 150 mg/15 mL , Tablet , RENFORT','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','02055','Foil Strip x 10\'s (Box of 100\'s)','R0040','Renfort','Unique Pharmaceutical Labs',0,0,0),('RANIT150MGSOL1400457011370','Ranitidine , 150 mg , Solution For Injection , CHRISFEN , 2 mL Amber ampul','RANIT','Ranitidine','150MG','150 mg','SOL14','SOLUTION FOR INJECTION','00457','2 mL Amber ampul','C0083','Chrisfen','Umedica Labs Pvt Ltd',0,0,0),('RANIT150MGTAB24002308','Ranitidine , 150 mg , Tablet Film Coated , ULCERGO','RANIT','Ranitidine','150MG','150 mg','TAB24','TABLET FILM COATED','01325','Alu/Alu Strip x 10\'s (box of 100\'s)','U0008','Ulcergo','',0,0,0),('RANIT150MGTAB2401684011346','Ranitidine , 150 mg , Tablet Film Coated , EMIL PHARMACEUTICALS INDUSTRIES PVT LTD INDIA','RANIT','Ranitidine','150MG','150 mg','TAB24','TABLET FILM COATED','01684','Blister pack x 20\'s (Box of 100\'s)','','','Emil Pharmaceuticals Industries Pvt Ltd India',0,0,0),('RANIT150MGTAB2402029011348','Ranitidine , 150 mg , Tablet Film Coated , HIZON','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB24','TABLET FILM COATED','02008','Foil strip 10 (Box of 100\'s)','','','Hizon Laboratories, Inc.',0,0,0),('RANIT150MGTAB2402055007776','Ranitidine , 150 mg , Tablet Film Coated , PEPRASAN-T','RANIT','Ranitidine','150MG','150 mg','TAB24','TABLET FILM COATED','02055','Foil strip x 10\'s (Box of 100\'s)','P0050','Peprasan-T','Berlin Pharm\'l. Industry Co.',0,0,0),('RANIT150MGTAB2402334011374','Ranitidine , 150 mg , Tablet Film Coated , DANITIN','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB24','TABLET FILM COATED','02356','Strip Foil x 10\'s (Box of 100\'s)','D0013','Danitin','Y.S.P. Industries (M) Sdn. Bhd.',0,0,0),('RANIT150MGTAB24BP351005000','Ranitidine , 150 mg , Tablet Film Coated , EMIL','RANIT','Ranitidine','150MG','150 mg','TAB24','TABLET FILM COATED','BP351','Blister pack x 10\'s (box of 100\'s )','','','Emil',0,0,0),('RANIT150MGTAB4900238005553','Ranitidine , 150 mg , Tablet , EPICORT','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','02055','Foil Strip x 10\'s (Box of 100\'s)','E0038','Epidin','V.S. International Pvt Ltd',0,0,0),('RANIT150MGTAB4900238005554','Ranitidine , 150 mg , Tablet , ZANTAC FR','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB20','TABLET EFFERVESCENT','00238','10 Tablets per Polypropylene Tube w/ Polyethylene Cap','Z0009','Zantac Fr','Glaxo Wellcome Production',0,0,0),('RANIT150MGTAB4901153011365','Ranitidine , 150 mg , Tablet , ACIRIC-150','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','01153','Alu Strip 10\'s (Box of 100\'s)','A0018','Aciric-150','Euphoric Pharmaceuticals (P) Ltd India',0,0,0),('RANIT150MGTAB4901604011366','Ranitidine , 150 mg , Tablet , ACIRIC-150','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','01604','Blister pack of 10 (Box of 100\'s)','A0018','Aciric-150','Euphoric Pharmaceuticals (P) Ltd',0,0,0),('RANIT150MGTAB4901647007070','Ranitidine , 150 mg , Tablet , ULCEMED','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','01647','Blister pack x 10\'s (Box of 100\'s)','U0003','Ulcemed','Medica Korea Co., Ltd. - Korea',0,0,0),('RANIT150MGTAB4901671007296','Ranitidine , 150 mg , Tablet , RANAE','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','02055','Foil Strip x 10\'s (Box of 100\'s)','R0011','Ranae','Umedica Labs Pvt Ltd',0,0,0),('RANIT150MGTAB4901718007390','Ranitidine , 150 mg , Tablet , EUGLIN','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','01718','Blister pack x 7\'s (Box of 14\'s)','E2099','Euglin','Seoul Pharma Co. Ltd',0,0,0),('RANIT150MGTAB4902022007708','Ranitidine , 150 mg , Tablet , ZANTOL','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','02022','Foil strip 4\'s','Z0010','Zantol','Duopharma',0,0,0),('RANIT150MGTAB4902030011349','Ranitidine , 150 mg , Tablet , HIZON','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','02055','Foil Strip x 10\'s (Box of 100\'s)','','','Hizon Laboratories, Inc.',0,0,0),('RANIT150MGTAB4902037007729','Ranitidine , 150 mg , Tablet , ULCERAL','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','02037','Foil Strip of 10\'s (Box of 5 Foil Strips)','U0007','Ulceral','Lloyd Laboratories Inc.',0,0,0),('RANIT150MGTAB4902038011368','Ranitidine , 150 mg , Tablet , AMLOC','RANI1','Ranitidine Hydrochloride','150MG','150 mg','TAB49','TABLET','02032','Foil Strip of 10\'s (Box of 100\'s)','A0098','Amloc','Stallion Labs Pvt Ltd',0,0,0),('RANIT150MGTAB4902039011372','Ranitidine , 150 mg , Tablet , DANAZINE','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','02039','Foil strip of 4\'s (Box of 100\'s)','D2003','Danazine','Yung Shin Pharma Ind. Co., Ltd.',0,0,0),('RANIT150MGTAB4902055007777','Ranitidine , 150 mg , Tablet , EUGLO PLUS','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','02066','Foil Strip x 10\'s (Box of 60\'s)','E0067','EU-Ran','Lloyd Laboratories Inc.',0,0,0),('RANIT150MGTAB4902055007778','Ranitidine , 150 mg , Tablet , RANIMAX','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','R0016','Ranimax','Plethico',0,0,0),('RANIT150MGTAB4902055007779','Ranitidine , 150 mg , Tablet , RANISAN','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','R0017','Ranisan','Kopran Ltd',0,0,0),('RANIT150MGTAB4902055007780','Ranitidine , 150 mg , Tablet , ULCEMED','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','U0003','Ulcemed','Medica Korea Co., Ltd',0,0,0),('RANIT150MGTAB4902055007781','Ranitidine , 150 mg , Tablet , VERANIDINE','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','FS10T','Foil strip 10 x 10\'s (Box of 100\'s)','V0040','Veranidine','Saphire Lifesciences Pvt Ltd',0,0,0),('RANIT150MGTAB4902055007782','Ranitidine , 150 mg , Tablet , ZERDIN','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','02356','Strip Foil x 10\'s (Box of 100\'s)','Z0038','Zerdin','Hizon Laboratories, Inc.',0,0,0),('RANIT150MGTAB4902055011350','Ranitidine , 150 mg , Tablet , DRUGMAKERS BIOTECH','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','BP351','Blister Pack x 10\'s (Box of 100\'s)','','','Drugmakers Laboratories, Inc.',0,0,0),('RANIT150MGTAB4902089011352','Ranitidine , 150 mg , Tablet , PASCUAL','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','02356','Strip Foil x 10\'s (Box of 100\'s)','','','Pascual Laboratories Inc.',0,0,0),('RANIT150MGTAB4902334011359','Ranitidine , 150 mg , Tablet , ACEPTIN','RANI1','Ranitidine (as Hydrochloride)','150MG','150 mg','TAB49','TABLET','02334','Strip Foil 10 x 10\'s (Box of 100\'s)','A0009','Aceptin','Hizon Laboratories, Inc.',0,0,0),('RANIT150MGTAB4902356011354','Ranitidine , 150 mg , Tablet , HIZON','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','02356','Strip foil x 10\'s (Box of 100\'s)','','','Hizon',0,0,0),('RANIT150MGTAB4902361011360','Ranitidine , 150 mg , Tablet , ACEPTIN','RANIT','Ranitidine','150MG','150 mg','TAB49','TABLET','02361','Strip foil x 10\'s (Box of 50\'s)','A0009','Aceptin','Hizon',0,0,0),('RANIT25MGMSOL1400309005622','Ranitidine , 25 mg/mL , Solution For Injection , ULCEMED , 100 mL USP Type I clear glass ampul colorless vial','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00309','100 mL USP Type I clear glass ampul colorless vial','U0003','Ulcemed','Medica Korea Co. Ltd.',0,0,0),('RANIT25MGMSOL1400457005818','Ranitidine , 25 mg/mL , Solution For Injection , ZELTAC , 2 mL Amber ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00457','2 mL Amber ampul','Z0029','Zeltac','Plethico Pharm\'l. Ltd.',0,0,0),('RANIT25MGMSOL1400471005837','Ranitidine , 25 mg/mL , Solution For Injection , GABIX , 2 mL ampul (Box of 100\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00471','2 mL ampul (Box of 100\'s)','G2009','Gabix','Unimed Pharmaceuticals, Inc.',0,0,0),('RANIT25MGMSOL1400473005839','Ranitidine , 25 mg/mL , Solution For Injection , GABIX , 2 mL ampul (Box of 50\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00473','2 mL ampul (Box of 50\'s)','G2009','Gabix','Unimed Pharmaceuticals, Inc.',0,0,0),('RANIT25MGMSOL1400474011371','Ranitidine , 25 mg/mL , Solution For Injection , DALACIN C , 2 mL Ampul x 10\'s','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00474','2 mL Ampul x 10\'s','D0009','Dalacin C','Deutsche Lab Inc.',0,0,0),('RANIT25MGMSOL1400494005855','Ranitidine , 25 mg/mL , Solution For Injection , ULCI-CURE , 2 mL Glass ampul (Box of 5\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00494','2 mL Glass ampul (Box of 5\'s)','U0010','Ulci-Cure','Plethico',0,0,0),('RANIT25MGMSOL1400499011338','Ranitidine , 25 mg/mL , Solution For Injection , TORRENT , 2 mL Hermetic Amber ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00499','2 mL Hermetic Amber ampul','','','Torrent',0,0,0),('RANIT25MGMSOL1400501005860','Ranitidine , 25 mg/mL , Solution For Injection , SIUTEC , 2 mL LDPE Plastic Ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00501','2 mL LDPE Plastic Ampul','S0061','Siutec','Siu Guan Chem. Ind. Co.,Ltd.',0,0,0),('RANIT25MGMSOL1400513005869','Ranitidine , 25 mg/mL , Solution For Injection , RANTIZEC , 2 mL Type I Clear Glass ampul (Box of 5\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00513','2 mL Type I Clear Glass ampul (Box of 5\'s)','P0023','Rantizec','Ildong Pharma Co. Ltd. - Korea',0,0,0),('RANIT25MGMSOL1400519005871','Ranitidine , 25 mg/mL , Solution For Injection , RAXIDE , 2 mL Type I glass ampul (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00519','2 mL Type I glass ampul (Box of 10\'s)','R0028','Raxide','Cadila Health Ltd',0,0,0),('RANIT25MGMSOL1400530011340','Ranitidine , 25 mg/mL , Solution For Injection , STALLION LABORATORIES PVT. LTD. , 2 mL USP glass Type I ampul (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00530','2 mL USP glass Type I ampul (Box of 10\'s)','','','Stallion Laboratories Pvt. Ltd.',0,0,0),('RANIT25MGMSOL1400532005879','Ranitidine , 25 mg/mL , Solution For Injection , INCID , 2 mL USP Type I Amber ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00532','2 mL USP Type I Amber ampul','I0012','Incid','Plethico',0,0,0),('RANIT25MGMSOL1400532005880','Ranitidine , 25 mg/mL , Solution For Injection , RA BLOC , 2 mL USP Type I Amber ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00532','2 mL USP Type I Amber ampul','R0001','Ra Bloc','Euro-Med',0,0,0),('RANIT25MGMSOL1400532011341','Ranitidine , 25 mg/mL , Solution For Injection , YANGZHOU KANGTAI , 2 mL USP Type I Amber ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00532','2 mL USP Type I Amber ampul','','','Yangzhou Kangtai',0,0,0),('RANIT25MGMSOL1400533005881','Ranitidine , 25 mg/mL , Solution For Injection , RANIBLOC , 2 mL USP Type I Amber ampul (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00533','2 mL USP Type I Amber ampul (Box of 10\'s)','R0015','Ranibloc','Plethico',0,0,0),('RANIT25MGMSOL1400533011342','Ranitidine , 25 mg/mL , Solution For Injection , DAEWON, 2 mL USP Type I Amber ampul (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00533','2 mL USP Type I Amber ampul (Box of 10\'s)','','','Daewon',0,0,0),('RANIT25MGMSOL1400533011343','Ranitidine , 25 mg/mL , Solution For Injection , OBOI LABORATORIES , 2 mL USP Type I Amber ampul (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00533','2 mL USP Type I Amber ampul (Box of 10\'s)','','','Oboi Laboratories',0,0,0),('RANIT25MGMSOL1400533011362','Ranitidine , 25 mg/mL , Solution For Injection , ACIRAN , 2 mL USP Type I Amber ampul (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00533','2 mL USP Type I Amber ampul (Box of 10\'s)','A0016','Aciran','Plethico',0,0,0),('RANIT25MGMSOL1400537005885','Ranitidine , 25 mg/mL , Solution For Injection , ULCEDRUG , 2 mL USP Type I Amber glass ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00537','2 mL USP Type I Amber glass ampul','U0001','Ulcedrug','Stallion Labs Pvt Ltd India',0,0,0),('RANIT25MGMSOL1400538011344','Ranitidine , 25 mg/mL , Solution For Injection , SRS , 2 mL USP Type I Amber glass ampul (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00538','2 mL USP Type I Amber glass ampul (Box of 10\'s)','','','SRS',0,0,0),('RANIT25MGMSOL1400542005891','Ranitidine , 25 mg/mL , Solution For Injection , ULCERIX , 2 mL USP Type I clear glass ampul (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00542','2 mL USP Type I clear glass ampul (Box of 10\'s)','U0009','Ulcerix','Oboi Labs',0,0,0),('RANIT25MGMSOL1400550005895','Ranitidine , 25 mg/mL , Solution For Injection , RAMADINE , 2 mL USP Type I Flint glass ampul (Box of 5\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00550','2 mL USP Type I Flint glass ampul (Box of 5\'s)','R0009','Ramadine','PT Indofarma Tbk',0,0,0),('RANIT25MGMSOL1400557005900','Ranitidine , 25 mg/mL , Solution For Injection , RANFORT , 2 mL USP Type I glass vial (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00557','2 mL USP Type I glass vial (Box of 10\'s)','R0014','Ranfort','Mount Mettur Pharmaceuticals Ltd',0,0,0),('RANIT25MGMSOL1400735006031','Ranitidine , 25 mg/mL , Solution For Injection , RENFORT , 30 mL Amber glass Bottle','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','00735','30 mL Amber glass Bottle','R0040','Renfort','Unique Pharma\'l Labs',0,0,0),('RANIT25MGMSOL1401211011373','Ranitidine , 25 mg/mL , Solution For Injection , DANBUTOL , Alu/Alu Blister pack x 10\'s (Box of 60\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','01211','Alu/Alu Blister pack x 10\'s (Box of 60\'s)','D2004','Danbutol','Yung Shin',0,0,0),('RANIT25MGMSOL1401784007452','Ranitidine , 25 mg/mL , Solution For Injection , EUROCOXIN FORTE , Box of 10 ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','01784','Box of 10 ampul','E2105','Eurocoxin Forte','Xier Kang Tai Pharmaceutical Co. Ltd.',0,0,0),('RANIT25MGMSOL1402469011357','Ranitidine , 25 mg/mL , Solution For Injection , SINOCHEM NINGBO LTD , USP glass Type I ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','02469','USP glass Type I ampul','','','Sinochem Ningbo Ltd',0,0,0),('RANIT25MGMSOL1402483008228','Ranitidine , 25 mg/mL , Solution For Injection , ULCERGO , USP Type I Amber glass ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','02483','USP Type I Amber glass ampul','U0008','Ulcergo','The Acme Labs Ltd',0,0,0),('RANIT25MGMSOL1402483011369','Ranitidine , 25 mg/mL , Solution For Injection , AMLOC , USP Type I Amber glass ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL14','SOLUTION FOR INJECTION','02483','USP Type I Amber glass ampul','A0098','Amloc','Umedica Labs Pvt Ltd',0,0,0),('RANIT25MGMSOL3200456005816','Ranitidine , 25 mg/mL , Solution , RANITAC , 2 mL Alum Flip off x 10 (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL32','SOLUTION','00456','2 mL Alum Flip off x 10 (Box of 10\'s)','R0019','Ranitac','Yangzhou Kangtai',0,0,0),('RANIT25MGMSOL3200534005882','Ranitidine , 25 mg/mL , Solution , DYNAE , 2 mL USP Type I amber colored ampul (Box of 10\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL32','SOLUTION','00534','2 mL USP Type I amber colored ampul (Box of 10\'s)','D0119','Dynae','Yung Shin Pharm. Co Ltd',0,0,0),('RANIT25MGMSOL3200535005883','Ranitidine , 25 mg/mL , Solution , DYNAE , 2 mL USP Type I amber colored ampul (Box of 50\'s)','RANIT','Ranitidine','25MGM','25 mg/mL','SOL32','SOLUTION','00535','2 mL USP Type I amber colored ampul (Box of 50\'s)','D0119','Dynae','Yung Shin Pharm. Co Ltd',0,0,0),('RANIT25MGMSOL3200861006129','Ranitidine , 25 mg/mL , Solution , RANAE , 5 mL Plastic Dropper in bottle','RANIT','Ranitidine','25MGM','25 mg/mL','SOL32','SOLUTION','00861','5 mL Plastic Dropper in bottle','R0011','Ranae','Mount Mettur Pharm',0,0,0),('RANIT25MGMSOL3202474011375','Ranitidine , 25 mg/mL , Solution , DANITIN , USP Type amber ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL32','SOLUTION','02474','USP Type amber ampul','D0013','Danitin','Yung Shin Pharmaceutical Ind. Co. Ltd',0,0,0),('RANIT25MGMSOL322MLAM003079','Ranitidine , 25 mg/mL , Solution , TIDVEX , 2 mL ampul','RANIT','Ranitidine','25MGM','25 mg/mL','SOL32','SOLUTION','2MLAM','2 mL ampul','T0054','Tidvex','Mount Mettur Pharm',0,0,0),('RANIT3HMGXTAB2002032007724','Ranitidine , 300 mg , Tablet Effervescent , ZANTAC FR','RANIT','Ranitidine','3HMGX','300 mg','TAB20','TABLET EFFERVESCENT','02032','Foil strip of 10\'s (Box of 100\'s)','Z0009','Zantac Fr','Glaxo Wellcome Production',0,0,0),('RANIT3HMGXTAB4901701007374','Ranitidine , 300 mg , Tablet , RANITAB','RANIT','Ranitidine','3HMGX','300 mg','TAB49','TABLET','01701','Blister pack x 30\'s (Box of 60\'s)','R0018','Ranitab','Ranbaxy',0,0,0),('RANIT3HMGXTAB4901974007669','Ranitidine , 300 mg , Tablet , ULCERGO','RANIT','Ranitidine','3HMGX','300 mg','TAB49','TABLET','01974','Double foil Blister pack x 10\'s (Box of 60\'s)','U0008','Ulcergo','The ACME Labs',0,0,0),('RANIT3HMGXTAB4902013007701','Ranitidine , 300 mg , Tablet , VERANIDINE','RANIT','Ranitidine','3HMGX','300 mg','TAB49','TABLET','FS10T','Foil strip 10 x 10\'s (Box of 100\'s)','V0040','Veranidine','Saphire Lifesciences Pvt Ltd',0,0,0),('RANIT3HMGXTAB4902055007813','Ranitidine , 300 mg , Tablet , RANITEIN','RANIT','Ranitidine','3HMGX','300 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','R0020','Ranitein','CSPC Zhognuo Pharmaceutical Co. Ltd.',0,0,0),('RANIT3HMGXTAB4902066007865','Ranitidine , 300 mg , Tablet , RAMADINE','RANIT','Ranitidine','3HMGX','300 mg','TAB49','TABLET','02066','Foil strip x 10\'s (Box of 60\'s)','R0009','Ramadine','Apotex Inc',0,0,0),('RANIT3HMGXTAB4902367008138','Ranitidine , 300 mg , Tablet , SYNDENDINE','RANIT','Ranitidine','3HMGX','300 mg','TAB49','TABLET','02367','Strip foil x 4\'s (Box of 100\'s)','S0117','Syndendine','Okasa Pharma Ltd. Pvt. - India',0,0,0),('RANIT3HMGXTAB49FS10X003138','Ranitidine , 300 mg , Tablet , ULCERAGON','RANIT','Ranitidine','3HMGX','300 mg','TAB49','TABLET','FS10X','Foil strip by 10\'s (Box of 100\'s)','U0006','Ulceragon','Torrent',0,0,0),('RANIT75MGXTAB2401325006768','Ranitidine , 75 mg , Tablet Film Coated , ULCEPTOR','RANIT','Ranitidine','75MGX','75 mg','TAB24','TABLET FILM COATED','01325','Alu/Alu Strip x 10\'s (Box of 100\'s)','U0005','Ulceptor','Drugmakers',0,0,0),('RANIT75MGXTAB4902055011351','Ranitidine , 75 mg , Tablet , DRUGMAKERS','RANIT','Ranitidine','75MGX','75 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','','','Drugmakers',0,0,0),('REBAM100MGTAB24002354','Rebamipide , 100 mg , Tablet Film Coated , GASTRIX','REBAM','REBAMIPIDE','100MG','100 mg','TAB24','TABLET FILM COATED','01336','Alu/Clear PVC Blister pack x 10\'s (Box of 100\'s)','G2015','Gastrix','Chunggei Pharma Co Ltd',0,0,0),('RETIN25TIUCAPSU01971011376','Retinol , 25000 IU , Capsule , AFAXIN','RETIN','Retinol','25TIU','25000 IU','CAPSU','CAPSULE','01971','Cylindrical HPDE Bottle','A2050','Afaxin','Cardinal Health',0,0,0),('RIFAM2H5MLSUS1400677005967','Rifampulicin , 200 mg/5 mL , Suspension , RIMACTANE FORTE , 250 mL Amber bottle','RIFAM','Rifampulicin','2H5ML','200 mg/5 mL','SUS14','SUSPENSION','00677','250 mL Amber bottle','R0075','Rimactane Forte','Interphil',0,0,0),('RIFAM2H5MLSUS14120AM002917','Rifampulicin , 200 mg/5 mL , Suspension , RIMACTANE FORTE , 120 mL Amber bottle','RIFAM','Rifampulicin','2H5ML','200 mg/5 mL','SUS14','SUSPENSION','120AM','120 mL Amber bottle','R0075','Rimactane Forte','Interphil',0,0,0),('RIFAM2H5MLSUS14120AM004149','Rifampulicin , 200 mg/5 mL , Suspension , FOZAR , 120 mL Amber bottle','RIFAM','Rifampulicin','2H5ML','200 mg/5 mL','SUS14','SUSPENSION','120AM','120 mL Amber bottle','F2160','Fozar','San Marino',0,0,0),('RIFAM2H5MLSUS1460AMB002918','Rifampulicin , 200 mg/5 mL , Suspension , RIMACTANE FORTE , 60 mL Amber bottle','RIFAM','Rifampulicin','2H5ML','200 mg/5 mL','SUS14','SUSPENSION','60AMB','60 mL Amber bottle','R0075','Rimactane Forte','Interphil',0,0,0),('RIFAM450MGCAPSU00124011377','Rifampicin , 450 mg , Capsule , HIZON','RIFAM','Rifampicin','450MG','450 mg','CAPSU','CAPSULE','00124','10 Blister pack x 10\'s (Box of 100\'s)','','','Hizon',0,0,0),('RIFAM450MGCAPSU01554011379','Rifampulicin , 450 mg , Capsule , LLOYD LABORATORIES, INC.','RIFAM','Rifampulicin','450MG','450 mg','CAPSU','CAPSULE','01554','Blister foil 120\'s','','','Lloyd Laboratories, Inc.',0,0,0),('RIFAM450MGCAPSU02088011378','Rifampicin , 450 mg , Capsule , PASCUAL','RIFAM','Rifampicin','450MG','450 mg','CAPSU','CAPSULE','02088','Foil strip x 6\'s (Box of 30\'s)','','','Pascual',0,0,0),('RIFAM450MGCAPSUBP351004007','Rifampicin , 450 mg , Capsule , EUCET','RIFAM','Rifampicin','450MG','450 mg','CAPSU','CAPSULE','BP351','Blister pack x 10\'s (box of 100\'s )','E2097','Eucet','Lumar Pharmaceutical Laboratory',0,0,0),('RIFAM450MGCAPSUBP351005002','Rifampicin , 450 mg , Capsule , COMPACT','RIFAM','Rifampicin','450MG','450 mg','CAPSU','CAPSULE','BP351','Blister pack x 10\'s (box of 100\'s )','','','Compact',0,0,0),('RIFAM600MGTAB4901746007414','Rifampicin , 600 mg , Tablet , RIMACTANE','RIFAM','Rifampicin','600MG','600 mg','TAB49','TABLET','01746','Blister x 10\'s (Box of 100\'s)','R0074','Rimactane','Interphil',0,0,0),('RISPE1MGPGTAB4901230011385','Risperidone , 1 mg/g , Tablet , DIAFAT','RISPE','Risperidone','1MGPG','1 mg/g','TAB49','TABLET','01230','Alu/Alu Blister pack x 4\'s (Box of 28\'s)','D0036','Diafat','Ferrer Int\'l SA',0,0,0),('RISPE1MGXXTAB2401208011380','Risperidone , 1 mg , Tablet Film Coated , LLOYD LABS INC','RISPE','Risperidone','1MGXX','1 mg','TAB24','TABLET FILM COATED','01208','Alu/Alu Blister pack x 10\'s (Box of 30\'s)','','','Lloyd Labs Inc',0,0,0),('RISPE2MGXXTAB2402304011381','Risperidone , 2 mg , Tablet Film Coated , LLOYD LABS INC','RISPE','Risperidone','2MGXX','2 mg','TAB24','TABLET FILM COATED','02304','PVC/PVDC/Alu Blister pack x 10\'s (Box of 100\'s)','','','Lloyd Labs Inc',0,0,0),('RISPE2MGXXTAB4901652011382','Risperidone , 2 mg , Tablet , ASMAX','RISPE','Risperidone','2MGXX','2 mg','TAB49','TABLET','01652','Blister Pack x 10\'s (Box of 20\'s)','A0182','Asmax','Torrent',0,0,0),('RISPE2MGXXTAB4901657011383','Risperidone , 2 mg , Tablet , ASMAX','RISPE','Risperidone','2MGXX','2 mg','TAB49','TABLET','01657','Blister pack x 10\'s (Box of 50\'s)','A0182','Asmax','Torrent',0,0,0),('RISPE3MGXXTAB4901383011386','Risperidone , 3 mg , Tablet , DIAFAT','RISPE','Risperidone','3MGXX','3 mg','TAB49','TABLET','01383','Alu/PVC White Opaque Blister pack x 10\'s (Box of 100\'s)','D0036','Diafat','Ferrer Int\'l SA',0,0,0),('ROCUR10MGXSOL1400572005915','Rocuronium , 10 mg , Solution For Injection , ESMERON , 2.5 mL Colorless glass vial (Box of 10\'s)','ROCUR','Rocuronium','10MGX','10 mg','SOL14','SOLUTION FOR INJECTION','00572','2.5 mL Colorless glass vial (Box of 10\'s)','','Esmeron','N.V Organon',0,0,0),('ROCUR50MG5SOL1400572005916','Rocuronium , 50 mg/5 mL , Solution For Injection , ESILGAN , 2.5 mL Colorless glass vial (Box of 10\'s)','ROCUR','Rocuronium','50MG5','50 mg/5 mL','SOL14','SOLUTION FOR INJECTION','00572','2.5 mL Colorless glass vial (Box of 10\'s)','E2088','Esilgan','N.V. Organon Oss',0,0,0),('S-AML5MGXXTAB4901609011911','S-Amlodipine (As Besilate) , 5 mg , Tablet , AMLOBES','S-AML','S-Amlodipine (as Besilate)','5MGXX','5 mg','TAB49','TABLET','01609','Blister Pack of 10\'s (Box of 100\'s)','A0244','Amlobes','Emil Pharm\'ls Industries Pvt. Ltd.',0,0,0),('SALB1150MGSYRUPPLASB005261','Salbutamol + Guaifenesin , 1 mg/50 mg , Syrup , ASERIL , Plastic bottle','SALB1','Salbutamol + Guaifenesin','150MG','1 mg/50 mg','SYRUP','SYRUP','PLASB','Plastic bottle','A0229','Aseril','Drugmaker\'s Labs Inc',0,0,0),('SALB11HML2CAPSUB10SH002147','Salbutamol + Guaifenesin , 100mg/2mg , Capsule , SAN MARINO LABS','SALB1','Salbutamol + Guaifenesin','1HML2','100mg/2mg','CAPSU','CAPSULE','B10SH','Blister pack of 10s (Box of 100s)','','','San Marino Labs',0,0,0),('SALB11MG50SYRUP00348011458','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , BRYTOLIN , 120 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','00348','120 mL Amber bottle','B0102','Brytolin','La Croesus Pharma, Inc.',0,0,0),('SALB11MG50SYRUP00361005675','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , INTAC , 120 mL Boston Round Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','00361','120 mL Boston Round Amber bottle','I0025','Intac','Sydenham Labs Inc',0,0,0),('SALB11MG50SYRUP00394011449','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , MORISHITA SEGGS , 15 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','00394','15 mL Amber bottle','','','Morishita Seggs',0,0,0),('SALB11MG50SYRUP00394011459','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , BRYTOLIN , 15 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','00394','15 mL Amber bottle','B0102','Brytolin','La Croesus Pharma, Inc.',0,0,0),('SALB11MG50SYRUP00576005917','Salbutamol + Guaifenesin , 1mg/50 mg per 5 mL , Syrup , LBX , 2.5 mL LDPE ampul','SALB1','Salbutamol + Guaifenesin','1MG50','1mg/50 mg per 5 mL','SYRUP','SYRUP','00576','2.5 mL LDPE ampul','L0018','Lbx','Baton Rouge Lab',0,0,0),('SALB11MG50SYRUP00982011455','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , BROMITAPP , 60 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','B2082','Bromitapp','Lumar Pharma\'l Labs',0,0,0),('SALB11MG50SYRUP00982011457','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , BRONCHOMED , 60 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','B2087','Bronchomed','Hizon',0,0,0),('SALB11MG50SYRUP00982011460','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , BRYTOLIN , 60 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','B0102','Brytolin','La Croesus Pharma, Inc.',0,0,0),('SALB11MG50SYRUP01003011450','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , LA CROESUS PHARMA INC. , 60 mL Amber Colored Glass Bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','01003','60 mL Amber Colored Glass Bottle','','','La Croesus Pharma Inc.',0,0,0),('SALB11MG50SYRUP01008011456','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , BRONCHOFEN , 60 mL Amber Glass Bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','01008','60 mL Amber Glass Bottle','B2086','Bronchofen','San Marino',0,0,0),('SALB11MG50SYRUP01014011453','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , ASTAGEN , 60 mL Amber Glass Bottle w/ Aluminum Metal Cap','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','01014','60 mL Amber Glass Bottle w/ Aluminum Metal Cap','A0187','Astagen','Hizon',0,0,0),('SALB11MG50SYRUP01033006418','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , INTAC , 60 mL Boston Round Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','01033','60 mL Boston Round Amber bottle','I0025','Intac','Sydenham Labs Inc',0,0,0),('SALB11MG50SYRUP120AM004207','Salbutamol + Guaifenesin , 1mg/50 mg per 5 mL , Syrup , G-KOFF , 120 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1mg/50 mg per 5 mL','SYRUP','SYRUP','120AM','120 mL Amber bottle','G2046','G-Koff','Drugmakers Biotech',0,0,0),('SALB11MG50SYRUP120AM005033','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , MORISHITA SEGGS , 120 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','120AM','120 mL Amber bottle','','','Morishita Seggs',0,0,0),('SALB11MG50SYRUP60AMB002812','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , PRIMESAL , 60 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','P0103','Primesal','Sydenham Labs., Inc',0,0,0),('SALB11MG50SYRUP60AMB004208','Salbutamol + Guaifenesin , 1mg/50 mg per 5 mL , Syrup , G-KOFF , 60 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1mg/50 mg per 5 mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','G2046','G-Koff','Drugmakers Biotech',0,0,0),('SALB11MG50SYRUP60AMB005031','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , LA CROESUS PHARMA INC. , 60 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','La Croesus Pharma Inc.',0,0,0),('SALB11MG50SYRUP60AMB005032','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , LUMAR PHARMA\'L LABS , 60 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','Lumar Pharma\'l Labs',0,0,0),('SALB11MG50SYRUP60AMB005034','Salbutamol + Guaifenesin , 1 mg/50mg/5mL , Syrup , MORISHITA SEGGS , 60 mL Amber bottle','SALB1','Salbutamol + Guaifenesin','1MG50','1 mg/50mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','Morishita Seggs',0,0,0),('SALB2100MCMDIXX02714011684','Salbutamol (As Sulfate) , 100 mcg/Actuation , Metered Dose Inhaler , ASMACAIRE , Aluminum can 200 doses','SALB2','Salbutamol (as Sulfate)','100MC','100 mcg/Actuation','MDIXX','METERED DOSE INHALER','02714','Aluminum can 200 doses','A0175','Asmacaire','Laboratorio Aldo Union S.A.',0,0,0),('SALB2100MCMDIXX02715011685','Salbutamol (As Sulfate) , 100 mcg/Actuation , Metered Dose Inhaler , ASMACAIRE , Aluminum can 250 doses','SALB2','Salbutamol (as Sulfate)','100MC','100 mcg/Actuation','MDIXX','METERED DOSE INHALER','02715','Aluminum can 250 doses','A0175','Asmacaire','Laboratorio Aldo Union S.A.',0,0,0),('SALB22MG5MSYRUPAG60C002323','Salbutamol (As Sulfate) , 2 mg/5mL , Syrup , NULL , box of 1 60ml amber glass, boston round w/ 20mm pilfer-proof aluminum cap w/ foam liner','SALB2','SALBUTAMOL (as Sulfate)','2MG5M','2 mg/5mL','SYRUP','SYRUP','AG60C','box of 1 60ml amber glass, boston round w/ 20mm pilfer-proof aluminum cap w/ foam liner','','','Accord Bio Labs',0,0,0),('SALBU1HMCGMDIXX00582011419','Salbutamol , 100 mcg , Metered Dose Inhaler , ASMACAIRE , 2.5 mL Transluscent Nebules (Box of 100\'s)','SALBU','Salbutamol','1HMCG','100 mcg','MDIXX','METERED DOSE INHALER','00582','2.5 mL Transluscent Nebules (Box of 100\'s)','A0175','Asmacaire','Laboratorio Aldo Union S.A.',0,0,0),('SALBU1HMCGSOLU901042011414','Salbutamol , 100 mcg , Solution For Inhalation , AIROMIR , 60 mL Glass bottle','SALBU','Salbutamol','1HMCG','100 mcg','SOLU9','SOLUTION FOR INHALATION','01042','60 mL Glass bottle','A0046','Airomir','3M Health Care Ltd.',0,0,0),('SALBU1MGMLSOL3200578005918','Salbutamol , 1 mg/mL , Solution , VENTOLIN NEBULES , 2.5 mL LDPE Nebules (Box of 20\'s)','SALBU','Salbutamol','1MGML','1 mg/mL','SOL32','SOLUTION','00578','2.5 mL LDPE Nebules (Box of 20\'s)','V0034','Ventolin Nebules','GSK Pty Ltd',0,0,0),('SALBU1MGMLSOL3401033011428','Salbutamol , 1 mg/mL , Solution For Nebulization , ASMAX , 60 mL Boston Round Amber bottle','SALBU','Salbutamol','1MGML','1 mg/mL','SOL34','SOLUTION FOR NEBULIZATION','01033','60 mL Boston Round Amber bottle','A0182','Asmax','Hizon',0,0,0),('SALBU1MGMLSOL3402185007988','Salbutamol , 1 mg/mL , Solution For Nebulization , HIVENT , Plastic Ampul x 20\'s','SALBU','Salbutamol','1MGML','1 mg/mL','SOL34','SOLUTION FOR NEBULIZATION','02185','Plastic Ampul x 20\'s','H0030','Hivent','Euro-Med',0,0,0),('SALBU1MGMLSOL3415MLB001955','Salbutamol , 1 mg/mL , Solution For Nebulization , VENTAR , 15 mL bottle','SALBU','Salbutamol','1MGML','1 mg/mL','SOL34','Solution For Nebulization','15MLB','15 mL bottle','V0029','Ventar','',0,0,0),('SALBU1MGMLSOL3425MLB001954','Salbutamol , 1 mg/mL , Solution For Nebulization , SEDALIN , 2.5 mL bottle','SALBU','Salbutamol','1MGML','1 mg/mL','SOL34','Solution For Nebulization','25MLB','2.5 mL bottle','S0017','Sedalin','',0,0,0),('SALBU1MGMLSOL3435MLB001956','Salbutamol , 1 mg/mL , Solution For Nebulization , VENTAR , 35 mL bottle','SALBU','Salbutamol','1MGML','1 mg/mL','SOL34','Solution For Nebulization','35MLB','35 mL bottle','V0029','Ventar','',0,0,0),('SALBU1MGMLSOL3460AMB002901','Salbutamol , 1 mg/mL , Solution For Nebulization , RESDIL , 60 mL Amber bottle','SALBU','Salbutamol','1MGML','1 mg/mL','SOL34','SOLUTION FOR NEBULIZATION','60AMB','60 mL Amber bottle','R0046','Resdil','Hizon',0,0,0),('SALBU1MGMLSOL3460MLB001951','Salbutamol , 1 mg/mL , Solution For Nebulization , ASMAX , 60 mL bottle','SALBU','Salbutamol','1MGML','1 mg/mL','SOL34','Solution For Nebulization','60MLB','60 mL bottle','A0182','Asmax','',0,0,0),('SALBU1MGMLSOL34AMPUL001952','Salbutamol , 1 mg/mL , Solution For Nebulization , BIONEB , Ampul','SALBU','Salbutamol','1MGML','1 mg/mL','SOL34','Solution For Nebulization','AMPUL','Ampul','B0067','Bioneb','',0,0,0),('SALBU1MGMLSOLU900571005913','Salbutamol , 1 mg/mL , Solution For Inhalation , MONILIASOL , 2.5 mL Clear plastic nebule of 5\'s (Box of 30\'s)','SALBU','Salbutamol','1MGML','1 mg/mL','SOLU9','SOLUTION FOR INHALATION','00571','2.5 mL Clear plastic nebule of 5\'s (Box of 30\'s)','M0133','Moniliasol','Ahlcon Parenterals Ltd',0,0,0),('SALBU1MGMLSOLU900571005914','Salbutamol , 1 mg/mL , Solution For Inhalation , PROVEXEL NS , 2.5 mL Clear plastic nebule of 5\'s (Box of 30\'s)','SALBU','Salbutamol','1MGML','1 mg/mL','SOLU9','SOLUTION FOR INHALATION','00571','2.5 mL Clear plastic nebule of 5\'s (Box of 30\'s)','P0125','Provexel Ns','Ahlcon Parenterals Ltd',0,0,0),('SALBU1MGMLSOLU900571011433','Salbutamol , 1 mg/mL , Solution For Inhalation , AUMOX , 2.5 mL Clear plastic nebule of 5\'s (Box of 30\'s)','SALBU','Salbutamol','1MGML','1 mg/mL','SOLU9','SOLUTION FOR INHALATION','00571','2.5 mL Clear plastic nebule of 5\'s (Box of 30\'s)','A2208','Aumox','Ahlcon Parenterals (India) Ltd.',0,0,0),('SALBU1MGMLSOLU900982011421','Salbutamol , 1 mg/mL , Solution For Inhalation , ASMALIN , 60 mL Amber bottle','SALBU','Salbutamol','1MGML','1 mg/mL','SOLU9','SOLUTION FOR INHALATION','60AMB','60 mL Amber bottle','A0178','Asmalin','Medispray Laboratories Pvt. Ltd. India',0,0,0),('SALBU1MGMLSOLU925MLA001950','Salbutamol , 1 mg/mL , Solution For Inhalation , ASMALIN , 2.5 mL Ampul','SALBU','Salbutamol','1MGML','1 mg/mL','SOLU9','Solution For Inhalation','25MLA','2.5 mL Ampul','A0178','Asmalin','',0,0,0),('SALBU1MGMLSOLU960AMB005263','Salbutamol , 1 mg/mL , Solution For Inhalation , ASMAACT , 60 mL Amber bottle','SALBU','Salbutamol','1MGML','1 mg/mL','SOLU9','SOLUTION FOR INHALATION','60AMB','60 mL Amber bottle','A2188','Asmaact','E.L. Labs Inc',0,0,0),('SALBU200MCCAPSUB10SH002059','Salbutamol , 200 mcg , Capsule , ASMALIN PULMOCAP','SALBU','Salbutamol','200MC','200 mcg','CAPSU','Capsule','B10SH','Blister pack of 10s (Box of 100s)','A0179','Asmalin Pulmocap','',0,0,0),('SALBU2MG5MSYRUP00348005651','Salbutamol , 2 mg/5mL , Syrup , VIMONZIL , 120 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','120AM','120 mL Amber bottle','V0056','Vimonzil','YSP',0,0,0),('SALBU2MG5MSYRUP00356005666','Salbutamol , 2 mg/5mL , Syrup , THEORYL , 120 mL Amber glass bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00356','120 mL Amber glass bottle','T0048','Theoryl','J.M. Tolmann',0,0,0),('SALBU2MG5MSYRUP00356011388','Salbutamol , 2 mg/5mL , Syrup , DIAMOND , 120 mL Amber glass bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00356','120 mL Amber glass bottle','','','Diamond',0,0,0),('SALBU2MG5MSYRUP00361005676','Salbutamol , 2 mg/5mL , Syrup , PROX-S , 120 mL Boston Round Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00361','120 mL Boston Round Amber bottle','P0134','Prox-S','Lloyd Laboratories Inc.',0,0,0),('SALBU2MG5MSYRUP00394011431','Salbutamol , 2 mg/5mL , Syrup , ASTIN , 15 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00394','15 mL Amber bottle','A2202','Astin','Lloyd Labs., Inc.',0,0,0),('SALBU2MG5MSYRUP00401011446','Salbutamol , 2 mg/5mL , Syrup , BUCANIL , 15 mL Amber bottle with Dropper','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00401','15 mL Amber bottle with Dropper','B0108','Bucanil','Sydenham',0,0,0),('SALBU2MG5MSYRUP00574011390','Salbutamol , 2 mg/5mL , Syrup , LLOYD LABS., INC. , 2.5 mL LDP Plastic (Box of 30\'s)','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00574','2.5 mL LDP Plastic (Box of 30\'s)','','','Lloyd Labs., Inc.',0,0,0),('SALBU2MG5MSYRUP00580005920','Salbutamol , 2 mg/5mL , Syrup , SALBUMED , 2.5 mL Plastic ampul (Pack of 5\'s)','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00580','2.5 mL Plastic ampul (Pack of 5\'s)','S0002','Salbumed','Medgen',0,0,0),('SALBU2MG5MSYRUP00580011416','Salbutamol , 2 mg/5mL , Syrup , AMOLTEX , 2.5 mL Plastic ampul (Pack of 5\'s)','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00580','2.5 mL Plastic ampul (Pack of 5\'s)','A0113','Amoltex','Lloyd Labs Inc',0,0,0),('SALBU2MG5MSYRUP00728011432','Salbutamol , 2 mg/5mL , Syrup , ASTIN , 30 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00728','30 mL Amber bottle','A2202','Astin','Lloyd Labs., Inc.',0,0,0),('SALBU2MG5MSYRUP00735011392','Salbutamol , 2 mg/5mL , Syrup , DIAMOND , 30 mL Amber glass Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00735','30 mL Amber glass Bottle','','','Diamond',0,0,0),('SALBU2MG5MSYRUP00739011447','Salbutamol , 2 mg/5mL , Syrup , BUSTON , 30 mL Boston Round Amber Glass Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00739','30 mL Boston Round Amber Glass Bottle','B0114','Buston','Lloyd Laboratories Inc.',0,0,0),('SALBU2MG5MSYRUP00982006278','Salbutamol , 2 mg/5mL , Syrup , THEORYL , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','T0048','Theoryl','Interchemex',0,0,0),('SALBU2MG5MSYRUP00982006279','Salbutamol , 2 mg/5mL , Syrup , VENTOSAL , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','V0036','Ventosal','Hizon',0,0,0),('SALBU2MG5MSYRUP00982011393','Salbutamol , 2 mg/5mL , Syrup , JM TOLMANN , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','','','JM Tolmann',0,0,0),('SALBU2MG5MSYRUP00982011394','Salbutamol , 2 mg/5mL , Syrup , DANLEX , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','','','Danlex',0,0,0),('SALBU2MG5MSYRUP00982011398','Salbutamol , 2 mg/5mL , Syrup , AD-DRUGSTEL PHARMA\'L LABS., INC , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','','','Ad-Drugstel Pharma\'l Labs., Inc',0,0,0),('SALBU2MG5MSYRUP00982011399','Salbutamol , 2 mg/5mL , Syrup , ACCORD BIO LABS. , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','','','Accord Bio Labs.',0,0,0),('SALBU2MG5MSYRUP00982011412','Salbutamol , 2 mg/5mL , Syrup , ACTIVENT , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','A0023','Activent','Hizon Laboratories, Inc.',0,0,0),('SALBU2MG5MSYRUP00982011439','Salbutamol , 2 mg/5mL , Syrup , BRONCHO-VAXOM , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','B2090','Broncho-Vaxom','Lumar Pharma\'l Labs',0,0,0),('SALBU2MG5MSYRUP00982011448','Salbutamol , 2 mg/5mL , Syrup , CLAVOMAX , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','00982','60 mL Amber bottle','C2071','Clavomax','J.M. Tolmann',0,0,0),('SALBU2MG5MSYRUP01008006380','Salbutamol , 2 mg/5mL , Syrup , RABACAF , 60 mL Amber Glass Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','01008','60 mL Amber Glass Bottle','R0002','Rabacaf','Lloyd Laboratories',0,0,0),('SALBU2MG5MSYRUP01008006381','Salbutamol , 2 mg/5mL , Syrup , THEORYL , 60 mL Amber Glass Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','01008','60 mL Amber Glass Bottle','T0048','Theoryl','J.M. Tolmann',0,0,0),('SALBU2MG5MSYRUP01008011400','Salbutamol , 2 mg/5mL , Syrup , INTERCHEMEX , 60 mL Amber Glass Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','01008','60 mL Amber Glass Bottle','','','Interchemex',0,0,0),('SALBU2MG5MSYRUP01008011402','Salbutamol , 2 mg/5mL , Syrup , VIRGO PHARM\'L. LAB. , 60 mL Amber Glass Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','01008','60 mL Amber Glass Bottle','','','Virgo Pharm\'l. Lab.',0,0,0),('SALBU2MG5MSYRUP01008011403','Salbutamol , 2 mg/5mL , Syrup , DIAMOND , 60 mL Amber Glass Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','01008','60 mL Amber Glass Bottle','','','Diamond',0,0,0),('SALBU2MG5MSYRUP01008011413','Salbutamol , 2 mg/5mL , Syrup , ACTIVENT , 60 mL Amber Glass Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','01008','60 mL Amber Glass Bottle','A0023','Activent','Hizon',0,0,0),('SALBU2MG5MSYRUP01008011434','Salbutamol , 2 mg/5mL , Syrup , BEFIDAN , 60 mL Amber Glass Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','01008','60 mL Amber Glass Bottle','B0027','Befidan','Pharmatechnica Laboratory Inc',0,0,0),('SALBU2MG5MSYRUP01051011405','Salbutamol , 2 mg/5mL , Syrup , MORISHITA SEGGS , 60 mL HDPE Plastic Bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','01051','60 mL HDPE Plastic Bottle','','','Morishita Seggs',0,0,0),('SALBU2MG5MSYRUP120MB002009','Salbutamol , 2 mg/5mL , Syrup , ASMALIN , 120 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','120MB','120 mL bottle','A0178','Asmalin','',0,0,0),('SALBU2MG5MSYRUP120MB002022','Salbutamol , 2 mg/5mL , Syrup , HIVENT , 120 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','120MB','120 mL bottle','H0030','Hivent','',0,0,0),('SALBU2MG5MSYRUP120MB002030','Salbutamol , 2 mg/5mL , Syrup , MEVENTIL , 120 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','120MB','120 mL bottle','M0109','Meventil','',0,0,0),('SALBU2MG5MSYRUP120MB002036','Salbutamol , 2 mg/5mL , Syrup , PROX-S , 120 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','120MB','120 mL bottle','P0134','Prox-S','',0,0,0),('SALBU2MG5MSYRUP120MB002050','Salbutamol , 2 mg/5mL , Syrup , VENALAX , 120 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','120MB','120 mL bottle','V0025','Venalax','',0,0,0),('SALBU2MG5MSYRUP25MLA002890','Salbutamol , 2 mg/5mL , Syrup , RENJUSAL , 2.5 mL ampule','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','25MLA','2.5 mL ampule','R0109','Renjusal','Novagen Pharma\'l CO., Inc',0,0,0),('SALBU2MG5MSYRUP35MLB002023','Salbutamol , 2 mg/5mL , Syrup , HIVENT , 35 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','35MLB','35 mL bottle','H0030','Hivent','',0,0,0),('SALBU2MG5MSYRUP60AMB002939','Salbutamol , 2 mg/5mL , Syrup , SAL , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','S0001','Sal','La Croesus Pharma Inc',0,0,0),('SALBU2MG5MSYRUP60AMB002941','Salbutamol , 2 mg/5mL , Syrup , SALBUTAREN , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','S0003','Salbutaren','J.M. Tolmann',0,0,0),('SALBU2MG5MSYRUP60AMB003187','Salbutamol , 2 mg/5mL , Syrup , VENTAMOL , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','V0028','Ventamol','Lloyd Labs Inc',0,0,0),('SALBU2MG5MSYRUP60AMB003193','Salbutamol , 2 mg/5mL , Syrup , VENTROL , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','V0072','Ventrol','Diamond Labs Inc',0,0,0),('SALBU2MG5MSYRUP60AMB003681','Salbutamol , 2 mg/5mL , Syrup , CLESSOL , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','C2072','Clessol','JM Tolmann',0,0,0),('SALBU2MG5MSYRUP60AMB005013','Salbutamol , 2 mg/5mL , Syrup , ACE , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','Ace',0,0,0),('SALBU2MG5MSYRUP60AMB005015','Salbutamol , 2 mg/5mL , Syrup , AM-EUROPHARMA , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','Am-Europharma',0,0,0),('SALBU2MG5MSYRUP60AMB005016','Salbutamol , 2 mg/5mL , Syrup , DIAMOND , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','Diamond',0,0,0),('SALBU2MG5MSYRUP60AMB005020','Salbutamol , 2 mg/5mL , Syrup , NEW MYREX LAB , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','New Myrex Lab',0,0,0),('SALBU2MG5MSYRUP60AMB005025','Salbutamol , 2 mg/5mL , Syrup , UNITED LAB , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','United Lab',0,0,0),('SALBU2MG5MSYRUP60AMB005265','Salbutamol , 2 mg/5mL , Syrup , ASMACAIRE , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','A0175','Asmacaire','AD Drugstel',0,0,0),('SALBU2MG5MSYRUP60AMB005266','Salbutamol , 2 mg/5mL , Syrup , ASMACON FORTE , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','A2190','Asmacon Forte','United Lab',0,0,0),('SALBU2MG5MSYRUP60AMB005267','Salbutamol , 2 mg/5mL , Syrup , ASMALIN BRONCHO TABLET , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','A2192','Asmalin Broncho Tablet','J.M. Tolmann Labs., Inc',0,0,0),('SALBU2MG5MSYRUP60AMB005277','Salbutamol , 2 mg/5mL , Syrup , ASVENT PLUS , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','A2204','Asvent Plus','Virgo',0,0,0),('SALBU2MG5MSYRUP60MLB001995','Salbutamol , 2 mg/5mL , Syrup , AIRSAL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','A0047','Airsal','',0,0,0),('SALBU2MG5MSYRUP60MLB001996','Salbutamol , 2 mg/5mL , Syrup , BUMEX , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','B0109','Bumex','',0,0,0),('SALBU2MG5MSYRUP60MLB001997','Salbutamol , 2 mg/5mL , Syrup , CLETAL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','C0157','Cletal','',0,0,0),('SALBU2MG5MSYRUP60MLB001998','Salbutamol , 2 mg/5mL , Syrup , LUMAR PHARMACEUTICALS LAB. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Lumar Pharmaceuticals Lab.',0,0,0),('SALBU2MG5MSYRUP60MLB001999','Salbutamol , 2 mg/5mL , Syrup , SAL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','S0001','Sal','',0,0,0),('SALBU2MG5MSYRUP60MLB002000','Salbutamol , 2 mg/5mL , Syrup , THEORYL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','T0048','Theoryl','',0,0,0),('SALBU2MG5MSYRUP60MLB002001','Salbutamol , 2 mg/5mL , Syrup , VENTOSAL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','V0036','Ventosal','',0,0,0),('SALBU2MG5MSYRUP60MLB002002','Salbutamol , 2 mg/5mL , Syrup , ACTIVENT , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','A0023','Activent','',0,0,0),('SALBU2MG5MSYRUP60MLB002003','Salbutamol , 2 mg/5mL , Syrup , AD-DRUGSTEL PHARMACEUTICAL LAB. INC. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Ad-Drugstel Pharmaceutical Lab. Inc.',0,0,0),('SALBU2MG5MSYRUP60MLB002004','Salbutamol , 2 mg/5mL , Syrup , AM EURO PHARMA CORP. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Am Euro Pharma Corp.',0,0,0),('SALBU2MG5MSYRUP60MLB002005','Salbutamol , 2 mg/5mL , Syrup , AMOLTEX , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','A0113','Amoltex','',0,0,0),('SALBU2MG5MSYRUP60MLB002006','Salbutamol , 2 mg/5mL , Syrup , ARBADOS , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','A0165','Arbados','',0,0,0),('SALBU2MG5MSYRUP60MLB002007','Salbutamol , 2 mg/5mL , Syrup , ASBUNYL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','A0172','Asbunyl','',0,0,0),('SALBU2MG5MSYRUP60MLB002008','Salbutamol , 2 mg/5mL , Syrup , ASFRENON , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','A0174','Asfrenon','',0,0,0),('SALBU2MG5MSYRUP60MLB002010','Salbutamol , 2 mg/5mL , Syrup , ASMALIN , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','A0178','Asmalin','',0,0,0),('SALBU2MG5MSYRUP60MLB002011','Salbutamol , 2 mg/5mL , Syrup , ASMAX , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','V0025','Asmax','',0,0,0),('SALBU2MG5MSYRUP60MLB002012','Salbutamol , 2 mg/5mL , Syrup , ASVENT , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','A0190','Asvent','',0,0,0),('SALBU2MG5MSYRUP60MLB002013','Salbutamol , 2 mg/5mL , Syrup , BEISOL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','B0028','Beisol','',0,0,0),('SALBU2MG5MSYRUP60MLB002014','Salbutamol , 2 mg/5mL , Syrup , BRYTOLIN , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','B0107','Brytolin','',0,0,0),('SALBU2MG5MSYRUP60MLB002015','Salbutamol , 2 mg/5mL , Syrup , BUTALYN , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','B0117','Butalyn','',0,0,0),('SALBU2MG5MSYRUP60MLB002016','Salbutamol , 2 mg/5mL , Syrup , CLETAL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','C0157','Cletal','',0,0,0),('SALBU2MG5MSYRUP60MLB002017','Salbutamol , 2 mg/5mL , Syrup , COFRESSAN , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','C0201','Cofressan','',0,0,0),('SALBU2MG5MSYRUP60MLB002018','Salbutamol , 2 mg/5mL , Syrup , DANLEX RESEARCH LAB. INC. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Danlex Research Lab. Inc.',0,0,0),('SALBU2MG5MSYRUP60MLB002019','Salbutamol , 2 mg/5mL , Syrup , DRUGMAKERS BIOTECH RESEARCH LAB. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Drugmakers Biotech Research Lab.',0,0,0),('SALBU2MG5MSYRUP60MLB002021','Salbutamol , 2 mg/5mL , Syrup , EMPLUSAL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','E0022','Emplusal','',0,0,0),('SALBU2MG5MSYRUP60MLB002024','Salbutamol , 2 mg/5mL , Syrup , HIVENT , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','H0030','Hivent','',0,0,0),('SALBU2MG5MSYRUP60MLB002025','Salbutamol , 2 mg/5mL , Syrup , INTERCHEMEX LAB. INC. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Interchemex Lab. Inc.',0,0,0),('SALBU2MG5MSYRUP60MLB002026','Salbutamol , 2 mg/5mL , Syrup , JM TOLMANN LAB. INC. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','JM Tolmann Lab. Inc.',0,0,0),('SALBU2MG5MSYRUP60MLB002027','Salbutamol , 2 mg/5mL , Syrup , LLOYD LAB. INC. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Lloyd Lab. Inc.',0,0,0),('SALBU2MG5MSYRUP60MLB002028','Salbutamol , 2 mg/5mL , Syrup , MAROBEN , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','M0014','Maroben','',0,0,0),('SALBU2MG5MSYRUP60MLB002029','Salbutamol , 2 mg/5mL , Syrup , MEDGEN LAB. INC. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Medgen Lab. Inc.',0,0,0),('SALBU2MG5MSYRUP60MLB002031','Salbutamol , 2 mg/5mL , Syrup , MEVENTIL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','M0109','Meventil','',0,0,0),('SALBU2MG5MSYRUP60MLB002032','Salbutamol , 2 mg/5mL , Syrup , NEO-MUCOREX , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','N0023','Neo-Mucorex','',0,0,0),('SALBU2MG5MSYRUP60MLB002033','Salbutamol , 2 mg/5mL , Syrup , NEW MYREX LAB. INC. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','New Myrex Lab. Inc.',0,0,0),('SALBU2MG5MSYRUP60MLB002034','Salbutamol , 2 mg/5mL , Syrup , PASCUAL LAB. INC. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Pascual Lab. Inc.',0,0,0),('SALBU2MG5MSYRUP60MLB002035','Salbutamol , 2 mg/5mL , Syrup , PRIMESAL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','P0103','Primesal','',0,0,0),('SALBU2MG5MSYRUP60MLB002037','Salbutamol , 2 mg/5mL , Syrup , PROX-S , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','P0134','Prox-S','',0,0,0),('SALBU2MG5MSYRUP60MLB002038','Salbutamol , 2 mg/5mL , Syrup , RABACAF , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','R0002','Rabacaf','',0,0,0),('SALBU2MG5MSYRUP60MLB002039','Salbutamol , 2 mg/5mL , Syrup , SAL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','S0001','Sal','',0,0,0),('SALBU2MG5MSYRUP60MLB002041','Salbutamol , 2 mg/5mL , Syrup , SALBUTAREN , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','S0003','Salbutaren','',0,0,0),('SALBU2MG5MSYRUP60MLB002042','Salbutamol , 2 mg/5mL , Syrup , SALBUVAN , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','S0005','Salbuvan','',0,0,0),('SALBU2MG5MSYRUP60MLB002044','Salbutamol , 2 mg/5mL , Syrup , SEDALIN , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','S0017','Sedalin','',0,0,0),('SALBU2MG5MSYRUP60MLB002045','Salbutamol , 2 mg/5mL , Syrup , SRILUX , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','S0081','Srilux','',0,0,0),('SALBU2MG5MSYRUP60MLB002046','Salbutamol , 2 mg/5mL , Syrup , THEORYL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','T0048','Theoryl','',0,0,0),('SALBU2MG5MSYRUP60MLB002047','Salbutamol , 2 mg/5mL , Syrup , TURBOLAX , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','T0107','Turbolax','',0,0,0),('SALBU2MG5MSYRUP60MLB002048','Salbutamol , 2 mg/5mL , Syrup , TYROLINE , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','T0113','Tyroline','',0,0,0),('SALBU2MG5MSYRUP60MLB002049','Salbutamol , 2 mg/5mL , Syrup , UNITED LAB. INC. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','United Lab. Inc.',0,0,0),('SALBU2MG5MSYRUP60MLB002051','Salbutamol , 2 mg/5mL , Syrup , VENALAX , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','V0025','Venalax','',0,0,0),('SALBU2MG5MSYRUP60MLB002052','Salbutamol , 2 mg/5mL , Syrup , VENDRE , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','V0026','Vendre','',0,0,0),('SALBU2MG5MSYRUP60MLB002053','Salbutamol , 2 mg/5mL , Syrup , VENTAR , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','V0029','Ventar','',0,0,0),('SALBU2MG5MSYRUP60MLB002054','Salbutamol , 2 mg/5mL , Syrup , VENTOLIN , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','V0032','Ventolin','',0,0,0),('SALBU2MG5MSYRUP60MLB002055','Salbutamol , 2 mg/5mL , Syrup , VIMONZIL , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','V0056','Vimonzil','',0,0,0),('SALBU2MG5MSYRUP60MLB002056','Salbutamol , 2 mg/5mL , Syrup , VIRGO PHARMACEUTICAL LAB. , 60 mL bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','60MLB','60 mL bottle','','','Virgo Pharmaceutical Lab.',0,0,0),('SALBU2MG5MSYRUPAMBOT002020','Salbutamol , 2 mg/5mL , Syrup , EFAMED , Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','AMBOT','Amber bottle','E0007','Efamed','',0,0,0),('SALBU2MG5MSYRUPAMBOT002040','Salbutamol , 2 mg/5mL , Syrup , SALBUMED , Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','AMBOT','Amber bottle','S0002','Salbumed','',0,0,0),('SALBU2MG5MSYRUPAMBOT002043','Salbutamol , 2 mg/5mL , Syrup , SALVEX , Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','Syrup','AMBOT','Amber bottle','S0008','Salvex','',0,0,0),('SALBU2MG5MSYRUPBR560002838','Salbutamol , 2 mg/5mL , Syrup , PROX-S , 60 mL Boston Round Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5mL','SYRUP','SYRUP','BR560','60 mL Boston Round Amber bottle','P0134','Prox-S','Lloyd Laboratories Inc.',0,0,0),('SALBU2MGMLSOL3400410005777','Salbutamol , 2 mg/mL , Solution For Nebulization , RESDIL , 15 mL Amber glass bottle w/ medicine dropper','SALBU','Salbutamol','2MGML','2 mg/mL','SOL34','SOLUTION FOR NEBULIZATION','00410','15 mL Amber glass bottle w/ medicine dropper','R0046','Resdil','Hizon',0,0,0),('SALBU2MGMLSOL3415MLB002058','Salbutamol , 2 mg/mL , Solution For Nebulization , RESDIL , 15 mL bottle','SALBU','Salbutamol','2MGML','2 mg/mL','SOL34','Solution For Nebulization','15MLB','15 mL bottle','R0046','Resdil','',0,0,0),('SALBU2MGMLSOL3460AMB004259','Salbutamol , 2 mg/mL , Solution For Nebulization , HIVENT , 60 mL Amber bottle','SALBU','Salbutamol','2MGML','2 mg/mL','SOL34','SOLUTION FOR NEBULIZATION','60AMB','60 mL Amber bottle','H0030','Hivent','Euro-Med',0,0,0),('SALBU2MGMLSOL34AMPUL002057','Salbutamol , 2 mg/mL , Solution For Nebulization , HIVENT DS , Ampul','SALBU','Salbutamol','2MGML','2 mg/mL','SOL34','Solution For Nebulization','AMPUL','Ampul','H0030','Hivent DS','',0,0,0),('SALBU2MGMLSYRUP01760011441','Salbutamol , 2 mg/mL , Syrup , BRONCO-AID , Box of 1 60 mL amber glass, boston round w/ 20mm pilfer-proof aluminum cap w/ foam liner','SALBU','Salbutamol','2MGML','2 mg/mL','SYRUP','SYRUP','01760','Box of 1 60 mL amber glass, boston round w/ 20mm pilfer-proof aluminum cap w/ foam liner','B2091','Bronco-Aid','Geofmann Pharma\'l',0,0,0),('SALBU2MGMLSYRUP60AMB002316','Salbutamol , 2 mg/mL , Syrup , ASTAGEN , 60ml Amber bottle','SALBU','Salbutamol','2MGML','2 mg/mL','SYRUP','SYRUP','60AMB','60ml Amber bottle','A0187','Astagen','',0,0,0),('SALBU2MGMLSYRUP60AMB005026','Salbutamol , 2 mg/mL , Syrup , J.M. TOLMANN LABS., INC , 60 mL Amber bottle','SALBU','Salbutamol','2MGML','2 mg/mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','J.M. Tolmann Labs., Inc',0,0,0),('SALBU2MGMLSYRUP60AMB005260','Salbutamol , 2 mg/mL , Syrup , ASENZA , 60 mL Amber bottle','SALBU','Salbutamol','2MGML','2 mg/mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','A2185','Asenza','Novagen Pharma\'l CO., Inc',0,0,0),('SALBU2MGXXCAPSUB10SH001957','Salbutamol , 2 mg , Capsule , ERVENTRIL','SALBU','Salbutamol','2MGXX','2 mg','CAPSU','Capsule','B10SH','Blister pack of 10s (Box of 100s)','E0047','Erventril','',0,0,0),('SALBU2MGXXCAPSUPVC10001968','Salbutamol , 2 mg , Capsule , EMPYSOL','SALBU','Salbutamol','2MGXX','2 mg','CAPSU','Capsule','PVC10','PVC blister pack by 10s (Box of 100s)','E0024','Empysol','',0,0,0),('SALBU2MGXXTAB4901409006863','Salbutamol , 2 mg , Tablet , SALBUTHEN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01409','Aluminum Alloy Can with Metering Valve','S0004','Salbuthen','Sharon Biomedicine Ltd',0,0,0),('SALBU2MGXXTAB4901452011427','Salbutamol , 2 mg , Tablet , ASMASOLON','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01452','Aluminum strip foil x 10\'s (Box of 100\'s)','A2194','Asmasolon','Hizon Labs Inc',0,0,0),('SALBU2MGXXTAB4901647007098','Salbutamol , 2 mg , Tablet , RESDIL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01647','Blister pack x 10\'s (Box of 100\'s)','R0046','Resdil','Hizon Labs. Inc.',0,0,0),('SALBU2MGXXTAB4901647011406','Salbutamol , 2 mg , Tablet , SCHEELE','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01647','Blister pack x 10\'s (Box of 100\'s)','','','Scheele',0,0,0),('SALBU2MGXXTAB4901684007337','Salbutamol , 2 mg , Tablet , SOLBEN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01684','Blister pack x 20\'s (Box of 100\'s)','S0065','Solben','New Myrex Labs Inc.',0,0,0),('SALBU2MGXXTAB4901684007338','Salbutamol , 2 mg , Tablet , VENTAR','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01684','Blister pack x 20\'s (Box of 100\'s)','V0029','Ventar','Hizon Labs. Inc.',0,0,0),('SALBU2MGXXTAB4901684011409','Salbutamol , 2 mg , Tablet , J.M. TOLMANN LABS., INC','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01684','Blister pack x 20\'s (Box of 100\'s)','','','J.M. Tolmann Labs., Inc',0,0,0),('SALBU2MGXXTAB4901684011422','Salbutamol , 2 mg , Tablet , ASMALIN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01684','Blister pack x 20\'s (Box of 100\'s)','A0178','Asmalin','Amherst',0,0,0),('SALBU2MGXXTAB4901827011443','Salbutamol , 2 mg , Tablet , BRONCOLIN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01827','Box of alu/Alu Blister pack x 10\'s + 1\'s Rotahaler device','B2092','Broncolin','Flamingo Pharma\'l Ltd',0,0,0),('SALBU2MGXXTAB4901835011410','Salbutamol , 2 mg , Tablet , AMHERST','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01835','Canister x 200 actuations','','','Amherst',0,0,0),('SALBU2MGXXTAB4901973007668','Salbutamol , 2 mg , Tablet , HIVENT','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01973','Double foil Blister pack x 10\'s (Box of 100\'s)','H0030','Hivent','Euro-Med Labs Inc.',0,0,0),('SALBU2MGXXTAB4901980011423','Salbutamol , 2 mg , Tablet , ASMALIN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','01980','Flex Foil Strip 25 x 4\'s (Box of 100\'s)','','Asmalin','Amherst Labs Inc',0,0,0),('SALBU2MGXXTAB4902020007706','Salbutamol , 2 mg , Tablet , NOBUTOL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','02020','Foil strip 14\'s','N0044','Nobutol','Novagen',0,0,0),('SALBU2MGXXTAB4902224011426','Salbutamol , 2 mg , Tablet , ASMANYL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','02224','Pressurized aluminum canister of 200 doses','A0235','Asmanyl','Philmed',0,0,0),('SALBU2MGXXTAB49AM100003443','Salbutamol , 2 mg , Tablet , BIOSULIDD N','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','AM100','Amber bottle of 100s','B2059','Biosulidd N','Saphire Lifesciences Pvt. Ltd.',0,0,0),('SALBU2MGXXTAB49B10SH001958','Salbutamol , 2 mg , Tablet , SAL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','B10SH','Blister pack of 10s (Box of 100s)','S0001','Sal','',0,0,0),('SALBU2MGXXTAB49B10SH001960','Salbutamol , 2 mg , Tablet , DIAMOND LAB. INC.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','B10SH','Blister pack of 10s (Box of 100s)','','','Diamond Lab. Inc.',0,0,0),('SALBU2MGXXTAB49B10SH001976','Salbutamol , 2 mg , Tablet , ASMAREX','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','B10SH','Blister pack of 10s (Box of 100s)','A0181','Asmarex','',0,0,0),('SALBU2MGXXTAB49B10SH001979','Salbutamol , 2 mg , Tablet , BIOXAL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','B10SH','Blister pack of 10s (Box of 100s)','B0075','Bioxal','',0,0,0),('SALBU2MGXXTAB49B10SH001981','Salbutamol , 2 mg , Tablet , DIAMOND LAB. INC.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','B10SH','Blister pack of 10s (Box of 100s)','','','Diamond Lab. Inc.',0,0,0),('SALBU2MGXXTAB49B10SH001983','Salbutamol , 2 mg , Tablet , HIZON LAB. INC.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','B10SH','Blister pack of 10s (Box of 100s)','','','Hizon Lab. Inc.',0,0,0),('SALBU2MGXXTAB49B10SH001994','Salbutamol , 2 mg , Tablet , VENTAR','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','B10SH','Blister pack of 10s (Box of 100s)','V0029','Ventar','',0,0,0),('SALBU2MGXXTAB49B10SH002942','Salbutamol , 2 mg , Tablet , SALBUVAN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','B10SH','Blister pack of 10s (Box of 100s)','S0005','Salbuvan','Philmed',0,0,0),('SALBU2MGXXTAB49B10SH005005','Salbutamol , 2 mg , Tablet , AM-EUROPHARMA CORP','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','B10SH','Blister pack of 10s (Box of 100s)','','','Am-Europharma Corp',0,0,0),('SALBU2MGXXTAB49BF100001966','Salbutamol , 2 mg , Tablet , VENTOLIN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BF100','Blister foil by 100s','V0032','Ventolin','',0,0,0),('SALBU2MGXXTAB49BOXHX001967','Salbutamol , 2 mg , Tablet , VIRGO PHARMACEUTICAL LAB.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BOXHX','Box of 100s','','','Virgo Pharmaceutical Lab.',0,0,0),('SALBU2MGXXTAB49BP100001962','Salbutamol , 2 mg , Tablet , EMPLUSAL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP100','Blister pack x 100','E0022','Emplusal','',0,0,0),('SALBU2MGXXTAB49BP100001965','Salbutamol , 2 mg , Tablet , SOLBEN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP100','Blister pack x 100','S0065','Solben','',0,0,0),('SALBU2MGXXTAB49BP100001969','Salbutamol , 2 mg , Tablet , ACTIVENT','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP100','Blister pack x 100','A0023','Activent','',0,0,0),('SALBU2MGXXTAB49BP100001970','Salbutamol , 2 mg , Tablet , AD-DRUGSTEL PHARMACEUTICAL LAB. INC.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP100','Blister pack x 100','','','Ad-Drugstel Pharmaceutical Lab. Inc.',0,0,0),('SALBU2MGXXTAB49BP100001992','Salbutamol , 2 mg , Tablet , SALBUVAN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP100','Blister pack x 100','S0005','Salbuvan','',0,0,0),('SALBU2MGXXTAB49BP100005010','Salbutamol , 2 mg , Tablet , PASCUAL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','BP100','Blister pack x 100','','','Pascual',0,0,0),('SALBU2MGXXTAB49BP20H001963','Salbutamol , 2 mg , Tablet , JM TOLMANN LAB. INC.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP20H','Blister pack of 20s (Box of 100s)','','','JM Tolmann Lab. Inc.',0,0,0),('SALBU2MGXXTAB49BP20H001972','Salbutamol , 2 mg , Tablet , ASBUNYL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP20H','Blister pack of 20s (Box of 100s)','A0172','Asbunyl','',0,0,0),('SALBU2MGXXTAB49BP20H001974','Salbutamol , 2 mg , Tablet , ASFRENON','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP20H','Blister pack X 20\'s (Box of 100\'s)','A0174','Asfrenon','',0,0,0),('SALBU2MGXXTAB49BP20H001982','Salbutamol , 2 mg , Tablet , DRUGMAKERS BIOTECH RESEARCH LAB.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP20H','Blister pack of 20s (Box of 100s)','','','Drugmakers Biotech Research Lab.',0,0,0),('SALBU2MGXXTAB49BP20H001987','Salbutamol , 2 mg , Tablet , PULMOLEX','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP20H','Blister pack of 20s (Box of 100s)','P0139','Pulmolex','',0,0,0),('SALBU2MGXXTAB49BP20H001991','Salbutamol , 2 mg , Tablet , SALBUMED','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BP20H','Blister pack of 20s (Box of 100s)','S0002','Salbumed','',0,0,0),('SALBU2MGXXTAB49BP20H005008','Salbutamol , 2 mg , Tablet , LEJAL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','BP20H','Blister pack of 20s (Box of 100s)','','','Lejal',0,0,0),('SALBU2MGXXTAB49BP351002859','Salbutamol , 2 mg , Tablet , QUAVENT','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','Q0014','Quavent','Flamingo Pharma\'l Ltd',0,0,0),('SALBU2MGXXTAB49BP351002940','Salbutamol , 2 mg , Tablet , SALBUMED','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','S0002','Salbumed','Medgen',0,0,0),('SALBU2MGXXTAB49BP351003190','Salbutamol , 2 mg , Tablet , VENTOLIN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','V0032','Ventolin','Glaxo Wellcome Gmbh & Co., KG',0,0,0),('SALBU2MGXXTAB49BPXXX001984','Salbutamol , 2 mg , Tablet , MEDGEN LAB. INC.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','BPXXX','Blister pack','','','Medgen Lab. Inc.',0,0,0),('SALBU2MGXXTAB49FFSXX001975','Salbutamol , 2 mg , Tablet , ASMALIN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','FFSXX','Flex Foil Strip','A0178','Asmalin','',0,0,0),('SALBU2MGXXTAB49FS100001986','Salbutamol , 2 mg , Tablet , PASCUAL LAB. INC.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','FS100','Foil strip by 100s','','','Pascual Lab. Inc.',0,0,0),('SALBU2MGXXTAB49FS10X001980','Salbutamol , 2 mg , Tablet , BUMEX','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','FS10X','Foil strip by 10\'s (Box of 100\'s)','B0109','Bumex','',0,0,0),('SALBU2MGXXTAB49FS4CX001971','Salbutamol , 2 mg , Tablet , AMHERST LAB. INC.','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','FS4CX','Foil Strip by 4\'s (Box of 100\'s)','','','Amherst Lab. Inc.',0,0,0),('SALBU2MGXXTAB49FSTRI001993','Salbutamol , 2 mg , Tablet , SEDALIN','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','FSTRI','Foil strip','S0017','Sedalin','',0,0,0),('SALBU2MGXXTAB49PVC10001959','Salbutamol , 2 mg , Tablet , ASMAR','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','PVC10','PVC blister pack by 10s (Box of 100s)','A0180','Asmar','',0,0,0),('SALBU2MGXXTAB49PVC10001985','Salbutamol , 2 mg , Tablet , NOBUTOL','SALBU','Salbutamol','2MGXX','2 mg','TAB49','Tablet','PVC10','PVC blister pack by 10s (Box of 100s)','N0044','Nobutol','',0,0,0),('SALBU4MGXXTAB1201424006872','Salbutamol , 4 mg , Tablet Controlled Release , VENTOLIN VOLMAX','SALBU','Salbutamol','4MGXX','4 mg','TAB12','TABLET CONTROLLED RELEASE','01424','Aluminum Foil Blister pack x 10\'s (Box of 100\'s)','V0035','Ventolin Volmax','Glaxo SmithKline S.p.A.',0,0,0),('SALBU4MGXXTAB12BP14X002066','Salbutamol , 4 mg , Tablet Controlled Release , VENTOLIN VOLMAX','SALBU','Salbutamol','4MGXX','4 mg','TAB12','Tablet Controlled Release','BP14X','Blister pack x 14','V0035','Ventolin Volmax','',0,0,0),('SALBU4MGXXTAB49BP20H002060','Salbutamol , 4 mg , Tablet , AD-DRUGSTEL PHARMACEUTICAL LAB. INC.','SALBU','Salbutamol','4MGXX','4 mg','TAB49','Tablet','BP20H','Blister pack of 20s (Box of 100s)','','','Ad-Drugstel Pharmaceutical Lab. Inc.',0,0,0),('SALBU4MGXXTAB49BP20H005028','Salbutamol , 4 mg , Tablet , DRUGMAKERS','SALBU','Salbutamol','4MGXX','4 mg','TAB49','TABLET','BP20H','Blister pack of 20s (Box of 100s)','','','Drugmakers',0,0,0),('SALBU4MGXXTAB49BPHXH002061','Salbutamol , 4 mg , Tablet , BRONELID FORTE','SALBU','Salbutamol','4MGXX','4 mg','TAB49','Tablet','BPHXH','Blister pack of 100s (Box of 100s)','B0102','Bronelid Forte','',0,0,0),('SALBU4MGXXTAB49BPHXH002062','Salbutamol , 4 mg , Tablet , INTERCHEMEX LAB. INC','SALBU','Salbutamol','4MGXX','4 mg','TAB49','Tablet','BPHXH','Blister pack of 100s (Box of 100s)','','','Interchemex Lab. Inc',0,0,0),('SALBU4MGXXTAB49BPHXH002063','Salbutamol , 4 mg , Tablet , LUMAR PHARMACEUTICALS LAB.','SALBU','Salbutamol','4MGXX','4 mg','TAB49','Tablet','BPHXH','Blister pack of 100s (Box of 100s)','','','Lumar Pharmaceuticals Lab.',0,0,0),('SALBU4MGXXTAB49BPHXH002065','Salbutamol , 4 mg , Tablet , SCHEELE LAB. PHIL. INC.','SALBU','Salbutamol','4MGXX','4 mg','TAB49','Tablet','BPHXH','Blister pack of 100s (Box of 100s)','','','Scheele Lab. Phil. Inc.',0,0,0),('SALBU4MGXXTAB49BPXXX002064','Salbutamol , 4 mg , Tablet , PASCUAL LAB. INC.','SALBU','Salbutamol','4MGXX','4 mg','TAB49','Tablet','BPXXX','Blister pack','','','Pascual Lab. Inc.',0,0,0),('SALBU5MG5MSOL3210MLB002067','Salbutamol , 5 mg/5mL , Solution , VENTOL , 10 mL bottle','SALBU','Salbutamol','5MG5M','5 mg/5mL','SOL32','Solution','10MLB','10 mL bottle','V0031','Ventol','',0,0,0),('SALBU5MG5MSOL3415MLB002068','Salbutamol , 5 mg/5mL , Solution For Nebulization , BIODEAL LAB , 15 mL bottle','SALBU','Salbutamol','5MG5M','5 mg/5mL','SOL34','Solution For Nebulization','15MLB','15 mL bottle','','','Biodeal Lab',0,0,0),('SALBU5MG5MSOL3415MLB002069','Salbutamol , 5 mg/5mL , Solution For Nebulization , RESDIL , 15 mL bottle','SALBU','Salbutamol','5MG5M','5 mg/5mL','SOL34','Solution For Nebulization','15MLB','15 mL bottle','R0046','Resdil','',0,0,0),('SALBU5MGMLSOL3460AMB002903','Salbutamol , 5 mg/mL , Solution For Nebulization , RESDIL , 60 mL Amber bottle','SALBU','Salbutamol','5MGML','5 mg/mL','SOL34','SOLUTION FOR NEBULIZATION','60AMB','60 mL Amber bottle','R0046','Resdil','Hizon',0,0,0),('SALBU8MGXXTAB12FS14X002070','Salbutamol , 8 mg , Tablet Controlled Release , VENTOLIN VOLMAX','SALBU','Salbutamol','8MGXX','8 mg','TAB12','Tablet Controlled Release','FS14X','Foil strip by 14s','V0035','Ventolin Volmax','',0,0,0),('SALBUSYRUP00982011430','Salbutamol , 2 mg/5 mL , Syrup , ASTAGEN , 60 mL Amber bottle','SALBU','Salbutamol','2MG5M','2 mg/5 mL','SYRUP','SYRUP','00982','60 mL Amber bottle','','Astagen','Hizon Labs Inc',0,0,0),('SELEG5MGXXTAB4902074007892','Selegiline , 5 mg , Tablet , JOSENTA','SELEG','Selegiline','5MGXX','5 mg','TAB49','TABLET','02074','Foil strip x 4\'s (Box of 100\'s)','J0021','Josenta','Chinoin Pharmaceutical & Chemical Works Co Lt',0,0,0),('SERTR50MGXTAB2401368011461','Sertraline , 50 mg , Tablet Film Coated , LLOYD LABS INC','SERTR','Sertraline','50MGX','50 mg','TAB24','TABLET FILM COATED','01368','Alu/PVC Blister pack x 10\'s (Box of 30\'s)','','','Lloyd Labs Inc',0,0,0),('SERTR50MGXTAB4901696007372','Sertraline , 50 mg , Tablet , EXUBERA','SERTR','Sertraline','50MGX','50 mg','TAB49','TABLET','01696','Blister pack x 30\'s','E2138','Exubera','Amherst Labs Inc',0,0,0),('SERTR50MGXTAB4902243008026','Sertraline , 50 mg , Tablet , EXTRANEAL','SERTR','Sertraline','50MGX','50 mg','TAB49','TABLET','02243','PVC blister pack of 14 (Box of 28\'s)','E2137','Extraneal','Amherst',0,0,0),('SILV110MG0CREA35GHDJ002339','Silver Sulfadiazine , 10 mg/g (1%) , Cream , SILVEX','SILV1','Silver Sulfadiazine','10MG0','10 mg/g (1%)','CREA3','CREAM','5GHDJ','500g HDPE Jar','S0126','Silvex','Agio Pharml Ltd',0,0,0),('SILV110MGGCREA300589005923','Silver Sulfadiazine , 10 mg/g , Cream , FLAMMAZINE','SILV1','Silver Sulfadiazine','10MGG','10 mg/g','CREA3','CREAM','00589','20 g Polyethylene tube','F2076','Flammazine','Solvay Pharma S.A.',0,0,0),('SILV110MGGCREA300589011462','Silver Sulfadiazine , 10 mg/g , Cream , BUMEX','SILV1','Silver Sulfadiazine','10MGG','10 mg/g','CREA3','CREAM','00589','20 g Polyethylene tube','B0109','Bumex','Beximco Pharmaceuticals Ltd',0,0,0),('SILV110MGGCREA300811006093','Silver Sulfadiazine , 10 mg/g , Cream , FLAMMAZINE','SILV1','Silver Sulfadiazine','10MGG','10 mg/g','CREA3','CREAM','00811','5 g Polyethylene tube','F2076','Flammazine','Solvay Pharma S.A.',0,0,0),('SILV110MGGCREA300883006143','Silver Sulfadiazine , 10 mg/g , Cream , FLAMMAZINE','SILV1','Silver Sulfadiazine','10MGG','10 mg/g','CREA3','CREAM','00883','50 g Polyethylene tube','F2076','Flammazine','Solvay Pharma S.A.',0,0,0),('SILV110MGGCREA300883011463','Silver Sulfadiazine , 10 mg/g , Cream , BUMEX','SILV1','Silver Sulfadiazine','10MGG','10 mg/g','CREA3','CREAM','00883','50 g Polyethylene tube','B0109','Bumex','Beximco Pharmaceuticals Ltd',0,0,0),('SILV110MGGCREA300933006178','Silver Sulfadiazine , 10 mg/g , Cream , FLAMMAZINE','SILV1','Silver Sulfadiazine','10MGG','10 mg/g','CREA3','CREAM','00933','500 g Polypropylene Jar','','Flammazine','Solvay Pharmaceuticals BV',0,0,0),('SILV110MGGCREA300933011464','Silver Sulfadiazine , 10 mg/g , Cream , BUMEX','SILV1','Silver Sulfadiazine','10MGG','10 mg/g','CREA3','CREAM','00933','500 g Polypropylene Jar','B0109','Bumex','Beximo Pharma\'l Ltd',0,0,0),('SILV110MGGCREA301456006901','Silver Sulfadiazine , 10 mg/g , Cream , FLAMMACERIUM','SILV1','Silver Sulfadiazine','10MGG','10 mg/g','CREA3','CREAM','01456','Aluminum tube','F2075','Flammacerium','Solvay Pharma SA - Spain',0,0,0),('SIMVA10MGXTAB2401208012177','Simvastatin , 10 mg , Tablet Film Coated , XIMVAST','SIMVA','Simvastatin','10MGX','10 mg','TAB24','TABLET FILM COATED','01208','Alu/Alu Blister Pack x 10\'s (Box of 30\'s)','X1524','Ximvast','Micro Labs Limited',0,0,0),('SIMVA10MGXTAB2401478006924','Metronidazole , 10 mg , Tablet Film Coated , FORAMEBEX','SIMVA','Simvastatin','10MGX','10 mg','TAB24','TABLET FILM COATED','02867','Strip Foil (Box of 30\'s)','F2153','Forcad','Lloyd Laboratories Inc.',0,0,0),('SIMVA10MGXTAB2402036007728','Simvastatin , 10 mg , Tablet Film Coated , EUROCOR','SIMVA','Simvastatin','10MGX','10 mg','TAB24','TABLET FILM COATED','02036','Foil strip of 10\'s (Box of 50\'s)','E2104','Eurocor','Lloyd Laboratories, Inc.',0,0,0),('SIMVA10MGXTAB2402062007843','Simvastatin , 10 mg , Tablet Film Coated , ECOSTA','SIMVA','Simvastatin','10MGX','10 mg','TAB24','TABLET FILM COATED','01208','Alu/Alu Blister Pack x 10\'s (Box of 30\'s)','E2009','Ecosta','Micro Labs Limited',0,0,0),('SIMVA10MGXTAB2402867012110','Simvastatin , 10 mg , Tablet Film Coated , EUVASTEN','SIMVA','Simvastatin','10MGX','10 mg','TAB24','TABLET FILM COATED','02867','Strip Foil (Box of 30\'s)','E2151','Euvasten','Lloyd Laboratories, Inc.',0,0,0),('SIMVA10MGXTAB24B10SH003613','Simvastatin , 10 mg , Tablet Film Coated , CHOLESTAD','SIMVA','Simvastatin','10MGX','10 mg','TAB24','TABLET FILM COATED','02062','Foil Strip x 10\'s (Box of 30\'s)','C2044','Cholestat','P.T. Kalbe Farma Tbk',0,0,0),('SIMVA10MGXTAB24B10SH005039','Simvastatin , 10 mg , Tablet Film Coated , LLOYD LABS INC','SIMVA','Simvastatin','10MGX','10 mg','TAB24','TABLET FILM COATED','01323','Alu/Alu Strip Pack x 10 Tablets (Box of 30\'s)','','','Lloyd Laboratories, Inc.',0,0,0),('SIMVA10MGXTAB24BOX10005038','Simvastatin , 10 mg , Tablet Film Coated , GEOFMAN PHARMACEUTICALS','SIMVA','Simvastatin','10MGX','10 mg','TAB24','TABLET FILM COATED','02761','Blister Pack of 10\'s/Box','','Simvastin','Geofman Pharmaceuticals',0,0,0),('SIMVA10MGXTAB4901357011466','Simvastatin , 10 mg , Tablet , DRUGMAKER\'S LABS. INC.','SIMVA','Simvastatin','10MGX','10 mg','TAB49','TABLET','01684','Blister pack x 20\'s (Box of 100\'s)','','','Drugmaker\'s Laboratories. Inc.',0,0,0),('SIMVA10MGXTAB4901368011467','Simvastatin , 10 mg , Tablet , DRUGMAKER\'S LABS. INC.','SIMVA','Simvastatin','10MGX','10 mg','TAB49','TABLET','01684','Blister Pack x 20\'s (Box of 100\'s)','','Qualistat','Drugmaker\'s Laboratories. Inc.',0,0,0),('SIMVA10MGXTAB4901654007195','Simvastatin , 10 mg , Tablet , DORMIZOL','SIMVA','Simvastatin','10MGX','10 mg','TAB49','TABLET','01654','Blister pack x 10\'s (Box of 30\'s)','D2117','Dormizol','Laboratorio Dosa SA Argentina',0,0,0),('SIMVA10MGXTAB4901678012038','Simvastatin , 10 mg , Tablet , ZOCOR','SIMVA','Simvastatin','10MGX','10 mg','TAB49','TABLET','01678','Blister Pack x 15 Tablets (Box of 30\'s)','Z1610','Zocor','Merck Sharp & Dohme Ltd.',0,0,0),('SIMVA10MGXTAB4902055011485','Simvastatin , 10 mg , Tablet , ASTHATOR-4','SIMVA','Simvastatin','10MGX','10 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','A2200','Asthator-4','Sydenham Labs., Inc',0,0,0),('SIMVA10MGXTAB4902353011479','Simvastatin , 10 mg , Tablet , THE MADRAS PHARMACEUTICAL','SIMVA','Simvastatin','10MGX','10 mg','TAB49','TABLET','BP351','Blister Pack x 10\'s (Box of 100\'s)','','','The Madras Pharmaceutical',0,0,0),('SIMVA10MGXTAB49BOX30005036','Simvastatin , 10 mg , Tablet , NOVARTIS','SIMVA','Simvastatin','10MGX','10 mg','TAB49','TABLET','BOX30','Blister box of 30','','','Novartis',0,0,0),('SIMVA10MGXTAB49BP20H005037','Simvastatin , 10 mg , Tablet , PASCUAL LABS. INC.','SIMVA','Simvastatin','10MGX','10 mg','TAB49','TABLET','BPX30','Blister Pack of 10\'s (Box of 30\'s)','','','Pascual Laboratories. Inc.',0,0,0),('SIMVA10MGXTAB49BPXXX005035','Simvastatin , 10 mg , Tablet , CIPLA','SIMVA','Simvastatin','10MGX','10 mg','TAB49','TABLET','BPXXX','Blister pack','','','Cipla',0,0,0),('SIMVA200MGTAB24SPT10002301','Simvastatin , 200 mg , Tablet Film Coated , NULL','SIMVA','Simvastatin','200MG','200 mg','TAB24','TABLET FILM COATED','SPT10','Strip pack by 10s (Box of 100s)','','','Lloyd Labs',0,0,0),('SIMVA20MGXTAB24002369','Simvastatin , 20 mg , Tablet Film Coated , LOCHOL','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','01368','Alu/PVC Blister pack x 10\'s (Box of 30\'s)','L0098','Lochol','Siam Bheasach Co Ltd',0,0,0),('SIMVA20MGXTAB2401365006811','Simvastatin , 20 mg , Tablet Film Coated , EUROCAINE','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','01365','Alu/PVC Blister pack x 10\'s (Box of 100\'s)','E2103','Eurocaine','Lloyd Laboratories Inc.',0,0,0),('SIMVA20MGXTAB2401654011470','Simvastatin , 20 mg , Tablet Film Coated , SALUTAS PHARMA GMBH','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','01654','Blister Pack x 10\'s (Box of 30\'s)','','','Salutas Pharma GmbH',0,0,0),('SIMVA20MGXTAB2401654011471','Simvastatin , 20 mg , Tablet Film Coated , LLOYD LABS INC','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','01322','Alu/Alu Strip Pack x 10\'s (Box of 30\'s)','','','Lloyd Laboratories, Inc.',0,0,0),('SIMVA20MGXTAB2401654011472','Simvastatin , 20 mg , Tablet Film Coated , YOO YOUNG PHARM CO. LTD','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','01319','Alu/Alu Strip Foil x 10\'s (Box of 30\'s)','','','Yoo Young Pharm Co. Ltd',0,0,0),('SIMVA20MGXTAB2401745011484','Simvastatin , 20 mg , Tablet Film Coated , ARTEON','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','01745','Blister strips 10\'s (Box of 100\'s)','A0227','Arteon','Interphil Labs Inc',0,0,0),('SIMVA20MGXTAB2401928011500','Simvastatin , 20 mg , Tablet Film Coated , CHOLESTOL','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','01922','Clear PVC/Aluminum Foil Blister Strip 10 x 10\'s (Box of 100\'s)','C2046','Cholestrol','Interphil Laboratories, Inc.',0,0,0),('SIMVA20MGXTAB2402045011489','Simvastatin , 20 mg , Tablet Film Coated , BUZTIN','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02045','Foil strip x 10 (Box of 100\'s)','B2095','Buztin','J.M. Tolmann',0,0,0),('SIMVA20MGXTAB2402047011495','Simvastatin , 20 mg , Tablet Film Coated , CHLOROMYCETIN','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02994','Blister Strip x 14\'s (Box of 140\'s)','C2042','Cholenorm','Plethico Pharmaceuticals Ltd.',0,0,0),('SIMVA20MGXTAB2402055007793','Simvastatin , 20 mg , Tablet Film Coated , MORDEK','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02055','Foil strip x 10\'s (Box of 100\'s)','M0137','Mordek','Lloyd Laboratories Inc.',0,0,0),('SIMVA20MGXTAB2402055011477','Simvastatin , 20 mg , Tablet Film Coated , LLOYD LABORATORIES, INC.','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02055','Foil Strip x 10\'s (Box of 100\'s)','','','Lloyd Laboratories, Inc.',0,0,0),('SIMVA20MGXTAB2402055011483','Simvastatin , 20 mg , Tablet Film Coated , AFORDEL','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02055','Foil strip x 10\'s (Box of 100\'s)','A0041','Afordel','Genpharm, Inc.',0,0,0),('SIMVA20MGXTAB2402055012098','Simvastatin , 20 mg , Tablet Film Coated , CHOLEZTIN','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02055','Foil Strip x 10\'s (Box of 100\'s)','C2167','Choleztin','J.M. Tolmann Laboratories, Inc',0,0,0),('SIMVA20MGXTAB2402062011501','Simvastatin , 20 mg , Tablet Film Coated , CHOLESTROL','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02994','Blister Strip x 14\'s (Box of 140\'s)','','Cholevas','Plethico Pharmaceuticals Ltd.',0,0,0),('SIMVA20MGXTAB2402070007866','Simvastatin , 20 mg , Tablet Film Coated , MORDEK','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02070','Foil strip x 30\'s (Box of 100\'s)','M0137','Mordek','Lloyd Laboratories Inc.',0,0,0),('SIMVA20MGXTAB2402708012176','Simvastatin , 20 mg , Tablet Film Coated , WILSIM','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02708','Alu/PVDC Clear Blister Pack by 10\'s (box of 100\'s)','W1511','Wilsim','Hizon Laboratories, Inc.',0,0,0),('SIMVA20MGXTAB24B1010002475','Simvastatin , 20 mg , Tablet Film Coated , LERIN','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','B1010','Blister pack of 10s (Box of 10s)','L0024','Lerin','JM Tolmann Labs Inc',0,0,0),('SIMVA20MGXTAB24B1050005250','Simvastatin , 20 mg , Tablet Film Coated , ARTEARS','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','B1050','Blister pack of 10s (Box of 50s)','A2178','Artears','Interphil Labs Inc.',0,0,0),('SIMVA20MGXTAB24B10SH003614','Simvastatin , 20 mg , Tablet Film Coated , CHOLESTROL','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','B10SH','Blister pack of 10s (Box of 100s)','C2046','Cholestrol','Domesco Medical Import Export Joint Stock Cor',0,0,0),('SIMVA20MGXTAB24B10SH005249','Simvastatin , 20 mg , Tablet Film Coated , ARTEARS','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','B10SH','Blister pack of 10s (Box of 100s)','A2178','Artears','Interphil Labs Inc.',0,0,0),('SIMVA20MGXTAB24BP351003514','Simvastatin , 20 mg , Tablet Film Coated , BUTALYN','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','BP351','Blister pack x 10\'s (box of 100\'s )','B0117','Butalyn','J.M. TOLMANN LABS',0,0,0),('SIMVA20MGXTAB24BP351005043','Simvastatin , 20 mg , Tablet Film Coated , YUHAN CORP','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','02047','Foil strip x 10 (Box of 1\'s)','','','Yuhan Corp',0,0,0),('SIMVA20MGXTAB24BPX30002204','Simvastatin , 20 mg , Tablet Film Coated , NULL','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','BPX30','Blister Pack of 10s (Box of 30s)','','','Teva Pharma\'l Works Pvt. Ltd Co',0,0,0),('SIMVA20MGXTAB24FS103002177','Simvastatin , 20 mg , Tablet Film Coated , NULL','SIMVA','Simvastatin','20MGX','20 mg','TAB24','TABLET FILM COATED','FS103','Foil strip by 10s (Box of 30s)','','','Yoo Young Pharm Co Ltd',0,0,0),('SIMVA20MGXTAB4901267006724','Simvastatin , 20 mg , Tablet , ENCIFER','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01645','Blister pack x 10\'s (100\'s/box)','E2049','Endovaz','Unique Pharmaceutical Laboratories',0,0,0),('SIMVA20MGXTAB4901269006728','Simvastatin , 20 mg , Tablet , ENCIFER','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01269','Alu/Alu Blister x 10\'s (Box of 250\'s)','E2048','Encifer','Unique Pharmaceutical Laboratories',0,0,0),('SIMVA20MGXTAB4901270006730','Simvastatin , 20 mg , Tablet , ENCIFER','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01270','Alu/Alu Blister x 10\'s (Box of 30\'s)','E2048','Encifer','Unique Pharmaceutical Laboratories',0,0,0),('SIMVA20MGXTAB4901464011481','Simvastatin , 20 mg , Tablet , AFORDEL','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01464','Aluminum/PVC/PVDC Blister Pack x 30\'s (Box of 150\'s)','A0041','Afordel','Matrix Laboratories Limited',0,0,0),('SIMVA20MGXTAB4901587011468','Simvastatin , 20 mg , Tablet , CIPLA','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01654','Blister Pack x 10\'s (Box of 30\'s)','','','Cipla Ltd.',0,0,0),('SIMVA20MGXTAB4901654007203','Simvastatin , 20 mg , Tablet , DORMIZOL','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01654','Blister pack x 10\'s (Box of 30\'s)','D2117','Dormizol','Laboratorio Dosa SA Argentina',0,0,0),('SIMVA20MGXTAB4901654007204','Simvastatin , 20 mg , Tablet , FORAMEFER','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','02380','Strip Pack x 10\'s (Box of 30\'s)','F2153','Forcad','Lloyd Laboratories Inc.',0,0,0),('SIMVA20MGXTAB4901654011469','Simvastatin , 20 mg , Tablet , HIZON LABS INC','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01645','Blister pack x 10\'s (100\'s/box)','','','Hizon Laboratories, Inc.',0,0,0),('SIMVA20MGXTAB4901654011473','Simvastatin , 20 mg , Tablet , DRUGMAKERS','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01654','Blister pack x 10\'s (Box of 30\'s)','','','Drugmakers',0,0,0),('SIMVA20MGXTAB4901654012037','Simvastatin , 20 mg , Tablet , ZOCOR','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01654','Blister Pack x 10\'s (Box of 30\'s)','Z1610','Zocor','Merck Sharp & Dohme Ltd.',0,0,0),('SIMVA20MGXTAB4901684011475','Simvastatin , 20 mg , Tablet , DRUGMAKERS','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','BP20H','Blister pack x 20\'s (Box of 100\'s)','','','Drugmakers',0,0,0),('SIMVA20MGXTAB4901710011476','Simvastatin , 20 mg , Tablet , THE MADRAS PHARMACEUTICALS','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01710','Blister pack x 5\'s (Box of 30\'s)','','','The Madras Pharmaceuticals',0,0,0),('SIMVA20MGXTAB4901894011498','Simvastatin , 20 mg , Tablet , CHOLESTAD','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01609','Blister Pack of 10\'s (Box of 100\'s)','C2045','Cholestol','Sydenham Laboratories, Inc.',0,0,0),('SIMVA20MGXTAB4902045007743','Simvastatin , 20 mg , Tablet , LIPIGEM','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','02045','Foil strip x 10 (Box of 100\'s)','L0048','Lipigem','Sydenham Labs Inc',0,0,0),('SIMVA20MGXTAB4902045011497','Simvastatin , 20 mg , Tablet , CHOLENORM','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','01645','Blister pack x 10\'s (100\'s/box)','C2043','Cholestad','Berlin Pharmaceuticasl Laboratory',0,0,0),('SIMVA20MGXTAB4902055011986','Simvastatin , 20 mg , Tablet , OROVAS','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','02055','Foil Strip x 10\'s (Box of 100\'s)','O1541','Orovas','Lloyd Laboratories, Inc.',0,0,0),('SIMVA20MGXTAB4902064011486','Simvastatin , 20 mg , Tablet , AVANDIA','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','02064','Foil strip x 10\'s (Box of 50\'s)','A2217','Avandia','Sydenham Labs Inc',0,0,0),('SIMVA20MGXTAB4902229008015','Simvastatin , 20 mg , Tablet , ENDAZOLE','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','02229','PVC Alu blister 10 ( Box of 100 \'s)','E0026','Endazole','Unique Pharmaceutical Labs India',0,0,0),('SIMVA20MGXTAB4902768012058','Simvastatin , 20 mg , Tablet , PASCUAL LABORATORIES, INC.','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','02768','Blister Pack x 10\'s (Box of 30\'s Compliance Pack)','','','Pascual Laboratories, Inc.',0,0,0),('SIMVA20MGXTAB4902774012059','Simvastatin , 20 mg , Tablet , PASCUAL LABORATORIES, INC.','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','02774','Blister Pack x 5\'s (Box of 25\'s Compliance Pack)','','','Pascual Laboratories, Inc.',0,0,0),('SIMVA20MGXTAB49B10SH005040','Simvastatin , 20 mg , Tablet , DRUGMAKERS','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','B10SH','Blister pack of 10s (Box of 100s)','','','Drugmakers',0,0,0),('SIMVA20MGXTAB49BP351005041','Simvastatin , 20 mg , Tablet , HIZON LABS INC','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','','','Hizon Labs Inc',0,0,0),('SIMVA20MGXTAB49BP351005042','Simvastatin , 20 mg , Tablet , HIZON LABS INC','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 30\'s)','','','Hizon Labs Inc',0,0,0),('SIMVA20MGXTAB49BPT35003947','Simvastatin , 20 mg , Tablet , ECOSTA','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','BPT35','Blister pack x 10 (Box of 30\'s)','E2009','Ecosta','Micro Labs',0,0,0),('SIMVA20MGXTAB49BPT35012001','Simvastatin , 20 mg , Tablet , SIMVOR','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','BPT35','Blister Pack x 10\'s (Box of 100\'s)','S1643','Simvor','Ranbaxy Laboratories Ltd.',0,0,0),('SIMVA20MGXTAB49BPX30002296','Simvastatin , 20 mg , Tablet , NULL','SIMVA','Simvastatin','20MGX','20 mg','TAB49','TABLET','BPX30','Blister Pack of 10s (Box of 30s)','','','Pascual Labs',0,0,0),('SIMVA40MGXTAB2400124011465','Simvastatin , 40 mg , Tablet Film Coated , CENTURION LABS','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','00124','10 Blister pack x 10\'s (Box of 100\'s)','','','Centurion Labs',0,0,0),('SIMVA40MGXTAB2401461011480','Simvastatin , 40 mg , Tablet Film Coated , AFORDEL','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','01461','Aluminum/PVC Blister pack x 15\'s (Box of 30\'s)','A0041','Afordel','Genpharm, Inc.',0,0,0),('SIMVA40MGXTAB2401654011474','Simvastatin , 40 mg , Tablet Film Coated , SALUTAS PHARMA GMBH','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','01654','Blister Pack x 10\'s (Box of 30\'s)','','','Salutas Pharma GmbH',0,0,0),('SIMVA40MGXTAB2401654011494','Simvastatin , 40 mg , Tablet Film Coated , CARDIOSAR','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','01654','Blister Pack x 10\'s (Box of 30\'s)','C2011','Cardiosim','Hizon Laboratories, Inc.',0,0,0),('SIMVA40MGXTAB2401673007299','Simvastatin , 40 mg , Tablet Film Coated , LIPISON-S-40','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','01673','Blister Pack x 14\'s (Box of 28\'s)','','Lipitin-S-40','Flamingo Pharmaceuticals Ltd.',0,0,0),('SIMVA40MGXTAB2401673011499','Simvastatin , 40 mg , Tablet Film Coated , CHOLESTAT','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','03011','Clear PVC/PVDC/Aluminum Foil Blister Strip 10 x 10\'s (Box of 100\'s)','C2046','Cholestrol','Interphil Laboratories, Inc.',0,0,0),('SIMVA40MGXTAB2402048011491','Simvastatin , 40 mg , Tablet Film Coated , BUZTIN','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','02048','Foil strip x 10 (Box of 30\'s)','B2095','Buztin','J.M. Tolmann Labs. Inc.',0,0,0),('SIMVA40MGXTAB2402055011478','Simvastatin , 40 mg , Tablet Film Coated , LLOYD LABORATORIES, INC.','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','02055','Foil Strip x 10\'s (Box of 100\'s)','','','Lloyd Laboratories, Inc.',0,0,0),('SIMVA40MGXTAB2402055011493','Simvastatin , 40 mg , Tablet Film Coated , BUZTIN','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','02055','Foil strip x 10\'s (Box of 100\'s)','B2095','Buztin','J.M. Tolmann',0,0,0),('SIMVA40MGXTAB2402055012099','Simvastatin , 40 mg , Tablet Film Coated , CHOLEZTIN','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','02055','Foil Strip x 10\'s (Box of 100\'s)','C2167','Choleztin','J.M. Tolmann Laboratories, Inc',0,0,0),('SIMVA40MGXTAB2402055012156','Simvastatin , 40 mg , Tablet Film Coated , PROVAST','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','02055','Foil Strip x 10\'s (Box of 100\'s)','P1616','Provast','J.M. Tolmann Laboratories, Inc',0,0,0),('SIMVA40MGXTAB2402372008149','Simvastatin , 40 mg , Tablet Film Coated , EUROCLAV','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','02372','Strip pack 10 x 10\'s (Box of 100\'s)','E0070','Euroclav','Lloyd Labs. Inc.',0,0,0),('SIMVA40MGXTAB24B10SH004015','Simvastatin , 40 mg , Tablet Film Coated , EUTHYROX 50','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','02055','Foil Strip x 10\'s (Box of 100\'s)','','Euvasten','Lloyd Laboratories Inc.',0,0,0),('SIMVA40MGXTAB24B10SH005251','Simvastatin , 40 mg , Tablet Film Coated , ARTEARS','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','1645','Blister pack x 10\'s (100\'s/box)','A0227','Arteon','Interphil Laboratories, Inc.',0,0,0),('SIMVA40MGXTAB24BP351005048','Simvastatin , 40 mg , Tablet Film Coated , AMHERST LABS. INC.','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','BP351','Blister pack x 10\'s (box of 100\'s )','','','Amherst Labs. Inc.',0,0,0),('SIMVA40MGXTAB24BPT35003946','Simvastatin , 40 mg , Tablet Film Coated , ECONOPRED PLUS','SIMVA','Simvastatin','40MGX','40 mg','TAB24','TABLET FILM COATED','BPT35','Blister pack x 10 (Box of 30\'s)','E2007','Econopred Plus','Micro Labs',0,0,0),('SIMVA40MGXTAB4901654011482','Simvastatin , 40 mg , Tablet , AFORDEL','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','01464','Aluminum/PVC/PVDC Blister Pack x 15\'s (Box of 150\'s)','A0041','Afordel','Matrix Laboratories Limited',0,0,0),('SIMVA40MGXTAB4901654011496','Simvastatin , 40 mg , Tablet , CHOLEFEN','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','1645','Blister pack x 10\'s (100\'s/box)','C2043','Cholestad','Berlin Pharmaceuticasl Laboratory',0,0,0),('SIMVA40MGXTAB4901654012000','Simvastatin , 40 mg , Tablet , SIMBATHREE','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','01654','Blister Pack x 10\'s (Box of 30\'s)','S1642','Simbathree','Hizon Laboratories, Inc.',0,0,0),('SIMVA40MGXTAB4901710012040','Simvastatin , 40 mg , Tablet , ZOCOR HP','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','01710','Blister Pack x 5\'s (Box of 30\'s)','Z1611','Zocor HP','Merck Sharp & Dohme Ltd.',0,0,0),('SIMVA40MGXTAB4902055011987','Simvastatin , 40 mg , Tablet , OROVAS','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','02055','Foil Strip x 10\'s (Box of 100\'s)','O1541','Orovas','Lloyd Laboratories, Inc.',0,0,0),('SIMVA40MGXTAB49B10SH005047','Simvastatin , 40 mg , Tablet , PASCUAL LAB., INC','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','B10SH','Blister pack of 10s (Box of 100s)','','','Pascual Lab., Inc',0,0,0),('SIMVA40MGXTAB49BP351005044','Simvastatin , 40 mg , Tablet , HIZON LABS INC','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','01654','Blister Pack x 10\'s (Box of 30\'s)','','','Hizon Laboratories, Inc.',0,0,0),('SIMVA40MGXTAB49BP351005045','Simvastatin , 40 mg , Tablet , HIZON LABS INC','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 30\'s)','','','Hizon Labs Inc',0,0,0),('SIMVA40MGXTAB49BP351005046','Simvastatin , 40 mg , Tablet , LLOYD LAB., INC','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','02062','Foil Strip x 10\'s (Box of 30\'s)','','','Lloyd Laboratories, Inc.',0,0,0),('SIMVA40MGXTAB49BP351005254','Simvastatin , 40 mg , Tablet , ARTEON','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','A0227','Arteon','Interphil Laboratories, Inc.',0,0,0),('SIMVA40MGXTAB49BPX30002289','Simvastatin , 40 mg , Tablet , NULL','SIMVA','Simvastatin','40MGX','40 mg','TAB49','TABLET','BPX30','Blister Pack of 10s (Box of 30s)','','','Pascual Labs',0,0,0),('SIMVA80MGXTAB2401475011487','Simvastatin , 80 mg , Tablet Film Coated , BUTADIL','SIMVA','Simvastatin','80MGX','80 mg','TAB24','TABLET FILM COATED','01475','Alu-PVC Blister pack x 10\'s (Box of 100\'s)','B0115','Butadil','J.M. Tolmann',0,0,0),('SIMVA80MGXTAB2401654007237','Simvastatin , 80 mg , Tablet Film Coated , MOREXEN','SIMVA','Simvastatin','80MGX','80 mg','TAB24','TABLET FILM COATED','01654','Blister pack x 10\'s (Box of 30\'s)','M0138','Morexen','Lloyd Laboratories, Inc.',0,0,0),('SIMVA80MGXTAB2402045011490','Simvastatin , 80 mg , Tablet Film Coated , BUZTIN','SIMVA','Simvastatin','80MGX','80 mg','TAB24','TABLET FILM COATED','02045','Foil strip x 10 (Box of 100\'s)','B2095','Buztin','J.M. TOLMANN LABS',0,0,0),('SIMVA80MGXTAB2402239008024','Simvastatin , 80 mg , Tablet Film Coated , ECOSTA','SIMVA','Simvastatin','80MGX','80 mg','TAB24','TABLET FILM COATED','02239','PVC blister pack 20 (Box of 100\'s)','E2009','Ecosta','Micro Labs Ltd',0,0,0),('SIMVA80MGXTAB4902857012039','Simvastatin , 80 mg , Tablet , ZOCOR','SIMVA','Simvastatin','80MGX','80 mg','TAB49','TABLET','02857','PVC/PE/PVDC Blister Pack x 5\'s (Box of 30\'s)','Z1610','Zocor','Merck Sharp & Dohme Ltd.',0,0,0),('SODI2000P9SOL1400610011513','Sodium Chloride , 0.009 , Solution For Injection , B. BRAUN , 20 mL LDPE Bottle','SODI2','Sodium Chloride','000P9','0.009','SOL14','SOLUTION FOR INJECTION','00610','20 mL LDPE Bottle','','','B. Braun',0,0,0),('SODI2000P9SOL1400761011518','Sodium Chloride , 0.009 , Solution For Injection , EURO-MED , 30 mL White Plastic bottle w/ plastic cap','SODI2','Sodium Chloride','000P9','0.009','SOL14','SOLUTION FOR INJECTION','00761','30 mL White Plastic bottle w/ plastic cap','','','Euro-Med',0,0,0),('SODI2000P9SOL1400916011519','Sodium Chloride , 0.009 , Solution For Injection , B. BRAUN , 50 mL LDPE Bottle','SODI2','Sodium Chloride','000P9','0.009','SOL14','SOLUTION FOR INJECTION','00916','50 mL LDPE Bottle','','','B. Braun',0,0,0),('SODI2000P9SOL1500750011516','Sodium Chloride , 0.009 , Solution Irrigation , EURO-MED , 30 mL LDPE plastic bottle','SODI2','Sodium Chloride','000P9','0.009','SOL15','SOLUTION IRRIGATION','00750','30 mL LDPE plastic bottle','','','Euro-Med',0,0,0),('SODI2000P9SOL3500235011508','Sodium Chloride , 0.09 , Solution For Infusion , EURO-MED , 10 mL White LDPE dropper-tip bottle','SODI2','Sodium Chloride','000P9','0.09','SOL35','SOLUTION FOR INFUSION','00235','10 mL White LDPE dropper-tip bottle','','','Euro-Med',0,0,0),('SODI2000P9SOL3500612011514','Sodium Chloride , 0.009 , Solution For Infusion , ALBERT DAVID LTD , 20 mL LDPE vial','SODI2','Sodium Chloride','000P9','0.009','SOL35','SOLUTION FOR INFUSION','00612','20 mL LDPE vial','','','Albert David Ltd',0,0,0),('SODI2000P9SOL3500918011520','Sodium Chloride , 0.009 , Solution For Infusion , ALBERT DAVID LTD , 50 mL LDPE vial','SODI2','Sodium Chloride','000P9','0.009','SOL35','SOLUTION FOR INFUSION','00918','50 mL LDPE vial','','','Albert David Ltd',0,0,0),('SODI2009P0SOL1500751011517','Sodium Chloride , 0.009 , Solution Irrigation , BAXTER HEALTHCARE , 30 mL LDPE squeezable bottle w/ cap and plug','SODI2','Sodium Chloride','009P0','0.009','SOL15','SOLUTION IRRIGATION','00751','30 mL LDPE squeezable bottle w/ cap and plug','','','Baxter Healthcare',0,0,0),('SODI2009P0SOL3500607011512','Sodium Chloride , 0.009 , Solution For Infusion , BEST DRUG INDUSTRIES, INC. , 20 mL Glass vial (Box of 10\'s)','SODI2','Sodium Chloride','009P0','0.009','SOL35','SOLUTION FOR INFUSION','00607','20 mL Glass vial (Box of 10\'s)','','','Best Drug Industries, Inc.',0,0,0),('SODI21GRAMTAB49002382','Sodium Chloride , 1 gram , Tablet , NULL','SODI2','Sodium Chloride','1GRAM','1 gram','TAB49','TABLET','03100','Wide mouthed amber bottle x 100\'s','','','Amherst Labs',0,0,0),('SODI225MGLSOL3500190011507','Sodium Chloride , 2.5 mg /mL , Solution For Infusion , HIZON , 10 mL HDPE Container','SODI2','Sodium Chloride','25MGL','2.5 mg /mL','SOL35','SOLUTION FOR INFUSION','00190','10 mL HDPE Container','','','Hizon',0,0,0),('SODI35MGXXMDIXX00204011522','Sodium Chromoglicate , 5 mg , Metered Dose Inhaler , CIPLA , 10 mL Polyethylene Bottle (Box of 1\'s)','SODI3','Sodium Chromoglicate','5MGXX','5 mg','MDIXX','METERED DOSE INHALER','00204','10 mL Polyethylene Bottle (Box of 1\'s)','','','Cipla',0,0,0),('SODI5000P2OINTX00384005694','Sodium Fusidate , 0.02 , Ointment , FUSIVIS','SODI5','Sodium Fusidate','000P2','0.02','OINTX','OINTMENT','00384','15 g Aluminum Tube','F2193','Fusivis','Agio Pharmaceuticals Ltd',0,0,0),('SODI5000P2OINTX00803006078','Sodium Fusidate , 0.02 , Ointment , FUSIVIS','SODI5','Sodium Fusidate','000P2','0.02','OINTX','OINTMENT','00803','5 g Aluminum Tube','F2193','Fusivis','Agio Pharmaceuticals Ltd',0,0,0),('SODI520MGGOINTX00382005692','Sodium Fusidate , 20 mg/g , Ointment , FUSEM','SODI5','Sodium Fusidate','20MGG','20 mg/g','OINTX','OINTMENT','00382','15 g Alum Tube/Box','F2190','Fusem','Geno Pharmaceuticals Ltd',0,0,0),('SODI520MGGOINTX00799006077','Sodium Fusidate , 20 mg/g , Ointment , FUSEM','SODI5','Sodium Fusidate','20MGG','20 mg/g','OINTX','OINTMENT','00799','5 g Alum Tube/Box','F2190','Fusem','Geno Pharmaceuticals Ltd',0,0,0),('SODI52MGGXOINTX00384011523','Sodium Fusidate , 2 mg/g , Ointment , LLOYD LABS. INC.','SODI5','Sodium Fusidate','2MGGX','2 mg/g','OINTX','OINTMENT','00384','15 g Aluminum Tube','','','Lloyd Labs. Inc.',0,0,0),('SODIU1MEGLSOL1400639011503','Sodium Bicarbonate , 1 mEg/mL , Solution For Injection , EURO-MED LABORATORIES , 20 mL vial','SODIU','Sodium Bicarbonate','1MEGL','1 mEg/mL','SOL14','SOLUTION FOR INJECTION','00639','20 mL vial','','','Euro-Med Laboratories',0,0,0),('SODIU325MGTAB4901118011504','Sodium Bicarbonate , 325 mg , Tablet , LLOYD LAB., INC','SODIU','Sodium Bicarbonate','325MG','325 mg','TAB49','TABLET','01118','851 g PE Film Bag','','','Lloyd Lab., Inc',0,0,0),('SODIU650MGTAB4901189011505','Sodium Bicarbonate , 650 mg , Tablet , AMHERST','SODIU','Sodium Bicarbonate','650MG','650 mg','TAB49','TABLET','01189','Alu/Alu Blister pack of 7\'s (Box of 28\'s)','','','Amherst',0,0,0),('SODIU70MMLSOL1400615011502','Sodium Bicarbonate , 70 mg/mL , Solution For Injection , EURO-MED LABORATORIES PHILS. INC , 20 mL Low Density Polyethylene Vial','SODIU','Sodium Bicarbonate','70MML','70 mg/mL','SOL14','SOLUTION FOR INJECTION','00615','20 mL Low Density Polyethylene Vial','','','Euro-Med Laboratories Phils. Inc',0,0,0),('SPIRO100MGTAB2401441011528','Spironolactone , 100 mg , Tablet Film Coated , ALDACTONE','SPIRO','Spironolactone','100MG','100 mg','TAB24','TABLET FILM COATED','01441','Aluminum Foil x 10\'s (Box of 50\'s)','A2072','Aldactone','Piramal Healthcare (UK) Ltd',0,0,0),('SPIRO100MGTAB4901985011525','Spironolactone , 100 mg , Tablet , AMHERST LABS INC','SPIRO','Spironolactone','100MG','100 mg','TAB49','TABLET','01985','Flex foils x 10\'s (Box of 30\'s)','','','Amherst Labs Inc',0,0,0),('SPIRO100MGTAB4902002011530','Spironolactone , 100 mg , Tablet , ALDACTONE','SPIRO','Spironolactone','100MG','100 mg','TAB49','TABLET','FSTRI','Foil strip','A2072','Aldactone','Interphil',0,0,0),('SPIRO100MGTAB4902055011533','Spironolactone , 100 mg , Tablet , ALDACTONE','SPIRO','Spironolactone','100MG','100 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','A2072','Aldactone','United Lab',0,0,0),('SPIRO25MGMTAB2402055011531','Spironolactone , 25 mg/mL , Tablet Film Coated , ALDACTONE','SPIRO','Spironolactone','25MGM','25 mg/mL','TAB24','TABLET FILM COATED','02055','Foil strip x 10\'s (Box of 100\'s)','A2072','Aldactone','Piramal Healthcare (UK) Ltd',0,0,0),('SPIRO25MGXTAB4901359011527','Spironolactone , 25 mg , Tablet , ALDACTONE','SPIRO','Spironolactone','25MGX','25 mg','TAB49','TABLET','01359','Alu/PVC Blister pack of 10\'s (Box of 100\'s)','A2072','Aldactone','Interphil',0,0,0),('SPIRO25MGXTAB4901985011526','Spironolactone , 25 mg , Tablet , AMHERST LABS INC','SPIRO','Spironolactone','25MGX','25 mg','TAB49','TABLET','01985','Flex foils x 10\'s (Box of 30\'s)','','','Amherst Labs Inc',0,0,0),('SPIRO50MGXTAB2401474011529','Spironolactone , 50 mg , Tablet Film Coated , ALDACTONE','SPIRO','Spironolactone','50MGX','50 mg','TAB24','TABLET FILM COATED','01474','Alu-PVC Blister Pack of 10\'s (Box of 100\'s)','A2072','Aldactone','Piramal Healthcare (UK) Ltd',0,0,0),('SPIRO50MGXTAB4901474011524','Spironolactone , 50 mg , Tablet , AMHERST LABS INC','SPIRO','Spironolactone','50MGX','50 mg','TAB49','TABLET','01474','Alu-PVC Blister Pack of 10\'s (Box of 100\'s)','','','Amherst Labs Inc',0,0,0),('SPIRO50MGXTAB4902055011532','Spironolactone , 50 mg , Tablet , ALDACTONE','SPIRO','Spironolactone','50MGX','50 mg','TAB49','TABLET','02055','Foil strip x 10\'s (Box of 100\'s)','A2072','Aldactone','Interphil',0,0,0),('STRE11GRAMPOW1300012011534','Streptomycin , 1 gram , Powder For Injection Solution , SHANDONG REYOUNG PHARMACEUTICAL CO. LTD.','STRE1','Streptomycin','1GRAM','1 gram','POW13','POWDER FOR INJECTION SOLUTION','00012','1 g Clear vial','','','Shandong Reyoung Pharmaceutical Co. Ltd.',0,0,0),('STRE11GRAMPOW1301947011535','Streptomycin , 1 gram , Powder For Injection Solution , KARNATAKA','STRE1','Streptomycin','1GRAM','1 gram','POW13','POWDER FOR INJECTION SOLUTION','01947','Clear, 1 glass vial (Box of 10\'s)','','','Karnataka',0,0,0),('STRE11GRAMPOW13FVIAL005050','Streptomycin , 1 gram , Powder For Injection Solution , CHINA MEHECO','STRE1','Streptomycin','1GRAM','1 gram','POW13','POWDER FOR INJECTION SOLUTION','FVIAL','Flint vial','','','China Meheco',0,0,0),('SULFU00P10OINTX02197011537','Sulfur , 0.1 , Ointment , VIRGO PHARMA\'L LAB.','SULFU','Sulfur','00P10','0.1','OINTX','OINTMENT','02197','Plastic jar','','','Virgo Pharma\'l Lab.',0,0,0),('SULFU1HMGGOINTX00724011536','Sulfur , 100 mg/g , Ointment , J. CHEMIE LABORATORY INC','SULFU','Sulfur','1HMGG','100 mg/g','OINTX','OINTMENT','00724','30 g Aluminum Tube','','','J. Chemie Laboratory Inc',0,0,0),('SULTA250M5POW24HB60M002400','Sultamicillin , 250 mg/5mL , Powder For Suspension , UNASYN, HDPE bottle x 60mL','SULTA','SULTAMICILLIN','250M5','250 mg/5mL','POW24','POWDER FOR SUSPENSION','HB60M','HDPE bottle x 60mL','UNAS','Unasyn','',0,0,0),('SUXAM20MGMSOL1400232011538','Suxamethonium , 20 mg/mL , Solution For Injection , ANEKCIN, 10 mL Vial (Box of 10\'s)','SUXAM','Suxamethonium','20MGM','20 mg/mL','SOL14','SOLUTION FOR INJECTION','00232','10 mL Vial (Box of 10\'s)','A2131','Anekcin','Hanson Labs',0,0,0),('SUXAM20MGMSOL1400232011539','Suxamethonium , 20 mg/mL , Solution For Injection , ANEKTIL, 10 mL Vial (Box of 10\'s)','SUXAM','Suxamethonium','20MGM','20 mg/mL','SOL14','SOLUTION FOR INJECTION','00232','10 mL Vial (Box of 10\'s)','A2132','Anektil','Oboi Labs',0,0,0),('TACRO5MGXXCAPSU00140011540','Tacrolimus , 5 mg , Capsule , INTAS PHARMA\'L LTD','TACRO','Tacrolimus','5MGXX','5 mg','CAPSU','CAPSULE','00140','10 g Laminated Tube','','','Intas Pharma\'l Ltd',0,0,0),('TAMO120MGXTAB24BPT35012119','Tamoxifen (As Citrate) , 20 mg , Tablet Film Coated , GYRAXEN','TAMO1','Tamoxifen (as Citrate)','20MGX','20 mg','TAB24','TABLET FILM COATED','BPT35','Blister Pack x 10\'s (Box of 100\'s)','G2085','Gyraxen','Korea United Pharm., Inc.',0,0,0),('TAMO120MGXTAB4901317012006','Tamoxifen (As Citrate) , 20 mg , Tablet , TAMOSAN','TAMO1','Tamoxifen (as Citrate)','20MGX','20 mg','TAB49','TABLET','01317','Alu/Alu Strip Foil x 10 Tablets (Box of 10\'s)','T1607','Tamosan','SRS Pharmaceuticals Pvt. Ltd.',0,0,0),('TAMO120MGXTAB4901654011985','Tamoxifen Citrate , 20 mg , Tablet , NOLVADEX-D','TAMO1','Tamoxifen Citrate','20MGX','20 mg','TAB49','TABLET','01654','Blister Pack x 10\'s (Box of 30\'s)','N1567','Nolvadex-D','AstraZeneca UK Ltd.',0,0,0),('TAMO120MGXTAB4902710012035','Tamoxifen (As Citrate) , 20 mg , Tablet , ZITAZONIUM','TAMO1','Tamoxifen (as Citrate)','20MGX','20 mg','TAB49','TABLET','02710','Aluminum Blister Foil x 10\'s (Box of 30\'s)','Z1607','Zitazonium','Egis Pharmaceuticals Public Limited Company',0,0,0),('TAMO120MGXTAB4902766012005','Tamoxifen (As Citrate) , 20 mg , Tablet , TAMOPLEX','TAMO1','Tamoxifen (as Citrate)','20MGX','20 mg','TAB49','TABLET','02766','Blister Pack x 10\'s (Box of 100 Blisters)','T1606','Tamoplex','Pharmachemie B.V.',0,0,0),('TAMOX20MGXTAB4901317006763','Tamoxifen , 20 mg , Tablet , NOVAFENIC','TAMOX','Tamoxifen','20MGX','20 mg','TAB49','TABLET','01317','Alu/Alu Strip Foil x 10 Tablets (Box of 10\'s)','N0062','Novafenic','AstraZeneca UK Ltd. - UK',0,0,0),('TAMOX20MGXTAB49B10SH003940','Tamoxifen , 20 mg , Tablet , DYNASTIN','TAMO1','Tamoxifen (as Citrate)','20MGX','20 mg','TAB49','TABLET','03040','Polypropylene Bottle/LDPE Stopper','','Ebefen','Ebewe Pharma Ges.m.b.H kg',0,0,0),('TAMOX20MGXTAB49BP100004049','Tamoxifen , 20 mg , Tablet , FENAFEX','TAMOX','Tamoxifen','20MGX','20 mg','TAB49','TABLET','BP100','Blister pack x 100','F2026','Fenafex','Salutas Pharma GmbH',0,0,0),('TAMOX20MGXTAB49BP351004050','Tamoxifen , 20 mg , Tablet , FENAFEX','TAMOX','Tamoxifen','20MGX','20 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','F2026','Fenafex','Salutas Pharma GmbH',0,0,0),('TAMOX20MGXTAB49BP351005051','Tamoxifen , 20 mg , Tablet , LABARATORIOS FILAXIS SA ARGENTINA','TAMOX','Tamoxifen','20MGX','20 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','','','Labaratorios Filaxis SA Argentina',0,0,0),('TAMOX20MGXTAB49BPX30003941','Tamoxifen , 20 mg , Tablet , DYNASTIN','TAMOX','Tamoxifen','20MGX','20 mg','TAB49','TABLET','BPX30','Blister pack of 10s (Box of 30s)','D0121','Dynastin','Ebewe Pharma Ges.m.b.H kg',0,0,0),('TAMSU4HMCGTAB2401445006890','Tamsulosin , 400 mcg , Tablet Film Coated , HARFEVAN','TAMSU','Tamsulosin','4HMCG','400 mcg','TAB24','TABLET FILM COATED','01445','Aluminum PVC Blister pack x 10\'s (Box of 100\'s)','H0007','Harfevan','Astellas Europe BV',0,0,0),('TAMSU4HMCGTAB2401446006892','Tamsulosin , 400 mcg , Tablet Film Coated , HARFEVAN','TAMSU','Tamsulosin','4HMCG','400 mcg','TAB24','TABLET FILM COATED','01446','Aluminum PVC Blister pack x 10\'s (Box of 30\'s)','H0007','Harfevan','Astellas Europe BV',0,0,0),('TELA14010MTAB4901208012018','Telmisartan + Amlodipine (As Besilate) , 40 mg/10 mg , Tablet , TWYNSTA','TELA1','Telmisartan + Amlodipine (as Besilate)','4010M','40 mg/10 mg','TAB49','TABLET','01208','Alu/Alu Blister Pack x 10\'s (Box of 30\'s)','T1604','Twynsta','Cipla Limited',0,0,0),('TELA140MG5TAB4901208012019','Telmisartan + Amlodipine (As Besilate) , 40 mg/5 mg , Tablet , TWYNSTA','TELA1','Telmisartan + Amlodipine (as Besilate)','40MG5','40 mg/5 mg','TAB49','TABLET','01208','Alu/Alu Blister Pack x 10\'s (Box of 30\'s)','T1604','Twynsta','Cipla Limited',0,0,0),('TELA18010MTAB4901208012020','Telmisartan + Amlodipine (As Besilate) , 80 mg/10 mg , Tablet , TWYNSTA','TELA1','Telmisartan + Amlodipine (as Besilate)','8010M','80 mg/10 mg','TAB49','TABLET','01208','Alu/Alu Blister Pack x 10\'s (Box of 30\'s)','T1604','Twynsta','Cipla Limited',0,0,0),('TELA180MG5TAB4901208012021','Telmisartan + Amlodipine (As Besilate) , 80 mg/5 mg , Tablet , TWYNSTA','TELA1','Telmisartan + Amlodipine (as Besilate)','80MG5','80 mg/5 mg','TAB49','TABLET','01208','Alu/Alu Blister Pack x 10\'s (Box of 30\'s)','T1604','Twynsta','Cipla Limited',0,0,0),('TELA240125TAB4901182011981','Telmisartan + Hydrochlorothiazide , 40 mg + 12.5 mg , Tablet , MICARDIS PLUS','TELA2','Telmisartan + Hydrochlorothiazide','40125','40 mg + 12.5 mg','TAB49','TABLET','01182','Alu/Alu Blister Pack of 10\'s (Box of 30\'s)','M1652','Micardis Plus','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELA240125TAB4901189011983','Telmisartan + Hydrochlorothiazide , 40 mg + 12.5 mg , Tablet , MICARDIS PLUS','TELA2','Telmisartan + Hydrochlorothiazide','40125','40 mg + 12.5 mg','TAB49','TABLET','01189','Alu/Alu Blister Pack of 7\'s (Box of 28\'s)','M1652','Micardis Plus','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELA240M12CAPSU01237011638','Telmisartan + Hydrochlorothiazide , 40 mg/12.5 mg , Capsule , AMHERST LABORATORIES INC.','TELA2','Telmisartan + Hydrochlorothiazide','40M12','40 mg/12.5 mg','CAPSU','CAPSULE','01237','Alu/Alu Blister Pack x 6\'s (Box of 30\'s)','','','Amherst Laboratories Inc.',0,0,0),('TELA240M12TAB4901546011937','Telmisartan + Hydrochlorothiazide , 40 mg/12.5 mg , Tablet , CO-TASMI','TELA2','Telmisartan + Hydrochlorothiazide','40M12','40 mg/12.5 mg','TAB49','TABLET','01546','Blister Foil by 7\'s (Box of 14\'s)','C2174','Co-Tasmi','Getz Pharma Pvt. Ltd.',0,0,0),('TELA240M12TAB4902360011917','Telmisartan + Hydrochlorothiazide , 40 mg/12.5 mg , Tablet , ARBITEL-H','TELA2','Telmisartan + Hydrochlorothiazide','40M12','40 mg/12.5 mg','TAB49','TABLET','02360','Strip Foil by 10\'s (Box of 30\'s)','A2170','Arbitel-H','Micro Labs Limited',0,0,0),('TELA280125CAPSU01237011639','Telmisartan + Hydrochlorothiazide , 80 mg/12.5 mg , Capsule , AMHERST LABORATORIES INC.','TELA2','Telmisartan + Hydrochlorothiazide','80125','80 mg/12.5 mg','CAPSU','CAPSULE','01237','Alu/Alu Blister Pack x 6\'s (Box of 30\'s)','','','Amherst Laboratories Inc.',0,0,0),('TELA28012MTAB4901182011982','Telmisartan + Hydrochlorothiazide , 80 mg + 12.5 mg , Tablet , MICARDIS PLUS','TELA2','Telmisartan + Hydrochlorothiazide','8012M','80 mg + 12.5 mg','TAB49','TABLET','01182','Alu/Alu Blister Pack of 10\'s (Box of 30\'s)','M1652','Micardis Plus','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELA28012MTAB4901189011984','Telmisartan + Hydrochlorothiazide , 80 mg + 12.5 mg , Tablet , MICARDIS PLUS','TELA2','Telmisartan + Hydrochlorothiazide','8012M','80 mg + 12.5 mg','TAB49','TABLET','01189','Alu/Alu Blister Pack of 7\'s (Box of 28\'s)','M1652','Micardis Plus','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELA28025MTAB4901169011977','Telmisartan + Hydrochlorothiazide , 80 mg/25 mg , Tablet , MICARDIS PLUS','TELA2','Telmisartan + Hydrochlorothiazide','8025M','80 mg/25 mg','TAB49','TABLET','01169','Alu/Alu Blister Pack (Box of 14\'s)','M1652','Micardis Plus','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELA28025MTAB4901189011991','Telmisartan + Hydrochlorothiazide , 80 mg/25 mg , Tablet , PRITOR PLUS','TELA2','Telmisartan + Hydrochlorothiazide','8025M','80 mg/25 mg','TAB49','TABLET','01189','Alu/Alu Blister Pack of 7\'s (Box of 28\'s)','P1615','Pritor Plus','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELA28025MTAB4902681011978','Telmisartan + Hydrochlorothiazide , 80 mg/25 mg , Tablet , MICARDIS PLUS','TELA2','Telmisartan + Hydrochlorothiazide','8025M','80 mg/25 mg','TAB49','TABLET','02681','Alu/Alu Blister Pack (Box of 28\'s)','M1652','Micardis Plus','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELA28025MTAB4902682011979','Telmisartan + Hydrochlorothiazide , 80 mg/25 mg , Tablet , MICARDIS PLUS','TELA2','Telmisartan + Hydrochlorothiazide','8025M','80 mg/25 mg','TAB49','TABLET','02682','Alu/Alu Blister Pack (Box of 30\'s)','M1652','Micardis Plus','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELA28025MTAB4902683011980','Telmisartan + Hydrochlorothiazide , 80 mg/25 mg , Tablet , MICARDIS PLUS','TELA2','Telmisartan + Hydrochlorothiazide','8025M','80 mg/25 mg','TAB49','TABLET','02683','Alu/Alu Blister Pack (Box of 7\'s)','M1652','Micardis Plus','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELAM20MGXTAB2401205012090','Telmisartan , 20 mg , Tablet Film Coated , CARDISAR','TELAM','Telmisartan','20MGX','20 mg','TAB24','TABLET FILM COATED','01205','Alu/Alu Blister Pack x 10\'s (Box of 10\'s)','C2162','Cardisar','Surge Laboratories Pvt. Ltd.',0,0,0),('TELAM20MGXTAB4901205012013','Telmisartan , 20 mg , Tablet , TELMICARD-20','TELAM','Telmisartan','20MGX','20 mg','TAB49','TABLET','01205','Alu/Alu Blister Pack x 10\'s (Box of 10\'s)','T1594','Telmicard-20','Rainbow Lifesciences Pvt. Ltd.',0,0,0),('TELAM20MGXTAB4901295011997','Telmisartan , 20 mg , Tablet , SAFETELMI','TELAM','Telmisartan','20MGX','20 mg','TAB49','TABLET','01295','Alu/Alu Foil Strip x 10\'s (Box of 100\'s)','S1637','Safetelmi','MSN Laboratories Ltd.',0,0,0),('TELAM20MGXTAB4901546012010','Telmisartan , 20 mg , Tablet , TASMI','TELAM','Telmisartan','20MGX','20 mg','TAB49','TABLET','01546','Blister Foil by 7\'s (Box of 14\'s)','T1611','Tasmi','Getz Pharma Pvt. Ltd.',0,0,0),('TELAM20MGXTAB4901550011541','Telmisartan , 20 mg , Tablet , ARBADOS','TELAM','Telmisartan','20MGX','20 mg','TAB49','TABLET','02360','Strip Foil by 10\'s (Box of 30\'s)','A2167','Arbitel-20','Micro Labs Limited',0,0,0),('TELAM20MGXTAB49B1010002099','Telmisartan , 20 mg , Tablet , NULL','TELAM','Telmisartan','20MGX','20 mg','TAB49','TABLET','B1010','Blister pack of 10s (Box of 10s)','','','Rainbow Life Sciences Pvt Ltd',0,0,0),('TELAM40MGXTAB2401205012091','Telmisartan , 40 mg , Tablet Film Coated , CARDISAR','TELAM','Telmisartan','40MGX','40 mg','TAB24','TABLET FILM COATED','01205','Alu/Alu Blister Pack x 10\'s (Box of 10\'s)','C2162','Cardisar','Surge Laboratories Pvt. Ltd.',0,0,0),('TELAM40MGXTAB4901189011990','Telmisartan , 40 mg , Tablet , PRITOR','TELAM','Telmisartan','40MGX','40 mg','TAB49','TABLET','01189','Alu/Alu Blister Pack of 7\'s (Box of 28\'s)','P0106','Pritor','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELAM40MGXTAB4901205012014','Telmisartan , 40 mg , Tablet , TELMICARD-40','TELAM','Telmisartan','40MGX','40 mg','TAB49','TABLET','01205','Alu/Alu Blister Pack x 10\'s (Box of 10\'s)','T1595','Telmicard-40','Rainbow Lifesciences Pvt. Ltd.',0,0,0),('TELAM40MGXTAB4901295011998','Telmisartan , 40 mg , Tablet , SAFETELMI','TELAM','Telmisartan','40MGX','40 mg','TAB49','TABLET','01295','Alu/Alu Foil Strip x 10\'s (Box of 100\'s)','S1637','Safetelmi','MSN Laboratories Ltd.',0,0,0),('TELAM40MGXTAB4901546012011','Telmisartan , 40 mg   , Tablet , TASMI','TELAM','Telmisartan','40MGX','40 mg','TAB49','TABLET','01546','Blister Foil by 7\'s (Box of 14\'s)','T1611','Tasmi','Getz Pharma Pvt. Ltd.',0,0,0),('TELAM40MGXTAB4902360011542','Telmisartan , 40 mg , Tablet , ARBCAP','TELAM','Telmisartan','40MGX','40 mg','TAB49','TABLET','02360','Strip Foil by 10\'s (Box of 30\'s)','','Arbitel-40','Micro Labs Limited',0,0,0),('TELAM40MGXTAB4902711011975','Telmisartan , 40 mg , Tablet , MICARDIS','TELAM','Telmisartan','40MGX','40 mg','TAB49','TABLET','02711','Aluminum Blister x 10 Tablets (Box of 30\'s)','M0113','Micardis','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELAM40MGXTAB4902712011976','Telmisartan , 40 mg , Tablet , MICARDIS','TELAM','Telmisartan','40MGX','40 mg','TAB49','TABLET','02712','Aluminum Blister x 7 Tablets (Box of 28\'s)','M0113','Micardis','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELAM80MGXTAB2401205012092','Telmisartan , 80 mg , Tablet Film Coated , CARDISAR','TELAM','Telmisartan','80MGX','80 mg','TAB24','TABLET FILM COATED','01205','Alu/Alu Blister Pack x 10\'s (Box of 10\'s)','C2162','Cardisar','Surge Laboratories Pvt. Ltd.',0,0,0),('TELAM80MGXTAB4901546011543','Telmisartan , 80 mg , Tablet , ARBITEL-20','TELAM','Telmisartan','80MGX','80 mg','TAB49','TABLET','01553','Blister foil 100\'s (Box of 30\'s)','A2169','Arbitel-80','Micro Labs Limited',0,0,0),('TELAM80MGXTAB4901546012012','Telmisartan , 80 mg , Tablet , TASMI','TELAM','Telmisartan','80MGX','80 mg','TAB49','TABLET','01546','Blister Foil by 7\'s (Box of 14\'s)','T1611','Tasmi','Getz Pharma Pvt. Ltd.',0,0,0),('TELAM80MGXTAB49BP728002071','Telmisartan , 80 mg , Tablet , MICARDIS','TELAM','Telmisartan','80MGX','80 mg','TAB49','TABLET','02705','Aluminum Blister x 7 Tablets (Box of 28\'s)','M0113','Micardis','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELAM80MGXTAB49BPX30002072','Telmisartan , 80 mg , Tablet , MICARDIS','TELAM','Telmisartan','80MGX','80 mg','TAB49','TABLET','02959','Aluminum Blister x 10\'s (Box of 30\'s)','M0113','Micardis','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TELAM80MGXTAB49BSXXX002073','Telmisartan , 80 mg , Tablet , PRITOR','TELAM','Telmisartan','80MGX','80 mg','TAB49','TABLET','02958','Aluminum Blister Pack of 7\'s (Box of 28\'s)','P0106','Pritor','Boehringer Ingelheim Pharma GmbH & Co. KG',0,0,0),('TERAZ2GXXXTAB4900240011545','Terazosin , 2 g , Tablet , CONGESTAP','TERAZ','Terazosin','2GXXX','2 g','TAB49','TABLET','00240','10 Tablets/ Strip Foil (Box of 100\'s)','C2123','Congestap','Taiwan Biotech Co Ltd',0,0,0),('TERAZ2MGXXTAB4901250011544','Terazosin , 2 mg , Tablet , J.M. TOLMANN LABS., INC','TERAZ','Terazosin','2MGXX','2 mg','TAB49','TABLET','01250','Alu/Alu Blister pack x 8\'s (Box of 16\'s)','','','J.M. Tolmann Labs., Inc',0,0,0),('TERAZ5MGXXTAB49BP351005052','Terazosin , 5 mg , Tablet , J.M. TOLMANN LABS., INC','TERAZ','Terazosin','5MGXX','5 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','','','J.M. Tolmann Labs., Inc',0,0,0),('TERBU00005SOL1400982006205','Terbutaline , 0.0005 , Solution For Injection , PULMONYL , 60 mL Amber bottle','TERBU','Terbutaline','00005','0.0005','SOL14','SOLUTION FOR INJECTION','00982','60 mL Amber bottle','P0141','Pulmonyl','Euro-Med',0,0,0),('TERBU15MGMSYRUP00077011564','Terbutaline , 1.5 mg/5 mL , Syrup , BRYTOLIN , 1 mL Plastic ampul (5 ampuls per sachet)','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','00077','1 mL Plastic ampul (5 ampuls per sachet)','B0107','Brytolin','y.s.p. Industries (M) Sdn Bhd Malaysia',0,0,0),('TERBU15MGMSYRUP00348011547','Terbutaline , 1.5 mg/5 mL , Syrup , SCHEELE LABORATORIES PHILS INC. , 120 mL Amber bottle','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','00348','120 mL Amber bottle','','','Scheele Laboratories Phils Inc.',0,0,0),('TERBU15MGMSYRUP00982011550','Terbutaline , 1.5 mg/5 mL , Syrup , SCHEELE LABORATORIES PHILS INC. , 60 mL Amber bottle','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','Scheele Laboratories Phils Inc.',0,0,0),('TERBU15MGMSYRUP00982011551','Terbutaline , 1.5 mg/5 mL , Syrup , ASIA PACIFIC HEALTHCARE , 60 mL Amber bottle','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','','','Asia Pacific Healthcare',0,0,0),('TERBU15MGMSYRUP01063011562','Terbutaline , 1.5 mg/5 mL , Syrup , BRICANYL , 60 mL Plastic bottle','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','01063','60 mL Plastic bottle','B2075','Bricanyl','Interphil',0,0,0),('TERBU15MGMSYRUP01844011553','Terbutaline , 1.5 mg/5 mL , Syrup , DRUGMAKERS BIOTECH , Clear ampul (Box of 10\'s)','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','01844','Clear ampul (Box of 10\'s)','','','Drugmakers Biotech',0,0,0),('TERBU15MGMSYRUP120AM003068','Terbutaline , 1.5 mg/5 mL , Syrup , TERMABRON , 120 mL Amber bottle','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','120AM','120 mL Amber bottle','T0040','Termabron','Swiss Pharma',0,0,0),('TERBU15MGMSYRUP60AMB003065','Terbutaline , 1.5 mg/5 mL , Syrup , TERBUSOL , 60 mL Amber bottle','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','T0039','Terbusol','San Marino',0,0,0),('TERBU15MGMSYRUP60AMB003069','Terbutaline , 1.5 mg/5 mL , Syrup , TERMABRON , 60 mL Amber bottle','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','60AMB','60 mL Amber bottle','T0040','Termabron','Swiss Pharma',0,0,0),('TERBU15MGMSYRUPAMPUL002843','Terbutaline , 1.5 mg/5 mL , Syrup , PULMOXCEL , Ampule','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','AMPUL','Ampule','P0143','Pulmoxcel','Hizon Labs., Inc.',0,0,0),('TERBU15MGMSYRUPBR560005140','Terbutaline , 1.5 mg/5 mL , Syrup , ALLOXYGEN , 60 mL Boston Round Amber bottle','TERBU','Terbutaline','15MGM','1.5 mg/5 mL','SYRUP','SYRUP','BR560','60 mL Boston Round Amber bottle','A0061','Alloxygen','Gruppo',0,0,0),('TERBU25MGLSOL3260AMB002844','Terbutaline , 2.5 mg /mL , Solution , PULMOXCEL , 60 mL Amber bottle','TERBU','Terbutaline','25MGL','2.5 mg /mL','SOL32','SOLUTION','60AMB','60 mL Amber bottle','P0143','Pulmoxcel','Hizon',0,0,0),('TERBU25MGLSOL34120AM002841','Terbutaline , 2.5 mg /mL , Solution For Nebulization , PULMONYL , 120 mL Amber bottle','TERBU','Terbutaline','25MGL','2.5 mg /mL','SOL34','SOLUTION FOR NEBULIZATION','120AM','120 mL Amber bottle','P0141','Pulmonyl','Euro-Med Labs Phils Inc',0,0,0),('TERBU25MGLSOL3460AMB002842','Terbutaline , 2.5 mg /mL , Solution For Nebulization , PULMONYL , 60 mL Amber bottle','TERBU','Terbutaline','25MGL','2.5 mg /mL','SOL34','SOLUTION FOR NEBULIZATION','60AMB','60 mL Amber bottle','P0141','Pulmonyl','Euro-Med Labs Phils Inc',0,0,0),('TERBU25PGMTAB4901647007095','Terbutaline , 2.5 mg , Tablet , TERBUMAX','TERBU','Terbutaline','25PGM','2.5 mg','TAB49','TABLET','01647','Blister pack x 10\'s (Box of 100\'s)','T0038','Terbumax','Swiss Pharma',0,0,0),('TERBU25PGMTAB4901684011552','Terbutaline , 2.5 mg , Tablet , SWISS PHARMA','TERBU','Terbutaline','25PGM','2.5 mg','TAB49','TABLET','BP20H','Blister pack x 20\'s (Box of 100\'s)','','','Swiss Pharma',0,0,0),('TERBU25PGMTAB4901924011554','Terbutaline , 2.5 mg , Tablet , SCHEELE','TERBU','Terbutaline','25PGM','2.5 mg','TAB49','TABLET','01924','Clear PVC/Aluminum Foil Blister Strip 5 x 20\'s (Box of 100\'s)','','','Scheele',0,0,0),('TERBU25PGMTAB4902002011555','Terbutaline , 2.5 mg , Tablet , AM-EUROPHARMA CORP','TERBU','Terbutaline','25PGM','2.5 mg','TAB49','TABLET','FSTRI','Foil strip','','','Am-Europharma Corp',0,0,0),('TERBU25PGMTAB4902045007747','Terbutaline , 2.5 mg , Tablet , VENTRYL','TERBU','Terbutaline','25PGM','2.5 mg','TAB49','TABLET','02045','Foil strip x 10 (Box of 100\'s)','V0037','Ventryl','New Myrex Lab',0,0,0),('TERBU25PGMTAB49BP20H002230','Terbutaline , 2.5 mg , Tablet , NULL','TERBU','Terbutaline','25PGM','2.5 mg','TAB49','TABLET','BP20H','Blister pack of 20s (Box of 100s)','','','New Myrex Labs',0,0,0),('TERBU25PGMTAB49BP351003410','Terbutaline , 2.5 mg , Tablet , BENUVIT-C','TERBU','Terbutaline','25PGM','2.5 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','B2022','Benuvit-C','San Marino',0,0,0),('TERBU25PGMTAB49BP351005054','Terbutaline , 2.5 mg , Tablet , SCHEELE','TERBU','Terbutaline','25PGM','2.5 mg','TAB49','TABLET','BP351','Blister pack x 10\'s (box of 100\'s )','','','Scheele',0,0,0),('TERBU25PGMTAB49BPXXX003458','Terbutaline , 2.5 mg , Tablet , BLIPHICON','TERBU','Terbutaline','25PGM','2.5 mg','TAB49','TABLET','BPXXX','Blister pack','B2063','Bliphicon','Swiss Pharma',0,0,0),('TERBU5HMCGSOL1400384011561','Terbutaline , 500 mcg/mL , Solution For Injection , BRENALAX , 15 g Aluminum Tube','TERBU','Terbutaline','5HMCG','500 mcg/mL','SOL14','SOLUTION FOR INJECTION','00384','15 g Aluminum Tube','B2074','Brenalax','CENEXI',0,0,0),('TERBU5HMCGSOL1400982011560','Terbutaline , 500 mcg/mL , Solution For Injection , BRENAL , 60 mL Amber bottle','TERBU','Terbutaline','5HMCG','500 mcg/mL','SOL14','SOLUTION FOR INJECTION','00982','60 mL Amber bottle','B0091','Brenal','L.B.S. Laboratory ltd. Part',0,0,0),('TERBU5MGXXCAPSU02002011556','Terbutaline , 5 mg , Capsule , DRUGMAKERS','TERBU','Terbutaline','5MGXX','5 mg','CAPSU','CAPSULE','FSTRI','Foil strip','','','Drugmakers',0,0,0),('TETR2250MGCAPSU01406011566','Tetracycline , 250 mg , Capsule , DRUGMAKERS','TETR2','Tetracycline','250MG','250 mg','CAPSU','CAPSULE','01406','Alum Foil x 5\'s (Box of 15\'s)','','','Drugmakers',0,0,0),('TETR2250MGCAPSUBP351005055','Tetracycline , 250 mg , Capsule , AMHERST','TETR2','Tetracycline','250MG','250 mg','CAPSU','CAPSULE','BP351','Blister pack x 10\'s (box of 100\'s )','','','Amherst',0,0,0),('TETR2500MGCAPSU01495011567','Tetracycline , 500 mg , Capsule , AMHERST LABS INC','TETR2','Tetracycline','500MG','500 mg','CAPSU','CAPSULE','01495','Amber bottle 100\'s','','','Amherst Labs Inc',0,0,0),('TETR2500MGCAPSU01991011569','Tetracycline , 500 mg , Capsule , JM TOLMANN','TETR2','Tetracycline','500MG','500 mg','CAPSU','CAPSULE','01991','Foi strip x 4\'s (Box of 100\'s)','','','JM Tolmann',0,0,0),('TETR2500MGCAPSU02074011570','Tetracycline , 500 mg , Capsule , SYDENHAM LABORATORIES, INC.','TETR2','Tetracycline','500MG','500 mg','CAPSU','CAPSULE','02074','Foil strip x 4\'s (Box of 100\'s)','','','Sydenham Laboratories, Inc.',0,0,0),('TETR2500MGCAPSUBP10X005059','Tetracycline , 500 mg , Capsule , J.M. TOLMANN LABS., INC','TETR2','Tetracycline','500MG','500 mg','CAPSU','CAPSULE','BP10X','Blister pack x 10','','','J.M. Tolmann Labs., Inc',0,0,0),('TETR2500MGCAPSUFSTRI002612','Tetracycline , 500 mg , Capsule , METRINOX IV','TETR2','Tetracycline','500MG','500 mg','CAPSU','CAPSULE','FSTRI','Foil strip','M0093','Metrinox Iv','Virgo',0,0,0),('THEO1130MGTAB4902637011572','Theophylline (Anhydrous) , 130 mg , Tablet , ASMAREX','THEO1','Theophylline (anhydrous)','130MG','130 mg','TAB49','TABLET','02637','Wide Mouthed Plastic Container of 100\'s','A0181','Asmarex','United Labs Inc.',0,0,0),('THIA1100MGTAB4901501011574','Thiamine (Hydrochloride) , 100 mg , Tablet , GENERAL DRUG & CHEM','THIA1','Thiamine (hydrochloride)','100MG','100 mg','TAB49','TABLET','01501','Amber Bottle of 100\'s','','','General Drug & Chem',0,0,0),('THIAM10MGXTAB4901684012003','Thiamazole , 10 mg , Tablet , STRUMAZOL','THIAM','Thiamazole','10MGX','10 mg','TAB49','TABLET','01684','Blister Pack x 20\'s (Box of 100\'s)','S0155','Strumazol','Nycomed Christians, N.V.',0,0,0),('THIAM10MGXTAB4902706012002','Thiamazole , 10 mg , Tablet , STRUMAZOL','THIAM','Thiamazole','10MGX','10 mg','TAB49','TABLET','02706','Alu/PVC Blister Pack by 20\'s (Box of 100\'s)','S0155','Strumazol','Nycomed Christiaens',0,0,0),('THIAM30MG5TAB49BPX30002413','Thiamazole , 30mg/5mL , Tablet , STRUMAZOL','THIAM','Thiamazole','30MGX','30 mg','TAB49','TABLET','01654','Blister Pack x 10\'s (Box of 30\'s)','S0155','Strumazol','Nycomed Christiaens, N.V.',0,0,0),('TOBR13MGMLSUSP200882006142','Tobramycin + Dexamethasone , 3 mg/mL , Suspension Drops , DUAVENT , 5 mL White LDPE Plastic Bottle','TOBR1','Tobramycin + Dexamethasone','3MGML','3 mg/mL','SUSP2','SUSPENSION DROPS','00882','5 mL White LDPE Plastic Bottle','D2130','Duavent','Pascual',0,0,0),('TOBRA40MGMSOL1400855011575','Tobramycin , 40 mg/mL , Solution For Injection , KOREA UNITED PHARM (KOREA) , 5 mL LDPE Plastic Container','TOBRA','Tobramycin','40MGM','40 mg/mL','SOL14','SOLUTION FOR INJECTION','00855','5 mL LDPE Plastic Container','','','Korea United Pharm (Korea)',0,0,0),('TOLN11511MCREA302815011658','Tolnaftate + Betamethasone + Gentamicin Clioquinol , 10 mg + 500 mcg + 1 mg + 10 mg , Cream , QUADRIDERM CREAM , Collapsible Aluminum Tube of 10 g (Box of 1\'s)','TOLN1','Tolnaftate + Betamethasone + Gentamicin Clioq','1511M','10 mg + 500 mcg + 1 mg + 10 mg','CREA3','CREAM','02815','Collapsible Aluminum Tube of 10 g (Box of 1\'s)','Q1515','Quadriderm Cream','Schering-Plough S.A.',0,0,0),('TOLN11511MCREA302816011659','Tolnaftate + Betamethasone + Gentamicin Clioquinol , 10 mg + 500 mcg + 1 mg + 10 mg , Cream , QUADRIDERM CREAM , Collapsible Aluminum Tube of 15 g (Box of 1\'s)','TOLN1','Tolnaftate + Betamethasone + Gentamicin Clioq','1511M','10 mg + 500 mcg + 1 mg + 10 mg','CREA3','CREAM','02816','Collapsible Aluminum Tube of 15 g (Box of 1\'s)','Q1515','Quadriderm Cream','Schering-Plough S.A.',0,0,0),('TOLN11511MCREA302817011660','Tolnaftate + Betamethasone + Gentamicin Clioquinol , 10 mg + 500 mcg + 1 mg + 10 mg , Cream , QUADRIDERM CREAM , Collapsible Aluminum Tube of 5 g (Box of 1\'s)','TOLN1','Tolnaftate + Betamethasone + Gentamicin Clioq','1511M','10 mg + 500 mcg + 1 mg + 10 mg','CREA3','CREAM','02817','Collapsible Aluminum Tube of 5 g (Box of 1\'s)','Q1515','Quadriderm Cream','Schering-Plough S.A.',0,0,0),('TOLNA000P1CREA300381011576','Tolnaftate , 0.01 , Cream , DRUGMAKERS','TOLNA','Tolnaftate','000P1','0.01','CREA3','CREAM','00381','15 g Alum Tube','','','Drugmakers',0,0,0),('TOLNA000P1CREA300798011577','Tolnaftate , 0.01 , Cream , DRUGMAKERS','TOLNA','Tolnaftate','000P1','0.01','CREA3','CREAM','00798','5 g Alum Tube','','','Drugmakers',0,0,0),('TOLNA10MGGOINTX00725011580','Tolnaftate , 10 mg/g , Ointment , DERMABLEND','TOLNA','Tolnaftate','10MGG','10 mg/g','OINTX','OINTMENT','00725','30 g Luminated plastic tube','D2031','Dermablend','Interphil Labs Inc',0,0,0),('TOLNA110MGCREA300386011666','Tolnaftate , 1 % (10 mg/ g) , Cream , TOLNADERM , Collapsible Aluminum Tube x 15 g','TOLNA','Tolnaftate','110MG','1 % (10 mg/ g)','CREA3','CREAM','00386','Collapsible Aluminum Tube x 15 g','T1598','Tolnaderm','HOE Pharmaceuticals Sdn Bhd.',0,0,0),('TOLNA110MGCREA300806011667','Tolnaftate , 1 % (10 mg/ g) , Cream , TOLNADERM , Collapsible Aluminum Tube x 5 g','TOLNA','Tolnaftate','110MG','1 % (10 mg/ g)','CREA3','CREAM','00806','Collapsible Aluminum Tube x 5 g','T1599','Tolnaderm','HOE Pharmaceuticals Sdn Bhd.',0,0,0),('TOLNA1PXXXCREA300813011578','Tolnaftate , 1% , Cream , INTERPHIL','TOLNA','Tolnaftate','1PXXX','1%','CREA3','CREAM','00813','5 g Tube','','','Interphil',0,0,0),('TOLNA1XPXXCREA302722011663','Tolnaftate , 1% , Cream , TINACTIN , Aluminum Tube  (.5 g)','TOLNA','Tolnaftate','1XPXX','1%','CREA3','CREAM','02722','Aluminum Tube  (.5 g)','T1597','Tinactin','Schering-Plough Labs. N.V.',0,0,0),('TOLNA1XPXXCREA302723011664','Tolnaftate , 1% , Cream , TINACTIN , Aluminum Tube  (10 g)','TOLNA','Tolnaftate','1XPXX','1%','CREA3','CREAM','02723','Aluminum Tube  (10 g)','T1597','Tinactin','Schering-Plough Labs. N.V.',0,0,0),('TOLNA1XPXXCREA302724011665','Tolnaftate , 1% , Cream , TINACTIN , Aluminum Tube  (15 g)','TOLNA','Tolnaftate','1XPXX','1%','CREA3','CREAM','02724','Aluminum Tube  (15 g)','T1598','Tinactin','Schering-Plough Labs. N.V.',0,0,0),('TOPIR100MGTAB2401566007002','Topiramate , 100 mg , Tablet Film Coated , EPINEX','TOPIR','Topiramate','100MG','100 mg','TAB24','TABLET FILM COATED','01566','Blister pack (Aluminum and PVDC Foil) x 10\'s; Box of 30\'s','E2068','Epinex','Micro Labs',0,0,0),('TOPIR100MGTAB4901161006572','Topiramate , 100 mg , Tablet , EPILANZ-10','TOPIR','Topiramate','100MG','100 mg','TAB49','TABLET','01161','Alu/Alu Blister 6 x10\'s (Box of 60\'s)','E2063','Epilanz-10','Torrent Pharmaceuticals Ltd',0,0,0),('TOPIR100MGTAB49BPX30002103','Topiramate , 100 mg , Tablet , NULL','TOPIR','Topiramate','100MG','100 mg','TAB49','TABLET','BPX30','Blister Pack of 10s (Box of 30s)','','','Hilton Pharma Pvt Ltd',0,0,0),('TOPIR25MGXTAB4901180006591','Topiramate , 25 mg , Tablet , EPILEPTIN','TOPIR','Topiramate','25MGX','25 mg','TAB49','TABLET','01180','Alu/Alu Blister pack of 10\'s (Box of 100\'s)','E2064','Epileptin','Torrent Pharmaceuticals Ltd',0,0,0),('TOPIR50MGXTAB2401288006739','Topiramate , 50 mg , Tablet Film Coated , EPI-PEEL SYSTEM LEVEL 1','TOPIR','Topiramate','50MGX','50 mg','TAB24','TABLET FILM COATED','01288','Alu/Alu Foil Blister x 10\'s (Box of 30\'s)','E2069','Epi-Peel System Level 1','Micro Labs',0,0,0),('TOPIR50MGXTAB4901180006593','Topiramate , 50 mg , Tablet , EPIMATE-100','TOPIR','Topiramate','50MGX','50 mg','TAB49','TABLET','01180','Alu/Alu Blister pack of 10\'s (Box of 100\'s)','E2065','Epimate-100','Torrent Pharmaceuticals Ltd',0,0,0),('TRAMA100MGTAB2201386006848','Tramadol , 100 mg , Tablet Extended Release , DUROMINE','TRAMA','Tramadol','100MG','100 mg','TAB22','TABLET EXTENDED RELEASE','01386','Alu/PVC/PVDC White Opaque Blister pack x 10\'s (Box of 30\'s)','D2141','Duromine','Laboratoires Confab Inc',0,0,0),('TRAMA50MGMSOL1400062011581','Tramadol , 50 mg/mL , Solution For Injection , SHIJIAZHUANG PHARMACEUTICAL GROUP , 1 mL Ampul','TRAMA','Tramadol','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00062','1 mL Ampul','','','Shijiazhuang Pharmaceutical Group',0,0,0),('TRAMA50MGMSOL1400490005853','Tramadol , 50 mg/mL , Solution For Injection , DOLFENAL , 2 mL Colorless ampul (Box of 10\'s)','TRAMA','Tramadol','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00490','2 mL Colorless ampul (Box of 10\'s)','D0090','Dolfenal','Plethico Pharma\'l Ltd',0,0,0),('TRAMA50MGMSOL1400516011582','Tramadol , 50 mg/mL , Solution For Injection , EURO-MED LABS. PHILS. INC. , 2 mL Type I colorless glass ampul (Box of 5\'s)','TRAMA','Tramadol','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00516','2 mL Type I colorless glass ampul (Box of 5\'s)','','','Euro-Med Labs. Phils. Inc.',0,0,0),('TRAMA50MGMSOL1400541005889','Tramadol , 50 mg/mL , Solution For Injection , PEPTIMAX , 2 mL USP Type I Clear Ampul','TRAMA','Tramadol','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00541','2 mL USP Type I Clear Ampul','P0052','Peptimax','Shinpoong Pharm. Co. LTd.',0,0,0),('TRAMA50MGMSOL1400886011583','Tramadol , 50 mg/mL , Solution For Injection , WINDLAS BIOTECH LTD , 50 mg/mL x 2 mL ampul (Box of 5\'s)','TRAMA','Tramadol','50MGM','50 mg/mL','SOL14','SOLUTION FOR INJECTION','00886','50 mg/mL x 2 mL ampul (Box of 5\'s)','','','Windlas Biotech Ltd',0,0,0),('TRAMA50MGMSOL3200474011589','Tramadol , 50 mg/mL , Solution , ANALGEN , 2 mL Ampul x 10\'s','TRAMA','Tramadol','50MGM','50 mg/mL','SOL32','SOLUTION','00474','2 mL Ampul x 10\'s','A2125','Analgen','Samjin Pharm. Co Ltd',0,0,0),('TRAMA50MGMSOL3200519011590','Tramadol , 50 mg/mL , Solution , CLOGEN , 2 mL Type I glass ampul (Box of 10\'s)','TRAMA','Tramadol','50MGM','50 mg/mL','SOL32','SOLUTION','00519','2 mL Type I glass ampul (Box of 10\'s)','C0174','Clogen','Mount Mettur Pharmaceuticals Ltd',0,0,0),('TRAMA50MGMSOL32011584','Tramadol , 50 mg/mL , Solution , KARNATAKA ANTIBIOTIS & PHARMACEUTICALS LTD , ampul 10/ box x 10 boxes','TRAMA','Tramadol','50MGM','50 mg/mL','SOL32','SOLUTION','02975','ampul 10/ box x 10 boxes','','','Karnataka Antibiotis & Pharmaceuticals Ltd',0,0,0),('TRAMA50MGXCAPSU01658011586','Tramadol , 50 mg , Capsule , DRUGMAKER\'S LABS INC','TRAMA','Tramadol','50MGX','50 mg','CAPSU','CAPSULE','01658','Blister Pack x 10\'s (Box of 60\'s)','','','Drugmaker\'s Labs Inc',0,0,0),('TRAMA50MGXCAPSUB10SH002186','Tramadol , 50 mg , Capsule , DRUGMAKER\'S LABS','TRAMA','Tramadol','50MGX','50 mg','CAPSU','CAPSULE','B10SH','Blister pack of 10s (Box of 100s)','','','Drugmaker\'s Labs',0,0,0),('TRAMA50MGXCAPSUB10SH003909','Tramadol , 50 mg , Capsule , DOLEXPEL','TRAMA','Tramadol','50MGX','50 mg','CAPSU','CAPSULE','B10SH','Blister pack of 10s (Box of 100s)','D0089','Dolexpel','Bangkok Lab and Cosmetic Co Ltd',0,0,0),('TRAMA50MGXCAPSUBP351003916','Tramadol , 50 mg , Capsule , DOLOTRAL','TRAMA','Tramadol','50MGX','50 mg','CAPSU','CAPSULE','BP351','Blister pack x 10\'s (box of 100\'s )','D2106','Dolotral','Unichem Labs.',0,0,0),('TRAMA50MGXCAPSUBP351005061','Tramadol , 50 mg , Capsule , CENTURION LABS','TRAMA','Tramadol','50MGX','50 mg','CAPSU','CAPSULE','BP351','Blister pack x 10\'s (box of 100\'s )','','','Centurion Labs',0,0,0),('TRAMA50MGXTAB4901365006824','Tramadol , 50 mg , Tablet , DOLPAZ','TRAMA','Tramadol','50MGX','50 mg','TAB49','TABLET','01365','Alu/PVC Blister pack x 10\'s (Box of 100\'s)','D2107','Dolpaz','Lloyd Labs Inc',0,0,0),('TRANE100GLSOL1400837006116','Tranexamic Acid , 100 mg/mL , Solution For Injection , EMES , 5 mL Clear glass ampul (Box of 5\'s)','TRANE','Tranexamic Acid','100GL','100 mg/mL','SOL14','SOLUTION FOR INJECTION','00837','5 mL Clear glass ampul (Box of 5\'s)','E2035','Emes','Windlas Biotech Ltd',0,0,0),('TRANE100GLSOL1400837006117','Tranexamic Acid , 100 mg/mL , Solution For Injection , FEXORAL , 5 mL Clear glass ampul (Box of 5\'s)','TRANE','Tranexamic Acid','100GL','100 mg/mL','SOL14','SOLUTION FOR INJECTION','00837','5 mL Clear glass ampul (Box of 5\'s)','F2055','Fexoral','Oriental Chemical Works, Inc',0,0,0),('TRANE100GLSOL1402100011595','Tranexamic Acid , 100 mg/mL , Solution For Injection , C-VEX , Glass ampul','TRANE','Tranexamic Acid','100GL','100 mg/mL','SOL14','SOLUTION FOR INJECTION','02100','Glass ampul','C2158','C-Vex','Shin Poong Pharm. Co',0,0,0),('TRANE1H5MGSOL38002406','Tranexamic Acid , 100 mg/mL (500 mg/5 mL) , Solution For Injection (Iv) , EMIROX , 5ml clear colorless ampul (box of 5\'s)','TRANE','Tranexamic Acid','1H5MG','100 mg/mL (500 mg/5 mL)','SOL38','SOLUTION FOR INJECTION (IV)','03084','5 mL clear colorless ampul (box of 5\'s)','E0120','Emirox','',0,0,0),('TRANE250MGCAPSUB10SH003718','Tranexamic Acid , 250 mg , Capsule , CLOTTINEX','TRANE','Tranexamic Acid','250MG','250 mg','CAPSU','CAPSULE','B10SH','Blister pack of 10s (Box of 100s)','C2088','Clottinex','Lloyd Laboratories Inc.',0,0,0),('TRANE500MGCAPSU01913011594','Tranexamic Acid , 500 mg , Capsule , CLOTTAM','TRANE','Tranexamic Acid','500MG','500 mg','CAPSU','CAPSULE','01913','Clear PVC/Aluminum blister strip','C2087','Clottam','Lloyd',0,0,0),('TRANE500MGCAPSUB10SH005067','Tranexamic Acid , 500 mg , Capsule , SWISS PHARMA RESEARCH LABS INC','TRANE','Tranexamic Acid','500MG','500 mg','CAPSU','CAPSULE','B10SH','Blister pack of 10s (Box of 100s)','','','Swiss Pharma Research Labs Inc',0,0,0),('TRANE500MGCAPSUBP351003716','Tranexamic Acid , 500 mg , Capsule , CLOTIGEN','TRANE','Tranexamic Acid','500MG','500 mg','CAPSU','CAPSULE','BP351','Blister pack x 10\'s (box of 100\'s )','C2086','Clotigen','Lloyd',0,0,0),('TRANE500MGCAPSUBP351005068','Tranexamic Acid , 500 mg , Capsule , SYDENHAM LABS. INC.','TRANE','Tranexamic Acid','500MG','500 mg','CAPSU','CAPSULE','BP351','Blister pack x 10\'s (box of 100\'s )','','','Sydenham Labs. Inc.',0,0,0),('TRANE500MGCAPSUBPTCH005066','Tranexamic Acid , 500 mg , Capsule , LLOYD LABS INC','TRANE','Tranexamic Acid','500MG','500 mg','CAPSU','CAPSULE','BPTCH','Blister pack x 10 (Box of 100\'s)','','','Lloyd Labs Inc',0,0,0),('TRANE500MGSOL1400845011591','Tranexamic Acid , 500 mg , Solution For Injection , WINDLAS BIOTECH LTD , 5 mL Glass ampul (2 Blister pack x 5\'s of Type I Glass ampul ) (Box of 10\'s)','TRANE','Tranexamic Acid','500MG','500 mg','SOL14','SOLUTION FOR INJECTION','00845','5 mL Glass ampul (2 Blister pack x 5\'s of Type I Glass ampul ) (Box of 10\'s)','','','Windlas Biotech Ltd',0,0,0),('TRANE50MGXSOL145MLAM005065','Tranexamic Acid , 50 mg , Solution For Injection , CHINA CHEMICAL & PHARMACEUTICAL CO. LTD , 5 mL ampul','TRANE','Tranexamic Acid','50MGX','50 mg','SOL14','SOLUTION FOR INJECTION','5MLAM','5 mL ampul','','','China Chemical & Pharmaceutical Co. Ltd',0,0,0),('TRANE5HMG5SOL1400835006115','Tranexamic Acid , 500 mg/5 mL , Solution For Injection , MEVENTIL , 5 mL Clear Colorless Glass ampul (Box of 5\'s)','TRANE','Tranexamic Acid','5HMG5','500 mg/5 mL','SOL14','SOLUTION FOR INJECTION','00835','5 mL Clear Colorless Glass ampul (Box of 5\'s)','M0109','Meventil','Korea United Phar Inc. (Korea)',0,0,0),('TRETI00005GELXX00650011599','Tretinoin , 0.0005 , Gel , DERMACTIN','TRETI','Tretinoin','00005','0.0005','GELXX','GEL','00650','25 g Metal Tube','D2032','Dermactin','MCB Dermatological Products',0,0,0),('TRETI0025PCREA300136011596','Tretinoin , 0.025% , Cream , DRUGMAKERS BIOTECH','TRETI','Tretinoin','0025P','0.025%','CREA3','CREAM','00136','10 g Aluminum Tube','','','Drugmakers Biotech',0,0,0),('TRETI05MGGCREA301834011597','Tretinoin , 0.5 mg/g , Cream , GRUPPO MEDICA INC','TRETI','Tretinoin','05MGG','0.5 mg/g','CREA3','CREAM','01834','Box x 20 g aluminum tube','','','Gruppo Medica Inc',0,0,0),('TRIAM40MGMSUSP700857011600','Triamcinolone , 40 mg/mL , Suspension Injection , AUROBLUE , 5 mL LDPE white plastic bottle','TRIAM','Triamcinolone','40MGM','40 mg/mL','SUSP7','SUSPENSION INJECTION','00857','5 mL LDPE white plastic bottle','A2210','Auroblue','Aurolab',0,0,0),('TRIAM4MGMLSUSP700091011601','Triamcinolone , 4 mg/mL , Suspension Injection , CHRISOLOP , 1 mL vial','TRIAM','Triamcinolone','4MGML','4 mg/mL','SUSP7','SUSPENSION INJECTION','00091','1 mL vial','C0085','Chrisolop','SM Pharmaceuticals Sdn Bhd',0,0,0),('TRIM120MGXTAB2401193012069','Trimetazidine Dihydrochloride , 20 mg , Tablet Film Coated , ANGIREL','TRIM1','Trimetazidine Dihydrochloride','20MGX','20 mg','TAB24','TABLET FILM COATED','01193','Alu/Alu Blister Pack x 10\'s (Box of 100\'s)','A1841','Angirel','Unison Laboratories Co. Ltd.',0,0,0),('TRIM120MGXTAB2401208012155','Trimetazidine (As Dihydrochloride) , 20 mg  , Tablet Film Coated , PREDU-XL','TRIM1','Trimetazidine (as Dihydrochloride)','20MGX','20 mg','TAB24','TABLET FILM COATED','01208','Alu/Alu Blister Pack x 10\'s (Box of 30\'s)','P1613','Predu-XL','XL Laboratories Pvt. Ltd.',0,0,0),('TRIM120MGXTAB2401451012173','Trimetazidine Dihydrochloride , 20 mg , Tablet Film Coated , VASOTRATE-D','TRIM1','Trimetazidine Dihydrochloride','20MGX','20 mg','TAB24','TABLET FILM COATED','01451','Aluminum Strip Foil of 10\'s (Box of 100 Film Coated Tablets)','V1582','Vasotrate-D','Torrent Pharmaceuticals Ltd.',0,0,0),('TRIM120MGXTAB2401652012175','Trimetazidine Dihydrochloride , 20 mg , Tablet Film Coated , VASSAPRO','TRIM1','Trimetazidine Dihydrochloride','20MGX','20 mg','TAB24','TABLET FILM COATED','01652','Blister Pack x 10\'s (Box of 20\'s)','V1583','Vassapro','Lloyd Laboratories, Inc.',0,0,0),('TRIM120MGXTAB2401658012164','Trimetazidine Dihydrochloride , 20 mg , Tablet Film Coated , TAZZ','TRIM1','Trimetazidine Dihydrochloride','20MGX','20 mg','TAB24','TABLET FILM COATED','01658','Blister Pack x 10\'s (Box of 60\'s)','T1621','Tazz','Orchid Healthcare',0,0,0),('TRIM120MGXTAB2402721012174','Trimetazidine Dihydrochloride , 20 mg , Tablet Film Coated , VASOTRATE-D','TRIM1','Trimetazidine Dihydrochloride','20MGX','20 mg','TAB24','TABLET FILM COATED','02721','Aluminum Strip Foil of 10\'s (Box of 30 Film Coated Tablets)','V1582','Vasotrate-D','Torrent Pharmaceuticals Ltd.',0,0,0),('TRIM120MGXTAB4902055011913','Trimetazidine Dihydrochloride , 20 mg , Tablet , ANGIMAX','TRIM1','Trimetazidine Dihydrochloride','20MGX','20 mg','TAB49','TABLET','02055','Foil Strip x 10\'s (Box of 100\'s)','A1839','Angimax','Hizon Laboratories. Inc.',0,0,0),('TRIM135MGXTAB5202356012190','Trimetazidine Dihydrochloride , 35 mg , Tablet Modified Release , ANGIMAX MR','TRIM1','Trimetazidine Dihydrochloride','35MGX','35 mg','TAB52','TABLET MODIFIED RELEASE','02356','Strip Foil x 10\'s (Box of 100\'s)','A1840','Angimax MR','E.L. Laboratories, Inc.',0,0,0),('TRIM235MGXTAB2401205012166','Trimetazidine (As Hydrochloride) , 35 mg , Tablet Film Coated , TRIMECARD MR 35','TRIM2','Trimetazidine (as Hydrochloride)','35MGX','35 mg','TAB24','TABLET FILM COATED','01205','Alu/Alu Blister Pack x 10\'s (Box of 10\'s)','T1601','Trimecard MR 35','Rainbow Life Sciences Pvt. Ltd.',0,0,0),('TRIME20MGXTAB4902055012026','Trimetazidine , 20 mg , Tablet , VASTAREL 20','TRIME','Trimetazidine','20MGX','20 mg','TAB49','TABLET','02055','Foil Strip x 10\'s (Box of 100\'s)','V1584','Vastarel 20','Les Laboratories Servier Industrie',0,0,0),('TRIME20MGXTAB4902356011966','Trimetazidine , 20 mg , Tablet , LONGITY','TRIME','Trimetazidine','20MGX','20 mg','TAB49','TABLET','02356','Strip Foil x 10\'s (Box of 100\'s)','L1579','Longity','Micro Labs., Ltd.',0,0,0),('TRIME35MGXTAB4901701012027','Trimetazidine , 35 mg , Tablet , VASTAREL MR','TRIME','Trimetazidine','35MGX','35 mg','TAB49','TABLET','01701','Blister Pack x 30\'s (Box of 60 Tablets)','V1585','Vastarel MR','Les Laboratories Servier Industrie',0,0,0),('TRIME35MGXTAB5201689012192','Trimetazidine , 35 mg , Tablet Modified Release , VESTAR','TRIME','Trimetazidine','35MGX','35 mg','TAB52','TABLET MODIFIED RELEASE','01689','Blister Pack x 20\'s (Box of 60\'s)','V1586','Vestar','Amherst Laboratories, Inc.',0,0,0),('VALPR100GLSOL1402143011603','Valproic Acid , 100 mg/mL , Solution For Injection , DENTOFEN , HDPE Bottle x 60\'s','VALPR','Valproic Acid','100GL','100 mg/mL','SOL14','SOLUTION FOR INJECTION','02143','HDPE Bottle x 60\'s','D0029','Dentofen','Hospira',0,0,0),('VALPR250M5SYRUP00848011602','Valproic Acid , 250 mg/5 mL , Syrup , ALEPTIZ , 5 mL Glass Vial (Box of 10\'s)','VALPR','Valproic Acid','250M5','250 mg/5 mL','SYRUP','SYRUP','00848','5 mL Glass Vial (Box of 10\'s)','A2077','Aleptiz','Apotex Inc. (Canada)',0,0,0),('VALPR250M5SYRUP02133011604','Valproic Acid , 250 mg/5 mL , Syrup , DEPACON , HDPE bottle of 100\'s','VALPR','Valproic Acid','250M5','250 mg/5 mL','SYRUP','SYRUP','02133','HDPE bottle of 100\'s','D2021','Depacon','P.T. Abbott Indonesia',0,0,0),('VANCO1GRAMPOW1300940006183','Vancomycin , 1 gram , Powder For Injection Solution , KATHREX','VANCO','Vancomycin','1GRAM','1 gram','POW13','POWDER FOR INJECTION SOLUTION','00940','500 mg Glass vial (Box of 1\'s)','K0004','Kathrex','Swiss Parenterals Ltd.',0,0,0),('VANCO500MGPOW1301224011606','Vancomycin , 500 mg , Powder For Injection Solution , ALKEM LABORATORIES LTD','VANCO','Vancomycin','500MG','500 mg','POW13','POWDER FOR INJECTION SOLUTION','01224','Alu/Alu Blister pack x 14\'s (Box of 28\'s)','','','Alkem Laboratories Ltd',0,0,0),('VANCO500MGPOW1301880007567','Vancomycin , 500 mg , Powder For Injection Solution , KATHREX','VANCO','Vancomycin','500MG','500 mg','POW13','POWDER FOR INJECTION SOLUTION','01880','Clear glass USP Type III vial','K0004','Kathrex','Swiss Parenterals Ltd.',0,0,0),('VANCO500MGPOW1302440011608','Vancomycin , 500 mg , Powder For Injection Solution , ALKEM LABS LTD','VANCO','Vancomycin','500MG','500 mg','POW13','POWDER FOR INJECTION SOLUTION','02440','Type III clear & colorless glass vial (Box of 10\'s)','','','Alkem Labs Ltd',0,0,0),('VANCO500MGPOW1302486008233','Vancomycin , 500 mg , Powder For Injection Solution , ECOZAR','VANCO','Vancomycin','500MG','500 mg','POW13','POWDER FOR INJECTION SOLUTION','02486','USP Type I borosilicate glass vial (Box of 10\'s)','E2010','Ecozar','Lek Pharmaceuticals d.d.',0,0,0),('VANCO500MGPOW2801893011607','Vancomycin , 500 mg , Powder For Iv Infusion , MAYNE PHARMA','VANCO','Vancomycin','500MG','500 mg','POW28','POWDER FOR IV INFUSION','01893','Clear glass vial with blue plastic flip cap','','','Mayne Pharma',0,0,0),('VINBL1MGMLSOL1400217011610','Vinblastine , 1 mg/mL , Solution For Injection , HOSPIRA AUSTRALIA PTY LTD, 10 mL USP Type I flint vial','VINBL','Vinblastine','1MGML','1 mg/mL','SOL14','SOLUTION FOR INJECTION','00217','10 mL USP Type I flint vial','','','Hospira Australia Pty Ltd',0,0,0),('VINCR1MGMLSOL1400178011612','Vincristine , 1 mg/mL , Solution For Injection , ALCAVIXIN , 10 mL Clear Type I glass vial','VINCR','Vincristine','1MGML','1 mg/mL','SOL14','SOLUTION FOR INJECTION','00178','10 mL Clear Type I glass vial','A2071','Alcavixin','Korea United Pharma Inc',1,0,0),('VINCR1MGXXPOW1002585011611','Vincristine , 1 mg , Powder For Injection Solution Lyophilized , LABORATORIOS FILAXIS SA- ARGENTINA','VINCR','Vincristine','1MGXX','1 mg','POW10','POWDER FOR INJECTION SOLUTION LYOPHILIZED','02585','UST Type I vial','','','Laboratorios Filaxis SA- Argentina',0,0,0),('VITAE400IUCAPSU02194011614','Vitamin E , 400 IU , Capsule , AGIVITA E','VITAE','Vitamin E','400IU','400 IU','CAPSU','CAPSULE','02194','Plastic bottle x 50\'s','A2059','Agivita E','Agio',0,0,0),('VITB450MGXTAB4902045011613','Vitamin B6 , 50 mg , Tablet , NUTRICIA MFG. USA, INC.','VITB4','Vitamin B6','50MGX','50 mg','TAB49','TABLET','02045','Foil strip x 10 (Box of 100\'s)','','','Nutricia Mfg. USA, Inc.',1,0,0),('VITCB10525TAB49002322','Vb1+Vb6+V12+Vc+Buclizine Hci , 10 mg + 5 mg + 25 mcg + 500 mg + 25 mg , Tablet , APPEBON 500','VITCB','VB1+VB6+V12+VC+Buclizine HCI','10525','10 mg + 5 mg + 25 mcg + 500 mg + 25 mg','TAB49','TABLET','BOT1H','bottle of 100\'s','A0236','Appebon 500','Amherst Labs',0,0,0),('WARFA1MGXXTAB4902192011617','Warfarin , 1 mg , Tablet , COUMADIN','WARFA','Warfarin','1MGXX','1 mg','TAB49','TABLET','02192','Plastic bottle x 100\'s','C2143','Coumadin','Bristol-Myers Squibb Holding Pharma Ltd',0,0,0),('WARFA25PGMTAB4902189011616','Warfarin , 2.5 mg , Tablet , COTRAZID','WARFA','Warfarin','25PGM','2.5 mg','TAB49','TABLET','02189','Plastic bottle of 100\'s','C2142','Cotrazid','Bristol Myers Squibb Holdings Pharma Ltd',1,0,0),('WARFA25PGMTAB4902192011615','Warfarin , 2.5 mg , Tablet , COTENACE','WARFA','Warfarin','25PGM','2.5 mg','TAB49','TABLET','02192','Plastic bottle x 100\'s','C2141','Cotenace','Bristol Myers-Squibb Holding Pharma Ltd.',0,0,0),('ZINCX20MGXTAB18FS103002281','Zinc , 20 mg , Tablet Dispersible , NULL','ZINCX','Zinc','20MGX','20 mg','TAB18','TABLET DISPERSIBLE','FS103','Foil strip by 10s (Box of 30s)','','','Sai Mirra Innopharm Pvt Ltd',0,0,0),('ZOLPI10MGXTAB2402169007977','Zolpidem , 10 mg , Tablet Film Coated , PICINAF','ZOLPI','Zolpidem','10MGX','10 mg','TAB24','TABLET FILM COATED','02169','Opaque blister','P0068','Picinaf','EGIS Pharmaceuticals Public Limited Company',0,0,0);
/*!40000 ALTER TABLE `drugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examination_category`
--

DROP TABLE IF EXISTS `examination_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examination_category` (
  `exam_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_cat_name` varchar(255) NOT NULL,
  `exam_cat_desc` varchar(255) NOT NULL,
  PRIMARY KEY (`exam_cat_id`),
  UNIQUE KEY `exam_cat_name` (`exam_cat_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examination_category`
--

LOCK TABLES `examination_category` WRITE;
/*!40000 ALTER TABLE `examination_category` DISABLE KEYS */;
INSERT INTO `examination_category` VALUES (1,'Hematology','Blood');
/*!40000 ALTER TABLE `examination_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fasting_cat`
--

DROP TABLE IF EXISTS `fasting_cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fasting_cat` (
  `fast_id` int(11) NOT NULL AUTO_INCREMENT,
  `fast_name` varchar(255) NOT NULL,
  PRIMARY KEY (`fast_id`),
  UNIQUE KEY `fast_name` (`fast_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fasting_cat`
--

LOCK TABLES `fasting_cat` WRITE;
/*!40000 ALTER TABLE `fasting_cat` DISABLE KEYS */;
INSERT INTO `fasting_cat` VALUES (1,'Fasting');
/*!40000 ALTER TABLE `fasting_cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `final_disposition`
--

DROP TABLE IF EXISTS `final_disposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `final_disposition` (
  `disposition_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) NOT NULL,
  `patient_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`disposition_id`),
  KEY `fk_Patient_id` (`patient_id`),
  CONSTRAINT `fk_Patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `final_disposition`
--

LOCK TABLES `final_disposition` WRITE;
/*!40000 ALTER TABLE `final_disposition` DISABLE KEYS */;
/*!40000 ALTER TABLE `final_disposition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icd_code10`
--

DROP TABLE IF EXISTS `icd_code10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icd_code10` (
  `icd_code` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_id` int(11) NOT NULL,
  `icd_name` varchar(255) NOT NULL,
  `icd_desc` varchar(255) NOT NULL,
  PRIMARY KEY (`icd_code`),
  KEY `diagnosis_id` (`diagnosis_id`),
  CONSTRAINT `icd_code10_ibfk_1` FOREIGN KEY (`diagnosis_id`) REFERENCES `admitting_diagnosis` (`diagnosis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icd_code10`
--

LOCK TABLES `icd_code10` WRITE;
/*!40000 ALTER TABLE `icd_code10` DISABLE KEYS */;
/*!40000 ALTER TABLE `icd_code10` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `immidiate_contact`
--

DROP TABLE IF EXISTS `immidiate_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `immidiate_contact` (
  `im_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `relation` varchar(255) NOT NULL,
  `patient_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`im_id`),
  KEY `fk_Patient_immidiate` (`patient_id`),
  CONSTRAINT `fk_Patient_immidiate` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `immidiate_contact`
--

LOCK TABLES `immidiate_contact` WRITE;
/*!40000 ALTER TABLE `immidiate_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `immidiate_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_bill_seq`
--

DROP TABLE IF EXISTS `lab_bill_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_bill_seq` (
  `lab_bill_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lab_bill_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_bill_seq`
--

LOCK TABLES `lab_bill_seq` WRITE;
/*!40000 ALTER TABLE `lab_bill_seq` DISABLE KEYS */;
/*!40000 ALTER TABLE `lab_bill_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_billing`
--

DROP TABLE IF EXISTS `lab_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_billing` (
  `lab_bill_id` varchar(30) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT 'Laboratory Tests',
  `bill_name` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `lab_bill_status` tinyint(4) DEFAULT '0',
  `patient_id` varchar(30) NOT NULL,
  PRIMARY KEY (`lab_bill_id`),
  KEY `fk_lab_patient` (`patient_id`),
  CONSTRAINT `fk_lab_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_billing`
--

LOCK TABLES `lab_billing` WRITE;
/*!40000 ALTER TABLE `lab_billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `lab_billing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_lab_bill` BEFORE INSERT ON `lab_billing` FOR EACH ROW BEGIN
  INSERT INTO lab_bill_seq VALUES (NULL);
  SET NEW.lab_bill_id = CONCAT('LAB-BLL-', LPAD(LAST_INSERT_ID(), 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lab_request_remarks`
--

DROP TABLE IF EXISTS `lab_request_remarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_request_remarks` (
  `remarks_id` int(11) NOT NULL AUTO_INCREMENT,
  `remark` varchar(255) NOT NULL,
  `rem_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lab_id_fk` int(11) NOT NULL,
  `user_id_fk` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`remarks_id`),
  KEY `fk_lab_id` (`lab_id_fk`),
  KEY `fk_userid_7` (`user_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_request_remarks`
--

LOCK TABLES `lab_request_remarks` WRITE;
/*!40000 ALTER TABLE `lab_request_remarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `lab_request_remarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_specimen_request`
--

DROP TABLE IF EXISTS `lab_specimen_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_specimen_request` (
  `trans_spec_id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_req_id` int(11) NOT NULL,
  `specimen_id` int(11) NOT NULL,
  PRIMARY KEY (`trans_spec_id`),
  KEY `fk_lab_reqid` (`lab_req_id`),
  KEY `fk_lab_specid` (`specimen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_specimen_request`
--

LOCK TABLES `lab_specimen_request` WRITE;
/*!40000 ALTER TABLE `lab_specimen_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `lab_specimen_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratory_examination_type`
--

DROP TABLE IF EXISTS `laboratory_examination_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laboratory_examination_type` (
  `lab_exam_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_exam_type_name` varchar(255) NOT NULL,
  `lab_exam_type_category_id` int(11) NOT NULL,
  `lab_exam_type_description` varchar(255) NOT NULL,
  `lab_exam_type_price` float NOT NULL,
  PRIMARY KEY (`lab_exam_type_id`),
  UNIQUE KEY `lab_exam_type_name` (`lab_exam_type_name`),
  KEY `fk_cat_id` (`lab_exam_type_category_id`),
  CONSTRAINT `fk_cat_id` FOREIGN KEY (`lab_exam_type_category_id`) REFERENCES `examination_category` (`exam_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory_examination_type`
--

LOCK TABLES `laboratory_examination_type` WRITE;
/*!40000 ALTER TABLE `laboratory_examination_type` DISABLE KEYS */;
INSERT INTO `laboratory_examination_type` VALUES (1,'CBC',1,'Complete Blood Count',0);
/*!40000 ALTER TABLE `laboratory_examination_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratory_request`
--

DROP TABLE IF EXISTS `laboratory_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laboratory_request` (
  `lab_id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_patient` varchar(30) DEFAULT NULL,
  `lab_date_req` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lab_status` tinyint(4) NOT NULL DEFAULT '1',
  `lab_patient_checkin` date DEFAULT NULL,
  `user_id_fk` varchar(30) NOT NULL DEFAULT '0',
  `exam_type_fk` int(11) NOT NULL,
  `urgency_cat_fk` int(11) NOT NULL,
  `fasting_cat_fk` int(11) NOT NULL,
  `date_altered_status` datetime DEFAULT NULL,
  PRIMARY KEY (`lab_id`),
  KEY `fk_lab_patient_2` (`lab_patient`),
  KEY `fk_userid_6` (`user_id_fk`),
  KEY `fk_examreq_id` (`exam_type_fk`),
  KEY `fk_urg_id2` (`urgency_cat_fk`),
  KEY `fk_fast_cat2` (`fasting_cat_fk`),
  CONSTRAINT `fk_examreq_id` FOREIGN KEY (`exam_type_fk`) REFERENCES `laboratory_examination_type` (`lab_exam_type_id`),
  CONSTRAINT `fk_fast_cat2` FOREIGN KEY (`fasting_cat_fk`) REFERENCES `fasting_cat` (`fast_id`),
  CONSTRAINT `fk_lab_patient_2` FOREIGN KEY (`lab_patient`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_urg_id2` FOREIGN KEY (`urgency_cat_fk`) REFERENCES `urgency_cat` (`urg_id`),
  CONSTRAINT `fk_userid_6` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory_request`
--

LOCK TABLES `laboratory_request` WRITE;
/*!40000 ALTER TABLE `laboratory_request` DISABLE KEYS */;
INSERT INTO `laboratory_request` VALUES (1,'PTNT-000001','2016-08-21 03:12:08',1,'2016-08-21','USER-00002',1,1,1,'2016-08-21 00:00:00');
/*!40000 ALTER TABLE `laboratory_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratory_specimens`
--

DROP TABLE IF EXISTS `laboratory_specimens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laboratory_specimens` (
  `specimen_id` int(11) NOT NULL AUTO_INCREMENT,
  `specimen_name` varchar(255) NOT NULL,
  `specimen_description` varchar(255) NOT NULL,
  PRIMARY KEY (`specimen_id`),
  UNIQUE KEY `specimen_name` (`specimen_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory_specimens`
--

LOCK TABLES `laboratory_specimens` WRITE;
/*!40000 ALTER TABLE `laboratory_specimens` DISABLE KEYS */;
INSERT INTO `laboratory_specimens` VALUES (1,'Blood','Blood');
/*!40000 ALTER TABLE `laboratory_specimens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenance` (
  `maintenance_status_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `maintenance_status_name` varchar(255) NOT NULL,
  `maintenance_status_description` varchar(255) NOT NULL,
  PRIMARY KEY (`maintenance_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance`
--

LOCK TABLES `maintenance` WRITE;
/*!40000 ALTER TABLE `maintenance` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_status`
--

DROP TABLE IF EXISTS `maintenance_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenance_status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_type_id` int(11) NOT NULL,
  `status_name` varchar(255) NOT NULL,
  PRIMARY KEY (`status_id`),
  KEY `room_type_id` (`room_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_status`
--

LOCK TABLES `maintenance_status` WRITE;
/*!40000 ALTER TABLE `maintenance_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine_request`
--

DROP TABLE IF EXISTS `medicine_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine_request` (
  `med_reqID` varchar(30) NOT NULL,
  `requestor_id` varchar(30) NOT NULL,
  `drug_code` varchar(255) NOT NULL,
  `req_status` tinyint(4) NOT NULL DEFAULT '0',
  `date_requested` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `unique_id` varchar(50) NOT NULL,
  PRIMARY KEY (`med_reqID`),
  KEY `requestor_id_fk` (`requestor_id`),
  KEY `drug_code_fk` (`drug_code`),
  CONSTRAINT `drug_code_fk` FOREIGN KEY (`drug_code`) REFERENCES `drugs` (`drug_code`),
  CONSTRAINT `requestor_id_fk` FOREIGN KEY (`requestor_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_request`
--

LOCK TABLES `medicine_request` WRITE;
/*!40000 ALTER TABLE `medicine_request` DISABLE KEYS */;
INSERT INTO `medicine_request` VALUES ('REQ-0001','USER-00008','WARFA25PGMTAB4902189011616',2,'2016-10-05 04:46:30','2'),('REQ-0002','USER-00008','VITB450MGXTAB4902045011613',2,'2016-10-05 04:46:30','2'),('REQ-0003','USER-00008','VINCR1MGMLSOL1400178011612',2,'2016-10-05 04:46:30','2');
/*!40000 ALTER TABLE `medicine_request` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_med_req_id` BEFORE INSERT ON `medicine_request` FOR EACH ROW BEGIN
  INSERT INTO medReq_sequence VALUES (NULL);
  SET NEW.med_reqID = CONCAT('REQ-', LPAD(LAST_INSERT_ID(), 4, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `medreq_sequence`
--

DROP TABLE IF EXISTS `medreq_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medreq_sequence` (
  `med_req_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`med_req_seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medreq_sequence`
--

LOCK TABLES `medreq_sequence` WRITE;
/*!40000 ALTER TABLE `medreq_sequence` DISABLE KEYS */;
INSERT INTO `medreq_sequence` VALUES (1),(2),(3);
/*!40000 ALTER TABLE `medreq_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notif_seen`
--

DROP TABLE IF EXISTS `notif_seen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notif_seen` (
  `notif_seen_id` varchar(30) NOT NULL,
  `notif_ids` varchar(30) NOT NULL DEFAULT '0',
  `notif_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notif_seen_stat` tinyint(4) NOT NULL,
  PRIMARY KEY (`notif_seen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notif_seen`
--

LOCK TABLES `notif_seen` WRITE;
/*!40000 ALTER TABLE `notif_seen` DISABLE KEYS */;
/*!40000 ALTER TABLE `notif_seen` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_notif_seen` BEFORE INSERT ON `notif_seen` FOR EACH ROW BEGIN
  INSERT INTO notif_seen_sequence VALUES (NULL);
  SET NEW.notif_seen_id = CONCAT('NOTIF-SEEN', LPAD(LAST_INSERT_ID(), 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `notif_seen_sequence`
--

DROP TABLE IF EXISTS `notif_seen_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notif_seen_sequence` (
  `notif_seen_idd` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`notif_seen_idd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notif_seen_sequence`
--

LOCK TABLES `notif_seen_sequence` WRITE;
/*!40000 ALTER TABLE `notif_seen_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `notif_seen_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notif_sequence`
--

DROP TABLE IF EXISTS `notif_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notif_sequence` (
  `notif_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`notif_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notif_sequence`
--

LOCK TABLES `notif_sequence` WRITE;
/*!40000 ALTER TABLE `notif_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `notif_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `notif_id` varchar(30) NOT NULL,
  `notif_type` int(11) NOT NULL,
  `notif_desc` varchar(255) NOT NULL,
  `notif_status` tinyint(4) NOT NULL,
  PRIMARY KEY (`notif_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_notifs` BEFORE INSERT ON `notifications` FOR EACH ROW BEGIN
  INSERT INTO notif_sequence VALUES (NULL);
  SET NEW.notif_id = CONCAT('NOTIF', LPAD(LAST_INSERT_ID(), 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nurse_req_sequence`
--

DROP TABLE IF EXISTS `nurse_req_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurse_req_sequence` (
  `csr_reqseq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`csr_reqseq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse_req_sequence`
--

LOCK TABLES `nurse_req_sequence` WRITE;
/*!40000 ALTER TABLE `nurse_req_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurse_req_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse_sequence`
--

DROP TABLE IF EXISTS `nurse_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurse_sequence` (
  `nurse_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nurse_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse_sequence`
--

LOCK TABLES `nurse_sequence` WRITE;
/*!40000 ALTER TABLE `nurse_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurse_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse_type`
--

DROP TABLE IF EXISTS `nurse_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurse_type` (
  `nurse_type_id` tinyint(4) NOT NULL,
  `type_name` varchar(255) NOT NULL,
  `type_desc` varchar(255) NOT NULL,
  PRIMARY KEY (`nurse_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse_type`
--

LOCK TABLES `nurse_type` WRITE;
/*!40000 ALTER TABLE `nurse_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurse_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses`
--

DROP TABLE IF EXISTS `nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurses` (
  `nurse_id` varchar(30) NOT NULL DEFAULT '0',
  `user_nurse_fk` varchar(30) NOT NULL DEFAULT '0',
  `nurse_type` tinyint(4) NOT NULL,
  PRIMARY KEY (`nurse_id`),
  KEY `fk_nurse_type` (`nurse_type`),
  KEY `fk_user_nurse` (`user_nurse_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses`
--

LOCK TABLES `nurses` WRITE;
/*!40000 ALTER TABLE `nurses` DISABLE KEYS */;
/*!40000 ALTER TABLE `nurses` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nurses` BEFORE INSERT ON `nurses` FOR EACH ROW BEGIN
  INSERT INTO nurse_sequence VALUES (NULL);
  SET NEW.nurse_id = CONCAT('NURSE-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `occupancy`
--

DROP TABLE IF EXISTS `occupancy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `occupancy` (
  `occupancy_status_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `occupancy_status_name` varchar(255) NOT NULL,
  `occupancy_status_description` varchar(255) NOT NULL,
  PRIMARY KEY (`occupancy_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupancy`
--

LOCK TABLES `occupancy` WRITE;
/*!40000 ALTER TABLE `occupancy` DISABLE KEYS */;
/*!40000 ALTER TABLE `occupancy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occupancy_status`
--

DROP TABLE IF EXISTS `occupancy_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `occupancy_status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_type_id` int(11) NOT NULL,
  `status_name` varchar(255) NOT NULL,
  PRIMARY KEY (`status_id`),
  KEY `room_type_id` (`room_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupancy_status`
--

LOCK TABLES `occupancy_status` WRITE;
/*!40000 ALTER TABLE `occupancy_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `occupancy_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operations` (
  `operation_id` int(11) NOT NULL AUTO_INCREMENT,
  `operation_name` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`operation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
INSERT INTO `operations` VALUES (1,'Andiogram',50000,0),(2,'Tule3',500,1),(3,'Magpa-baog',25,1),(4,'Tule2',23,1),(5,'Tule',23,1);
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `age` int(3) NOT NULL,
  `gender` text NOT NULL,
  `birthdate` date NOT NULL,
  `birthplace` varchar(255) NOT NULL,
  `occupation` varchar(255) NOT NULL,
  `religion` varchar(255) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  `present_address` varchar(255) NOT NULL,
  `telephone_number` int(10) NOT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `patient_status` varchar(255) NOT NULL,
  `patient_id` varchar(30) NOT NULL DEFAULT '0',
  `date_registered` date NOT NULL,
  `date_checkin` date NOT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `fk_bedRooms` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES ('Cadiz','Raymund','Isis','isiscadz@gmail.com',69,'M','1969-12-11','Isis City','ISIS','Muslim','Filipino','Isis city 69 village ISIS',5080000,'09060000000','2','PTNT-000001','2016-07-06','0000-00-00'),('Garrett','Ruby','Martin','rmartin0@wikipedia.org',1,'Female','1981-05-15','Bell Ville','Punjabi','Argentina','Japanese','194 Bay Court',1,'1','0','PTNT-000002','0000-00-00','0000-00-00'),('Medina','Philip','Robertson','probertson1@arizona.edu',2,'Male','1953-01-17','Sison','Latvian','Philippines','Laotian','399 Forest Dale Hill',2,'2','0','PTNT-000003','0000-00-00','0000-00-00'),('Martin','Willie','Wagner','wwagner2@cornell.edu',3,'Male','2008-12-22','Infanta','Azeri','Philippines','Panamanian','6393 Judy Center',3,'3','0','PTNT-000004','0000-00-00','0000-00-00'),('Ortiz','Julia','Hayes','jhayes3@amazon.co.jp',4,'Female','1989-03-21','Xinmatou','Bosnian','China','Thai','73271 Lawn Parkway',4,'4','0','PTNT-000005','0000-00-00','0000-00-00'),('Cook','William','Greene','wgreene4@comsenz.com',5,'Male','1989-05-18','Balungkopi','Ndebele','Indonesia','Tlingit-Haida','768 Arapahoe Crossing',5,'5','0','PTNT-000006','0000-00-00','0000-00-00'),('Crawford','Todd','Hughes','thughes5@creativecommons.org',6,'Male','1968-02-22','Lebak','Macedonian','Indonesia','American Indian','5695 La Follette Road',6,'6','0','PTNT-000007','0000-00-00','0000-00-00'),('Adams','Earl','Fox','efox6@merriam-webster.com',7,'Male','2005-03-06','Izhmorskiy','Swahili','Russia','Paiute','7 Roxbury Trail',7,'7','0','PTNT-000008','0000-00-00','0000-00-00'),('Harris','Denise','Bradley','dbradley7@t.co',8,'Female','2008-10-11','Boshkengash','Kannada','Tajikistan','Colombian','175 Pine View Junction',8,'8','0','PTNT-000009','0000-00-00','0000-00-00'),('Rice','Tina','Peters','tpeters8@hatena.ne.jp',9,'Female','2010-07-01','Hino','Telugu','Japan','Vietnamese','41 Macpherson Place',9,'9','0','PTNT-000010','0000-00-00','0000-00-00'),('Webb','Lawrence','Williamson','lwilliamson9@cbc.ca',10,'Male','1969-12-24','Garoua Boulaï','Filipino','Cameroon','Guatemalan','9846 Sheridan Pass',10,'10','0','PTNT-000011','0000-00-00','0000-00-00'),('Harris','Amanda','Mendoza','amendozaa@nhs.uk',11,'Female','1996-04-10','La Trinidad','Bulgarian','Philippines','Guamanian','536 Meadow Ridge Parkway',11,'11','0','PTNT-000012','0000-00-00','0000-00-00'),('Bryant','Michael','Dixon','mdixonb@indiegogo.com',12,'Male','2013-08-05','Sempu','Mongolian','Indonesia','Lumbee','9299 Anhalt Point',12,'12','0','PTNT-000013','0000-00-00','0000-00-00'),('Cunningham','Amy','Edwards','aedwardsc@sfgate.com',13,'Female','1965-07-11','Santa Tecla','Catalan','El Salvador','Aleut','7229 Birchwood Point',13,'13','0','PTNT-000014','0000-00-00','0000-00-00'),('Campbell','Joshua','Fernandez','jfernandezd@amazon.co.uk',14,'Male','1963-02-24','Yaogu','Italian','China','Tohono O\'Odham','6143 Fair Oaks Pass',14,'14','0','PTNT-000015','0000-00-00','0000-00-00'),('Carpenter','Albert','Hawkins','ahawkinse@alibaba.com',15,'Male','1979-12-09','Zuogaiduoma','Dzongkha','China','Bolivian','959 Union Lane',15,'15','0','PTNT-000016','0000-00-00','0000-00-00'),('Murphy','Norma','Willis','nwillisf@senate.gov',16,'Female','1994-12-17','Puerto Esperanza','Bulgarian','Argentina','Ottawa','4906 Muir Court',16,'16','0','PTNT-000017','0000-00-00','0000-00-00'),('Chavez','Bonnie','Morales','bmoralesg@jugem.jp',17,'Female','1963-08-31','Pinoma','Gujarati','Philippines','Blackfeet','35817 Quincy Trail',17,'17','0','PTNT-000018','0000-00-00','0000-00-00'),('Butler','Sharon','Gray','sgrayh@shutterfly.com',18,'Female','1978-06-07','Mhlume','Maltese','Swaziland','Tlingit-Haida','9 Pepper Wood Place',18,'18','0','PTNT-000019','0000-00-00','0000-00-00'),('Snyder','Eugene','Ortiz','eortizi@bing.com',19,'Male','1960-08-21','Louny','Finnish','Czech Republic','Malaysian','5 Troy Hill',19,'19','0','PTNT-000020','0000-00-00','0000-00-00'),('Warren','David','Carpenter','dcarpenterj@salon.com',20,'Male','1976-05-29','Puerto Padre','Bulgarian','Cuba','Micronesian','46305 Stoughton Pass',20,'20','0','PTNT-000021','0000-00-00','0000-00-00'),('Morris','Keith','Bailey','kbaileyk@unc.edu',21,'Male','1997-07-19','Kärdla','Persian','Estonia','Navajo','688 Hazelcrest Alley',21,'21','0','PTNT-000022','0000-00-00','0000-00-00'),('Arnold','Brandon','Riley','brileyl@shareasale.com',22,'Male','2008-12-02','La Plata','Thai','Colombia','Tlingit-Haida','56708 Stephen Crossing',22,'22','0','PTNT-000023','0000-00-00','0000-00-00'),('Scott','Diana','West','dwestm@theglobeandmail.com',23,'Female','1985-02-22','Xuhang','Dari','China','Alaska Native','90871 Menomonie Alley',23,'23','0','PTNT-000024','0000-00-00','0000-00-00'),('Jacobs','Robert','Gray','rgrayn@ed.gov',24,'Male','1956-12-09','Sherwood Park','Malay','Canada','Venezuelan','8915 Farwell Court',24,'24','0','PTNT-000025','0000-00-00','0000-00-00'),('Myers','Brian','Ryan','bryano@techcrunch.com',25,'Male','2005-11-05','Aygezard','Latvian','Armenia','Lumbee','5 Hintze Street',25,'25','0','PTNT-000026','0000-00-00','0000-00-00'),('Sims','Richard','Little','rlittlep@macromedia.com',26,'Male','1978-09-22','Balma','Pashto','France','Cuban','0403 Carey Court',26,'26','0','PTNT-000027','0000-00-00','0000-00-00'),('Murray','Shawn','Alexander','salexanderq@tmall.com',27,'Male','1972-09-15','Yangdenghu','Khmer','China','Malaysian','37 Lien Court',27,'27','0','PTNT-000028','0000-00-00','0000-00-00'),('Fowler','Julie','Kelley','jkelleyr@theglobeandmail.com',28,'Female','1962-09-19','Dubravica','Sotho','Bosnia and Herzegovina','Guatemalan','03 Dayton Road',28,'28','0','PTNT-000029','0000-00-00','0000-00-00'),('Bell','Roy','Griffin','rgriffins@arizona.edu',29,'Male','1991-11-10','Kafyr-Kumukh','Swedish','Russia','Yaqui','065 Tomscot Junction',29,'29','0','PTNT-000030','0000-00-00','0000-00-00'),('Rose','Johnny','Ray','jrayt@businessweek.com',30,'Male','2010-04-22','Bojonghaur','Latvian','Indonesia','Uruguayan','9 Upham Plaza',30,'30','0','PTNT-000031','0000-00-00','0000-00-00'),('Hanson','Terry','Ferguson','tfergusonu@dailymotion.com',31,'Male','2016-06-29','Fort Worth','Khmer','United States','Honduran','901 Hazelcrest Trail',31,'31','0','PTNT-000032','0000-00-00','0000-00-00'),('Lane','Margaret','Simpson','msimpsonv@tiny.cc',32,'Female','1982-08-18','Mesa','Afrikaans','Indonesia','Paiute','4 David Drive',32,'32','0','PTNT-000033','0000-00-00','0000-00-00'),('Parker','John','Foster','jfosterw@unesco.org',33,'Male','1994-12-10','Motala','Chinese','Sweden','Iroquois','2 Grayhawk Junction',33,'33','0','PTNT-000034','0000-00-00','0000-00-00'),('Cox','Pamela','Willis','pwillisx@google.it',34,'Female','1959-07-31','Muslyumovo','Kurdish','Russia','Chamorro','95336 Clemons Court',34,'34','0','PTNT-000035','0000-00-00','0000-00-00'),('Griffin','Paula','Smith','psmithy@surveymonkey.com',35,'Female','1977-07-19','Bojongsari','New Zealand Sign Language','Indonesia','Cherokee','4690 Kropf Alley',35,'35','0','PTNT-000036','0000-00-00','0000-00-00'),('Garcia','Phyllis','Harper','pharperz@jalbum.net',36,'Female','2010-05-10','Jishan','French','China','Malaysian','0201 Dapin Hill',36,'36','0','PTNT-000037','0000-00-00','0000-00-00'),('Johnson','Andrew','Murphy','amurphy10@yahoo.co.jp',37,'Male','1958-12-16','Jaguarari','Italian','Brazil','Blackfeet','176 5th Place',37,'37','0','PTNT-000038','0000-00-00','0000-00-00'),('Ray','Evelyn','Sims','esims11@de.vu',38,'Female','1950-08-23','Baipenzhu','Polish','China','Eskimo','86367 Ryan Alley',38,'38','0','PTNT-000039','0000-00-00','0000-00-00'),('Perez','Ernest','Hamilton','ehamilton12@arstechnica.com',39,'Male','1979-10-18','Dazhou','Pashto','China','Malaysian','09 Towne Point',39,'39','0','PTNT-000040','0000-00-00','0000-00-00'),('Weaver','Harold','Williams','hwilliams13@zdnet.com',40,'Male','1978-11-28','San Antonio','Kazakh','Venezuela','Dominican (Dominican Republic)','2692 Meadow Vale Hill',40,'40','0','PTNT-000041','0000-00-00','0000-00-00'),('Price','Terry','Henry','thenry14@imgur.com',41,'Male','2003-11-26','Dado','Catalan','Philippines','Colombian','15730 Twin Pines Junction',41,'41','0','PTNT-000042','0000-00-00','0000-00-00'),('King','Elizabeth','Richardson','erichardson15@tamu.edu',42,'Female','2008-11-23','Gus’-Khrustal’nyy','Moldovan','Russia','Asian','7 Melody Street',42,'42','0','PTNT-000043','0000-00-00','0000-00-00'),('Edwards','Bruce','Ross','bross16@youku.com',43,'Male','2008-06-04','Dujiajing','Pashto','China','Cuban','3752 Linden Junction',43,'43','0','PTNT-000044','0000-00-00','0000-00-00'),('Ford','Michelle','Mitchell','mmitchell17@dmoz.org',44,'Female','1954-10-03','Ráječko','Polish','Czech Republic','Kiowa','39 Helena Junction',44,'44','0','PTNT-000045','0000-00-00','0000-00-00'),('Baker','Kimberly','Lynch','klynch18@wsj.com',45,'Female','1996-12-07','Cornwall','Polish','Canada','Choctaw','13036 Dapin Hill',45,'45','0','PTNT-000046','0000-00-00','0000-00-00'),('Hamilton','Lisa','Hernandez','lhernandez19@4shared.com',46,'Female','2005-05-21','Banayoyo','Maltese','Philippines','Venezuelan','2098 Arizona Circle',46,'46','0','PTNT-000047','0000-00-00','0000-00-00'),('Reed','Antonio','Flores','aflores1a@constantcontact.com',47,'Male','2005-12-29','Bandungan Timur','Catalan','Indonesia','Colville','020 Mifflin Way',47,'47','0','PTNT-000048','0000-00-00','0000-00-00'),('Rose','Patricia','Jones','pjones1b@blogs.com',48,'Female','1984-03-13','Dianzi','Greek','China','Choctaw','9140 Lakewood Gardens Lane',48,'48','0','PTNT-000049','0000-00-00','0000-00-00'),('Baker','Ralph','Moore','rmoore1c@wordpress.org',49,'Male','1980-03-23','Bultfontein','Dhivehi','South Africa','Paraguayan','378 Hintze Center',49,'49','0','PTNT-000050','0000-00-00','0000-00-00'),('Sanchez','Willie','Diaz','wdiaz1d@blogtalkradio.com',50,'Male','1971-08-16','Xinying','Gujarati','Taiwan','Comanche','80 Boyd Street',50,'50','0','PTNT-000051','0000-00-00','0000-00-00'),('Harris','Clarence','Griffin','cgriffin0@yale.edu',10,'Male','1990-02-19','Argentina','Tohono O\'Odham','Brazil','','2 Crest Line Lane',3087651,'9144537832','0','PTNT-000052','0000-00-00','0000-00-00'),('Berry','Brian','Wheeler','bwheeler1@wikia.com',6,'Male','1950-04-01','Croatia','Tongan','Indonesia','','43 Basil Park',1162169,'9798969828','0','PTNT-000053','0000-00-00','0000-00-00'),('Lynch','Richard','Wood','rwood2@sciencedirect.com',3,'Male','2014-07-17','Russia','Indonesian','China','','73601 Golf Course Park',8822097,'9858892563','0','PTNT-000054','0000-00-00','0000-00-00'),('Lane','Rachel','Burke','rburke3@rambler.ru',52,'Female','2016-04-20','China','Filipino','Nicaragua','','5961 Vernon Place',5995021,'9537941920','0','PTNT-000055','0000-00-00','0000-00-00'),('Gilbert','Juan','Thompson','jthompson4@blogspot.com',79,'Male','1970-04-11','Indonesia','Native Hawaiian and Other Pacific Islander (NHPI)','Chile','','7449 Granby Plaza',5941109,'9356805339','0','PTNT-000056','0000-00-00','0000-00-00'),('Lewis','Kevin','Carr','kcarr5@cdc.gov',61,'Male','1953-05-10','Philippines','Central American','Montenegro','','865 Logan Drive',3209033,'9376826097','0','PTNT-000057','0000-00-00','0000-00-00'),('Harvey','Janice','Reed','jreed6@ask.com',78,'Female','1961-04-25','Philippines','Nicaraguan','Czech Republic','','34622 Forest Run Place',6749216,'9726312100','0','PTNT-000058','0000-00-00','0000-00-00'),('Pierce','Lillian','Adams','ladams7@marketwatch.com',30,'Female','2000-01-30','Peru','Puget Sound Salish','France','','55 Briar Crest Pass',1807704,'9978297007','0','PTNT-000059','0000-00-00','0000-00-00'),('Johnston','Joshua','Ramirez','jramirez8@huffingtonpost.com',74,'Male','2015-05-19','Ukraine','Cheyenne','China','','957 Muir Parkway',4092965,'9861675678','0','PTNT-000060','0000-00-00','0000-00-00'),('Fisher','Sarah','White','swhite9@deliciousdays.com',62,'Female','1984-05-14','Japan','Central American','United Arab Emirates','','2312 Namekagon Center',3953431,'9769581699','0','PTNT-000061','0000-00-00','0000-00-00'),('Phillips','Timothy','Johnston','tjohnstona@biblegateway.com',12,'Male','1996-08-21','China','Cuban','Greece','','2 Melvin Plaza',6619824,'9592016731','0','PTNT-000062','0000-00-00','0000-00-00'),('Rice','Lois','Fields','lfieldsb@google.co.uk',81,'Female','1964-04-26','Indonesia','Peruvian','Indonesia','','6468 Crownhardt Way',3088700,'9709587853','0','PTNT-000063','0000-00-00','0000-00-00'),('Riley','Irene','Grant','igrantc@webmd.com',25,'Female','1958-04-25','China','Colombian','Russia','','14339 Anderson Hill',2683964,'9304733346','0','PTNT-000064','0000-00-00','0000-00-00'),('Coleman','Rachel','Carpenter','rcarpenterd@rambler.ru',69,'Female','1991-08-20','China','Ecuadorian','China','','72 Longview Way',7062045,'9757552349','0','PTNT-000065','0000-00-00','0000-00-00'),('Harris','Alan','Bell','abelle@yale.edu',88,'Male','1994-11-28','Bosnia and Herzegovina','Chinese','Russia','','12 Stephen Alley',3669287,'9755851530','0','PTNT-000066','0000-00-00','0000-00-00'),('Castillo','Nicole','Johnson','njohnsonf@google.com.br',59,'Female','1956-09-13','Tajikistan','Delaware','Armenia','','806 Bluestem Terrace',5102249,'9973037315','0','PTNT-000067','0000-00-00','0000-00-00'),('Rice','Terry','Williams','twilliamsg@i2i.jp',45,'Male','2000-08-28','Indonesia','Iroquois','South Korea','','2268 Center Hill',6814342,'9926643872','0','PTNT-000068','0000-00-00','0000-00-00'),('Riley','Annie','Johnson','ajohnsonh@vimeo.com',76,'Female','1957-09-22','Poland','Uruguayan','Austria','','0226 Talisman Center',1478520,'9544837084','0','PTNT-000069','0000-00-00','0000-00-00'),('Ruiz','Jennifer','Berry','jberryi@mapquest.com',86,'Female','1987-06-28','Bulgaria','Puget Sound Salish','Kazakhstan','','386 Esch Crossing',5521664,'9921263189','0','PTNT-000070','0000-00-00','0000-00-00'),('Butler','Sandra','Patterson','spattersonj@g.co',89,'Female','2010-04-19','Venezuela','Kiowa','Indonesia','','7 Eliot Drive',7411069,'9632672462','0','PTNT-000071','0000-00-00','0000-00-00'),('Evans','Dennis','Ramirez','dramirezk@ibm.com',100,'Male','1961-01-01','Brazil','Puerto Rican','China','','8 Blue Bill Park Alley',4271529,'9573159026','0','PTNT-000072','0000-00-00','0000-00-00'),('Martin','Roy','Price','rpricel@goo.ne.jp',35,'Male','1977-06-21','Sweden','Chamorro','Tanzania','','96842 Talmadge Crossing',1896384,'9607882892','0','PTNT-000073','0000-00-00','0000-00-00'),('Burton','Julie','Cunningham','jcunninghamm@twitpic.com',82,'Female','2012-05-15','Nigeria','Taiwanese','Georgia','','88 Morningstar Junction',7535290,'9992166850','0','PTNT-000074','0000-00-00','0000-00-00'),('Taylor','Randy','Ross','rrossn@fastcompany.com',37,'Male','1960-11-17','Indonesia','Argentinian','Russia','','6788 Welch Alley',6317393,'9046367017','0','PTNT-000075','0000-00-00','0000-00-00'),('Simmons','Patrick','Banks','pbankso@marriott.com',79,'Male','1993-04-05','Brazil','Yakama','China','','439 Sutteridge Lane',1948402,'9643728489','0','PTNT-000076','0000-00-00','0000-00-00'),('Fuller','Carolyn','Schmidt','cschmidtp@github.com',20,'Female','1980-03-13','China','Guatemalan','Philippines','','076 Algoma Street',6824509,'9347036083','0','PTNT-000077','0000-00-00','0000-00-00'),('Washington','Kathryn','Edwards','kedwardsq@epa.gov',88,'Female','2011-03-17','Mexico','Argentinian','Indonesia','','54 Heath Street',2685899,'9737334956','0','PTNT-000078','0000-00-00','0000-00-00'),('Watkins','Phyllis','Lopez','plopezr@wikia.com',41,'Female','1993-11-02','Indonesia','Osage','Indonesia','','02099 Clyde Gallagher Center',9751379,'9003589272','0','PTNT-000079','0000-00-00','0000-00-00'),('Smith','Larry','Howard','lhowards@tmall.com',100,'Male','2001-04-28','Costa Rica','Venezuelan','Indonesia','','329 Kinsman Plaza',4593891,'9847658361','0','PTNT-000080','0000-00-00','0000-00-00'),('Tucker','Juan','Carpenter','jcarpentert@webmd.com',27,'Male','1971-09-12','Cuba','Costa Rican','Indonesia','','5 International Parkway',5357234,'9356176357','0','PTNT-000081','0000-00-00','0000-00-00'),('George','Robert','Fowler','rfowleru@typepad.com',27,'Male','1972-09-26','Brazil','Iroquois','Philippines','','709 Emmet Pass',1502041,'9229182742','0','PTNT-000082','0000-00-00','0000-00-00'),('Brooks','Gerald','Jackson','gjacksonv@tripod.com',8,'Male','2004-05-19','Thailand','Vietnamese','Central African Republic','','10 Sheridan Park',4154716,'9819070366','0','PTNT-000083','0000-00-00','0000-00-00'),('Tucker','Kenneth','Burton','kburtonw@hexun.com',31,'Male','1992-12-01','Iran','Sri Lankan','Estonia','','1044 Kenwood Center',8206597,'9312764738','0','PTNT-000084','0000-00-00','0000-00-00'),('Ryan','Paul','Ellis','pellisx@ezinearticles.com',56,'Male','1966-06-30','Sweden','Yuman','Poland','','5 Nobel Junction',1969081,'9029999443','0','PTNT-000085','0000-00-00','0000-00-00'),('Stanley','Andrew','Young','ayoungy@squidoo.com',30,'Male','1976-01-09','China','Samoan','China','','12 Fisk Pass',5616471,'9476203042','0','PTNT-000086','0000-00-00','0000-00-00'),('Bennett','Eugene','Webb','ewebbz@wired.com',12,'Male','1960-01-31','Czech Republic','Micronesian','Ireland','','29450 Dakota Avenue',9922637,'9713828586','0','PTNT-000087','0000-00-00','0000-00-00'),('Hernandez','Paul','Stone','pstone10@mit.edu',2,'Male','1999-03-26','Indonesia','Kiowa','Czech Republic','','24064 Green Terrace',3010571,'9258086267','0','PTNT-000088','0000-00-00','0000-00-00'),('Howard','Kenneth','Hayes','khayes11@dot.gov',5,'Male','2013-12-09','France','Spaniard','Sweden','','9 Marcy Drive',4819113,'9776019733','0','PTNT-000089','0000-00-00','0000-00-00'),('Dixon','Amy','Wagner','awagner12@boston.com',44,'Female','1952-06-25','Afghanistan','Spaniard','Germany','','5918 Pond Lane',3884894,'9250471843','0','PTNT-000090','0000-00-00','0000-00-00'),('Reed','Peter','Turner','pturner13@nhs.uk',10,'Male','1953-02-01','China','Dominican (Dominican Republic)','Mexico','','4933 Clemons Crossing',3379217,'9173161798','0','PTNT-000091','0000-00-00','0000-00-00'),('Brooks','Randy','Perry','rperry14@bluehost.com',84,'Male','1969-11-07','Ukraine','Samoan','Indonesia','','38064 Blue Bill Park Alley',3629191,'9472952936','0','PTNT-000092','0000-00-00','0000-00-00'),('Banks','Mary','Alvarez','malvarez15@adobe.com',96,'Female','2004-01-31','China','Chinese','Mexico','','57 Raven Crossing',8909991,'9390315783','0','PTNT-000093','0000-00-00','0000-00-00'),('Williams','Rose','Dixon','rdixon16@ehow.com',12,'Female','2009-01-02','Slovenia','Costa Rican','Poland','','06 Loftsgordon Alley',9052342,'9394719735','0','PTNT-000094','0000-00-00','0000-00-00'),('Simpson','Walter','Andrews','wandrews17@nationalgeographic.com',9,'Male','1985-01-10','Indonesia','Laotian','Japan','','7194 Blue Bill Park Road',4014128,'9128984979','0','PTNT-000095','0000-00-00','0000-00-00'),('White','Linda','Garrett','lgarrett18@scribd.com',16,'Female','1980-08-19','Japan','Apache','Kazakhstan','','38 Surrey Street',6795613,'9012923311','0','PTNT-000096','0000-00-00','0000-00-00'),('Austin','Edward','Palmer','epalmer19@github.com',74,'Male','1953-11-06','Philippines','Sioux','Dominican Republic','','4087 Blackbird Avenue',5919957,'9483825750','0','PTNT-000097','0000-00-00','0000-00-00'),('Webb','Elizabeth','Lee','elee1a@sitemeter.com',14,'Female','1988-06-23','Indonesia','Paraguayan','Philippines','','0711 Dawn Junction',6909131,'9837669743','0','PTNT-000098','0000-00-00','0000-00-00'),('Austin','Sandra','Harper','sharper1b@naver.com',2,'Female','1983-02-04','Nicaragua','Laotian','China','','71597 Spaight Road',9829478,'9452380731','0','PTNT-000099','0000-00-00','0000-00-00'),('Cox','Jose','Russell','jrussell1c@prweb.com',77,'Male','2012-02-12','Philippines','Creek','Honduras','','88837 Fisk Place',9773253,'9169329814','0','PTNT-000100','0000-00-00','0000-00-00'),('Rivera','Thomas','Cunningham','tcunningham1d@ucsd.edu',30,'Male','1995-04-18','China','Blackfeet','Brazil','','6 Rockefeller Point',8566877,'9445417442','0','PTNT-000101','0000-00-00','0000-00-00'),('Barnes','Justin','Fowler','jfowler1e@nyu.edu',31,'Male','1976-11-24','Philippines','Peruvian','Indonesia','','4204 Stang Plaza',5940682,'9329369253','0','PTNT-000102','0000-00-00','0000-00-00'),('Hill','James','Carroll','jcarroll1f@msu.edu',86,'Male','1977-11-28','Sweden','Colombian','Iran','','1 Talmadge Circle',6882383,'9894313363','0','PTNT-000103','0000-00-00','0000-00-00'),('Garrett','Cheryl','Carroll','ccarroll1g@photobucket.com',58,'Female','1954-01-18','Belarus','Osage','China','','7297 Dahle Trail',3881067,'9550407697','0','PTNT-000104','0000-00-00','0000-00-00'),('Wood','Louis','Morales','lmorales1h@squarespace.com',73,'Male','1957-07-17','Indonesia','Chinese','China','','30863 4th Avenue',7893225,'9374201783','0','PTNT-000105','0000-00-00','0000-00-00'),('Watkins','Andrew','King','aking1i@timesonline.co.uk',9,'Male','1967-10-29','Indonesia','Asian','Mexico','','0067 Ronald Regan Alley',2389932,'9156475294','0','PTNT-000106','0000-00-00','0000-00-00'),('Stewart','Sean','Thompson','sthompson1j@w3.org',39,'Male','1950-09-08','Russia','Nicaraguan','Benin','','8958 Ohio Drive',1830192,'9200982981','0','PTNT-000107','0000-00-00','0000-00-00'),('Rivera','Johnny','Burns','jburns1k@indiatimes.com',50,'Male','2001-08-27','Indonesia','Filipino','Bangladesh','','9624 Grover Way',4631631,'9661124473','0','PTNT-000108','0000-00-00','0000-00-00'),('Simpson','Helen','Cook','hcook1l@networkadvertising.org',28,'Female','1966-12-06','Russia','Delaware','Indonesia','','7763 Warbler Circle',5253289,'9380997161','0','PTNT-000109','0000-00-00','0000-00-00'),('Burke','Chris','Peterson','cpeterson1m@forbes.com',95,'Male','2004-04-19','China','Sioux','Mexico','','843 Lillian Park',9955536,'9665528444','0','PTNT-000110','0000-00-00','0000-00-00'),('Flores','Julia','Harvey','jharvey1n@twitter.com',55,'Female','1953-08-08','Greece','Shoshone','South Africa','','6572 Mendota Street',7765190,'9532047318','0','PTNT-000111','0000-00-00','0000-00-00'),('Berry','Nicole','Williamson','nwilliamson1o@smh.com.au',26,'Female','1957-05-27','Thailand','Salvadoran','China','','78138 Mcbride Court',8097006,'9539535621','0','PTNT-000112','0000-00-00','0000-00-00'),('Hill','Harry','Allen','hallen1p@artisteer.com',52,'Male','1992-06-21','Poland','Sri Lankan','Serbia','','7692 Clarendon Hill',1761235,'9258003477','0','PTNT-000113','0000-00-00','0000-00-00'),('Flores','James','Montgomery','jmontgomery1q@sfgate.com',22,'Male','1959-11-25','Philippines','Malaysian','China','','7984 Charing Cross Hill',7927933,'9303241060','0','PTNT-000114','0000-00-00','0000-00-00'),('Harvey','John','Carroll','jcarroll1r@bing.com',53,'Male','1952-08-25','Nepal','Hmong','Bosnia and Herzegovina','','79950 Dixon Avenue',1799173,'9022897209','0','PTNT-000115','0000-00-00','0000-00-00'),('Burton','Marie','Cruz','mcruz1s@paginegialle.it',31,'Female','1984-02-11','Poland','Venezuelan','Poland','','2 Westport Drive',3232738,'9639089469','0','PTNT-000116','0000-00-00','0000-00-00'),('Green','Janice','Coleman','jcoleman1t@theatlantic.com',96,'Female','2005-03-30','Mexico','Micronesian','Bolivia','','897 Oneill Avenue',8424825,'9849233249','0','PTNT-000117','0000-00-00','0000-00-00'),('Reid','Joyce','Gordon','jgordon1u@symantec.com',48,'Female','2002-12-27','Indonesia','Costa Rican','China','','59 Hanson Lane',5212027,'9388247792','0','PTNT-000118','0000-00-00','0000-00-00'),('Holmes','Rose','Sullivan','rsullivan1v@mozilla.org',11,'Female','1955-01-24','Angola','Malaysian','Brazil','','93 Pawling Pass',2013925,'9402321709','0','PTNT-000119','0000-00-00','0000-00-00'),('Stevens','Harold','Owens','howens1w@answers.com',8,'Male','1967-01-24','Russia','Filipino','China','','502 Shoshone Center',4375050,'9333683650','0','PTNT-000120','0000-00-00','0000-00-00'),('Morgan','Gary','Ross','gross1x@de.vu',98,'Male','1986-03-21','Sweden','Navajo','Indonesia','','0707 Lawn Place',4798419,'9378085007','0','PTNT-000121','0000-00-00','0000-00-00'),('Owens','Jeremy','Kennedy','jkennedy1y@marriott.com',41,'Male','1956-02-26','Sweden','Dominican (Dominican Republic)','Indonesia','','16636 Morrow Street',6261842,'9360885334','0','PTNT-000122','0000-00-00','0000-00-00'),('Fernandez','Bruce','Clark','bclark1z@telegraph.co.uk',67,'Male','2002-01-15','China','Navajo','United States','','87 Kipling Plaza',4935520,'9201216856','0','PTNT-000123','0000-00-00','0000-00-00'),('Sullivan','Carlos','Jenkins','cjenkins20@creativecommons.org',39,'Male','2016-04-24','Sweden','Delaware','China','','2 Hayes Pass',8833087,'9519399950','0','PTNT-000124','0000-00-00','0000-00-00'),('Washington','Martha','Dunn','mdunn21@spiegel.de',32,'Female','1969-12-15','Madagascar','Thai','Mauritius','','2 Porter Drive',3874823,'9577952120','0','PTNT-000125','0000-00-00','0000-00-00'),('Peters','Ralph','Marshall','rmarshall22@bravesites.com',68,'Male','1998-02-24','France','Alaskan Athabascan','Indonesia','','537 Elka Point',9787620,'9798593238','0','PTNT-000126','0000-00-00','0000-00-00'),('Walker','Evelyn','Simpson','esimpson23@biglobe.ne.jp',6,'Female','1968-06-15','Sweden','Polynesian','China','','004 Eliot Avenue',5609666,'9503919875','0','PTNT-000127','0000-00-00','0000-00-00'),('Montgomery','Jeremy','Brown','jbrown24@hubpages.com',67,'Male','1995-10-25','Afghanistan','Ute','Portugal','','3994 Hayes Lane',7081055,'9399800443','0','PTNT-000128','0000-00-00','0000-00-00'),('Foster','Bonnie','Hernandez','bhernandez25@apple.com',67,'Female','2008-04-01','China','Honduran','Canada','','404 Declaration Place',8743171,'9753399141','0','PTNT-000129','0000-00-00','0000-00-00'),('Wheeler','Martha','Ward','mward26@nymag.com',4,'Female','2004-05-11','Libya','Latin American Indian','China','','257 Columbus Park',5403327,'9116741972','0','PTNT-000130','0000-00-00','0000-00-00'),('Arnold','Denise','Gibson','dgibson27@storify.com',46,'Female','1990-03-03','Central African Republic','Indonesian','Czech Republic','','14 Fallview Court',2546537,'9507886932','0','PTNT-000131','0000-00-00','0000-00-00'),('Ferguson','Heather','Reed','hreed28@jugem.jp',5,'Female','1975-02-06','Russia','Sioux','Brazil','','3215 Farwell Crossing',1198605,'9738820898','0','PTNT-000132','0000-00-00','0000-00-00'),('Ellis','Andrea','Castillo','acastillo29@miibeian.gov.cn',97,'Female','1997-08-11','Philippines','Guatemalan','Portugal','','198 Glacier Hill Circle',7738569,'9153312578','0','PTNT-000133','0000-00-00','0000-00-00'),('Clark','Jerry','Dixon','jdixon2a@about.me',23,'Male','2010-05-12','Brazil','Tongan','Pakistan','','8 Claremont Drive',8287227,'9867884845','0','PTNT-000134','0000-00-00','0000-00-00'),('Hawkins','Amanda','Hudson','ahudson2b@eventbrite.com',54,'Female','1989-09-01','Indonesia','Creek','South Korea','','53019 Loomis Avenue',7702122,'9487433244','0','PTNT-000135','0000-00-00','0000-00-00'),('Grant','Tina','Woods','twoods2c@flavors.me',38,'Female','1993-09-10','Senegal','Yakama','China','','5 Hallows Terrace',1129075,'9260067008','0','PTNT-000136','0000-00-00','0000-00-00'),('Frazier','Rebecca','Evans','revans2d@posterous.com',40,'Female','1956-06-07','China','Sioux','Philippines','','63020 David Parkway',3186321,'9248384625','0','PTNT-000137','0000-00-00','0000-00-00'),('Reyes','Jessica','Fox','jfox2e@ebay.co.uk',21,'Female','1958-05-15','Jamaica','Chilean','China','','44874 Mendota Parkway',4698782,'9979777292','0','PTNT-000138','0000-00-00','0000-00-00'),('Berry','Samuel','Rice','srice2f@goo.ne.jp',50,'Male','1993-01-14','Kazakhstan','Latin American Indian','China','','81 Everett Parkway',8306283,'9366838793','0','PTNT-000139','0000-00-00','0000-00-00'),('Collins','Stephanie','Lawson','slawson2g@businessinsider.com',87,'Female','1995-01-31','Brazil','Colville','Peru','','7 Mallory Parkway',3346837,'9159366640','0','PTNT-000140','0000-00-00','0000-00-00'),('George','Donna','Harris','dharris2h@discuz.net',18,'Female','1981-02-18','Russia','Bangladeshi','Brazil','','0713 High Crossing Trail',1556323,'9426374058','0','PTNT-000141','0000-00-00','0000-00-00'),('James','Edward','Stevens','estevens2i@yelp.com',66,'Male','1950-10-23','Antigua and Barbuda','American Indian and Alaska Native (AIAN)','Switzerland','','262 Burrows Place',7952771,'9231850527','0','PTNT-000142','0000-00-00','0000-00-00'),('Crawford','Brenda','Hart','bhart2j@latimes.com',92,'Female','1969-12-31','Argentina','Honduran','Bahamas','','6 Bayside Park',1370375,'9538115234','0','PTNT-000143','0000-00-00','0000-00-00'),('Price','Jason','Jacobs','jjacobs2k@behance.net',18,'Male','1976-03-15','Philippines','American Indian','China','','889 Mockingbird Hill',1597652,'9257144457','0','PTNT-000144','0000-00-00','0000-00-00'),('Spencer','Jessica','Kim','jkim2l@tamu.edu',14,'Female','1999-12-19','Cameroon','Tohono O\'Odham','Laos','','6 Melby Street',4191237,'9456194998','0','PTNT-000145','0000-00-00','0000-00-00'),('Wright','Willie','Black','wblack2m@com.com',71,'Male','1984-03-20','France','Pakistani','Sweden','','6316 Logan Terrace',6002192,'9539014989','0','PTNT-000146','0000-00-00','0000-00-00'),('Henry','Marilyn','White','mwhite2n@google.nl',3,'Female','1982-08-06','Czech Republic','Sioux','China','','2 Charing Cross Hill',4429753,'9819879875','0','PTNT-000147','0000-00-00','0000-00-00'),('Henderson','Andrea','Rogers','arogers2o@booking.com',93,'Female','1952-06-27','Indonesia','Kiowa','Indonesia','','048 Pearson Drive',4058452,'9906912692','0','PTNT-000148','0000-00-00','0000-00-00'),('Martin','Joyce','Reynolds','jreynolds2p@mit.edu',11,'Female','2013-01-13','Iran','Potawatomi','Portugal','','4590 Portage Place',4502178,'9136966306','0','PTNT-000149','0000-00-00','0000-00-00'),('Kelley','Larry','Ferguson','lferguson2q@live.com',34,'Male','1999-01-19','South Africa','Eskimo','China','','52728 Melody Way',6372989,'9294455141','0','PTNT-000150','0000-00-00','0000-00-00'),('Hicks','Annie','Ford','aford2r@meetup.com',96,'Female','1982-10-07','Sweden','Black or African American','Czech Republic','','82965 Emmet Hill',2440243,'9555463979','0','PTNT-000151','0000-00-00','0000-00-00'),('Banks','Judy','Morrison','jmorrison2s@ocn.ne.jp',42,'Female','1954-08-05','Brazil','Crow','Czech Republic','','548 Troy Street',6838816,'9684986151','0','PTNT-000152','0000-00-00','0000-00-00'),('Grant','Linda','Stewart','lstewart2t@naver.com',39,'Female','1950-05-30','China','Samoan','China','','1575 Gerald Park',1249504,'9653254293','0','PTNT-000153','0000-00-00','0000-00-00'),('Howell','Shirley','Fowler','sfowler2u@intel.com',53,'Female','1995-12-26','France','Sioux','China','','10 Fuller Junction',9228266,'9252985993','0','PTNT-000154','0000-00-00','0000-00-00'),('Reynolds','Joan','Martin','jmartin2v@mit.edu',77,'Female','1974-11-22','France','Sioux','Indonesia','','32 Eastlawn Hill',6040304,'9716589785','0','PTNT-000155','0000-00-00','0000-00-00'),('Watkins','Sarah','Wood','swood2w@berkeley.edu',99,'Female','1990-06-17','China','Colville','Nigeria','','959 Hagan Court',9452561,'9953249860','0','PTNT-000156','0000-00-00','0000-00-00'),('Peters','Howard','Porter','hporter2x@prlog.org',12,'Male','1968-08-19','Afghanistan','Spaniard','Thailand','','0833 Bunting Lane',2942511,'9712790667','0','PTNT-000157','0000-00-00','0000-00-00'),('Foster','Roy','Reed','rreed2y@moonfruit.com',75,'Male','1984-06-26','Tanzania','Korean','China','','4 Stang Avenue',6619869,'9505112270','0','PTNT-000158','0000-00-00','0000-00-00'),('Lawson','Bonnie','Perkins','bperkins2z@bbc.co.uk',97,'Female','1990-09-11','Poland','Creek','France','','65295 Commercial Point',1236115,'9463348474','0','PTNT-000159','0000-00-00','0000-00-00'),('Edwards','Arthur','Stanley','astanley30@google.nl',47,'Male','2009-01-04','Kazakhstan','Shoshone','Indonesia','','3884 6th Court',4127158,'9033634672','0','PTNT-000160','0000-00-00','0000-00-00'),('Long','Janet','Ramirez','jramirez31@phpbb.com',70,'Female','1993-08-13','Portugal','Potawatomi','Bolivia','','02 Barby Junction',1406050,'9485636831','0','PTNT-000161','0000-00-00','0000-00-00'),('Morris','Marie','Boyd','mboyd32@hubpages.com',73,'Female','1969-08-17','China','Korean','Zambia','','011 Russell Terrace',4227734,'9533114902','0','PTNT-000162','0000-00-00','0000-00-00'),('Elliott','Andrew','Nguyen','anguyen33@usnews.com',39,'Male','1963-08-18','Brazil','Creek','Portugal','','61 Kim Place',2827779,'9672779122','0','PTNT-000163','0000-00-00','0000-00-00'),('Martinez','Katherine','Peters','kpeters34@dropbox.com',28,'Female','1950-01-28','Poland','Yaqui','Indonesia','','5945 Oak Trail',1433026,'9312364671','0','PTNT-000164','0000-00-00','0000-00-00'),('Jenkins','Ashley','Chavez','achavez35@salon.com',5,'Female','1990-07-27','Portugal','Sri Lankan','Brazil','','1 Acker Hill',9346216,'9177022958','0','PTNT-000165','0000-00-00','0000-00-00'),('Cole','Diana','Nguyen','dnguyen36@example.com',2,'Female','1981-10-02','Philippines','Korean','Indonesia','','46485 Garrison Terrace',7234952,'9918819381','0','PTNT-000166','0000-00-00','0000-00-00'),('King','Jeremy','Warren','jwarren37@wunderground.com',20,'Male','1994-10-05','Brazil','Cambodian','Indonesia','','57628 Waxwing Plaza',1704472,'9714943764','0','PTNT-000167','0000-00-00','0000-00-00'),('Day','Todd','Kelley','tkelley38@youku.com',12,'Male','1961-04-27','China','Hmong','Japan','','05747 Barnett Hill',1804793,'9201815523','0','PTNT-000168','0000-00-00','0000-00-00'),('Cook','Brian','Fuller','bfuller39@ezinearticles.com',30,'Male','2013-08-13','Albania','Blackfeet','Ukraine','','25407 Kipling Place',1403938,'9019658637','0','PTNT-000169','0000-00-00','0000-00-00'),('Baker','Andrew','Ramos','aramos3a@moonfruit.com',59,'Male','1985-02-14','Russia','Filipino','Portugal','','29 Blaine Circle',8726630,'9340297242','0','PTNT-000170','0000-00-00','0000-00-00'),('Welch','Louise','Ortiz','lortiz3b@clickbank.net',87,'Female','2004-06-13','United States','Colombian','Poland','','49330 Bay Avenue',8862549,'9410546661','0','PTNT-000171','0000-00-00','0000-00-00'),('Fields','Henry','Perry','hperry3c@irs.gov',8,'Male','2011-03-11','China','Cree','Portugal','','8696 Springs Court',3193544,'9702173365','0','PTNT-000172','0000-00-00','0000-00-00'),('White','Scott','Taylor','staylor3d@mozilla.org',45,'Male','1973-09-24','Indonesia','Menominee','China','','50858 Hudson Street',7166907,'9189784790','0','PTNT-000173','0000-00-00','0000-00-00'),('Day','Jerry','Hanson','jhanson3e@sina.com.cn',96,'Male','1981-07-22','Russia','Japanese','Argentina','','69 Nobel Lane',5953109,'9667793605','0','PTNT-000174','0000-00-00','0000-00-00'),('Scott','Heather','Wallace','hwallace3f@twitter.com',13,'Female','1990-01-19','Indonesia','Asian Indian','Indonesia','','6583 Mendota Point',9535726,'9500255149','0','PTNT-000175','0000-00-00','0000-00-00'),('Graham','Jennifer','Hawkins','jhawkins3g@hibu.com',9,'Female','1982-06-09','Russia','Lumbee','Indonesia','','5 Fisk Parkway',6068410,'9267854463','0','PTNT-000176','0000-00-00','0000-00-00'),('Wright','Paul','Oliver','poliver3h@kickstarter.com',23,'Male','2015-09-27','China','Uruguayan','Pakistan','','082 Monument Street',5588890,'9737402953','0','PTNT-000177','0000-00-00','0000-00-00'),('Meyer','Michael','Bailey','mbailey3i@sun.com',74,'Male','2003-07-19','Japan','Central American','Qatar','','489 Weeping Birch Place',4839767,'9408953287','0','PTNT-000178','0000-00-00','0000-00-00'),('Jacobs','Jesse','Harvey','jharvey3j@behance.net',78,'Male','1976-01-26','Philippines','Cambodian','Philippines','','2109 Clyde Gallagher Avenue',1568461,'9747084379','0','PTNT-000179','0000-00-00','0000-00-00'),('Carter','Deborah','Simmons','dsimmons3k@fastcompany.com',14,'Female','1993-11-09','Tanzania','Mexican','Tunisia','','64356 Northridge Terrace',3106824,'9586172615','0','PTNT-000180','0000-00-00','0000-00-00'),('Griffin','Marie','Miller','mmiller3l@skyrock.com',14,'Female','1988-01-18','Canada','Chippewa','Poland','','6194 Petterle Plaza',6784733,'9539074833','0','PTNT-000181','0000-00-00','0000-00-00'),('Lawson','Adam','Gardner','agardner3m@istockphoto.com',23,'Male','1999-04-05','China','Comanche','Philippines','','5140 Saint Paul Terrace',7478263,'9154910673','0','PTNT-000182','0000-00-00','0000-00-00'),('Coleman','Barbara','Owens','bowens3n@google.pl',38,'Female','2008-11-16','China','Pima','Indonesia','','07 Swallow Plaza',3320973,'9371344894','0','PTNT-000183','0000-00-00','0000-00-00'),('Banks','Ryan','Riley','rriley3o@theguardian.com',44,'Male','1999-04-01','Kazakhstan','Asian Indian','China','','8470 Merrick Center',3093477,'9588797604','0','PTNT-000184','0000-00-00','0000-00-00'),('Palmer','Ruby','Wright','rwright3p@salon.com',80,'Female','1951-07-01','South Africa','Malaysian','Russia','','5 Gulseth Road',8463798,'9532315162','0','PTNT-000185','0000-00-00','0000-00-00'),('Riley','Tammy','Holmes','tholmes3q@angelfire.com',92,'Female','1958-06-21','China','Alaskan Athabascan','Russia','','51 Manufacturers Avenue',8317945,'9239486934','0','PTNT-000186','0000-00-00','0000-00-00'),('Burton','Jeremy','Hunt','jhunt3r@purevolume.com',35,'Male','1961-09-09','Brazil','Dominican (Dominican Republic)','Indonesia','','120 Hintze Place',3596071,'9227336041','0','PTNT-000187','0000-00-00','0000-00-00'),('Harrison','Kathy','Watkins','kwatkins3s@paginegialle.it',65,'Female','1985-09-29','Indonesia','Native Hawaiian and Other Pacific Islander (NHPI)','China','','83513 Packers Place',2314527,'9763651863','0','PTNT-000188','0000-00-00','0000-00-00'),('Fisher','Jeremy','Johnson','jjohnson3t@arstechnica.com',87,'Male','2001-02-06','China','Nicaraguan','Portugal','','8963 Burning Wood Circle',1843349,'9006412484','0','PTNT-000189','0000-00-00','0000-00-00'),('Lee','Louise','Owens','lowens3u@illinois.edu',23,'Female','1960-04-04','China','Japanese','South Korea','','6445 Havey Junction',8873587,'9670168666','0','PTNT-000190','0000-00-00','0000-00-00'),('Oliver','Philip','Bell','pbell3v@wikia.com',53,'Male','1996-10-18','Poland','Navajo','China','','5 South Lane',7118539,'9385798220','0','PTNT-000191','0000-00-00','0000-00-00'),('Gonzales','Chris','Williams','cwilliams3w@naver.com',46,'Male','1968-03-13','Luxembourg','Malaysian','Philippines','','137 Raven Court',7944544,'9275946007','0','PTNT-000192','0000-00-00','0000-00-00'),('Henderson','Gregory','Cole','gcole3x@booking.com',65,'Male','1982-10-11','Croatia','Pima','Comoros','','49 Burning Wood Center',8415259,'9689264207','0','PTNT-000193','0000-00-00','0000-00-00'),('Wood','Kathryn','Smith','ksmith3y@delicious.com',2,'Female','1987-04-25','Ukraine','Salvadoran','Croatia','','18 Pepper Wood Point',4892906,'9128329244','0','PTNT-000194','0000-00-00','0000-00-00'),('Mills','Patricia','Holmes','pholmes3z@opera.com',25,'Female','1967-06-17','Pakistan','American Indian','China','','6831 Carioca Point',6610157,'9287229832','0','PTNT-000195','0000-00-00','0000-00-00'),('Chavez','Sara','Welch','swelch40@berkeley.edu',27,'Female','2013-11-14','Equatorial Guinea','Thai','Peru','','609 Westerfield Pass',7415355,'9546208020','0','PTNT-000196','0000-00-00','0000-00-00'),('James','Sarah','Richards','srichards41@themeforest.net',72,'Female','2009-12-12','Sweden','Chilean','Poland','','7 Kingsford Hill',3788862,'9892217009','0','PTNT-000197','0000-00-00','0000-00-00'),('Banks','Louise','Thomas','lthomas42@ifeng.com',3,'Female','1982-08-12','Russia','Polynesian','France','','64 Mariners Cove Point',9457577,'9650838484','0','PTNT-000198','0000-00-00','0000-00-00'),('Murray','Todd','James','tjames43@weebly.com',35,'Male','2006-01-07','Russia','Cree','Jordan','','737 Buena Vista Street',5753020,'9771413256','0','PTNT-000199','0000-00-00','0000-00-00'),('Stephens','George','Cox','gcox44@forbes.com',94,'Male','1953-06-01','Philippines','Yaqui','Eritrea','','24 Merchant Junction',3556168,'9271286040','0','PTNT-000200','0000-00-00','0000-00-00'),('Brown','Laura','Perkins','lperkins45@dagondesign.com',41,'Female','1954-09-19','Vietnam','Tohono O\'Odham','France','','714 Haas Parkway',6742111,'9663135387','0','PTNT-000201','0000-00-00','0000-00-00'),('Medina','Russell','Gonzalez','rgonzalez46@archive.org',56,'Male','2006-07-27','Norway','Vietnamese','Poland','','55 Amoth Court',8658707,'9498464166','0','PTNT-000202','0000-00-00','0000-00-00'),('Bowman','Tina','Woods','twoods47@blogger.com',29,'Female','1957-12-25','China','Asian Indian','Mexico','','293 Clove Lane',4353486,'9804501491','0','PTNT-000203','0000-00-00','0000-00-00'),('Nichols','Heather','Ellis','hellis48@photobucket.com',66,'Female','2014-11-19','Pakistan','Laotian','Sweden','','57463 Union Drive',3397698,'9271155219','0','PTNT-000204','0000-00-00','0000-00-00'),('Mendoza','Antonio','Kim','akim49@infoseek.co.jp',57,'Male','1995-04-04','Colombia','Korean','Azerbaijan','','9695 Dawn Junction',3421387,'9204200488','0','PTNT-000205','0000-00-00','0000-00-00'),('Moreno','Betty','Romero','bromero4a@yahoo.com',5,'Female','1967-02-18','Japan','Pueblo','Egypt','','54608 Killdeer Way',8584161,'9404423620','0','PTNT-000206','0000-00-00','0000-00-00'),('Moreno','Jeffrey','Hudson','jhudson4b@odnoklassniki.ru',31,'Male','1989-05-23','Papua New Guinea','Iroquois','Philippines','','99 Lakewood Trail',6882852,'9241055125','0','PTNT-000207','0000-00-00','0000-00-00'),('Roberts','Susan','Taylor','staylor4c@soup.io',26,'Female','1956-03-20','Russia','Choctaw','Luxembourg','','7698 Oneill Court',6719344,'9146422481','0','PTNT-000208','0000-00-00','0000-00-00'),('Richardson','Debra','Myers','dmyers4d@biblegateway.com',70,'Female','1977-06-01','United States','Peruvian','Brazil','','3 Michigan Way',2114594,'9737683721','0','PTNT-000209','0000-00-00','0000-00-00'),('Diaz','Amanda','Carroll','acarroll4e@edublogs.org',71,'Female','1965-02-05','Russia','Alaskan Athabascan','China','','80794 Sachtjen Avenue',3840706,'9511592103','0','PTNT-000210','0000-00-00','0000-00-00'),('Burns','Anna','Campbell','acampbell4f@pen.io',62,'Female','1980-06-04','Nigeria','Fijian','Uganda','','6 Graedel Street',4282626,'9152594874','0','PTNT-000211','0000-00-00','0000-00-00'),('Foster','William','Rogers','wrogers4g@java.com',44,'Male','1986-08-02','Comoros','Laotian','South Korea','','43672 Boyd Street',4346997,'9247827007','0','PTNT-000212','0000-00-00','0000-00-00'),('Henderson','Michael','Welch','mwelch4h@amazon.co.jp',66,'Male','1986-04-22','Philippines','Bolivian','Russia','','13959 Becker Circle',2388387,'9581293781','0','PTNT-000213','0000-00-00','0000-00-00'),('Johnson','Sharon','Mccoy','smccoy4i@nature.com',36,'Female','2015-08-05','Colombia','Creek','Latvia','','92105 Messerschmidt Plaza',5529701,'9809012918','0','PTNT-000214','0000-00-00','0000-00-00'),('Sullivan','Andrew','Lopez','alopez4j@bloglovin.com',4,'Male','1994-05-14','Russia','Polynesian','Zimbabwe','','1 Towne Lane',3173035,'9582234991','0','PTNT-000215','0000-00-00','0000-00-00'),('Mccoy','Irene','Bradley','ibradley4k@guardian.co.uk',33,'Female','1967-10-24','Czech Republic','Fijian','French Guiana','','60 Rieder Drive',8366619,'9076452207','0','PTNT-000216','0000-00-00','0000-00-00'),('Carr','Virginia','Oliver','voliver4l@shutterfly.com',82,'Female','2002-10-25','Poland','Filipino','Portugal','','32621 Brown Place',3463908,'9063012602','0','PTNT-000217','0000-00-00','0000-00-00'),('Watkins','Jerry','Mason','jmason4m@reuters.com',90,'Male','1957-07-28','Niger','Pueblo','New Zealand','','0 Messerschmidt Way',3863270,'9734678808','0','PTNT-000218','0000-00-00','0000-00-00'),('Bishop','Bruce','Webb','bwebb4n@wikia.com',95,'Male','1958-06-04','Ukraine','Choctaw','Syria','','0 Petterle Terrace',4975593,'9219623904','0','PTNT-000219','0000-00-00','0000-00-00'),('Richardson','Kimberly','Andrews','kandrews4o@census.gov',88,'Female','1970-01-31','China','Salvadoran','Lithuania','','96 Stone Corner Center',9284666,'9642670249','0','PTNT-000220','0000-00-00','0000-00-00'),('Little','Shawn','Campbell','scampbell4p@wp.com',75,'Male','1964-09-24','Poland','Salvadoran','United States','','8 Fieldstone Trail',2758296,'9767634324','0','PTNT-000221','0000-00-00','0000-00-00'),('Powell','Cheryl','Peterson','cpeterson4q@topsy.com',92,'Female','2013-03-03','China','Asian','North Korea','','13 Service Avenue',9822879,'9726570147','0','PTNT-000222','0000-00-00','0000-00-00'),('Burns','Samuel','Richardson','srichardson4r@sciencedaily.com',52,'Male','1989-06-07','Russia','Osage','Japan','','29 Old Gate Crossing',5379868,'9836276733','0','PTNT-000223','0000-00-00','0000-00-00'),('Gonzales','Brenda','Howard','bhoward4s@utexas.edu',42,'Female','1972-02-05','Ukraine','Nicaraguan','Russia','','19 Barnett Avenue',3281260,'9720158451','0','PTNT-000224','0000-00-00','0000-00-00'),('Foster','Arthur','Ruiz','aruiz4t@indiegogo.com',76,'Male','1963-10-30','China','Argentinian','Portugal','','85 Springview Circle',5685921,'9412067031','0','PTNT-000225','0000-00-00','0000-00-00'),('Mitchell','Carlos','Ryan','cryan4u@indiegogo.com',88,'Male','1968-10-31','Poland','Shoshone','Chile','','61 Hudson Pass',2331924,'9254454051','0','PTNT-000226','0000-00-00','0000-00-00'),('Palmer','Lois','Myers','lmyers4v@a8.net',97,'Female','1970-07-18','China','Alaskan Athabascan','Portugal','','0275 Linden Parkway',3828797,'9777119445','0','PTNT-000227','0000-00-00','0000-00-00'),('Hamilton','Adam','Burton','aburton4w@ebay.co.uk',36,'Male','1988-02-11','Greenland','Pakistani','Philippines','','6747 Summer Ridge Point',6930970,'9444602209','0','PTNT-000228','0000-00-00','0000-00-00'),('Jenkins','Henry','Berry','hberry4x@bigcartel.com',49,'Male','2002-02-10','China','Micronesian','China','','211 Burrows Plaza',5794263,'9062502645','0','PTNT-000229','0000-00-00','0000-00-00'),('Rice','Wayne','Wallace','wwallace4y@cnet.com',1,'Male','2003-12-19','Chile','Seminole','Philippines','','365 Eagle Crest Park',6381247,'9324798204','0','PTNT-000230','0000-00-00','0000-00-00'),('Carroll','Jean','Foster','jfoster4z@narod.ru',77,'Female','2014-09-29','Indonesia','Argentinian','China','','6231 Blackbird Parkway',4067590,'9073983973','0','PTNT-000231','0000-00-00','0000-00-00'),('Dean','Jack','Sullivan','jsullivan50@icio.us',98,'Male','2016-01-26','Finland','Seminole','Kosovo','','76716 Arizona Plaza',1960269,'9832756920','0','PTNT-000232','0000-00-00','0000-00-00'),('Hayes','Maria','Jones','mjones51@nationalgeographic.com',92,'Female','1967-08-21','Philippines','Thai','United States','','97908 Kropf Park',4716297,'9566149948','0','PTNT-000233','0000-00-00','0000-00-00'),('Baker','Carol','Pierce','cpierce52@nymag.com',62,'Female','1985-09-03','Greece','Latin American Indian','Russia','','060 Logan Hill',4107852,'9466310412','0','PTNT-000234','0000-00-00','0000-00-00'),('Dean','Nancy','Simmons','nsimmons53@soup.io',30,'Female','1986-09-04','Chile','Aleut','Japan','','70 Kensington Drive',7115292,'9504742292','0','PTNT-000235','0000-00-00','0000-00-00'),('Harrison','Eric','Boyd','eboyd54@unc.edu',11,'Male','1977-11-04','United States','Ecuadorian','South Africa','','635 Warner Pass',9245739,'9353688278','0','PTNT-000236','0000-00-00','0000-00-00'),('Gilbert','Heather','Berry','hberry55@cocolog-nifty.com',12,'Female','1977-04-23','Indonesia','Central American','Mongolia','','1 David Circle',7962538,'9656194338','0','PTNT-000237','0000-00-00','0000-00-00'),('West','Judy','Harrison','jharrison56@time.com',32,'Female','1981-06-20','China','Colombian','Philippines','','06378 Eastwood Pass',1908125,'9018898119','0','PTNT-000238','0000-00-00','0000-00-00'),('Bishop','Douglas','Cunningham','dcunningham57@netlog.com',10,'Male','1986-01-06','Norway','Ecuadorian','Argentina','','76 Ridgeview Center',2429224,'9358666078','0','PTNT-000239','0000-00-00','0000-00-00'),('Ross','Ralph','Henry','rhenry58@umich.edu',59,'Male','1969-06-28','Portugal','Potawatomi','China','','7 Roth Point',4304577,'9001166608','0','PTNT-000240','0000-00-00','0000-00-00'),('Ray','Ernest','Myers','emyers59@mapquest.com',7,'Male','2016-01-02','Czech Republic','Spaniard','Panama','','38 Moland Crossing',9917214,'9686816515','0','PTNT-000241','0000-00-00','0000-00-00'),('Brooks','Willie','Rice','wrice5a@usnews.com',5,'Male','1990-07-09','China','Pima','China','','39506 Fulton Terrace',5399290,'9635948872','0','PTNT-000242','0000-00-00','0000-00-00'),('Thompson','Judith','Bradley','jbradley5b@ebay.com',53,'Female','1960-01-05','Denmark','Tongan','Latvia','','091 Dexter Avenue',8297908,'9600223208','0','PTNT-000243','0000-00-00','0000-00-00'),('Robinson','Denise','Jacobs','djacobs5c@jalbum.net',54,'Female','1978-01-13','China','Apache','France','','067 Basil Terrace',2573413,'9303286657','0','PTNT-000244','0000-00-00','0000-00-00'),('Hayes','John','Ramos','jramos5d@bravesites.com',86,'Male','1963-07-14','Brazil','Osage','Philippines','','7 Tony Hill',5766849,'9462148820','0','PTNT-000245','0000-00-00','0000-00-00'),('Chavez','Terry','Collins','tcollins5e@tinyurl.com',84,'Male','1991-06-10','Indonesia','Crow','Haiti','','33 Pennsylvania Parkway',9761555,'9991263267','0','PTNT-000246','0000-00-00','0000-00-00'),('Allen','Billy','Weaver','bweaver5f@wikispaces.com',8,'Male','1977-05-28','Nigeria','Potawatomi','Russia','','211 Shasta Pass',4176383,'9714301271','0','PTNT-000247','0000-00-00','0000-00-00'),('Harris','Frances','Lewis','flewis5g@fema.gov',13,'Female','1950-03-08','South Africa','Chinese','Thailand','','704 Monterey Lane',2084470,'9087602600','0','PTNT-000248','0000-00-00','0000-00-00'),('Stevens','Ann','Fields','afields5h@wix.com',36,'Female','1981-03-28','Russia','Hmong','Poland','','34 Messerschmidt Street',5468512,'9377276605','0','PTNT-000249','0000-00-00','0000-00-00'),('James','Craig','Price','cprice5i@bandcamp.com',67,'Male','2003-07-12','Saint Kitts and Nevis','Alaska Native','Czech Republic','','030 Harbort Center',9356325,'9339430187','0','PTNT-000250','0000-00-00','0000-00-00'),('Stanley','Joseph','Hart','jhart5j@boston.com',75,'Male','2009-12-30','Philippines','White','Portugal','','7 Marquette Pass',5826311,'9842656101','0','PTNT-000251','0000-00-00','0000-00-00'),('Bishop','Rebecca','Nelson','rnelson5k@slideshare.net',77,'Female','1989-08-05','China','Kiowa','Belarus','','183 Oxford Junction',4393875,'9521021823','0','PTNT-000252','0000-00-00','0000-00-00'),('Hernandez','Keith','Vasquez','kvasquez5l@nyu.edu',42,'Male','1968-11-02','Japan','Pakistani','Brazil','','5973 Nelson Lane',2667242,'9093512487','0','PTNT-000253','0000-00-00','0000-00-00'),('Henderson','Johnny','Carr','jcarr5m@discovery.com',11,'Male','1985-01-26','Russia','Honduran','Russia','','97 Schiller Junction',5046610,'9131989207','0','PTNT-000254','0000-00-00','0000-00-00'),('Harvey','Amanda','Edwards','aedwards5n@google.cn',49,'Female','1996-12-25','China','Tlingit-Haida','Honduras','','8909 Harbort Place',7167564,'9736559729','0','PTNT-000255','0000-00-00','0000-00-00'),('Turner','Bruce','Carter','bcarter5o@google.com.au',64,'Male','1966-10-26','Russia','Guatemalan','Russia','','295 Packers Hill',4252751,'9609367059','0','PTNT-000256','0000-00-00','0000-00-00'),('Gibson','Steve','Cole','scole5p@t.co',5,'Male','2013-10-06','Brazil','Yakama','China','','889 Independence Lane',6409438,'9465014706','0','PTNT-000257','0000-00-00','0000-00-00'),('Howell','Jose','Cooper','jcooper5q@wikia.com',95,'Male','1951-01-30','Ukraine','Chilean','China','','2 Service Center',1318625,'9949335622','0','PTNT-000258','0000-00-00','0000-00-00'),('Stephens','Harold','Foster','hfoster5r@statcounter.com',93,'Male','1988-04-28','Democratic Republic of the Congo','Potawatomi','Indonesia','','18 Darwin Lane',5723963,'9257798554','0','PTNT-000259','0000-00-00','0000-00-00'),('Perkins','Katherine','Reynolds','kreynolds5s@github.io',87,'Female','2008-12-21','Costa Rica','Guamanian','Ukraine','','80628 Upham Drive',2647297,'9655953304','0','PTNT-000260','0000-00-00','0000-00-00'),('Barnes','Mildred','Mason','mmason5t@sitemeter.com',85,'Female','1966-04-25','United States','Ecuadorian','Canada','','537 Derek Crossing',2376691,'9055400019','0','PTNT-000261','0000-00-00','0000-00-00'),('Hamilton','Billy','Ramos','bramos5u@liveinternet.ru',8,'Male','1985-07-11','Brazil','Taiwanese','Thailand','','46 Lake View Road',8745813,'9319989406','0','PTNT-000262','0000-00-00','0000-00-00'),('Morrison','Kathleen','Brown','kbrown5v@narod.ru',28,'Female','2010-02-04','Finland','Bangladeshi','Suriname','','45604 Southridge Hill',6697972,'9310965006','0','PTNT-000263','0000-00-00','0000-00-00'),('Thomas','Karen','Morris','kmorris5w@nba.com',57,'Female','2013-12-03','China','Aleut','Philippines','','4 Drewry Drive',4338088,'9575116587','0','PTNT-000264','0000-00-00','0000-00-00'),('Gutierrez','Larry','Mills','lmills5x@army.mil',17,'Male','1993-04-15','Latvia','Alaskan Athabascan','Canada','','0 Mcbride Crossing',4820932,'9649719535','0','PTNT-000265','0000-00-00','0000-00-00'),('Henderson','Larry','Barnes','lbarnes5y@deviantart.com',29,'Male','1964-02-02','Indonesia','Paraguayan','Maldives','','755 Hintze Crossing',4417122,'9709066190','0','PTNT-000266','0000-00-00','0000-00-00'),('Miller','Betty','Webb','bwebb5z@nhs.uk',45,'Female','2003-09-15','Denmark','Paraguayan','Philippines','','074 Upham Center',8666168,'9218748663','0','PTNT-000267','0000-00-00','0000-00-00'),('Sims','Nicholas','Bailey','nbailey60@php.net',46,'Male','1967-06-07','Thailand','Black or African American','Indonesia','','1 Northland Terrace',8729740,'9075719870','0','PTNT-000268','0000-00-00','0000-00-00'),('Dunn','Nicole','Cruz','ncruz61@google.com.au',68,'Female','1989-12-12','Indonesia','Alaska Native','Peru','','757 Caliangt Alley',3060466,'9419972906','0','PTNT-000269','0000-00-00','0000-00-00'),('Martinez','Jean','Lane','jlane62@accuweather.com',27,'Female','2013-05-05','Indonesia','Chamorro','Indonesia','','04 Butterfield Terrace',6277219,'9245290390','0','PTNT-000270','0000-00-00','0000-00-00'),('Perry','Katherine','Kennedy','kkennedy63@lulu.com',48,'Female','1958-09-15','Indonesia','Seminole','Philippines','','502 Coolidge Lane',2736864,'9392648676','0','PTNT-000271','0000-00-00','0000-00-00'),('Shaw','Frank','Tucker','ftucker64@cbsnews.com',100,'Male','1969-05-08','South Africa','Samoan','Russia','','5331 Esch Center',7244379,'9456443544','0','PTNT-000272','0000-00-00','0000-00-00'),('Carroll','Tammy','Dunn','tdunn65@delicious.com',76,'Female','1997-07-13','China','Cambodian','Vietnam','','04 Annamark Way',5692350,'9381038138','0','PTNT-000273','0000-00-00','0000-00-00'),('Myers','Robin','George','rgeorge66@skype.com',50,'Female','1976-03-08','China','Ecuadorian','China','','78 Becker Plaza',8322753,'9229621693','0','PTNT-000274','0000-00-00','0000-00-00'),('Cook','Kelly','Sullivan','ksullivan67@booking.com',97,'Female','2002-01-16','France','Puget Sound Salish','Indonesia','','5774 Service Parkway',8207345,'9276854120','0','PTNT-000275','0000-00-00','0000-00-00'),('Peterson','Ruby','Perez','rperez68@nsw.gov.au',69,'Female','1993-05-10','China','Navajo','Portugal','','6 Glacier Hill Place',6075008,'9298247080','0','PTNT-000276','0000-00-00','0000-00-00'),('Price','Raymond','Davis','rdavis69@house.gov',83,'Male','2003-12-23','Taiwan','Pima','Japan','','023 2nd Park',6555179,'9480882462','0','PTNT-000277','0000-00-00','0000-00-00'),('Carpenter','Christine','Sanders','csanders6a@blogs.com',34,'Female','1957-08-21','China','Chilean','Brazil','','90782 Schurz Parkway',8137991,'9172095097','0','PTNT-000278','0000-00-00','0000-00-00'),('Payne','Elizabeth','Long','elong6b@ft.com',33,'Female','1979-10-30','China','Blackfeet','China','','981 Carberry Junction',4525532,'9161789585','0','PTNT-000279','0000-00-00','0000-00-00'),('Simmons','Catherine','Garrett','cgarrett6c@globo.com',88,'Female','2016-05-18','Iran','Cambodian','China','','2845 Florence Place',5573679,'9570453244','0','PTNT-000280','0000-00-00','0000-00-00'),('Martinez','Susan','Riley','sriley6d@nature.com',86,'Female','2002-04-27','Tunisia','Pima','Indonesia','','4118 Ridgeview Circle',9475431,'9782202914','0','PTNT-000281','0000-00-00','0000-00-00'),('Montgomery','Jason','Greene','jgreene6e@creativecommons.org',86,'Male','2006-06-21','Brazil','Central American','Mexico','','961 Charing Cross Pass',5133726,'9986730476','0','PTNT-000282','0000-00-00','0000-00-00'),('Carr','Kathy','Graham','kgraham6f@nydailynews.com',49,'Female','1982-02-04','Canada','Asian Indian','South Africa','','2 Eggendart Pass',9353061,'9113174051','0','PTNT-000283','0000-00-00','0000-00-00'),('Hunt','Mary','Henry','mhenry6g@acquirethisname.com',66,'Female','1954-06-03','Pakistan','Samoan','Yemen','','3125 Ronald Regan Hill',3998015,'9202650921','0','PTNT-000284','0000-00-00','0000-00-00'),('Pierce','Andrea','Ramirez','aramirez6h@washingtonpost.com',63,'Female','2000-06-07','Argentina','Micronesian','Argentina','','807 Vernon Pass',2129634,'9580406715','0','PTNT-000285','0000-00-00','0000-00-00'),('Carroll','Rose','Day','rday6i@economist.com',23,'Female','2010-09-17','North Korea','Indonesian','China','','02240 Hoffman Avenue',5503065,'9874958792','0','PTNT-000286','0000-00-00','0000-00-00'),('Little','Ronald','Thomas','rthomas6j@cnn.com',32,'Male','2001-12-27','Indonesia','Indonesian','Croatia','','88 Center Avenue',4695753,'9755558984','0','PTNT-000287','0000-00-00','0000-00-00'),('Jordan','Russell','Medina','rmedina6k@parallels.com',25,'Male','1976-12-26','Russia','Cambodian','Indonesia','','574 Surrey Junction',1625308,'9333510260','0','PTNT-000288','0000-00-00','0000-00-00'),('Morrison','David','Howard','dhoward6l@so-net.ne.jp',39,'Male','1999-12-04','Finland','White','Portugal','','8612 Blue Bill Park Lane',1873202,'9755407705','0','PTNT-000289','0000-00-00','0000-00-00'),('Robertson','Jose','Gray','jgray6m@uol.com.br',61,'Male','1985-10-20','Iran','Costa Rican','Vietnam','','6652 Westridge Lane',8680629,'9472243473','0','PTNT-000290','0000-00-00','0000-00-00'),('Harvey','Charles','Clark','cclark6n@discovery.com',31,'Male','1973-08-03','China','Laotian','China','','805 Glacier Hill Plaza',7056971,'9386205335','0','PTNT-000291','0000-00-00','0000-00-00'),('Wright','Anthony','Reid','areid6o@dell.com',71,'Male','1960-04-29','Serbia','Colombian','Malaysia','','4 Crownhardt Street',5144783,'9730635205','0','PTNT-000292','0000-00-00','0000-00-00'),('Morales','Joan','Rivera','jrivera6p@spotify.com',80,'Female','1963-03-22','Portugal','Sri Lankan','China','','6387 Esch Trail',2326574,'9833555910','0','PTNT-000293','0000-00-00','0000-00-00'),('Fernandez','Nicholas','Stewart','nstewart6q@hostgator.com',63,'Male','2000-10-17','Germany','South American','Malaysia','','6 Mallory Alley',8596849,'9708120780','0','PTNT-000294','0000-00-00','0000-00-00'),('Smith','Joseph','Hill','jhill6r@msn.com',17,'Male','1988-12-10','China','Spaniard','Russia','','94 Rutledge Plaza',9475263,'9385782863','0','PTNT-000295','0000-00-00','0000-00-00'),('Hicks','Eric','Dunn','edunn6s@qq.com',51,'Male','1991-02-24','United Kingdom','Puget Sound Salish','Tanzania','','0018 Springs Point',9810658,'9282202783','0','PTNT-000296','0000-00-00','0000-00-00'),('Scott','Michael','Martinez','mmartinez6t@storify.com',41,'Male','1986-04-03','Portugal','Costa Rican','Argentina','','6699 Kinsman Crossing',7066704,'9295497415','0','PTNT-000297','0000-00-00','0000-00-00'),('Martinez','Kimberly','Fowler','kfowler6u@cyberchimps.com',10,'Female','1959-02-18','Sweden','White','Russia','','68283 Canary Terrace',8854138,'9565210186','0','PTNT-000298','0000-00-00','0000-00-00'),('Morales','Theresa','Medina','tmedina6v@bloomberg.com',49,'Female','1976-11-24','Democratic Republic of the Congo','Aleut','Russia','','0259 Logan Court',8393575,'9909815643','0','PTNT-000299','0000-00-00','0000-00-00'),('Stephens','Matthew','Rice','mrice6w@va.gov',41,'Male','1989-02-12','Brazil','Choctaw','Armenia','','83397 Amoth Street',4263692,'9202548415','0','PTNT-000300','0000-00-00','0000-00-00'),('Simmons','Ronald','Montgomery','rmontgomery6x@google.com.au',24,'Male','1963-05-28','China','Central American','Philippines','','4 Granby Place',8406220,'9355280202','0','PTNT-000301','0000-00-00','0000-00-00'),('Gray','Anthony','Little','alittle6y@ow.ly',12,'Male','1991-12-09','Bulgaria','Cheyenne','Belarus','','05507 Wayridge Avenue',7912866,'9614310679','0','PTNT-000302','0000-00-00','0000-00-00'),('Powell','Norma','Daniels','ndaniels6z@nbcnews.com',37,'Female','1951-01-13','Swaziland','Salvadoran','Russia','','262 Anhalt Point',5086077,'9962421521','0','PTNT-000303','0000-00-00','0000-00-00'),('Riley','Jesse','Elliott','jelliott70@addtoany.com',96,'Male','2015-09-28','Iran','Thai','United States','','24 Goodland Point',9852387,'9539631700','0','PTNT-000304','0000-00-00','0000-00-00'),('Burns','Amy','Washington','awashington71@cdbaby.com',10,'Female','1959-04-29','Albania','Chickasaw','Portugal','','3021 Schlimgen Hill',3471455,'9471480874','0','PTNT-000305','0000-00-00','0000-00-00'),('Peters','Laura','Gordon','lgordon72@linkedin.com',73,'Female','1972-08-25','Indonesia','Asian','Portugal','','0369 South Point',1410887,'9184570098','0','PTNT-000306','0000-00-00','0000-00-00'),('Morrison','Harold','Knight','hknight73@sakura.ne.jp',27,'Male','2008-03-26','Indonesia','American Indian and Alaska Native (AIAN)','Philippines','','23793 Chive Center',3642897,'9043268409','0','PTNT-000307','0000-00-00','0000-00-00'),('Hunter','Margaret','Price','mprice74@prnewswire.com',93,'Female','1995-09-17','Indonesia','Samoan','Indonesia','','9 Helena Road',4112117,'9595290827','0','PTNT-000308','0000-00-00','0000-00-00'),('Day','Todd','Hawkins','thawkins75@privacy.gov.au',74,'Male','1984-07-24','Brazil','Yaqui','Thailand','','49 Rockefeller Drive',7724518,'9376492417','0','PTNT-000309','0000-00-00','0000-00-00'),('Green','Nicholas','Harper','nharper76@nydailynews.com',4,'Male','1968-04-24','Brazil','Hmong','Philippines','','0 Westport Court',6242253,'9478465601','0','PTNT-000310','0000-00-00','0000-00-00'),('Gibson','Antonio','Morgan','amorgan77@sogou.com',15,'Male','1956-12-27','Cyprus','Laotian','Ukraine','','480 Schurz Point',7735932,'9434094001','0','PTNT-000311','0000-00-00','0000-00-00'),('Thomas','Martin','Dunn','mdunn78@sina.com.cn',78,'Male','1962-05-11','Argentina','Honduran','China','','72624 Clemons Way',2498328,'9103437611','0','PTNT-000312','0000-00-00','0000-00-00'),('Turner','Jason','Kelley','jkelley79@fema.gov',97,'Male','1953-03-21','Comoros','Ute','China','','7847 Dawn Hill',5275035,'9576844193','0','PTNT-000313','0000-00-00','0000-00-00'),('Martin','Helen','Gonzales','hgonzales7a@indiegogo.com',64,'Female','1965-03-11','Philippines','Navajo','Russia','','04302 Forest Crossing',4952553,'9133847233','0','PTNT-000314','0000-00-00','0000-00-00'),('Hicks','Rebecca','James','rjames7b@nih.gov',3,'Female','1978-02-27','China','Sioux','Armenia','','8797 Merchant Road',4257592,'9165490061','0','PTNT-000315','0000-00-00','0000-00-00'),('Dean','Dorothy','Stone','dstone7c@si.edu',6,'Female','2001-05-31','Indonesia','Fijian','China','','00 Donald Pass',4838646,'9711408567','0','PTNT-000316','0000-00-00','0000-00-00'),('Perez','Marie','Vasquez','mvasquez7d@sohu.com',21,'Female','1977-11-29','Indonesia','Cuban','Ukraine','','00831 Riverside Junction',7364626,'9527901951','0','PTNT-000317','0000-00-00','0000-00-00'),('Rivera','Adam','Larson','alarson7e@nydailynews.com',77,'Male','1969-06-03','Philippines','Dominican (Dominican Republic)','Mexico','','657 Ronald Regan Plaza',6051843,'9561248244','0','PTNT-000318','0000-00-00','0000-00-00'),('Knight','Randy','Johnson','rjohnson7f@nifty.com',41,'Male','1995-06-29','France','Micronesian','Russia','','68437 Waywood Street',1668289,'9470707732','0','PTNT-000319','0000-00-00','0000-00-00'),('Wood','Gloria','Burton','gburton7g@nhs.uk',54,'Female','1960-09-14','China','Thai','Nigeria','','50 Vermont Junction',5230306,'9890643976','0','PTNT-000320','0000-00-00','0000-00-00'),('Johnston','Christine','Moore','cmoore7h@princeton.edu',76,'Female','1977-09-25','Sweden','Bangladeshi','United States','','1402 Mcguire Circle',8789305,'9668296799','0','PTNT-000321','0000-00-00','0000-00-00'),('Owens','Shirley','Fisher','sfisher7i@wisc.edu',71,'Female','1980-06-15','France','Hmong','Malaysia','','87557 Anthes Crossing',3298057,'9396662059','0','PTNT-000322','0000-00-00','0000-00-00'),('Carroll','Dorothy','Webb','dwebb7j@skype.com',55,'Female','1955-12-17','Sweden','American Indian and Alaska Native (AIAN)','Indonesia','','3553 Manufacturers Alley',3017654,'9105128098','0','PTNT-000323','0000-00-00','0000-00-00'),('Brooks','William','Reyes','wreyes7k@godaddy.com',71,'Male','1994-11-26','Belarus','Mexican','Venezuela','','4060 Florence Circle',6819793,'9025377524','0','PTNT-000324','0000-00-00','0000-00-00'),('Bishop','Sharon','Carroll','scarroll7l@yelp.com',65,'Female','1990-09-04','France','Guamanian','Ivory Coast','','0335 West Park',5585436,'9455168441','0','PTNT-000325','0000-00-00','0000-00-00'),('Gordon','Tina','Woods','twoods7m@cam.ac.uk',40,'Female','1978-04-21','Ukraine','Chinese','Cameroon','','902 Southridge Junction',8864325,'9800061447','0','PTNT-000326','0000-00-00','0000-00-00'),('Powell','Alan','Alexander','aalexander7n@economist.com',85,'Male','1988-12-10','France','Alaska Native','Russia','','1516 Northland Road',7086714,'9833271500','0','PTNT-000327','0000-00-00','0000-00-00'),('Matthews','Maria','Ferguson','mferguson7o@hubpages.com',59,'Female','1999-07-29','Mexico','Seminole','Haiti','','371 Londonderry Road',2113365,'9083072776','0','PTNT-000328','0000-00-00','0000-00-00'),('Meyer','Shirley','Ortiz','sortiz7p@surveymonkey.com',46,'Female','2006-10-31','Palestinian Territory','Native Hawaiian','Indonesia','','2 Nevada Place',6256602,'9575714678','0','PTNT-000329','0000-00-00','0000-00-00'),('Fox','Paul','Welch','pwelch7q@hibu.com',92,'Male','1981-02-26','Indonesia','Potawatomi','Indonesia','','7 Eggendart Trail',6721436,'9341341657','0','PTNT-000330','0000-00-00','0000-00-00'),('Patterson','James','Day','jday7r@elegantthemes.com',79,'Male','2014-03-22','Poland','Puget Sound Salish','China','','27688 Derek Point',1835866,'9548432318','0','PTNT-000331','0000-00-00','0000-00-00'),('Day','Elizabeth','Larson','elarson7s@latimes.com',59,'Female','2014-08-14','Philippines','Guatemalan','China','','622 Barby Street',8963655,'9035706749','0','PTNT-000332','0000-00-00','0000-00-00'),('Anderson','Joseph','Moore','jmoore7t@soup.io',59,'Male','1986-08-20','Sierra Leone','Honduran','Nepal','','86955 Cambridge Avenue',2102349,'9129045209','0','PTNT-000333','0000-00-00','0000-00-00'),('Johnston','Antonio','Garrett','agarrett7u@surveymonkey.com',49,'Male','1970-12-04','Poland','Tlingit-Haida','Portugal','','6 Susan Center',2955087,'9257505515','0','PTNT-000334','0000-00-00','0000-00-00'),('Carter','Matthew','Alexander','malexander7v@i2i.jp',62,'Male','1982-11-26','Colombia','Chickasaw','United States','','0 Green Ridge Crossing',5951135,'9697144727','0','PTNT-000335','0000-00-00','0000-00-00'),('Berry','Maria','Harris','mharris7w@foxnews.com',38,'Female','2006-12-25','China','Cuban','Russia','','45390 Division Place',1737410,'9682533340','0','PTNT-000336','0000-00-00','0000-00-00'),('Peterson','Ashley','Campbell','acampbell7x@samsung.com',12,'Female','1994-01-03','Philippines','American Indian and Alaska Native (AIAN)','Argentina','','906 Almo Alley',7669223,'9232500611','0','PTNT-000337','0000-00-00','0000-00-00'),('Banks','Gerald','Moreno','gmoreno7y@opera.com',42,'Male','2005-10-24','Portugal','Seminole','China','','1628 Elgar Court',9292641,'9970445210','0','PTNT-000338','0000-00-00','0000-00-00'),('Larson','Deborah','Fisher','dfisher7z@epa.gov',50,'Female','1985-08-18','Philippines','Native Hawaiian','Argentina','','95 Hagan Way',9108093,'9551809772','0','PTNT-000339','0000-00-00','0000-00-00'),('Webb','Anne','Chapman','achapman80@sourceforge.net',76,'Female','1969-03-15','Mexico','Latin American Indian','Ireland','','87890 Ridgeview Terrace',4184995,'9304524417','0','PTNT-000340','0000-00-00','0000-00-00'),('Jacobs','Jason','Sanders','jsanders81@wix.com',69,'Male','2013-08-26','Japan','Central American','Bangladesh','','71250 Red Cloud Point',5432814,'9127908595','0','PTNT-000341','0000-00-00','0000-00-00'),('Kim','Terry','Hart','thart82@comsenz.com',35,'Male','1995-02-13','Afghanistan','Houma','Russia','','85680 Jenifer Point',3656657,'9328765446','0','PTNT-000342','0000-00-00','0000-00-00'),('Griffin','Martha','Owens','mowens83@myspace.com',20,'Female','1973-05-17','Hungary','Korean','China','','7 Summerview Lane',7493927,'9855610982','0','PTNT-000343','0000-00-00','0000-00-00'),('Payne','Jack','Johnson','jjohnson84@e-recht24.de',57,'Male','1956-05-30','United States','Latin American Indian','Chile','','6 Kensington Road',8025807,'9981059713','0','PTNT-000344','0000-00-00','0000-00-00'),('Ortiz','Rose','Shaw','rshaw85@facebook.com',14,'Female','2003-10-09','Nigeria','Japanese','Lithuania','','47 Northport Drive',5474453,'9084917146','0','PTNT-000345','0000-00-00','0000-00-00'),('Rogers','Eugene','Dunn','edunn86@storify.com',74,'Male','2013-12-29','Germany','Indonesian','Indonesia','','91 Elka Parkway',8843454,'9346589844','0','PTNT-000346','0000-00-00','0000-00-00'),('Daniels','Tammy','Perry','tperry87@simplemachines.org',73,'Female','2013-02-03','Venezuela','Native Hawaiian and Other Pacific Islander (NHPI)','Kosovo','','79 Buena Vista Parkway',9783684,'9622754255','0','PTNT-000347','0000-00-00','0000-00-00'),('Sanchez','Jeffrey','Williamson','jwilliamson88@behance.net',29,'Male','1964-03-30','Papua New Guinea','Choctaw','Indonesia','','12823 Eastwood Street',8257802,'9534128179','0','PTNT-000348','0000-00-00','0000-00-00'),('Kelly','Juan','Moreno','jmoreno89@rambler.ru',43,'Male','2013-03-05','Japan','Menominee','China','','2597 Hollow Ridge Pass',1395127,'9662548476','0','PTNT-000349','0000-00-00','0000-00-00'),('Ruiz','Bruce','Armstrong','barmstrong8a@cnn.com',23,'Male','2011-04-04','Sweden','Argentinian','Sweden','','4 Ramsey Junction',2098033,'9401992250','0','PTNT-000350','0000-00-00','0000-00-00'),('Bryant','Ryan','Dean','rdean8b@wisc.edu',87,'Male','1998-04-28','Sweden','Puget Sound Salish','Philippines','','584 Rutledge Hill',6141428,'9090921148','0','PTNT-000351','0000-00-00','0000-00-00');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_patient_insert` BEFORE INSERT ON `patient` FOR EACH ROW BEGIN
  INSERT INTO patient_sequence VALUES (NULL);
  SET NEW.patient_id = CONCAT('PTNT-', LPAD(LAST_INSERT_ID(), 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `patient_category`
--

DROP TABLE IF EXISTS `patient_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_category` (
  `category_id` int(2) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `category_desc` varchar(255) NOT NULL,
  `patient_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `fk_Patient_patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_category`
--

LOCK TABLES `patient_category` WRITE;
/*!40000 ALTER TABLE `patient_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_sequence`
--

DROP TABLE IF EXISTS `patient_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_sequence` (
  `pat_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`pat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=352 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_sequence`
--

LOCK TABLES `patient_sequence` WRITE;
/*!40000 ALTER TABLE `patient_sequence` DISABLE KEYS */;
INSERT INTO `patient_sequence` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31),(32),(33),(34),(35),(36),(37),(38),(39),(40),(41),(42),(43),(44),(45),(46),(47),(48),(49),(50),(51),(52),(53),(54),(55),(56),(57),(58),(59),(60),(61),(62),(63),(64),(65),(66),(67),(68),(69),(70),(71),(72),(73),(74),(75),(76),(77),(78),(79),(80),(81),(82),(83),(84),(85),(86),(87),(88),(89),(90),(91),(92),(93),(94),(95),(96),(97),(98),(99),(100),(101),(102),(103),(104),(105),(106),(107),(108),(109),(110),(111),(112),(113),(114),(115),(116),(117),(118),(119),(120),(121),(122),(123),(124),(125),(126),(127),(128),(129),(130),(131),(132),(133),(134),(135),(136),(137),(138),(139),(140),(141),(142),(143),(144),(145),(146),(147),(148),(149),(150),(151),(152),(153),(154),(155),(156),(157),(158),(159),(160),(161),(162),(163),(164),(165),(166),(167),(168),(169),(170),(171),(172),(173),(174),(175),(176),(177),(178),(179),(180),(181),(182),(183),(184),(185),(186),(187),(188),(189),(190),(191),(192),(193),(194),(195),(196),(197),(198),(199),(200),(201),(202),(203),(204),(205),(206),(207),(208),(209),(210),(211),(212),(213),(214),(215),(216),(217),(218),(219),(220),(221),(222),(223),(224),(225),(226),(227),(228),(229),(230),(231),(232),(233),(234),(235),(236),(237),(238),(239),(240),(241),(242),(243),(244),(245),(246),(247),(248),(249),(250),(251),(252),(253),(254),(255),(256),(257),(258),(259),(260),(261),(262),(263),(264),(265),(266),(267),(268),(269),(270),(271),(272),(273),(274),(275),(276),(277),(278),(279),(280),(281),(282),(283),(284),(285),(286),(287),(288),(289),(290),(291),(292),(293),(294),(295),(296),(297),(298),(299),(300),(301),(302),(303),(304),(305),(306),(307),(308),(309),(310),(311),(312),(313),(314),(315),(316),(317),(318),(319),(320),(321),(322),(323),(324),(325),(326),(327),(328),(329),(330),(331),(332),(333),(334),(335),(336),(337),(338),(339),(340),(341),(342),(343),(344),(345),(346),(347),(348),(349),(350),(351);
/*!40000 ALTER TABLE `patient_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(50) NOT NULL,
  `permission_link` varchar(50) NOT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'Emergency Room','Admitting/EmergencyRoom',1),(2,'Direct Room','Admitting/DirectRoomAdmission',1),(3,'Admitted Patients','Admitting/AdmittedPatients',1),(4,'List','Patient/List',2),(5,'Make Radiology Request','Radiology/MakeRadiologyRequest',3),(6,'View Request Status','Radiology/ViewRequest',3),(7,'Radiology Maintenance','Radiology/Maintenance',3),(8,'All Requests','Radiology/RadiologyRequests',3),(9,'Report Bed','Rooms/ReportBed',4),(10,'Roles and permission','UserManagement/rolesandpermission',6),(11,'User','UserManagement/User',6),(12,'View Schedules','Appointment/viewschedule',7),(13,'My Schedule','Appointment/myschedule',7),(14,'Inventory','Pharmacy/pharmacy_inventory',8),(15,'Make Pharmacy Request','Pharmacy/pharmacy_request',8),(16,'Process Pharmacy Request','Pharmacy/process_pharmacy_request',8),(17,'Room Type','Rooms/RoomType',4),(18,'Room List','Rooms/Rooms',4),(19,'Pending Nurse Request','Csr/PendingRequests',10),(20,'Accepted Nurse Request','Csr/AcceptedRequests',10),(21,'Rejected Nurse Requests','Csr/RejectedRequests',10),(22,'Product List','Csr/ListofProducts',10),(23,'Product Request Restock','Csr/RequestRestock',10),(24,'Product Request History','Csr/RequestHistory',10),(25,'Request Item','Csr/RequestItem',10),(26,'Product Request','Csr/CSRProductRequest',10),(27,'View Request Status','Csr/ViewRequest',10),(28,'CSR Inventory','Purchasing/CSRInventory',11),(29,'CSR Requests','Purchasing/CSRRequests',11),(31,'Schedules','Appointment/schedules',7),(32,'Patient Billing','Billing/PatientBilling',5);
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_usertype`
--

DROP TABLE IF EXISTS `permission_usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_usertype` (
  `permission_usertype_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `access` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_usertype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_usertype`
--

LOCK TABLES `permission_usertype` WRITE;
/*!40000 ALTER TABLE `permission_usertype` DISABLE KEYS */;
INSERT INTO `permission_usertype` VALUES (5,1,4,1),(8,4,7,1),(9,4,8,1),(11,1,10,1),(12,1,11,1),(13,2,13,1),(14,5,14,1),(15,5,15,1),(16,5,16,1),(17,1,17,1),(18,7,28,1),(19,7,29,1),(20,9,19,1),(21,9,20,1),(22,9,21,1),(23,9,22,1),(24,9,23,1),(25,9,24,1),(26,9,28,1),(27,9,29,1),(28,14,1,1),(29,14,2,1),(30,14,3,1),(31,15,5,1),(32,15,7,1),(33,15,8,1),(34,3,3,1),(35,3,4,1),(36,3,5,1),(37,3,6,1),(38,3,9,1),(39,3,25,1),(40,3,27,1),(41,13,31,1),(42,3,15,1),(43,10,32,1);
/*!40000 ALTER TABLE `permission_usertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phar_aud_seq`
--

DROP TABLE IF EXISTS `phar_aud_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phar_aud_seq` (
  `phar_aud_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`phar_aud_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phar_aud_seq`
--

LOCK TABLES `phar_aud_seq` WRITE;
/*!40000 ALTER TABLE `phar_aud_seq` DISABLE KEYS */;
INSERT INTO `phar_aud_seq` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25);
/*!40000 ALTER TABLE `phar_aud_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharid_sequence`
--

DROP TABLE IF EXISTS `pharid_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharid_sequence` (
  `phar_item_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`phar_item_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharid_sequence`
--

LOCK TABLES `pharid_sequence` WRITE;
/*!40000 ALTER TABLE `pharid_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharid_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharm_bill_seq`
--

DROP TABLE IF EXISTS `pharm_bill_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharm_bill_seq` (
  `pharm_bill_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`pharm_bill_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharm_bill_seq`
--

LOCK TABLES `pharm_bill_seq` WRITE;
/*!40000 ALTER TABLE `pharm_bill_seq` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharm_bill_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharm_billing`
--

DROP TABLE IF EXISTS `pharm_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharm_billing` (
  `pharm_bill_id` varchar(30) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT 'Pharmacy Medicine',
  `bill_name` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `pharm_bill_status` tinyint(4) DEFAULT '0',
  `patient_id` varchar(30) NOT NULL,
  PRIMARY KEY (`pharm_bill_id`),
  KEY `fk_pharm_patient` (`patient_id`),
  CONSTRAINT `fk_pharm_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharm_billing`
--

LOCK TABLES `pharm_billing` WRITE;
/*!40000 ALTER TABLE `pharm_billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharm_billing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pharm_bill` BEFORE INSERT ON `pharm_billing` FOR EACH ROW BEGIN
  INSERT INTO pharm_bill_seq VALUES (NULL);
  SET NEW.pharm_bill_id = CONCAT('PHRM-BLL-', LPAD(LAST_INSERT_ID(), 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pharmacy_audit`
--

DROP TABLE IF EXISTS `pharmacy_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacy_audit` (
  `phar_aud_id` varchar(30) NOT NULL,
  `phar_item` varchar(30) NOT NULL,
  `phar_user_id` varchar(30) NOT NULL DEFAULT '0',
  `phar_patient` varchar(30) DEFAULT NULL,
  `quant_requested` int(11) NOT NULL,
  `total_price` float(10,2) NOT NULL,
  `date_req` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `phar_stat` tinyint(4) NOT NULL,
  `unique_id` varchar(255) NOT NULL,
  PRIMARY KEY (`phar_aud_id`),
  KEY `fk_Pat_pharm` (`phar_patient`),
  KEY `fk_item_id` (`phar_item`),
  KEY `fk_useridd` (`phar_user_id`),
  CONSTRAINT `phar_item_fk` FOREIGN KEY (`phar_item`) REFERENCES `pharmacy_inventory` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy_audit`
--

LOCK TABLES `pharmacy_audit` WRITE;
/*!40000 ALTER TABLE `pharmacy_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharmacy_audit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_phar_aud` BEFORE INSERT ON `pharmacy_audit` FOR EACH ROW BEGIN
  INSERT INTO phar_aud_seq VALUES (NULL);
  SET NEW.phar_aud_id = CONCAT('PHAR-AUD-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pharmacy_inventory`
--

DROP TABLE IF EXISTS `pharmacy_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacy_inventory` (
  `item_id` varchar(30) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_description` varchar(255) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  `item_price` float(10,2) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy_inventory`
--

LOCK TABLES `pharmacy_inventory` WRITE;
/*!40000 ALTER TABLE `pharmacy_inventory` DISABLE KEYS */;
INSERT INTO `pharmacy_inventory` VALUES ('1','Salnor','SOLUTION FOR INFUSION',25,500.00);
/*!40000 ALTER TABLE `pharmacy_inventory` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_item_id` BEFORE INSERT ON `pharmacy_inventory` FOR EACH ROW BEGIN
  INSERT INTO pharID_sequence VALUES (NULL);
  SET NEW.item_id = CONCAT('ITEM-', LPAD(LAST_INSERT_ID(), 4, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pharmacy_request`
--

DROP TABLE IF EXISTS `pharmacy_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacy_request` (
  `phar_req_id` int(11) NOT NULL AUTO_INCREMENT,
  `phar_req_quan` int(11) NOT NULL,
  `phar_item_id` varchar(30) NOT NULL,
  `phar_user_id` varchar(30) NOT NULL DEFAULT '0',
  `phar_req_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `phar_patient` varchar(30) DEFAULT NULL,
  `user_id_fk` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`phar_req_id`),
  KEY `fk_patpharm_id2` (`phar_patient`),
  KEY `fk_user_id2` (`phar_user_id`),
  KEY `fk_userid_9` (`user_id_fk`),
  KEY `phar_item_id_fk` (`phar_item_id`),
  CONSTRAINT `phar_item_id_fk` FOREIGN KEY (`phar_item_id`) REFERENCES `pharmacy_inventory` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy_request`
--

LOCK TABLES `pharmacy_request` WRITE;
/*!40000 ALTER TABLE `pharmacy_request` DISABLE KEYS */;
INSERT INTO `pharmacy_request` VALUES (1,5,'1','USER-00008','2016-08-21 04:04:17','PTNT-000001','USER-00008');
/*!40000 ALTER TABLE `pharmacy_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy_restock`
--

DROP TABLE IF EXISTS `pharmacy_restock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacy_restock` (
  `phar_res_id` varchar(30) NOT NULL,
  `phar_item` varchar(40) NOT NULL,
  `phar_user_id` varchar(30) NOT NULL DEFAULT '0',
  `quant_requested` int(11) NOT NULL,
  `date_req` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `phar_stat` tinyint(4) NOT NULL,
  `unique_id` varchar(255) NOT NULL,
  PRIMARY KEY (`phar_res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy_restock`
--

LOCK TABLES `pharmacy_restock` WRITE;
/*!40000 ALTER TABLE `pharmacy_restock` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharmacy_restock` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_phar_res_id` BEFORE INSERT ON `pharmacy_restock` FOR EACH ROW BEGIN
  INSERT INTO pharReq_sequence VALUES (NULL);
  SET NEW.phar_res_id = CONCAT('RES-', LPAD(LAST_INSERT_ID(), 4, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pharreq_sequence`
--

DROP TABLE IF EXISTS `pharreq_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharreq_sequence` (
  `phar_req_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`phar_req_seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharreq_sequence`
--

LOCK TABLES `pharreq_sequence` WRITE;
/*!40000 ALTER TABLE `pharreq_sequence` DISABLE KEYS */;
INSERT INTO `pharreq_sequence` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14);
/*!40000 ALTER TABLE `pharreq_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pur_req_seq`
--

DROP TABLE IF EXISTS `pur_req_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pur_req_seq` (
  `pur_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`pur_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pur_req_seq`
--

LOCK TABLES `pur_req_seq` WRITE;
/*!40000 ALTER TABLE `pur_req_seq` DISABLE KEYS */;
/*!40000 ALTER TABLE `pur_req_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_req_type`
--

DROP TABLE IF EXISTS `purchase_req_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_req_type` (
  `pur_req_id` varchar(30) NOT NULL DEFAULT '0',
  `pur_name` varchar(255) NOT NULL,
  `pur_desc` varchar(255) NOT NULL,
  PRIMARY KEY (`pur_req_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_req_type`
--

LOCK TABLES `purchase_req_type` WRITE;
/*!40000 ALTER TABLE `purchase_req_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_req_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pur_req` BEFORE INSERT ON `purchase_req_type` FOR EACH ROW BEGIN
  INSERT INTO pur_req_seq VALUES (NULL);
  SET NEW.pur_req_id = CONCAT('REQ-TYP', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `purchasing__pharm_sequence`
--

DROP TABLE IF EXISTS `purchasing__pharm_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchasing__pharm_sequence` (
  `purpharm_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`purpharm_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchasing__pharm_sequence`
--

LOCK TABLES `purchasing__pharm_sequence` WRITE;
/*!40000 ALTER TABLE `purchasing__pharm_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchasing__pharm_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchasing_csr`
--

DROP TABLE IF EXISTS `purchasing_csr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchasing_csr` (
  `purchase_id` varchar(30) NOT NULL,
  `requester_id` varchar(30) NOT NULL,
  `item_id` varchar(30) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `request_type` varchar(30) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `pur_stat` tinyint(4) NOT NULL,
  `date_altered_status` datetime DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`purchase_id`),
  KEY `fk_requester` (`requester_id`),
  KEY `fk_itemcsr` (`item_id`),
  KEY `fk_reqtype` (`request_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchasing_csr`
--

LOCK TABLES `purchasing_csr` WRITE;
/*!40000 ALTER TABLE `purchasing_csr` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchasing_csr` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_purchase` BEFORE INSERT ON `purchasing_csr` FOR EACH ROW BEGIN
  INSERT INTO purchasing_sequence VALUES (NULL);
  SET NEW.purchase_id = CONCAT('PRSE-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `purchasing_pharm`
--

DROP TABLE IF EXISTS `purchasing_pharm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchasing_pharm` (
  `purchase_id` varchar(30) NOT NULL,
  `requester_id` varchar(30) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `request_type` varchar(30) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `pur_stat` tinyint(4) NOT NULL,
  PRIMARY KEY (`purchase_id`),
  KEY `fk_itempharm2` (`item_id`),
  KEY `fk_reqtype22` (`request_type`),
  KEY `fk_requester22` (`requester_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchasing_pharm`
--

LOCK TABLES `purchasing_pharm` WRITE;
/*!40000 ALTER TABLE `purchasing_pharm` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchasing_pharm` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pur_pharm` BEFORE INSERT ON `purchasing_pharm` FOR EACH ROW BEGIN
  INSERT INTO purchasing__pharm_sequence VALUES (NULL);
  SET NEW.purchase_id = CONCAT('PRSE-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `purchasing_sequence`
--

DROP TABLE IF EXISTS `purchasing_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchasing_sequence` (
  `pur_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`pur_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchasing_sequence`
--

LOCK TABLES `purchasing_sequence` WRITE;
/*!40000 ALTER TABLE `purchasing_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchasing_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rad_bill_seq`
--

DROP TABLE IF EXISTS `rad_bill_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rad_bill_seq` (
  `rad_bill_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`rad_bill_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rad_bill_seq`
--

LOCK TABLES `rad_bill_seq` WRITE;
/*!40000 ALTER TABLE `rad_bill_seq` DISABLE KEYS */;
/*!40000 ALTER TABLE `rad_bill_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rad_billing`
--

DROP TABLE IF EXISTS `rad_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rad_billing` (
  `rad_bill_id` varchar(30) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT 'RadiologyTests',
  `bill_name` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `rad_bill_status` tinyint(4) DEFAULT '0',
  `patient_id` varchar(30) NOT NULL,
  PRIMARY KEY (`rad_bill_id`),
  KEY `fk_rad_patient` (`patient_id`),
  CONSTRAINT `fk_rad_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rad_billing`
--

LOCK TABLES `rad_billing` WRITE;
/*!40000 ALTER TABLE `rad_billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `rad_billing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_rad_bill` BEFORE INSERT ON `rad_billing` FOR EACH ROW BEGIN
  INSERT INTO rad_bill_seq VALUES (NULL);
  SET NEW.rad_bill_id = CONCAT('RAD-BLL-', LPAD(LAST_INSERT_ID(), 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rad_req_sequence`
--

DROP TABLE IF EXISTS `rad_req_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rad_req_sequence` (
  `rad_req_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`rad_req_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rad_req_sequence`
--

LOCK TABLES `rad_req_sequence` WRITE;
/*!40000 ALTER TABLE `rad_req_sequence` DISABLE KEYS */;
INSERT INTO `rad_req_sequence` VALUES (2),(3),(5),(6),(8),(9),(10),(11),(13),(14),(25),(26),(27),(28),(29),(30),(31),(34),(35),(36),(38),(40),(41),(42),(43),(44),(47),(48),(49),(50),(51),(52),(59),(60),(61),(62),(63),(64),(65),(66),(67),(68),(69),(71),(72),(73),(74),(75),(76),(77),(78),(79),(80),(81),(82),(83),(84),(85),(86),(87),(88),(89),(90),(93),(94),(95),(96),(106),(107),(108),(109),(110),(111),(112),(113),(114),(115),(116),(117),(118);
/*!40000 ALTER TABLE `rad_req_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiology_exam`
--

DROP TABLE IF EXISTS `radiology_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radiology_exam` (
  `exam_id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(255) NOT NULL,
  `exam_description` varchar(255) NOT NULL,
  `exam_price` float(10,2) NOT NULL,
  `exam_status` tinyint(4) NOT NULL,
  PRIMARY KEY (`exam_id`),
  UNIQUE KEY `exam_name` (`exam_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_exam`
--

LOCK TABLES `radiology_exam` WRITE;
/*!40000 ALTER TABLE `radiology_exam` DISABLE KEYS */;
INSERT INTO `radiology_exam` VALUES (1,'X-Ray','X-Ray',500.00,1),(2,'cbc','blood shit',400.00,1);
/*!40000 ALTER TABLE `radiology_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiology_pat`
--

DROP TABLE IF EXISTS `radiology_pat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radiology_pat` (
  `trans_id` varchar(30) NOT NULL,
  `rad_reqid` varchar(30) NOT NULL,
  `pat_id` varchar(30) NOT NULL,
  `request_status` tinyint(4) NOT NULL,
  PRIMARY KEY (`trans_id`),
  KEY `fk_rad_reqid` (`rad_reqid`),
  KEY `fk_pat_id` (`pat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_pat`
--

LOCK TABLES `radiology_pat` WRITE;
/*!40000 ALTER TABLE `radiology_pat` DISABLE KEYS */;
INSERT INTO `radiology_pat` VALUES ('RAD-REQ-00030','REQ-00113','PTNT-000001',0),('RAD-REQ-00031','REQ-00114','PTNT-000001',1),('RAD-REQ-00032','REQ-00115','PTNT-000001',0),('RAD-REQ-00033','REQ-00116','PTNT-000001',0),('RAD-REQ-00034','REQ-00117','PTNT-000001',1),('RAD-REQ-00035','REQ-00118','PTNT-000001',0);
/*!40000 ALTER TABLE `radiology_pat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_radpat` BEFORE INSERT ON `radiology_pat` FOR EACH ROW BEGIN
  INSERT INTO radiology_pat_sequence VALUES (NULL);
  SET NEW.trans_id = CONCAT('RAD-REQ-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `radiology_pat_sequence`
--

DROP TABLE IF EXISTS `radiology_pat_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radiology_pat_sequence` (
  `radpat_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`radpat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_pat_sequence`
--

LOCK TABLES `radiology_pat_sequence` WRITE;
/*!40000 ALTER TABLE `radiology_pat_sequence` DISABLE KEYS */;
INSERT INTO `radiology_pat_sequence` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31),(32),(33),(34),(35);
/*!40000 ALTER TABLE `radiology_pat_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `radiology_request`
--

DROP TABLE IF EXISTS `radiology_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radiology_request` (
  `request_id` varchar(30) NOT NULL,
  `patient_id` varchar(30) DEFAULT NULL,
  `user_request` varchar(30) NOT NULL DEFAULT '0',
  `exam_id` int(11) NOT NULL,
  `request_date` date NOT NULL,
  `user_id_fk` varchar(30) NOT NULL DEFAULT '0',
  `req_notes` text NOT NULL,
  PRIMARY KEY (`request_id`),
  KEY `fk_exam_id` (`exam_id`),
  KEY `fk_user_req` (`user_request`),
  KEY `fk_patient_id2` (`patient_id`),
  KEY `fk_userid_10` (`user_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `radiology_request`
--

LOCK TABLES `radiology_request` WRITE;
/*!40000 ALTER TABLE `radiology_request` DISABLE KEYS */;
INSERT INTO `radiology_request` VALUES ('REQ-00113','PTNT-000001','0',1,'2016-09-12','USER-00006','XRay and CBC'),('REQ-00114','PTNT-000001','0',2,'2016-09-12','USER-00006','XRay and CBC'),('REQ-00115','PTNT-000001','0',1,'2016-09-12','USER-00006','XRay and CBC 2'),('REQ-00116','PTNT-000001','0',2,'2016-09-12','USER-00006','XRay and CBC 2'),('REQ-00117','PTNT-000001','0',2,'2016-11-21','USER-00006','CBC'),('REQ-00118','PTNT-000001','0',1,'2016-11-21','USER-00006','X-Ray');
/*!40000 ALTER TABLE `radiology_request` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_rad_req` BEFORE INSERT ON `radiology_request` FOR EACH ROW BEGIN
  INSERT INTO rad_req_sequence VALUES (NULL);
  SET NEW.request_id = CONCAT('REQ-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `referral_physician`
--

DROP TABLE IF EXISTS `referral_physician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referral_physician` (
  `referral_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL DEFAULT '0',
  `patient_id` varchar(30) DEFAULT NULL,
  `user_id_fk` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`referral_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_Patient_referral` (`patient_id`),
  KEY `fk_userid_3` (`user_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referral_physician`
--

LOCK TABLES `referral_physician` WRITE;
/*!40000 ALTER TABLE `referral_physician` DISABLE KEYS */;
/*!40000 ALTER TABLE `referral_physician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retmed_sequence`
--

DROP TABLE IF EXISTS `retmed_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retmed_sequence` (
  `ret_med_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ret_med_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retmed_sequence`
--

LOCK TABLES `retmed_sequence` WRITE;
/*!40000 ALTER TABLE `retmed_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `retmed_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `return_medicine`
--

DROP TABLE IF EXISTS `return_medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `return_medicine` (
  `return_id` varchar(30) NOT NULL,
  `nurse_id` varchar(30) NOT NULL,
  `return_status` tinyint(4) NOT NULL DEFAULT '0',
  `audit_id` varchar(30) NOT NULL,
  PRIMARY KEY (`return_id`),
  KEY `audit_id_fk` (`audit_id`),
  KEY `nurse_idd_fk` (`nurse_id`),
  CONSTRAINT `audit_id_fk` FOREIGN KEY (`audit_id`) REFERENCES `pharmacy_audit` (`phar_aud_id`),
  CONSTRAINT `nurse_idd_fk` FOREIGN KEY (`nurse_id`) REFERENCES `nurses` (`nurse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return_medicine`
--

LOCK TABLES `return_medicine` WRITE;
/*!40000 ALTER TABLE `return_medicine` DISABLE KEYS */;
/*!40000 ALTER TABLE `return_medicine` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_ret_med_id` BEFORE INSERT ON `return_medicine` FOR EACH ROW BEGIN
  INSERT INTO retMed_sequence VALUES (NULL);
  SET NEW.return_id = CONCAT('RET-', LPAD(LAST_INSERT_ID(), 4, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `room_type`
--

DROP TABLE IF EXISTS `room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_type` (
  `room_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_name` varchar(255) NOT NULL,
  `room_description` varchar(255) NOT NULL,
  `room_price` float NOT NULL,
  `room_percentage` int(11) NOT NULL,
  PRIMARY KEY (`room_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type`
--

LOCK TABLES `room_type` WRITE;
/*!40000 ALTER TABLE `room_type` DISABLE KEYS */;
INSERT INTO `room_type` VALUES (1,'Emergency room','ER',1500,0),(2,'Private Room','Private',1500,0),(3,'Intensive Care Unit','ICU',2500,0),(4,'Operating Room','OR',3000,0);
/*!40000 ALTER TABLE `room_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_type` int(11) NOT NULL,
  `room_location` varchar(255) NOT NULL,
  `occupancy_status` tinyint(11) NOT NULL,
  `maintenance_status` tinyint(4) NOT NULL,
  PRIMARY KEY (`room_id`),
  KEY `room_type` (`room_type`),
  KEY `fk_room_maintenance` (`maintenance_status`),
  KEY `fk_room_occupancy` (`occupancy_status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,1,'GF',1,1),(2,2,'4F',1,1),(3,2,'3F',1,1);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sample_det_lab`
--

DROP TABLE IF EXISTS `sample_det_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_det_lab` (
  `sample_det_id` int(11) NOT NULL AUTO_INCREMENT,
  `urg_cat_fk` int(11) NOT NULL,
  `fast_id_fk` int(11) NOT NULL,
  `lab_samples` varchar(255) NOT NULL,
  PRIMARY KEY (`sample_det_id`),
  KEY `fk_urg_id` (`urg_cat_fk`),
  KEY `fk_fast_id` (`fast_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample_det_lab`
--

LOCK TABLES `sample_det_lab` WRITE;
/*!40000 ALTER TABLE `sample_det_lab` DISABLE KEYS */;
/*!40000 ALTER TABLE `sample_det_lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_categories`
--

DROP TABLE IF EXISTS `service_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_categories` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_name` varchar(255) NOT NULL,
  `service_desc` varchar(255) NOT NULL,
  `patient_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  UNIQUE KEY `service_name` (`service_name`),
  KEY `fk_Patient_service` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_categories`
--

LOCK TABLES `service_categories` WRITE;
/*!40000 ALTER TABLE `service_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(50) NOT NULL,
  `task_logo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'Admitting',''),(2,'Patient',''),(3,'Radiology',''),(4,'Rooms',''),(5,'Billing',''),(6,'Housekeeping',''),(7,'User Management',''),(8,'Appointments',''),(9,'Pharmacy',''),(10,'Laboratory',''),(11,'CSR',''),(12,'Purchasing','');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_usertype`
--

DROP TABLE IF EXISTS `task_usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_usertype` (
  `task_usertype_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  PRIMARY KEY (`task_usertype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_usertype`
--

LOCK TABLES `task_usertype` WRITE;
/*!40000 ALTER TABLE `task_usertype` DISABLE KEYS */;
INSERT INTO `task_usertype` VALUES (4,2,1),(6,3,4),(8,5,10),(9,6,1),(10,7,2),(11,8,5),(12,9,6),(16,4,1),(17,11,7),(18,10,9),(19,11,9),(20,1,14),(21,3,15),(22,1,3),(23,2,3),(24,3,3),(25,4,3),(26,10,3),(28,7,13),(29,8,3);
/*!40000 ALTER TABLE `task_usertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testtable`
--

DROP TABLE IF EXISTS `testtable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testtable` (
  `test` int(11) NOT NULL AUTO_INCREMENT,
  `val` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`test`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testtable`
--

LOCK TABLES `testtable` WRITE;
/*!40000 ALTER TABLE `testtable` DISABLE KEYS */;
INSERT INTO `testtable` VALUES (1,'BED-BLL-000016'),(2,'BED-BLL-000016'),(3,'BED-BLL-000016'),(4,'BED-BLL-000016'),(5,'BED-BLL-000016');
/*!40000 ALTER TABLE `testtable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_difference`
--

DROP TABLE IF EXISTS `time_difference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_difference` (
  `time_id` int(11) NOT NULL AUTO_INCREMENT,
  `disposition_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`time_id`),
  KEY `disposition_id` (`disposition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_difference`
--

LOCK TABLES `time_difference` WRITE;
/*!40000 ALTER TABLE `time_difference` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_difference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urgency_cat`
--

DROP TABLE IF EXISTS `urgency_cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `urgency_cat` (
  `urg_id` int(11) NOT NULL AUTO_INCREMENT,
  `urg_name` varchar(255) NOT NULL,
  PRIMARY KEY (`urg_id`),
  UNIQUE KEY `urg_name` (`urg_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urgency_cat`
--

LOCK TABLES `urgency_cat` WRITE;
/*!40000 ALTER TABLE `urgency_cat` DISABLE KEYS */;
INSERT INTO `urgency_cat` VALUES (1,'Urgent');
/*!40000 ALTER TABLE `urgency_cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_schedules`
--

DROP TABLE IF EXISTS `user_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_schedules` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL DEFAULT '0',
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `user_id_fk` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`schedule_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_userid_4` (`user_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_schedules`
--

LOCK TABLES `user_schedules` WRITE;
/*!40000 ALTER TABLE `user_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_sequence`
--

DROP TABLE IF EXISTS `user_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sequence` (
  `user_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`user_seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sequence`
--

LOCK TABLES `user_sequence` WRITE;
/*!40000 ALTER TABLE `user_sequence` DISABLE KEYS */;
INSERT INTO `user_sequence` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16);
/*!40000 ALTER TABLE `user_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `controller_type` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type`
--

LOCK TABLES `user_type` WRITE;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` VALUES (1,'Administrator','Admin','Can manage all features in systems'),(2,'Doctor','Doctor','Edi Doctor'),(3,'Nurse','Nurse','Edi Nurse'),(4,'Radiologist','Radiology','Radiologist'),(5,'Pharmacist','Pharmacy','Pharmacist'),(6,'Laboratory People','Laboratory','Laboratory People'),(7,'Purchasing Staff','Purchasing','Purchasing Staff'),(8,'Accounting Staff','Accounting','Accounting Staff'),(9,'CSR Staff','Csr','CSR Staff'),(10,'Billing Clerk','Accounting','Billing Clerk'),(11,'Cashier staff','Cashier','Cashier staff'),(12,'HouseKeeping','Housekeeping','HouseKeeping'),(13,'Management','Management','President, Medical Directors and Chairmans'),(14,'Admission','Admission','Admission aka front desk'),(15,'Radiology chief','Radiology chief','Radiology chief'),(16,'Laboratory Chief','Laboratory Chief','Laboratory Chief');
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` varchar(30) NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  `contact_number` varchar(11) NOT NULL,
  `gender` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `employment_date` date NOT NULL,
  `dept` varchar(30) NOT NULL,
  `ward_assigned` varchar(30) DEFAULT NULL,
  `default_password` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `type_id` (`type_id`),
  KEY `fk_dept_id2` (`dept`),
  KEY `fk_ward_ass` (`ward_assigned`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('USER-00001',1,'admin','d033e22ae348aeb5660fc2140aec35850c4da997','admin@admin.com','admin','admin','admin','2016-08-16','09063420000','M',1,'2016-08-21','',NULL,1),('USER-00002',6,'laboratory','80240dcecd105d50195cce7a318413dc013733e3','laboratory@laboratory.com','laboratory','kame','people','2016-08-17','09063420000','M',1,'2016-08-12','',NULL,1),('USER-00003',13,'president','982d46d22d9597c30d79d368dc9197f5f1fe5956','president@gmail.com','Dr. Joshua','Manaol','Tanedo','2016-08-16','09153192962','Male',1,'2016-08-11','',NULL,1),('USER-00005',2,'doctor','1f0160076c9f42a157f0a8f0dcc68e02ff69045b','asdads@asdasd.com','doctor','doctor','doctor','2016-08-03','09153192963','Male',1,'2016-08-17','',NULL,1),('USER-00006',3,'nurse','285f9a003f671c2486a3f87ea1ad5e37699ebc38','smkdma@asdas.asd','nurse','nurse','nurse','2016-08-11','09153192963','male',1,'2016-08-16','',NULL,1),('USER-00007',4,'radiologist','81323d4a8b7385d92825f42404dfaea0544c9742','asdasd@asdasdkc.asd','radiologist','radiologist','radiologist','2016-08-23','09153192962','male',1,'2016-08-11','',NULL,1),('USER-00008',5,'pharmacy','adfa59cc50d2bd2ce3af0061ed4925fdc37019ba','asdasd.asdasd.com','pharma','pharmac','asdsa','2016-08-02','09153192962','male',1,'2016-08-11','',NULL,1),('USER-00009',7,'purchasing','0e0730d60c07bff650576eb44f31e96809633aaa','asdasd.coasd.com','purchasing','purch','purchasing','2016-08-02','09153192962','male',1,'2016-08-15','',NULL,1),('USER-00010',8,'accounting','1853fd427d08bb9891c1c413b93626056177f9f3','asdasd.coamsd.com','accounting','ajsdaisd','ajbsdjasd','2016-08-25','09153192962','male',1,'2016-08-25','',NULL,1),('USER-00011',9,'csr','4fe486f255f36f8787d5c5cc1185e3d5d5c91c03','asasd.com','csr','csr','csr','2016-08-17','09153192962','male',1,'2016-08-18','',NULL,1),('USER-00012',10,'billing','acd14c7a6c04c1dd6dc6c2d66d487a28667c0ad6','jaskldjsad.com','billing','billing','billing','2016-08-11','09153192962','male',1,'2016-08-21','',NULL,1),('USER-00013',11,'cashier','a5b42198e3fb950b5ab0d0067cbe077a41da1245','asdasd.com','cashier','cashier','cashier','2016-08-17','09153192962','male',1,'2016-08-18','',NULL,1),('USER-00014',12,'housekeeping','451af4d13f3981311b6c1d9d343aec3dcaf22e3d','asdasd.casd.com','housekeeping','housekeeping','jousekeeping','2016-08-11','09153192962','male',1,'2016-08-12','',NULL,1),('USER-00015',2,'joshua','c0755c8ac8b27b615262ef7d938e0c1e9c83bf5f','joasdasd@asdas.com','Joshua','Manaol','Tanedo','1995-01-01','0914329292','M',1,'2016-09-18','',NULL,1),('USER-00016',14,'admitting','cc0a309f2ca9dd2df61c5e74307849421600f5f7','Admission@gmail.com','Admission','Admission','Admission','1997-03-18','4560186','M',1,'2016-11-21','',NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_users` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
  INSERT INTO user_sequence VALUES (NULL);
  SET NEW.user_id = CONCAT('USER-', LPAD(LAST_INSERT_ID(), 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vital_sequence`
--

DROP TABLE IF EXISTS `vital_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vital_sequence` (
  `vital_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`vital_seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vital_sequence`
--

LOCK TABLES `vital_sequence` WRITE;
/*!40000 ALTER TABLE `vital_sequence` DISABLE KEYS */;
INSERT INTO `vital_sequence` VALUES (1),(2),(3);
/*!40000 ALTER TABLE `vital_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vitals`
--

DROP TABLE IF EXISTS `vitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vitals` (
  `vital_id` varchar(30) NOT NULL DEFAULT '0',
  `heart_rate` varchar(255) NOT NULL DEFAULT 'n/a',
  `resp_rate` varchar(255) NOT NULL DEFAULT 'n/a',
  `blood_pres` varchar(255) NOT NULL DEFAULT 'n/a',
  `body_temp` varchar(255) NOT NULL DEFAULT 'n/a',
  `patient_id` varchar(30) NOT NULL DEFAULT '0',
  `user_id` varchar(30) NOT NULL,
  `date_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`vital_id`),
  KEY `fk_pat_vitals` (`patient_id`),
  KEY `user_id_fk` (`user_id`),
  CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vitals`
--

LOCK TABLES `vitals` WRITE;
/*!40000 ALTER TABLE `vitals` DISABLE KEYS */;
INSERT INTO `vitals` VALUES ('VITAL-002','25','25','120/75','36','PTNT-000001','USER-00006','2016-08-21 05:03:54'),('VITAL-003','36','36','120/80','36','PTNT-000001','USER-00006','2016-08-21 05:13:54');
/*!40000 ALTER TABLE `vitals` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_vitals` BEFORE INSERT ON `vitals` FOR EACH ROW BEGIN
  INSERT INTO vital_sequence VALUES (NULL);
  SET NEW.vital_id = CONCAT('VITAL-', LPAD(LAST_INSERT_ID(), 3, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `wards`
--

DROP TABLE IF EXISTS `wards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wards` (
  `ward_id` varchar(30) NOT NULL DEFAULT '0',
  `ward_name` varchar(255) NOT NULL,
  `ward_desc` varchar(255) NOT NULL,
  `ward_head` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ward_id`),
  KEY `fk_dept_head` (`ward_head`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wards`
--

LOCK TABLES `wards` WRITE;
/*!40000 ALTER TABLE `wards` DISABLE KEYS */;
/*!40000 ALTER TABLE `wards` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_wards` BEFORE INSERT ON `wards` FOR EACH ROW BEGIN
  INSERT INTO wards_sequence VALUES (NULL);
  SET NEW.ward_id = CONCAT('WARD-', LPAD(LAST_INSERT_ID(), 3, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `wards_sequence`
--

DROP TABLE IF EXISTS `wards_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wards_sequence` (
  `wards_seq_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`wards_seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wards_sequence`
--

LOCK TABLES `wards_sequence` WRITE;
/*!40000 ALTER TABLE `wards_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `wards_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'JNH'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `check_bed_billing` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `check_bed_billing` ON SCHEDULE EVERY 30 MINUTE STARTS '2017-01-06 09:33:46' ON COMPLETION NOT PRESERVE ENABLE DO call proc_checkStat() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'JNH'
--
/*!50003 DROP PROCEDURE IF EXISTS `proc_checkHour` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_checkHour`(IN ID varchar(30))
BEGIN
	declare p_BID varchar(30);
    declare v_price float(10,2);

	SELECT bed_bill_id into p_BID FROM bed_billing 
	WHERE DATE(date_updated) >= curdate() + INTERVAL 1 day
	ORDER BY date_updated 
    limit 1;
    
    select room_price
    into v_price
	from room_type
	where room_type_id IN(select bed_roomid
	from beds
		where bed_patient IN(Select patient_id 
								from bed_billing 
								where bed_bill_id 
								= p_BID));
    
    update bed_billing 
    set price = price + v_price
    where bed_bill_id = p_BID;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_checkStat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_checkStat`()
BEGIN
	DECLARE done int default false;
	Declare ID varchar(30);
	Declare checkStat cursor 
    for 
    select bed_bill_id from bed_billing where bed_bill_status = 0;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    open checkStat;
    
    StatLoop:loop
		fetch checkStat into ID;
        
        if done then
			leave StatLoop;
		end if;
        
        call proc_checkHour(ID); 
        
        
	end loop;
    
    CLOSE checkStat;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-16  9:03:02