-- MySQL dump 10.13  Distrib 5.7.8-rc, for Linux (x86_64)
--
-- Host: localhost    Database: unicodedata
-- ------------------------------------------------------
-- Server version	5.7.8-rc

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
-- Table structure for table `ucd`
--

DROP TABLE IF EXISTS `ucd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ucd` (
  `value` varchar(6) NOT NULL,
  `char` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category` enum('Cc','Cf','Co','Cs','Ll','Lm','Lo','Lt','Lu','Mc','Me','Mn','Nd','Nl','No','Pc','Pd','Pe','Pf','Pi','Po','Ps','Sc','Sk','Sm','So','Zl','Zp','Zs') NOT NULL,
  `combining_class` varchar(20) DEFAULT NULL,
  `bidi_class` enum('AL','AN','B','BN','CS','EN','ES','ET','FSI','L','LRE','LRI','LRO','NSM','ON','PDF','PDI','R','RLE','RLI','RLO','S','WS') NOT NULL,
  `decomposition` varchar(100) DEFAULT NULL,
  `numeric1` varchar(20) DEFAULT NULL,
  `numeric2` varchar(20) DEFAULT NULL,
  `numeric3` varchar(20) DEFAULT NULL,
  `bidi_mirrored` enum('N','Y') NOT NULL,
  `unicode1_name` varchar(100) DEFAULT NULL,
  `ISO_comment` char(0) DEFAULT NULL,
  `uppercase_mapping` varchar(5) DEFAULT NULL,
  `lowercase_mapping` varchar(5) DEFAULT NULL,
  `titlecase_mapping` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-09-01 22:25:02
