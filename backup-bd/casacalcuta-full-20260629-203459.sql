-- MySQL dump 10.13  Distrib 8.0.36-28, for Linux (x86_64)
--
-- Host: localhost    Database: casacalcuta
-- ------------------------------------------------------
-- Server version	8.0.36-28

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
/*!50717 SELECT COUNT(*) INTO @rocksdb_has_p_s_session_variables FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME = 'session_variables' */;
/*!50717 SET @rocksdb_get_is_supported = IF (@rocksdb_has_p_s_session_variables, 'SELECT COUNT(*) INTO @rocksdb_is_supported FROM performance_schema.session_variables WHERE VARIABLE_NAME=\'rocksdb_bulk_load\'', 'SELECT 0') */;
/*!50717 PREPARE s FROM @rocksdb_get_is_supported */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;
/*!50717 SET @rocksdb_enable_bulk_load = IF (@rocksdb_is_supported, 'SET SESSION rocksdb_bulk_load = 1', 'SET @rocksdb_dummy_bulk_load = 0') */;
/*!50717 PREPARE s FROM @rocksdb_enable_bulk_load */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;

--
-- Current Database: `casacalcuta`
--

/*!40000 DROP DATABASE IF EXISTS `casacalcuta`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `casacalcuta` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `casacalcuta`;

--
-- Table structure for table `auditorias`
--

DROP TABLE IF EXISTS `auditorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditorias` (
  `id_auditoria` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned NOT NULL,
  `accion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entidad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entidad_id` bigint unsigned NOT NULL,
  `fecha` date NOT NULL,
  `cambios` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_auditoria`),
  KEY `auditorias_usuario_id_foreign` (`usuario_id`),
  KEY `auditorias_entidad_entidad_id_index` (`entidad`,`entidad_id`),
  CONSTRAINT `auditorias_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditorias`
--

LOCK TABLES `auditorias` WRITE;
/*!40000 ALTER TABLE `auditorias` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autorizaciones`
--

DROP TABLE IF EXISTS `autorizaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autorizaciones` (
  `id_autorizacion` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vigente` tinyint(1) NOT NULL,
  `vencimiento` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_autorizacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autorizaciones`
--

LOCK TABLES `autorizaciones` WRITE;
/*!40000 ALTER TABLE `autorizaciones` DISABLE KEYS */;
INSERT INTO `autorizaciones` VALUES (1,'General',1,'2026-12-31','2026-06-04 20:14:46','2026-06-04 20:14:46');
/*!40000 ALTER TABLE `autorizaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-2czhHxBLd8ZObwW0','a:1:{s:11:\"valid_until\";i:1782770176;}',1783978336),('casacalcutabackend-cache-2H82NC1ywEnnivCI','a:1:{s:11:\"valid_until\";i:1782770348;}',1783979888),('casacalcutabackend-cache-3kCQCICgUN3XmPmb','a:1:{s:11:\"valid_until\";i:1782760630;}',1783970290),('casacalcutabackend-cache-5jvNuPQUYCI6OJLm','a:1:{s:11:\"valid_until\";i:1782499192;}',1783708492),('casacalcutabackend-cache-5ZASQALdfLsD9nBg','a:1:{s:11:\"valid_until\";i:1782180733;}',1783390273),('casacalcutabackend-cache-6o5xsRaUgQxiCW81','a:1:{s:11:\"valid_until\";i:1781896602;}',1783106262),('casacalcutabackend-cache-7gPv5pGcwr8ggcMM','a:1:{s:11:\"valid_until\";i:1782762260;}',1783971620),('casacalcutabackend-cache-7rgdlSJ6cyAZlY7D','a:1:{s:11:\"valid_until\";i:1782678304;}',1783887964),('casacalcutabackend-cache-8XLXQBhI9Vd45609','a:1:{s:11:\"valid_until\";i:1782678247;}',1783887787),('casacalcutabackend-cache-9mvTLrgHQg0cz2NV','a:1:{s:11:\"valid_until\";i:1782182427;}',1783390467),('casacalcutabackend-cache-AGYEAIORAR1BYfc9','a:1:{s:11:\"valid_until\";i:1782492645;}',1783702305),('casacalcutabackend-cache-B6ZdiL17yQEs3p0s','a:1:{s:11:\"valid_until\";i:1782499320;}',1783708920),('casacalcutabackend-cache-bEtPzXBnRRPVVIbR','a:1:{s:11:\"valid_until\";i:1782499230;}',1783708890),('casacalcutabackend-cache-bLwY3XtyX1wSj8pl','a:1:{s:11:\"valid_until\";i:1782761077;}',1783970557),('casacalcutabackend-cache-cePNs2ZUIsd8GUzX','a:1:{s:11:\"valid_until\";i:1781651826;}',1782861486),('casacalcutabackend-cache-chmAJ11dvaYe4vLI','a:1:{s:11:\"valid_until\";i:1782168470;}',1783377830),('casacalcutabackend-cache-DoYD5vX55nDHxisl','a:1:{s:11:\"valid_until\";i:1782421237;}',1783630897),('casacalcutabackend-cache-Dq4sItaXcNLK79g0','a:1:{s:11:\"valid_until\";i:1782759540;}',1783968960),('casacalcutabackend-cache-dx3o40AkjGsKSAXK','a:1:{s:11:\"valid_until\";i:1782180556;}',1783389976),('casacalcutabackend-cache-EdphhBV41nhi4JxK','a:1:{s:11:\"valid_until\";i:1782583911;}',1783793271),('casacalcutabackend-cache-emlmrcZ6SSrB5I02','a:1:{s:11:\"valid_until\";i:1782495397;}',1783702357),('casacalcutabackend-cache-fsZO2vlXqL9Dth7b','a:1:{s:11:\"valid_until\";i:1782080721;}',1783290381),('casacalcutabackend-cache-g0oa9aF4SpSayeUm','a:1:{s:11:\"valid_until\";i:1781899839;}',1783109499),('casacalcutabackend-cache-gB6iUVUkpJqo6KUH','a:1:{s:11:\"valid_until\";i:1782421365;}',1783631025),('casacalcutabackend-cache-gnGnAG9wlZ6eQcKO','a:1:{s:11:\"valid_until\";i:1782259907;}',1783468667),('casacalcutabackend-cache-gpdJYQWHhSLd7rvS','a:1:{s:11:\"valid_until\";i:1782762745;}',1783972165),('casacalcutabackend-cache-iwIddxMARSerD0Wn','a:1:{s:11:\"valid_until\";i:1782420740;}',1783629320),('casacalcutabackend-cache-J7QGnHqroNpVHRtm','a:1:{s:11:\"valid_until\";i:1782768624;}',1783977204),('casacalcutabackend-cache-kHtgBY6av0DJzDgt','a:1:{s:11:\"valid_until\";i:1781901586;}',1783111246),('casacalcutabackend-cache-KkvoG9hSK7tomC15','a:1:{s:11:\"valid_until\";i:1781651825;}',1782861425),('casacalcutabackend-cache-kNNf8pzaidYPAtYm','a:1:{s:11:\"valid_until\";i:1782760546;}',1783969546),('casacalcutabackend-cache-kRbTxwId64t2bT7u','a:1:{s:11:\"valid_until\";i:1781901811;}',1783111471),('casacalcutabackend-cache-L1cgds035nEVluyO','a:1:{s:11:\"valid_until\";i:1782760616;}',1783970216),('casacalcutabackend-cache-LtyrGRKl4yLlQXvg','a:1:{s:11:\"valid_until\";i:1781900009;}',1783109669),('casacalcutabackend-cache-lWB7jLE6dz7Awivu','a:1:{s:11:\"valid_until\";i:1782498810;}',1783705230),('casacalcutabackend-cache-mKQhq3a2Hz7cbzRL','a:1:{s:11:\"valid_until\";i:1782761828;}',1783971368),('casacalcutabackend-cache-MTc2pbujoCLsPSHS','a:1:{s:11:\"valid_until\";i:1782678404;}',1783888064),('casacalcutabackend-cache-mUkvEfzwpq20e0qM','a:1:{s:11:\"valid_until\";i:1782760849;}',1783970329),('casacalcutabackend-cache-OOIfgosSoS9txerV','a:1:{s:11:\"valid_until\";i:1782762958;}',1783972438),('casacalcutabackend-cache-OWMnCMWrExDEV2u6','a:1:{s:11:\"valid_until\";i:1782761593;}',1783971253),('casacalcutabackend-cache-pm54OKfOuZTbvxjV','a:1:{s:11:\"valid_until\";i:1782584653;}',1783794313),('casacalcutabackend-cache-PVippl142XcXE5aK','a:1:{s:11:\"valid_until\";i:1782759832;}',1783969252),('casacalcutabackend-cache-PVJfd4yKfklLvk8P','a:1:{s:11:\"valid_until\";i:1782168150;}',1783377810),('casacalcutabackend-cache-pxBXPsHWjIqYO802','a:1:{s:11:\"valid_until\";i:1782761646;}',1783971306),('casacalcutabackend-cache-qZehxEempVf5wX3E','a:1:{s:11:\"valid_until\";i:1782761550;}',1783970790),('casacalcutabackend-cache-Rkt9OXypDgyjLJUv','a:1:{s:11:\"valid_until\";i:1782498791;}',1783708151),('casacalcutabackend-cache-sZiaIGV2E1njYJuV','a:1:{s:11:\"valid_until\";i:1782762461;}',1783971941),('casacalcutabackend-cache-t7LaJNVruN4Ddh2w','a:1:{s:11:\"valid_until\";i:1782583255;}',1783791895),('casacalcutabackend-cache-uRJeCSBBUoJeX3sK','a:1:{s:11:\"valid_until\";i:1782498745;}',1783705105),('casacalcutabackend-cache-vI9Y2UORDlhMK9kE','a:1:{s:11:\"valid_until\";i:1782703761;}',1783913181),('casacalcutabackend-cache-vmDuXVBxlaAt00k4','a:1:{s:11:\"valid_until\";i:1782168091;}',1783377751),('casacalcutabackend-cache-Wd5PfwYHV4FZnAA6','a:1:{s:11:\"valid_until\";i:1782769845;}',1783979205),('casacalcutabackend-cache-WvanI1qoaikFb1m6','a:1:{s:11:\"valid_until\";i:1782499989;}',1783709349),('casacalcutabackend-cache-xc01SIlnnEnT9qNW','a:1:{s:11:\"valid_until\";i:1782414602;}',1783623782),('casacalcutabackend-cache-Y3hZfZzTl5zb9fgJ','a:1:{s:11:\"valid_until\";i:1782767522;}',1783976342),('casacalcutabackend-cache-ybyHLHPBq7nkVQej','a:1:{s:11:\"valid_until\";i:1782704786;}',1783913546),('casacalcutabackend-cache-z9MStp9kZg4cJiRS','a:1:{s:11:\"valid_until\";i:1782096356;}',1783306016),('laravel-cache-RKO9t3uLUZTs7Az3','a:1:{s:11:\"valid_until\";i:1781278566;}',1782487566),('laravel-cache-XnaRs4lutSfJWCGT','a:1:{s:11:\"valid_until\";i:1781281830;}',1782488250);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comisiones`
--

DROP TABLE IF EXISTS `comisiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comisiones` (
  `id_comision` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activa` tinyint(1) NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encargado` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_comision`),
  KEY `comisiones_encargado_foreign` (`encargado`),
  CONSTRAINT `comisiones_encargado_foreign` FOREIGN KEY (`encargado`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comisiones`
--

LOCK TABLES `comisiones` WRITE;
/*!40000 ALTER TABLE `comisiones` DISABLE KEYS */;
INSERT INTO `comisiones` VALUES (2,'Costura',1,'Comision de Costura',7,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(3,'Cocina',1,'Comision de Cocina',6,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(4,'Actividades',1,'Actividades con ninos',8,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(5,'Lectoescritura',1,'Comision de alfabetizacion',10,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(6,'Ropero',1,'Subcomision de ropero',9,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(8,'Comision de ejemplo',1,'Descripcion de ejemplo',5,'2026-06-29 19:55:07','2026-06-29 19:55:07');
/*!40000 ALTER TABLE `comisiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentacion_integrante`
--

DROP TABLE IF EXISTS `documentacion_integrante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentacion_integrante` (
  `documento_id` bigint unsigned NOT NULL,
  `integrante_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`documento_id`,`integrante_id`),
  KEY `documentacion_integrante_integrante_id_foreign` (`integrante_id`),
  CONSTRAINT `documentacion_integrante_documento_id_foreign` FOREIGN KEY (`documento_id`) REFERENCES `documentos` (`id_documento`) ON DELETE CASCADE,
  CONSTRAINT `documentacion_integrante_integrante_id_foreign` FOREIGN KEY (`integrante_id`) REFERENCES `integrantes` (`id_integrante`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentacion_integrante`
--

LOCK TABLES `documentacion_integrante` WRITE;
/*!40000 ALTER TABLE `documentacion_integrante` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentacion_integrante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos`
--

DROP TABLE IF EXISTS `documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentos` (
  `id_documento` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vigente` tinyint(1) NOT NULL,
  `vencimiento` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_documento`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos`
--

LOCK TABLES `documentos` WRITE;
/*!40000 ALTER TABLE `documentos` DISABLE KEYS */;
INSERT INTO `documentos` VALUES (1,'DNI',1,'2026-12-31','2026-06-04 20:14:04','2026-06-04 20:14:04');
/*!40000 ALTER TABLE `documentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donaciones`
--

DROP TABLE IF EXISTS `donaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donaciones` (
  `id_donacion` bigint unsigned NOT NULL AUTO_INCREMENT,
  `origen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int unsigned NOT NULL,
  `unidad_medida` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_recepcion` date NOT NULL,
  `registrado_por` bigint unsigned NOT NULL,
  `familia_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_donacion`),
  KEY `donaciones_registrado_por_foreign` (`registrado_por`),
  KEY `donaciones_familia_id_foreign` (`familia_id`),
  CONSTRAINT `donaciones_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE SET NULL,
  CONSTRAINT `donaciones_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donaciones`
--

LOCK TABLES `donaciones` WRITE;
/*!40000 ALTER TABLE `donaciones` DISABLE KEYS */;
INSERT INTO `donaciones` VALUES (1,'Donante','Bolson de ejemplo',10,'unidad','2026-06-04',1,11,'2026-06-27 15:45:25','2026-06-27 16:22:07'),(2,'Donante','Paquete de Fideos',12,'unidad','2026-06-04',1,11,'2026-06-27 15:45:54','2026-06-27 15:45:54'),(3,'Donante','Paquete de Fideos',12,'unidad','2026-06-04',1,5,'2026-06-27 16:04:38','2026-06-27 16:04:38'),(4,'Donante','Yerba x 1KG',20,'unidad','2026-06-27',1,5,'2026-06-27 16:21:45','2026-06-27 16:21:45'),(5,'Donante','Azucar',5,'kg','2026-06-27',1,5,'2026-06-27 23:40:50','2026-06-27 23:40:50'),(6,'Donante','Arroz',15,'kg','2026-06-29',1,NULL,'2026-06-29 03:49:46','2026-06-29 03:50:06'),(7,'chango','Bolson de ejemplo',3,'unidad','2026-06-04',1,15,'2026-06-29 19:41:49','2026-06-29 21:14:15');
/*!40000 ALTER TABLE `donaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `familias`
--

DROP TABLE IF EXISTS `familias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `familias` (
  `id_familia` bigint unsigned NOT NULL AUTO_INCREMENT,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `puntaje_prioridad` int unsigned DEFAULT NULL,
  `situacion_alimentaria` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `evaluado_por` bigint unsigned DEFAULT NULL,
  `fecha_ultima_evaluacion` date DEFAULT NULL,
  `prioridad_social` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_lista` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `activa` tinyint(1) NOT NULL,
  `referente_id` bigint unsigned DEFAULT NULL,
  `registrado_por` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `frecuencia_asistencia` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `participacion_merendero` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_familia`),
  UNIQUE KEY `familias_referente_id_unique` (`referente_id`),
  KEY `familias_registrado_por_foreign` (`registrado_por`),
  KEY `familias_evaluado_por_foreign` (`evaluado_por`),
  CONSTRAINT `familias_evaluado_por_foreign` FOREIGN KEY (`evaluado_por`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `familias_referente_id_foreign` FOREIGN KEY (`referente_id`) REFERENCES `integrantes` (`id_integrante`) ON DELETE SET NULL,
  CONSTRAINT `familias_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familias`
--

LOCK TABLES `familias` WRITE;
/*!40000 ALTER TABLE `familias` DISABLE KEYS */;
INSERT INTO `familias` VALUES (2,'742 Evergreen Terrace','555-0101',7,'urgente',1,'2026-06-29','muy_alta','PRINCIPAL','2024-01-15',1,2,1,'2026-06-04 20:21:29','2026-06-29 23:32:49','ocasional','activa'),(3,'744 Evergreen Terrace','555-0102',5,'sin_urgencia',5,'2026-06-08','muy_alta','PRINCIPAL','2024-02-10',1,7,5,'2026-06-04 20:21:29','2026-06-27 18:06:54','semanal','activa'),(4,'Apartment 2A, 33 Spooner Street','555-0103',4,'urgente',5,'2026-06-12','muy_alta','PRINCIPAL','2024-03-05',1,10,5,'2026-06-04 20:21:29','2026-06-12 00:25:56','ocasional','activa'),(5,'Wiggum Residence','555-0104',1,'urgente',5,'2026-06-08','muy_baja','ESPERA','2024-04-20',1,13,5,'2026-06-04 20:21:29','2026-06-12 00:25:56','ocasional','no_participa'),(6,'Hibbert Residence','555-0105',4,'urgente',5,'2026-06-08','muy_alta','PRINCIPAL','2024-05-11',1,16,1,'2026-06-04 20:21:29','2026-06-12 00:25:56','ocasional','activa'),(11,'Calle Jujuy 2220','2364111113',6,'urgente',5,'2026-06-29','media','PRINCIPAL','2026-06-23',1,24,1,'2026-06-24 00:18:10','2026-06-24 00:31:17','ocasional','no_participa'),(12,'Mariano Moreno 1111','2364111114',3,'urgente',5,'2026-06-29','baja','ESPERA','2026-06-23',1,22,5,'2026-06-24 00:21:24','2026-06-27 18:07:06','ocasional','ocacional'),(14,'ejemplo 123','102030',10,'urgente',5,'2026-06-29','ALTA','PRINCIPAL','2026-06-04',1,28,1,'2026-06-27 17:04:46','2026-06-27 17:07:26','ocasional','no_participa'),(15,'ejemplo 123','102030',10,'sin_urgencia',5,'2026-06-29','ALTA','ESPERA','2026-06-04',1,30,1,'2026-06-27 17:11:03','2026-06-27 18:56:06','ocasional','ocacional'),(16,'ejemplo 1234','1020320',10,'sin_urgencia',1,'2026-06-29','ALTA','PRINCIPAL','2026-06-04',1,NULL,5,'2026-06-27 17:20:14','2026-06-29 20:16:05','ocasional','ocacional'),(17,'Calle Spooner 410','23032003',1,'sin_urgencia',1,'2026-06-29','muy_baja','ESPERA','2026-06-27',1,31,1,'2026-06-27 22:43:13','2026-06-29 23:05:04','ocasional','no_participa'),(18,'Belgrano 111','0000 1111',2,'sin_urgencia',1,'2026-06-29','baja','ESPERA','2026-06-29',1,33,1,'2026-06-29 19:05:54','2026-06-29 20:54:18','semanal','ocasional'),(19,'aloe 222','5555555555',1,'sin_urgencia',1,'2026-06-29','baja','PRINCIPAL','2026-06-29',1,37,1,'2026-06-29 19:34:55','2026-06-29 20:14:50','ocasional','no_participa'),(20,'av siempreviva','2364225',6,'urgente',1,'2026-06-29','alta','ESPERA','2026-06-30',1,NULL,1,'2026-06-29 20:18:06','2026-06-29 21:32:23','ocasional','ocasionalno_participa');
/*!40000 ALTER TABLE `familias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrantes`
--

DROP TABLE IF EXISTS `integrantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integrantes` (
  `id_integrante` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `tipo_documento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_documento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referente` tinyint(1) NOT NULL,
  `familia_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_integrante`),
  UNIQUE KEY `integrantes_numero_documento_unique` (`numero_documento`),
  KEY `integrantes_familia_id_foreign` (`familia_id`),
  CONSTRAINT `integrantes_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrantes`
--

LOCK TABLES `integrantes` WRITE;
/*!40000 ALTER TABLE `integrantes` DISABLE KEYS */;
INSERT INTO `integrantes` VALUES (2,'Homer','Simpson','1956-05-12','DNI','SIM-001',1,2,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(3,'Marge','Simpson','1956-03-19','DNI','SIM-002',0,2,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(4,'Bart','Simpson','2010-04-01','DNI','SIM-003',0,2,'2026-06-04 20:21:29','2026-06-12 00:16:09'),(5,'Lisa','Simpson','2012-05-09','DNI','SIM-004',0,2,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(6,'Maggie','Simpson','2018-01-12','DNI','SIM-005',0,2,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(7,'Ned','Flanders','1959-02-01','DNI','FLA-001',1,3,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(8,'Rod','Flanders','2011-07-07','DNI','FLA-002',0,3,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(9,'Todd','Flanders','2013-09-15','DNI','FLA-003',0,3,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(10,'Kirk','Van Houten','1959-08-01','DNI','VAN-001',1,4,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(11,'Luann','Van Houten','1960-10-15','DNI','VAN-002',0,4,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(12,'Milhouse','Van Houten','2011-02-20','DNI','VAN-003',0,4,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(13,'Clancy','Wiggum','1954-01-21','DNI','WIG-001',1,5,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(14,'Sarah','Wiggum','1956-11-02','DNI','WIG-002',0,5,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(15,'Ralph','Wiggum','2012-02-28','DNI','WIG-003',0,5,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(16,'Julius','Hibbert','1952-09-18','DNI','HIB-001',1,6,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(17,'Bernice','Hibbert','1954-06-24','DNI','HIB-002',0,6,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(20,'Pablo','Ledesma','2000-11-23','DNI','40252022',0,11,'2026-06-24 00:18:53','2026-06-24 00:31:17'),(21,'Jeremias','Ledesma','2021-06-11','DNI','58003025',0,11,'2026-06-24 00:19:21','2026-06-24 00:19:21'),(22,'Marcos','Perez','1996-11-14','DNI','38040258',1,12,'2026-06-24 00:21:52','2026-06-24 00:23:48'),(23,'Paz','Perez','2016-11-22','DNI','55205862',0,12,'2026-06-24 00:22:21','2026-06-24 00:22:21'),(24,'Paz','Diaz','2001-06-23','DNI','42048568',1,11,'2026-06-24 00:30:37','2026-06-24 00:31:17'),(25,'Hugo','Simpson','2016-02-23','DNI','23022016',0,2,'2026-06-26 18:32:19','2026-06-26 18:32:19'),(27,'Diego','Rodriguez','2005-03-01','DNI','34543903',0,14,'2026-06-27 17:06:51','2026-06-27 17:06:51'),(28,'Diego','Rodriguez','2005-03-01','DNI','35543903',1,14,'2026-06-27 17:07:26','2026-06-27 17:07:26'),(29,'Martin','Rodriguez','2015-03-01','DNI','35901902',0,15,'2026-06-27 17:13:43','2026-06-27 18:17:28'),(30,'Martin','cumpleaños','2015-07-01','DNI','908765412',1,15,'2026-06-27 18:17:28','2026-06-27 18:17:28'),(31,'Peter','Griffin','1962-02-11','PASAPORTE','2554892',1,17,'2026-06-27 22:44:07','2026-06-27 22:44:18'),(32,'Stewie','Griffin','2010-02-25','DNI','50589631',0,17,'2026-06-27 23:06:47','2026-06-27 23:06:47'),(33,'marcos','diaz','1997-06-27','DNI','11111111',1,18,'2026-06-29 19:06:32','2026-06-29 19:06:40'),(34,'anahi','sanchez','1998-06-25','DNI','5984268',0,19,'2026-06-29 19:35:31','2026-06-29 19:48:11'),(35,'pequeño','niño','2024-02-29','DNI','52100015',0,19,'2026-06-29 19:39:57','2026-06-29 19:39:57'),(36,'grande','adole','2003-06-04','DNI','25458752',0,19,'2026-06-29 19:40:43','2026-06-29 19:40:43'),(37,'menor','edad','2018-01-01','DNI','22345678',1,19,'2026-06-29 19:48:11','2026-06-29 19:48:11'),(38,'menor','de edad','2026-05-07','DNI','90876512',0,16,'2026-06-29 20:16:05','2026-06-29 20:16:05'),(39,'matias','alvarez','2009-02-20','DNI','5624520',0,20,'2026-06-29 20:39:02','2026-06-29 20:39:02');
/*!40000 ALTER TABLE `integrantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_06_04_000003_create_domain_tables',2),(5,'2026_06_04_000004_add_family_referente_and_unique_document_number',3),(6,'2026_06_08_000005_add_priorizacion_social_columns_to_familias',4),(7,'2026_06_11_000006_drop_categoria_etaria_from_integrantes',4),(16,'2026_06_12_000007_add_priorizacion_social_inputs_to_familias',5),(17,'2026_06_12_000007_unique_family_date_on_registros_asistencia',5),(18,'2026_06_15_000008_change_estado_in_participacion_comision',5),(19,'2026_06_26_000009_add_visto_to_notificaciones_table',5),(20,'2026_06_29_000009_backfill_family_inputs_from_legacy_scores',5),(21,'2026_06_29_000010_drop_participacion_activa_validada_from_familias',5),(22,'2026_06_29_000011_drop_family_score_columns_from_familias',5),(23,'2026_06_29_000012_force_active_commission_families_priority',5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones`
--

DROP TABLE IF EXISTS `notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones` (
  `id_notificacion` bigint unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `motivo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visto` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_notificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
INSERT INTO `notificaciones` VALUES (17,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico',1,'2026-06-12 18:38:15','2026-06-26 18:17:33'),(18,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico',1,'2026-06-12 18:56:13','2026-06-26 18:53:29'),(19,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico',1,'2026-06-12 19:03:09','2026-06-26 18:53:29'),(20,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico',1,'2026-06-12 19:04:47','2026-06-26 18:53:28'),(21,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-12 19:06:44','2026-06-26 18:53:25'),(22,'2026-06-25','La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-25 02:53:18','2026-06-26 18:53:24'),(23,'2026-06-25','La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-25 02:58:14','2026-06-26 18:53:23'),(24,'2026-06-26','La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-26 17:59:01','2026-06-26 18:42:33'),(25,'2026-06-26','La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-26 18:40:42','2026-06-26 18:42:29'),(26,'2026-06-26','La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-26 18:41:12','2026-06-26 18:42:13'),(27,'2026-06-26','La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-26 19:01:20','2026-06-29 21:33:03'),(28,'2026-06-26','La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-26 19:06:14','2026-06-29 21:33:00'),(29,'2026-06-26','La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-26 19:07:40','2026-06-29 21:32:58'),(30,'2026-06-29','La familia de referente está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',1,'2026-06-29 21:30:15','2026-06-29 21:32:31'),(31,'2026-06-04','Notificacion de ejemplo',0,'2026-06-29 21:32:56','2026-06-29 21:32:56');
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participacion_comision`
--

DROP TABLE IF EXISTS `participacion_comision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participacion_comision` (
  `id_participacion_comision` bigint unsigned NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `observaciones` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `integrante_id` bigint unsigned NOT NULL,
  `comision_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_participacion_comision`),
  UNIQUE KEY `participacion_comision_integrante_id_comision_id_unique` (`integrante_id`,`comision_id`),
  KEY `participacion_comision_comision_id_foreign` (`comision_id`),
  CONSTRAINT `participacion_comision_comision_id_foreign` FOREIGN KEY (`comision_id`) REFERENCES `comisiones` (`id_comision`) ON DELETE CASCADE,
  CONSTRAINT `participacion_comision_integrante_id_foreign` FOREIGN KEY (`integrante_id`) REFERENCES `integrantes` (`id_integrante`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participacion_comision`
--

LOCK TABLES `participacion_comision` WRITE;
/*!40000 ALTER TABLE `participacion_comision` DISABLE KEYS */;
INSERT INTO `participacion_comision` VALUES (3,'2026-01-03','activo','Alta de participacion',2,2,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(4,'2026-01-17','activo','Alta de participacion',3,3,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(5,'2026-02-07','activo','Alta de participacion',4,4,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(6,'2026-02-21','activo','Alta de participacion',7,5,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(7,'2026-03-14','activo','Alta de participacion',10,6,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(8,'2026-04-11','inactivo','Baja posterior',13,2,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(9,'2026-05-16','activo','Alta de participacion',16,3,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(10,'2026-06-27','inactivo','Baja posterior',17,4,'2026-06-11 20:56:20','2026-06-11 20:56:20');
/*!40000 ALTER TABLE `participacion_comision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_especiales`
--

DROP TABLE IF EXISTS `pedidos_especiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_especiales` (
  `id_pedido_especial` bigint unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_carga` date NOT NULL,
  `registrado_por` bigint unsigned NOT NULL,
  `familia_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_pedido_especial`),
  KEY `pedidos_especiales_registrado_por_foreign` (`registrado_por`),
  KEY `pedidos_especiales_familia_id_foreign` (`familia_id`),
  CONSTRAINT `pedidos_especiales_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE SET NULL,
  CONSTRAINT `pedidos_especiales_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_especiales`
--

LOCK TABLES `pedidos_especiales` WRITE;
/*!40000 ALTER TABLE `pedidos_especiales` DISABLE KEYS */;
INSERT INTO `pedidos_especiales` VALUES (1,'Pedido de ejemplo','nuevo','2026-06-04',1,5,'2026-06-29 19:21:12','2026-06-29 19:21:12');
/*!40000 ALTER TABLE `pedidos_especiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permisos` (
  `id_permiso` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_permiso`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisos`
--

LOCK TABLES `permisos` WRITE;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
INSERT INTO `permisos` VALUES (1,'Gestionar usuarios','usuarios','2026-06-04 15:35:02','2026-06-04 15:35:02'),(2,'Gestionar roles','roles','2026-06-04 15:35:02','2026-06-04 15:35:02'),(3,'Gestionar permisos','permisos','2026-06-04 15:35:02','2026-06-04 15:35:02'),(4,'Gestionar notificaciones','notificaciones','2026-06-04 15:35:02','2026-06-04 15:35:02'),(5,'Ver usuarios','usuarios','2026-06-04 15:35:02','2026-06-04 15:35:02'),(7,'Evaluar prioridad social','priorizacion','2026-06-11 20:55:09','2026-06-11 20:55:09'),(9,'Ver Familias','familias','2026-06-12 10:55:48','2026-06-12 10:55:51'),(10,'Poner asistencia','familias','2026-06-12 10:56:56','2026-06-12 10:57:00'),(11,'Alerta Ausentismo','notificaciones','2026-06-12 13:14:41','2026-06-12 13:14:45'),(12,'Gestionar listas','familias','2026-06-12 16:12:06','2026-06-12 16:12:06'),(13,'Gestionar Familias','familias','2026-06-12 16:25:56','2026-06-12 16:25:59'),(14,'Ver comisiones','Comisiones','2026-06-29 14:43:13','2026-06-29 14:43:13'),(15,'Gestionar comisiones','Comisiones','2026-06-29 14:43:13','2026-06-29 14:43:13'),(16,'Gestionar participaciones','Comisiones','2026-06-29 14:43:13','2026-06-29 14:43:13');
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registros_asistencia`
--

DROP TABLE IF EXISTS `registros_asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registros_asistencia` (
  `id_registro_asistencia` bigint unsigned NOT NULL AUTO_INCREMENT,
  `familia_id` bigint unsigned NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registrado_por` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_registro_asistencia`),
  UNIQUE KEY `registros_asistencia_familia_id_fecha_unique` (`familia_id`,`fecha`),
  KEY `registros_asistencia_registrado_por_foreign` (`registrado_por`),
  CONSTRAINT `registros_asistencia_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE CASCADE,
  CONSTRAINT `registros_asistencia_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registros_asistencia`
--

LOCK TABLES `registros_asistencia` WRITE;
/*!40000 ALTER TABLE `registros_asistencia` DISABLE KEYS */;
INSERT INTO `registros_asistencia` VALUES (3,2,'2026-01-03','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(4,3,'2026-01-03','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(5,4,'2026-01-03','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(6,5,'2026-01-03','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(7,6,'2026-01-03','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(9,2,'2026-01-10','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(10,3,'2026-01-10','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(11,4,'2026-01-10','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(12,5,'2026-01-10','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(13,6,'2026-01-10','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(15,2,'2026-01-17','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(16,3,'2026-01-17','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(17,4,'2026-01-17','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(18,5,'2026-01-17','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(19,6,'2026-01-17','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(21,2,'2026-01-24','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(22,3,'2026-01-24','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(23,4,'2026-01-24','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(24,5,'2026-01-24','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(25,6,'2026-01-24','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(27,2,'2026-01-31','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(28,3,'2026-01-31','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(29,4,'2026-01-31','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(30,5,'2026-01-31','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(31,6,'2026-01-31','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(33,2,'2026-02-07','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(34,3,'2026-02-07','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(35,4,'2026-02-07','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(36,5,'2026-02-07','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(37,6,'2026-02-07','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(39,2,'2026-02-14','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(40,3,'2026-02-14','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(41,4,'2026-02-14','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(42,5,'2026-02-14','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(43,6,'2026-02-14','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(45,2,'2026-02-21','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(46,3,'2026-02-21','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(47,4,'2026-02-21','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(48,5,'2026-02-21','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(49,6,'2026-02-21','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(51,2,'2026-02-28','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(52,3,'2026-02-28','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(53,4,'2026-02-28','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(54,5,'2026-02-28','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(55,6,'2026-02-28','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(57,2,'2026-03-07','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(58,3,'2026-03-07','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(59,4,'2026-03-07','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(60,5,'2026-03-07','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(61,6,'2026-03-07','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(63,2,'2026-03-14','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(64,3,'2026-03-14','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(65,4,'2026-03-14','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(66,5,'2026-03-14','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(67,6,'2026-03-14','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(69,2,'2026-03-21','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(70,3,'2026-03-21','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(71,4,'2026-03-21','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(72,5,'2026-03-21','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(73,6,'2026-03-21','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(75,2,'2026-03-28','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(76,3,'2026-03-28','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(77,4,'2026-03-28','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(78,5,'2026-03-28','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(79,6,'2026-03-28','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(81,2,'2026-04-04','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(82,3,'2026-04-04','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(83,4,'2026-04-04','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(84,5,'2026-04-04','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(85,6,'2026-04-04','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(87,2,'2026-04-11','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(88,3,'2026-04-11','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(89,4,'2026-04-11','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(90,5,'2026-04-11','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(91,6,'2026-04-11','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(93,2,'2026-04-18','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(94,3,'2026-04-18','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(95,4,'2026-04-18','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(96,5,'2026-04-18','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(97,6,'2026-04-18','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(99,2,'2026-04-25','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(100,3,'2026-04-25','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(101,4,'2026-04-25','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(102,5,'2026-04-25','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(103,6,'2026-04-25','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(105,2,'2026-05-02','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(106,3,'2026-05-02','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(107,4,'2026-05-02','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(108,5,'2026-05-02','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(109,6,'2026-05-02','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(111,2,'2026-05-09','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(112,3,'2026-05-09','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(113,4,'2026-05-09','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(114,5,'2026-05-09','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(115,6,'2026-05-09','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(117,2,'2026-05-16','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(118,3,'2026-05-16','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(119,4,'2026-05-16','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(120,5,'2026-05-16','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(121,6,'2026-05-16','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(123,2,'2026-05-23','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(124,3,'2026-05-23','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(125,4,'2026-05-23','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(126,5,'2026-05-23','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(127,6,'2026-05-23','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(129,2,'2026-05-30','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(130,3,'2026-05-30','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(131,4,'2026-05-30','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(132,5,'2026-05-30','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(133,6,'2026-05-30','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(135,2,'2026-06-06','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(136,3,'2026-06-06','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(137,4,'2026-06-06','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(138,5,'2026-06-06','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(139,6,'2026-06-06','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(141,2,'2026-06-13','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(142,3,'2026-06-13','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(143,4,'2026-06-13','ausente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(144,5,'2026-06-13','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(145,6,'2026-06-13','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(160,6,'2026-06-04','presente',1,'2026-06-11 20:56:20','2026-06-11 20:56:20'),(220,12,'2026-06-13','ausente',1,'2026-06-25 02:58:14','2026-06-25 02:58:14'),(223,11,'2026-06-25','presente',5,'2026-06-25 21:34:22','2026-06-25 21:34:22'),(224,12,'2026-06-25','ausente',5,'2026-06-25 21:34:22','2026-06-25 21:34:22'),(225,2,'2026-06-25','presente',5,'2026-06-25 21:34:22','2026-06-25 21:34:22'),(226,6,'2026-06-25','ausente',5,'2026-06-25 21:34:22','2026-06-25 21:34:22'),(227,12,'2026-06-26','presente',5,'2026-06-26 17:59:01','2026-06-26 19:07:44'),(228,2,'2026-06-26','presente',5,'2026-06-26 17:59:01','2026-06-26 19:00:52'),(229,11,'2026-06-26','presente',5,'2026-06-26 17:59:01','2026-06-26 19:01:20'),(230,6,'2026-06-26','presente',5,'2026-06-26 17:59:01','2026-06-26 19:00:52'),(231,2,'2026-06-27','presente',5,'2026-06-26 18:40:42','2026-06-29 21:34:29'),(232,12,'2026-06-27','ausente',8,'2026-06-26 18:40:42','2026-06-26 18:40:42'),(233,6,'2026-06-27','presente',5,'2026-06-26 18:40:42','2026-06-29 21:34:29'),(234,11,'2026-06-27','presente',5,'2026-06-26 18:40:42','2026-06-29 21:34:29'),(235,11,'2026-06-28','presente',8,'2026-06-26 18:41:12','2026-06-26 18:41:12'),(236,12,'2026-06-28','ausente',8,'2026-06-26 18:41:12','2026-06-26 18:41:12'),(237,2,'2026-06-28','presente',8,'2026-06-26 18:41:12','2026-06-26 18:41:12'),(238,6,'2026-06-28','presente',8,'2026-06-26 18:41:12','2026-06-26 18:41:12'),(239,12,'2026-07-09','presente',5,'2026-06-26 19:09:21','2026-06-26 19:09:21'),(240,11,'2026-07-09','ausente',5,'2026-06-26 19:09:21','2026-06-26 19:09:21'),(241,2,'2026-07-09','presente',5,'2026-06-26 19:09:21','2026-06-26 19:09:21'),(242,6,'2026-07-09','presente',5,'2026-06-26 19:09:21','2026-06-26 19:09:21'),(243,15,'2026-08-24','ausente',1,'2026-06-27 18:52:46','2026-06-27 18:52:46'),(244,15,'2026-08-31','presente',1,'2026-06-27 18:56:51','2026-06-27 18:56:51'),(245,15,'2026-08-30','ausente',1,'2026-06-27 23:31:46','2026-06-27 23:31:46'),(246,15,'2026-09-05','ausente',1,'2026-06-27 23:32:08','2026-06-27 23:32:08'),(247,20,'2026-06-30','ausente',1,'2026-06-29 21:21:50','2026-06-29 21:21:50'),(248,16,'2026-06-30','presente',1,'2026-06-29 21:21:50','2026-06-29 21:21:50'),(249,19,'2026-06-30','presente',1,'2026-06-29 21:21:50','2026-06-29 21:21:50'),(250,11,'2026-06-30','presente',1,'2026-06-29 21:21:50','2026-06-29 21:21:50'),(251,14,'2026-06-30','presente',1,'2026-06-29 21:21:51','2026-06-29 21:21:51'),(252,3,'2026-06-30','presente',1,'2026-06-29 21:21:51','2026-06-29 21:21:51'),(253,6,'2026-06-30','presente',1,'2026-06-29 21:21:51','2026-06-29 21:21:51'),(254,2,'2026-06-30','presente',1,'2026-06-29 21:21:51','2026-06-29 21:21:51'),(255,19,'2026-07-01','presente',5,'2026-06-29 21:30:06','2026-06-29 21:34:40'),(256,11,'2026-07-01','presente',5,'2026-06-29 21:30:06','2026-06-29 21:34:40'),(257,14,'2026-07-01','ausente',5,'2026-06-29 21:30:06','2026-06-29 21:34:40'),(258,16,'2026-07-01','presente',5,'2026-06-29 21:30:06','2026-06-29 21:34:40'),(259,20,'2026-07-01','ausente',1,'2026-06-29 21:30:06','2026-06-29 21:30:06'),(260,2,'2026-07-01','presente',5,'2026-06-29 21:30:06','2026-06-29 21:34:40'),(261,3,'2026-07-01','presente',5,'2026-06-29 21:30:06','2026-06-29 21:34:40'),(262,6,'2026-07-01','presente',5,'2026-06-29 21:30:06','2026-06-29 21:34:40'),(263,14,'2026-07-02','presente',1,'2026-06-29 21:30:15','2026-06-29 21:30:15'),(264,16,'2026-07-02','presente',1,'2026-06-29 21:30:15','2026-06-29 21:30:15'),(265,19,'2026-07-02','presente',1,'2026-06-29 21:30:15','2026-06-29 21:30:15'),(266,20,'2026-07-02','ausente',1,'2026-06-29 21:30:15','2026-06-29 21:30:15'),(267,3,'2026-07-02','presente',1,'2026-06-29 21:30:15','2026-06-29 21:30:15'),(268,11,'2026-07-02','presente',1,'2026-06-29 21:30:15','2026-06-29 21:30:15'),(269,2,'2026-07-02','presente',1,'2026-06-29 21:30:15','2026-06-29 21:30:15'),(270,6,'2026-07-02','presente',1,'2026-06-29 21:30:15','2026-06-29 21:30:15'),(271,19,'2026-06-29','presente',5,'2026-06-29 21:34:17','2026-06-29 21:34:17'),(272,16,'2026-06-29','presente',5,'2026-06-29 21:34:17','2026-06-29 21:34:17'),(273,14,'2026-06-29','ausente',5,'2026-06-29 21:34:17','2026-06-29 21:34:17'),(274,6,'2026-06-29','presente',5,'2026-06-29 21:34:17','2026-06-29 21:34:17'),(275,3,'2026-06-29','presente',5,'2026-06-29 21:34:17','2026-06-29 21:34:17'),(276,11,'2026-06-29','presente',5,'2026-06-29 21:34:17','2026-06-29 21:34:17'),(277,2,'2026-06-29','presente',5,'2026-06-29 21:34:17','2026-06-29 21:34:17'),(278,19,'2026-06-27','presente',5,'2026-06-29 21:34:29','2026-06-29 21:34:29'),(279,16,'2026-06-27','presente',5,'2026-06-29 21:34:29','2026-06-29 21:34:29'),(280,14,'2026-06-27','ausente',5,'2026-06-29 21:34:29','2026-06-29 21:34:29'),(281,3,'2026-06-27','presente',5,'2026-06-29 21:34:29','2026-06-29 21:34:29');
/*!40000 ALTER TABLE `registros_asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_permiso`
--

DROP TABLE IF EXISTS `rol_permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_permiso` (
  `rol_id` bigint unsigned NOT NULL,
  `permiso_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`rol_id`,`permiso_id`),
  KEY `rol_permiso_permiso_id_foreign` (`permiso_id`),
  CONSTRAINT `rol_permiso_permiso_id_foreign` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id_permiso`) ON DELETE CASCADE,
  CONSTRAINT `rol_permiso_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_permiso`
--

LOCK TABLES `rol_permiso` WRITE;
/*!40000 ALTER TABLE `rol_permiso` DISABLE KEYS */;
INSERT INTO `rol_permiso` VALUES (1,1),(2,1),(1,2),(1,3),(1,4),(1,5),(2,5),(3,5),(1,7),(2,7),(3,7),(1,9),(2,9),(3,9),(5,9),(6,9),(1,10),(2,10),(3,10),(2,11),(1,12),(2,12),(1,13),(2,13),(1,14),(2,14),(1,15),(1,16),(2,16);
/*!40000 ALTER TABLE `rol_permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Gestionan usuarios y configuraciones','2026-06-04 15:35:02','2026-06-04 15:35:02'),(2,'Coordinador','Administran familias y listas','2026-06-04 15:35:02','2026-06-04 15:35:02'),(3,'Encargado','Registran asistencias y operaciones diarias','2026-06-04 15:35:02','2026-06-04 15:35:02'),(5,'Voluntarios','Ayudante de comision','2026-06-11 20:55:09','2026-06-11 20:55:09'),(6,'Ayudante','Rol con acceso de solo lectura sobre familias.','2026-06-12 16:12:06','2026-06-12 16:12:06');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_notificacion`
--

DROP TABLE IF EXISTS `usuario_notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_notificacion` (
  `usuario_id` bigint unsigned NOT NULL,
  `notificacion_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`usuario_id`,`notificacion_id`),
  KEY `usuario_notificacion_notificacion_id_foreign` (`notificacion_id`),
  CONSTRAINT `usuario_notificacion_notificacion_id_foreign` FOREIGN KEY (`notificacion_id`) REFERENCES `notificaciones` (`id_notificacion`) ON DELETE CASCADE,
  CONSTRAINT `usuario_notificacion_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_notificacion`
--

LOCK TABLES `usuario_notificacion` WRITE;
/*!40000 ALTER TABLE `usuario_notificacion` DISABLE KEYS */;
INSERT INTO `usuario_notificacion` VALUES (1,17),(5,17),(5,18),(5,19),(5,20),(5,21),(5,22),(5,23),(5,24),(5,25),(5,26),(5,27),(5,28),(5,29),(5,30);
/*!40000 ALTER TABLE `usuario_notificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `contrasena` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `rol_id` bigint unsigned NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuarios_email_unique` (`email`),
  KEY `usuarios_rol_id_foreign` (`rol_id`),
  CONSTRAINT `usuarios_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Admin','Sistema','admin@example.com',NULL,'$2y$04$Pi/maFwkmabAlOmtpE7y3.LGhCA9vML2iW847nk2Irte6R4W98LRW',1,1,NULL,'2026-06-04 15:35:03','2026-06-12 16:18:36'),(5,'María José','B','mariajose.b@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,2,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(6,'Araceli','B','araceli.b@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(7,'Sofía','M','sofia.m@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(8,'Valentina','G','valentina.g@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(9,'Cata','M','cata.m@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(10,'Marisa','C','marisa.c@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(11,'Estela','M','estela.m@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,5,NULL,'2026-06-12 12:32:23','2026-06-12 12:32:27'),(12,'Martina','G','martina.g@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,5,NULL,'2026-06-12 12:33:10','2026-06-12 12:33:14');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visita_domiciliaria_usuario`
--

DROP TABLE IF EXISTS `visita_domiciliaria_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visita_domiciliaria_usuario` (
  `visita_domiciliaria_id` bigint unsigned NOT NULL,
  `usuario_visitador` bigint unsigned NOT NULL,
  PRIMARY KEY (`visita_domiciliaria_id`,`usuario_visitador`),
  KEY `visita_domiciliaria_usuario_usuario_visitador_foreign` (`usuario_visitador`),
  CONSTRAINT `visita_domiciliaria_usuario_usuario_visitador_foreign` FOREIGN KEY (`usuario_visitador`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `visita_domiciliaria_usuario_visita_domiciliaria_id_foreign` FOREIGN KEY (`visita_domiciliaria_id`) REFERENCES `visitas_domiciliarias` (`id_visita_domiciliaria`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visita_domiciliaria_usuario`
--

LOCK TABLES `visita_domiciliaria_usuario` WRITE;
/*!40000 ALTER TABLE `visita_domiciliaria_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `visita_domiciliaria_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitas_domiciliarias`
--

DROP TABLE IF EXISTS `visitas_domiciliarias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitas_domiciliarias` (
  `id_visita_domiciliaria` bigint unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `familia_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_visita_domiciliaria`),
  KEY `visitas_domiciliarias_familia_id_foreign` (`familia_id`),
  CONSTRAINT `visitas_domiciliarias_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitas_domiciliarias`
--

LOCK TABLES `visitas_domiciliarias` WRITE;
/*!40000 ALTER TABLE `visitas_domiciliarias` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitas_domiciliarias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'casacalcuta'
--

--
-- Dumping routines for database 'casacalcuta'
--
/*!50112 SET @disable_bulk_load = IF (@is_rocksdb_supported, 'SET SESSION rocksdb_bulk_load = @old_rocksdb_bulk_load', 'SET @dummy_rocksdb_bulk_load = 0') */;
/*!50112 PREPARE s FROM @disable_bulk_load */;
/*!50112 EXECUTE s */;
/*!50112 DEALLOCATE PREPARE s */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-29 23:34:59
