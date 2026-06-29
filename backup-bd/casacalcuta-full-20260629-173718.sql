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
  `accion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entidad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entidad_id` bigint unsigned NOT NULL,
  `fecha` date NOT NULL,
  `cambios` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
INSERT INTO `cache` VALUES ('laravel-cache-RKO9t3uLUZTs7Az3','a:1:{s:11:\"valid_until\";i:1781278566;}',1782487566),('laravel-cache-XnaRs4lutSfJWCGT','a:1:{s:11:\"valid_until\";i:1781281830;}',1782488250);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `activa` tinyint(1) NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `encargado` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_comision`),
  KEY `comisiones_encargado_foreign` (`encargado`),
  CONSTRAINT `comisiones_encargado_foreign` FOREIGN KEY (`encargado`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comisiones`
--

LOCK TABLES `comisiones` WRITE;
/*!40000 ALTER TABLE `comisiones` DISABLE KEYS */;
INSERT INTO `comisiones` VALUES (2,'Costura',1,'Comision de Costura',1,'2026-06-11 20:56:20','2026-06-29 17:36:59'),(3,'Cocina',1,'Comision de Cocina',1,'2026-06-11 20:56:20','2026-06-29 17:36:59'),(4,'Actividades',1,'Actividades con ninos',1,'2026-06-11 20:56:20','2026-06-29 17:36:59'),(5,'Lectoescritura',1,'Comision de alfabetizacion',1,'2026-06-11 20:56:20','2026-06-29 17:36:59'),(6,'Ropero',1,'Subcomision de ropero',1,'2026-06-11 20:56:20','2026-06-29 17:36:59');
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
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `origen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int unsigned NOT NULL,
  `unidad_medida` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donaciones`
--

LOCK TABLES `donaciones` WRITE;
/*!40000 ALTER TABLE `donaciones` DISABLE KEYS */;
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
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `puntaje_prioridad` int unsigned DEFAULT NULL,
  `puntaje_menores` tinyint unsigned DEFAULT NULL,
  `situacion_alimentaria` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frecuencia_asistencia` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `participacion_merendero` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `participacion_activa_validada` tinyint(1) DEFAULT NULL,
  `puntaje_alimentacion` tinyint unsigned DEFAULT NULL,
  `puntaje_asistencia` tinyint unsigned DEFAULT NULL,
  `puntaje_participacion` tinyint unsigned DEFAULT NULL,
  `evaluado_por` bigint unsigned DEFAULT NULL,
  `fecha_ultima_evaluacion` date DEFAULT NULL,
  `prioridad_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_lista` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `activa` tinyint(1) NOT NULL,
  `referente_id` bigint unsigned DEFAULT NULL,
  `registrado_por` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_familia`),
  UNIQUE KEY `familias_referente_id_unique` (`referente_id`),
  KEY `familias_registrado_por_foreign` (`registrado_por`),
  KEY `familias_evaluado_por_foreign` (`evaluado_por`),
  CONSTRAINT `familias_evaluado_por_foreign` FOREIGN KEY (`evaluado_por`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `familias_referente_id_foreign` FOREIGN KEY (`referente_id`) REFERENCES `integrantes` (`id_integrante`) ON DELETE SET NULL,
  CONSTRAINT `familias_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familias`
--

LOCK TABLES `familias` WRITE;
/*!40000 ALTER TABLE `familias` DISABLE KEYS */;
INSERT INTO `familias` VALUES (2,'742 Evergreen Terrace','555-0101',8,2,'moderada','mas_de_una_vez','activa',1,2,2,2,59,'2026-06-29','muy_alta','PRINCIPAL','2024-01-15',1,2,1,'2026-06-04 20:21:29','2026-06-29 17:36:59'),(3,'744 Evergreen Terrace','555-0102',5,1,'moderada','semanal','ocasional',0,2,1,1,59,'2026-06-29','media','ESPERA','2024-02-10',1,7,1,'2026-06-04 20:21:29','2026-06-29 17:36:59'),(4,'Apartment 2A, 33 Spooner Street','555-0103',4,1,'urgente','ocasional','no_participa',0,3,0,0,59,'2026-06-29','media','ESPERA','2024-03-05',1,10,1,'2026-06-04 20:21:29','2026-06-29 17:36:59'),(5,'Wiggum Residence','555-0104',1,1,'sin_urgencia','ocasional','no_participa',0,0,0,0,59,'2026-06-29','muy_baja','INACTIVA','2024-04-20',1,13,1,'2026-06-04 20:21:29','2026-06-29 17:36:59'),(6,'Hibbert Residence','555-0105',4,0,'moderada','semanal','ocasional',0,2,1,1,59,'2026-06-29','media','PRINCIPAL','2024-05-11',1,16,1,'2026-06-04 20:21:29','2026-06-29 17:36:59');
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
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `tipo_documento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_documento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `referente` tinyint(1) NOT NULL,
  `familia_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_integrante`),
  UNIQUE KEY `integrantes_numero_documento_unique` (`numero_documento`),
  KEY `integrantes_familia_id_foreign` (`familia_id`),
  CONSTRAINT `integrantes_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrantes`
--

LOCK TABLES `integrantes` WRITE;
/*!40000 ALTER TABLE `integrantes` DISABLE KEYS */;
INSERT INTO `integrantes` VALUES (2,'Homer','Simpson','1956-05-12','DNI','SIM-001',1,2,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(3,'Marge','Simpson','1956-03-19','DNI','SIM-002',0,2,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(4,'Bart','Simpson','2010-04-01','DNI','SIM-003',0,2,'2026-06-04 20:21:29','2026-06-12 00:16:09'),(5,'Lisa','Simpson','2012-05-09','DNI','SIM-004',0,2,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(6,'Maggie','Simpson','2018-01-12','DNI','SIM-005',0,2,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(7,'Ned','Flanders','1959-02-01','DNI','FLA-001',1,3,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(8,'Rod','Flanders','2011-07-07','DNI','FLA-002',0,3,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(9,'Todd','Flanders','2013-09-15','DNI','FLA-003',0,3,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(10,'Kirk','Van Houten','1959-08-01','DNI','VAN-001',1,4,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(11,'Luann','Van Houten','1960-10-15','DNI','VAN-002',0,4,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(12,'Milhouse','Van Houten','2011-02-20','DNI','VAN-003',0,4,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(13,'Clancy','Wiggum','1954-01-21','DNI','WIG-001',1,5,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(14,'Sarah','Wiggum','1956-11-02','DNI','WIG-002',0,5,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(15,'Ralph','Wiggum','2012-02-28','DNI','WIG-003',0,5,'2026-06-04 20:21:29','2026-06-12 00:16:10'),(16,'Julius','Hibbert','1952-09-18','DNI','HIB-001',1,6,'2026-06-04 20:21:29','2026-06-04 20:21:29'),(17,'Bernice','Hibbert','1954-06-24','DNI','HIB-002',0,6,'2026-06-04 20:21:29','2026-06-04 20:21:29');
/*!40000 ALTER TABLE `integrantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_06_04_000003_create_domain_tables',2),(5,'2026_06_04_000004_add_family_referente_and_unique_document_number',3),(6,'2026_06_08_000005_add_priorizacion_social_columns_to_familias',4),(7,'2026_06_11_000006_drop_categoria_etaria_from_integrantes',4),(8,'2026_06_12_000007_add_priorizacion_social_inputs_to_familias',5),(9,'2026_06_12_000007_unique_family_date_on_registros_asistencia',5),(10,'2026_06_15_000008_change_estado_in_participacion_comision',5),(11,'2026_06_26_000009_add_visto_to_notificaciones_table',5);
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
  `motivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visto` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_notificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
INSERT INTO `notificaciones` VALUES (17,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico',0,'2026-06-12 18:38:15','2026-06-12 18:38:15'),(18,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico',0,'2026-06-12 18:56:13','2026-06-12 18:56:13'),(19,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico',0,'2026-06-12 19:03:09','2026-06-12 19:03:09'),(20,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico',0,'2026-06-12 19:04:47','2026-06-12 19:04:47'),(21,'2026-06-12','La familia de Homer Simpson está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',0,'2026-06-12 19:06:44','2026-06-12 19:06:44');
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
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `integrante_id` bigint unsigned NOT NULL,
  `comision_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_participacion_comision`),
  UNIQUE KEY `participacion_comision_integrante_id_comision_id_unique` (`integrante_id`,`comision_id`),
  KEY `participacion_comision_comision_id_foreign` (`comision_id`),
  CONSTRAINT `participacion_comision_comision_id_foreign` FOREIGN KEY (`comision_id`) REFERENCES `comisiones` (`id_comision`) ON DELETE CASCADE,
  CONSTRAINT `participacion_comision_integrante_id_foreign` FOREIGN KEY (`integrante_id`) REFERENCES `integrantes` (`id_integrante`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participacion_comision`
--

LOCK TABLES `participacion_comision` WRITE;
/*!40000 ALTER TABLE `participacion_comision` DISABLE KEYS */;
INSERT INTO `participacion_comision` VALUES (11,'2026-01-03','activo','Alta de participacion',2,2,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(12,'2026-01-17','activo','Alta de participacion',3,3,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(13,'2026-02-07','activo','Alta de participacion',4,4,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(14,'2026-02-21','activo','Alta de participacion',7,5,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(15,'2026-03-14','activo','Alta de participacion',10,6,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(16,'2026-04-11','inactivo','Baja posterior',13,2,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(17,'2026-05-16','activo','Alta de participacion',16,3,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(18,'2026-06-27','inactivo','Baja posterior',17,4,'2026-06-29 17:36:59','2026-06-29 17:36:59');
/*!40000 ALTER TABLE `participacion_comision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_especiales`
--

LOCK TABLES `pedidos_especiales` WRITE;
/*!40000 ALTER TABLE `pedidos_especiales` DISABLE KEYS */;
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
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `modulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
INSERT INTO `permisos` VALUES (1,'Gestionar usuarios','usuarios','2026-06-04 15:35:02','2026-06-04 15:35:02'),(2,'Gestionar roles','roles','2026-06-04 15:35:02','2026-06-04 15:35:02'),(3,'Gestionar permisos','permisos','2026-06-04 15:35:02','2026-06-04 15:35:02'),(4,'Gestionar notificaciones','notificaciones','2026-06-04 15:35:02','2026-06-04 15:35:02'),(5,'Ver usuarios','usuarios','2026-06-04 15:35:02','2026-06-04 15:35:02'),(7,'Evaluar prioridad social','priorizacion','2026-06-11 20:55:09','2026-06-11 20:55:09'),(9,'Ver Familias','familias','2026-06-12 10:55:48','2026-06-12 10:55:51'),(10,'Poner asistencia','familias','2026-06-12 10:56:56','2026-06-12 10:57:00'),(11,'Alerta Ausentismo','notificaciones','2026-06-12 13:14:41','2026-06-12 13:14:45'),(12,'Gestionar listas','familias','2026-06-12 16:12:06','2026-06-12 16:12:06'),(13,'Gestionar Familias','familias','2026-06-12 16:25:56','2026-06-12 16:25:59'),(14,'Ver comisiones','Comisiones','2026-06-29 17:36:58','2026-06-29 17:36:58'),(15,'Gestionar comisiones','Comisiones','2026-06-29 17:36:58','2026-06-29 17:36:58'),(16,'Gestionar participaciones','Comisiones','2026-06-29 17:36:58','2026-06-29 17:36:58');
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
  `estado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `registrado_por` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_registro_asistencia`),
  UNIQUE KEY `registros_asistencia_familia_id_fecha_unique` (`familia_id`,`fecha`),
  KEY `registros_asistencia_familia_id_foreign` (`familia_id`),
  KEY `registros_asistencia_registrado_por_foreign` (`registrado_por`),
  CONSTRAINT `registros_asistencia_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE CASCADE,
  CONSTRAINT `registros_asistencia_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registros_asistencia`
--

LOCK TABLES `registros_asistencia` WRITE;
/*!40000 ALTER TABLE `registros_asistencia` DISABLE KEYS */;
INSERT INTO `registros_asistencia` VALUES (213,2,'2026-01-03','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(214,3,'2026-01-03','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(215,4,'2026-01-03','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(216,5,'2026-01-03','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(217,6,'2026-01-03','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(218,2,'2026-01-10','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(219,3,'2026-01-10','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(220,4,'2026-01-10','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(221,5,'2026-01-10','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(222,6,'2026-01-10','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(223,2,'2026-01-17','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(224,3,'2026-01-17','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(225,4,'2026-01-17','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(226,5,'2026-01-17','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(227,6,'2026-01-17','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(228,2,'2026-01-24','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(229,3,'2026-01-24','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(230,4,'2026-01-24','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(231,5,'2026-01-24','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(232,6,'2026-01-24','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(233,2,'2026-01-31','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(234,3,'2026-01-31','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(235,4,'2026-01-31','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(236,5,'2026-01-31','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(237,6,'2026-01-31','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(238,2,'2026-02-07','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(239,3,'2026-02-07','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(240,4,'2026-02-07','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(241,5,'2026-02-07','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(242,6,'2026-02-07','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(243,2,'2026-02-14','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(244,3,'2026-02-14','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(245,4,'2026-02-14','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(246,5,'2026-02-14','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(247,6,'2026-02-14','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(248,2,'2026-02-21','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(249,3,'2026-02-21','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(250,4,'2026-02-21','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(251,5,'2026-02-21','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(252,6,'2026-02-21','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(253,2,'2026-02-28','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(254,3,'2026-02-28','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(255,4,'2026-02-28','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(256,5,'2026-02-28','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(257,6,'2026-02-28','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(258,2,'2026-03-07','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(259,3,'2026-03-07','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(260,4,'2026-03-07','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(261,5,'2026-03-07','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(262,6,'2026-03-07','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(263,2,'2026-03-14','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(264,3,'2026-03-14','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(265,4,'2026-03-14','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(266,5,'2026-03-14','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(267,6,'2026-03-14','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(268,2,'2026-03-21','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(269,3,'2026-03-21','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(270,4,'2026-03-21','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(271,5,'2026-03-21','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(272,6,'2026-03-21','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(273,2,'2026-03-28','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(274,3,'2026-03-28','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(275,4,'2026-03-28','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(276,5,'2026-03-28','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(277,6,'2026-03-28','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(278,2,'2026-04-04','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(279,3,'2026-04-04','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(280,4,'2026-04-04','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(281,5,'2026-04-04','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(282,6,'2026-04-04','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(283,2,'2026-04-11','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(284,3,'2026-04-11','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(285,4,'2026-04-11','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(286,5,'2026-04-11','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(287,6,'2026-04-11','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(288,2,'2026-04-18','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(289,3,'2026-04-18','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(290,4,'2026-04-18','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(291,5,'2026-04-18','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(292,6,'2026-04-18','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(293,2,'2026-04-25','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(294,3,'2026-04-25','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(295,4,'2026-04-25','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(296,5,'2026-04-25','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(297,6,'2026-04-25','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(298,2,'2026-05-02','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(299,3,'2026-05-02','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(300,4,'2026-05-02','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(301,5,'2026-05-02','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(302,6,'2026-05-02','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(303,2,'2026-05-09','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(304,3,'2026-05-09','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(305,4,'2026-05-09','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(306,5,'2026-05-09','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(307,6,'2026-05-09','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(308,2,'2026-05-16','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(309,3,'2026-05-16','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(310,4,'2026-05-16','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(311,5,'2026-05-16','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(312,6,'2026-05-16','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(313,2,'2026-05-23','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(314,3,'2026-05-23','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(315,4,'2026-05-23','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(316,5,'2026-05-23','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(317,6,'2026-05-23','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(318,2,'2026-05-30','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(319,3,'2026-05-30','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(320,4,'2026-05-30','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(321,5,'2026-05-30','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(322,6,'2026-05-30','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(323,2,'2026-06-06','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(324,3,'2026-06-06','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(325,4,'2026-06-06','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(326,5,'2026-06-06','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(327,6,'2026-06-06','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(328,2,'2026-06-13','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(329,3,'2026-06-13','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(330,4,'2026-06-13','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(331,5,'2026-06-13','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(332,6,'2026-06-13','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(333,2,'2026-06-20','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(334,3,'2026-06-20','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(335,4,'2026-06-20','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(336,5,'2026-06-20','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(337,6,'2026-06-20','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(338,2,'2026-06-27','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(339,3,'2026-06-27','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(340,4,'2026-06-27','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(341,5,'2026-06-27','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(342,6,'2026-06-27','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(343,2,'2026-06-04','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(344,3,'2026-06-04','ausente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59'),(345,4,'2026-06-04','presente',1,'2026-06-29 17:36:59','2026-06-29 17:36:59');
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
INSERT INTO `rol_permiso` VALUES (1,1),(2,1),(1,2),(1,3),(1,4),(2,4),(43,4),(1,5),(2,5),(3,5),(43,5),(44,5),(1,7),(2,7),(3,7),(1,9),(2,9),(3,9),(5,9),(6,9),(1,10),(2,10),(3,10),(2,11),(1,12),(2,12),(1,13),(2,13),(1,14),(2,14),(1,15),(1,16),(2,16);
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
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Gestionan usuarios y configuraciones','2026-06-04 15:35:02','2026-06-04 15:35:02'),(2,'Coordinador','Administran familias y listas','2026-06-04 15:35:02','2026-06-04 15:35:02'),(3,'Encargado','Registran asistencias y operaciones diarias','2026-06-04 15:35:02','2026-06-04 15:35:02'),(5,'Voluntarios','Ayudante de comision','2026-06-11 20:55:09','2026-06-11 20:55:09'),(6,'Ayudante','Rol con acceso de solo lectura sobre familias.','2026-06-12 16:12:06','2026-06-12 16:12:06'),(43,'Operador','Rol para tareas operativas','2026-06-29 17:36:58','2026-06-29 17:36:58'),(44,'Consulta','Rol con acceso de solo lectura','2026-06-29 17:36:58','2026-06-29 17:36:58');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
INSERT INTO `usuario_notificacion` VALUES (1,17),(5,17),(5,18),(5,19),(5,20),(5,21);
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
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `contrasena` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `rol_id` bigint unsigned NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuarios_email_unique` (`email`),
  KEY `usuarios_rol_id_foreign` (`rol_id`),
  CONSTRAINT `usuarios_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Admin','Sistema','admin@example.com',NULL,'$2y$12$Cbsiw7WGlyl1HvzlUR1e8OB3mqTdXvEwiPWkOkxWLOLxRkmXC8K.2',1,1,NULL,'2026-06-04 15:35:03','2026-06-29 17:36:58'),(5,'María José','B','mariajose.b@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,2,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(6,'Araceli','B','araceli.b@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(7,'Sofía','M','sofia.m@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(8,'Valentina','G','valentina.g@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(9,'Cata','M','cata.m@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(10,'Marisa','C','marisa.c@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,3,NULL,'2026-06-11 21:00:37','2026-06-11 21:00:37'),(11,'Estela','M','estela.m@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,5,NULL,'2026-06-12 12:32:23','2026-06-12 12:32:27'),(12,'Martina','G','martina.g@example.com',NULL,'$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy',1,5,NULL,'2026-06-12 12:33:10','2026-06-12 12:33:14'),(59,'Coordinador','CasaCalcuta','coordinador@example.com',NULL,'$2y$12$ZwbAFk/ZLeJkN95NYqal8ucedGWVKLwA6xuVMkpQ94z62ErCcaRUO',1,2,NULL,'2026-06-29 17:36:58','2026-06-29 17:36:58'),(60,'Operador','CasaCalcuta','operador@example.com',NULL,'$2y$12$hAQMDky1iRji2SUC7jZ5butXs/qpwhx/5XGYkuOSORx5vMS5fmSx.',1,43,NULL,'2026-06-29 17:36:58','2026-06-29 17:36:58'),(61,'Consulta','CasaCalcuta','consulta@example.com',NULL,'$2y$12$IEKrhJSAv4OqrMJsPssy7esTtaetDrxndiZUvG7NkFsAOyCVWzD92',1,44,NULL,'2026-06-29 17:36:58','2026-06-29 17:36:58');
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
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `familia_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_visita_domiciliaria`),
  KEY `visitas_domiciliarias_familia_id_foreign` (`familia_id`),
  CONSTRAINT `visitas_domiciliarias_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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

-- Dump completed on 2026-06-29 17:37:18
