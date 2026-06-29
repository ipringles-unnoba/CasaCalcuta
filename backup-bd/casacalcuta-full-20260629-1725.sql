/*
 Navicat Premium Dump SQL

 Source Server         : casacalcuta.backend.paidos.net.ar
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36-28)
 Source Host           : casacalcuta.backend.paidos.net.ar:3306
 Source Schema         : casacalcuta

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36-28)
 File Encoding         : 65001

 Date: 29/06/2026 17:25:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auditorias
-- ----------------------------
DROP TABLE IF EXISTS `auditorias`;
CREATE TABLE `auditorias`  (
  `id_auditoria` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entidad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entidad_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `cambios` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_auditoria`) USING BTREE,
  INDEX `auditorias_usuario_id_foreign`(`usuario_id` ASC) USING BTREE,
  INDEX `auditorias_entidad_entidad_id_index`(`entidad` ASC, `entidad_id` ASC) USING BTREE,
  CONSTRAINT `auditorias_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auditorias
-- ----------------------------

-- ----------------------------
-- Table structure for autorizaciones
-- ----------------------------
DROP TABLE IF EXISTS `autorizaciones`;
CREATE TABLE `autorizaciones`  (
  `id_autorizacion` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vigente` tinyint(1) NOT NULL,
  `vencimiento` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_autorizacion`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of autorizaciones
-- ----------------------------
INSERT INTO `autorizaciones` VALUES (1, 'General', 1, '2026-12-31', '2026-06-04 20:14:46', '2026-06-04 20:14:46');

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-3kCQCICgUN3XmPmb', 'a:1:{s:11:\"valid_until\";i:1782760630;}', 1783970290);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-5jvNuPQUYCI6OJLm', 'a:1:{s:11:\"valid_until\";i:1782499192;}', 1783708492);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-5ZASQALdfLsD9nBg', 'a:1:{s:11:\"valid_until\";i:1782180733;}', 1783390273);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-6o5xsRaUgQxiCW81', 'a:1:{s:11:\"valid_until\";i:1781896602;}', 1783106262);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-7gPv5pGcwr8ggcMM', 'a:1:{s:11:\"valid_until\";i:1782762260;}', 1783971620);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-7rgdlSJ6cyAZlY7D', 'a:1:{s:11:\"valid_until\";i:1782678304;}', 1783887964);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-8XLXQBhI9Vd45609', 'a:1:{s:11:\"valid_until\";i:1782678247;}', 1783887787);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-9mvTLrgHQg0cz2NV', 'a:1:{s:11:\"valid_until\";i:1782182427;}', 1783390467);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-AGYEAIORAR1BYfc9', 'a:1:{s:11:\"valid_until\";i:1782492645;}', 1783702305);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-B6ZdiL17yQEs3p0s', 'a:1:{s:11:\"valid_until\";i:1782499320;}', 1783708920);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-bEtPzXBnRRPVVIbR', 'a:1:{s:11:\"valid_until\";i:1782499230;}', 1783708890);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-bLwY3XtyX1wSj8pl', 'a:1:{s:11:\"valid_until\";i:1782761077;}', 1783970557);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-cePNs2ZUIsd8GUzX', 'a:1:{s:11:\"valid_until\";i:1781651826;}', 1782861486);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-chmAJ11dvaYe4vLI', 'a:1:{s:11:\"valid_until\";i:1782168470;}', 1783377830);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-DoYD5vX55nDHxisl', 'a:1:{s:11:\"valid_until\";i:1782421237;}', 1783630897);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-Dq4sItaXcNLK79g0', 'a:1:{s:11:\"valid_until\";i:1782759540;}', 1783968960);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-dx3o40AkjGsKSAXK', 'a:1:{s:11:\"valid_until\";i:1782180556;}', 1783389976);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-EdphhBV41nhi4JxK', 'a:1:{s:11:\"valid_until\";i:1782583911;}', 1783793271);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-emlmrcZ6SSrB5I02', 'a:1:{s:11:\"valid_until\";i:1782495397;}', 1783702357);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-fsZO2vlXqL9Dth7b', 'a:1:{s:11:\"valid_until\";i:1782080721;}', 1783290381);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-g0oa9aF4SpSayeUm', 'a:1:{s:11:\"valid_until\";i:1781899839;}', 1783109499);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-gB6iUVUkpJqo6KUH', 'a:1:{s:11:\"valid_until\";i:1782421365;}', 1783631025);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-gnGnAG9wlZ6eQcKO', 'a:1:{s:11:\"valid_until\";i:1782259907;}', 1783468667);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-gpdJYQWHhSLd7rvS', 'a:1:{s:11:\"valid_until\";i:1782762745;}', 1783972165);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-iwIddxMARSerD0Wn', 'a:1:{s:11:\"valid_until\";i:1782420740;}', 1783629320);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-kHtgBY6av0DJzDgt', 'a:1:{s:11:\"valid_until\";i:1781901586;}', 1783111246);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-KkvoG9hSK7tomC15', 'a:1:{s:11:\"valid_until\";i:1781651825;}', 1782861425);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-kNNf8pzaidYPAtYm', 'a:1:{s:11:\"valid_until\";i:1782760546;}', 1783969546);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-kRbTxwId64t2bT7u', 'a:1:{s:11:\"valid_until\";i:1781901811;}', 1783111471);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-L1cgds035nEVluyO', 'a:1:{s:11:\"valid_until\";i:1782760616;}', 1783970216);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-LtyrGRKl4yLlQXvg', 'a:1:{s:11:\"valid_until\";i:1781900009;}', 1783109669);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-lWB7jLE6dz7Awivu', 'a:1:{s:11:\"valid_until\";i:1782498810;}', 1783705230);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-mKQhq3a2Hz7cbzRL', 'a:1:{s:11:\"valid_until\";i:1782761828;}', 1783971368);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-MTc2pbujoCLsPSHS', 'a:1:{s:11:\"valid_until\";i:1782678404;}', 1783888064);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-mUkvEfzwpq20e0qM', 'a:1:{s:11:\"valid_until\";i:1782760849;}', 1783970329);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-OOIfgosSoS9txerV', 'a:1:{s:11:\"valid_until\";i:1782762958;}', 1783972438);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-OWMnCMWrExDEV2u6', 'a:1:{s:11:\"valid_until\";i:1782761593;}', 1783971253);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-pm54OKfOuZTbvxjV', 'a:1:{s:11:\"valid_until\";i:1782584653;}', 1783794313);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-PVippl142XcXE5aK', 'a:1:{s:11:\"valid_until\";i:1782759832;}', 1783969252);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-PVJfd4yKfklLvk8P', 'a:1:{s:11:\"valid_until\";i:1782168150;}', 1783377810);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-pxBXPsHWjIqYO802', 'a:1:{s:11:\"valid_until\";i:1782761646;}', 1783971306);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-qZehxEempVf5wX3E', 'a:1:{s:11:\"valid_until\";i:1782761550;}', 1783970790);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-Rkt9OXypDgyjLJUv', 'a:1:{s:11:\"valid_until\";i:1782498791;}', 1783708151);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-sZiaIGV2E1njYJuV', 'a:1:{s:11:\"valid_until\";i:1782762461;}', 1783971941);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-t7LaJNVruN4Ddh2w', 'a:1:{s:11:\"valid_until\";i:1782583255;}', 1783791895);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-uRJeCSBBUoJeX3sK', 'a:1:{s:11:\"valid_until\";i:1782498745;}', 1783705105);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-vI9Y2UORDlhMK9kE', 'a:1:{s:11:\"valid_until\";i:1782703761;}', 1783913181);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-vmDuXVBxlaAt00k4', 'a:1:{s:11:\"valid_until\";i:1782168091;}', 1783377751);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-WvanI1qoaikFb1m6', 'a:1:{s:11:\"valid_until\";i:1782499989;}', 1783709349);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-xc01SIlnnEnT9qNW', 'a:1:{s:11:\"valid_until\";i:1782414602;}', 1783623782);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-ybyHLHPBq7nkVQej', 'a:1:{s:11:\"valid_until\";i:1782704786;}', 1783913546);
INSERT INTO `cache` VALUES ('casacalcutabackend-cache-z9MStp9kZg4cJiRS', 'a:1:{s:11:\"valid_until\";i:1782096356;}', 1783306016);
INSERT INTO `cache` VALUES ('laravel-cache-RKO9t3uLUZTs7Az3', 'a:1:{s:11:\"valid_until\";i:1781278566;}', 1782487566);
INSERT INTO `cache` VALUES ('laravel-cache-XnaRs4lutSfJWCGT', 'a:1:{s:11:\"valid_until\";i:1781281830;}', 1782488250);

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_locks_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for comisiones
-- ----------------------------
DROP TABLE IF EXISTS `comisiones`;
CREATE TABLE `comisiones`  (
  `id_comision` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `activa` tinyint(1) NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `encargado` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_comision`) USING BTREE,
  INDEX `comisiones_encargado_foreign`(`encargado` ASC) USING BTREE,
  CONSTRAINT `comisiones_encargado_foreign` FOREIGN KEY (`encargado`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comisiones
-- ----------------------------
INSERT INTO `comisiones` VALUES (2, 'Costura', 1, 'Comision de Costura', 7, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `comisiones` VALUES (3, 'Cocina', 1, 'Comision de Cocina', 6, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `comisiones` VALUES (4, 'Actividades', 1, 'Actividades con ninos', 8, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `comisiones` VALUES (5, 'Lectoescritura', 1, 'Comision de alfabetizacion', 10, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `comisiones` VALUES (6, 'Ropero', 1, 'Subcomision de ropero', 9, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `comisiones` VALUES (8, 'Comision de ejemplo', 1, 'Descripcion de ejemplo', 5, '2026-06-29 19:55:07', '2026-06-29 19:55:07');

-- ----------------------------
-- Table structure for documentacion_integrante
-- ----------------------------
DROP TABLE IF EXISTS `documentacion_integrante`;
CREATE TABLE `documentacion_integrante`  (
  `documento_id` bigint UNSIGNED NOT NULL,
  `integrante_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`documento_id`, `integrante_id`) USING BTREE,
  INDEX `documentacion_integrante_integrante_id_foreign`(`integrante_id` ASC) USING BTREE,
  CONSTRAINT `documentacion_integrante_documento_id_foreign` FOREIGN KEY (`documento_id`) REFERENCES `documentos` (`id_documento`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `documentacion_integrante_integrante_id_foreign` FOREIGN KEY (`integrante_id`) REFERENCES `integrantes` (`id_integrante`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of documentacion_integrante
-- ----------------------------

-- ----------------------------
-- Table structure for documentos
-- ----------------------------
DROP TABLE IF EXISTS `documentos`;
CREATE TABLE `documentos`  (
  `id_documento` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vigente` tinyint(1) NOT NULL,
  `vencimiento` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_documento`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of documentos
-- ----------------------------
INSERT INTO `documentos` VALUES (1, 'DNI', 1, '2026-12-31', '2026-06-04 20:14:04', '2026-06-04 20:14:04');

-- ----------------------------
-- Table structure for donaciones
-- ----------------------------
DROP TABLE IF EXISTS `donaciones`;
CREATE TABLE `donaciones`  (
  `id_donacion` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `origen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int UNSIGNED NOT NULL,
  `unidad_medida` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_recepcion` date NOT NULL,
  `registrado_por` bigint UNSIGNED NOT NULL,
  `familia_id` bigint UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_donacion`) USING BTREE,
  INDEX `donaciones_registrado_por_foreign`(`registrado_por` ASC) USING BTREE,
  INDEX `donaciones_familia_id_foreign`(`familia_id` ASC) USING BTREE,
  CONSTRAINT `donaciones_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `donaciones_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of donaciones
-- ----------------------------
INSERT INTO `donaciones` VALUES (1, 'Donante', 'Bolson de ejemplo', 10, 'unidad', '2026-06-04', 1, 11, '2026-06-27 15:45:25', '2026-06-27 16:22:07');
INSERT INTO `donaciones` VALUES (2, 'Donante', 'Paquete de Fideos', 12, 'unidad', '2026-06-04', 1, 11, '2026-06-27 15:45:54', '2026-06-27 15:45:54');
INSERT INTO `donaciones` VALUES (3, 'Donante', 'Paquete de Fideos', 12, 'unidad', '2026-06-04', 1, 5, '2026-06-27 16:04:38', '2026-06-27 16:04:38');
INSERT INTO `donaciones` VALUES (4, 'Donante', 'Yerba x 1KG', 20, 'unidad', '2026-06-27', 1, 5, '2026-06-27 16:21:45', '2026-06-27 16:21:45');
INSERT INTO `donaciones` VALUES (5, 'Donante', 'Azucar', 5, 'kg', '2026-06-27', 1, 5, '2026-06-27 23:40:50', '2026-06-27 23:40:50');
INSERT INTO `donaciones` VALUES (6, 'Donante', 'Arroz', 15, 'kg', '2026-06-29', 1, NULL, '2026-06-29 03:49:46', '2026-06-29 03:50:06');
INSERT INTO `donaciones` VALUES (7, 'changoma', 'Bolson de ejemplo', 1, 'unidad', '2026-06-04', 1, 15, '2026-06-29 19:41:49', '2026-06-29 19:41:49');

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE,
  INDEX `failed_jobs_connection_queue_failed_at_index`(`connection` ASC, `queue` ASC, `failed_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for familias
-- ----------------------------
DROP TABLE IF EXISTS `familias`;
CREATE TABLE `familias`  (
  `id_familia` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `puntaje_prioridad` int UNSIGNED NULL DEFAULT NULL,
  `puntaje_menores` tinyint UNSIGNED NULL DEFAULT NULL,
  `puntaje_alimentacion` tinyint UNSIGNED NULL DEFAULT NULL,
  `puntaje_asistencia` tinyint UNSIGNED NULL DEFAULT NULL,
  `puntaje_participacion` tinyint UNSIGNED NULL DEFAULT NULL,
  `evaluado_por` bigint UNSIGNED NULL DEFAULT NULL,
  `fecha_ultima_evaluacion` date NULL DEFAULT NULL,
  `prioridad_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `estado_lista` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `activa` tinyint(1) NOT NULL,
  `referente_id` bigint UNSIGNED NULL DEFAULT NULL,
  `registrado_por` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_familia`) USING BTREE,
  UNIQUE INDEX `familias_referente_id_unique`(`referente_id` ASC) USING BTREE,
  INDEX `familias_registrado_por_foreign`(`registrado_por` ASC) USING BTREE,
  INDEX `familias_evaluado_por_foreign`(`evaluado_por` ASC) USING BTREE,
  CONSTRAINT `familias_evaluado_por_foreign` FOREIGN KEY (`evaluado_por`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `familias_referente_id_foreign` FOREIGN KEY (`referente_id`) REFERENCES `integrantes` (`id_integrante`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `familias_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of familias
-- ----------------------------
INSERT INTO `familias` VALUES (2, '742 Evergreen Terrace', '555-0101', 8, 4, 2, 2, 2, 6, '2026-06-08', 'muy_alta', 'PRINCIPAL', '2024-01-15', 1, 2, 1, '2026-06-04 20:21:29', '2026-06-27 23:55:54');
INSERT INTO `familias` VALUES (3, '744 Evergreen Terrace', '555-0102', 5, 2, 2, 1, 1, 6, '2026-06-08', 'media', 'PRINCIPAL', '2024-02-10', 1, 7, 1, '2026-06-04 20:21:29', '2026-06-27 18:06:54');
INSERT INTO `familias` VALUES (4, 'Apartment 2A, 33 Spooner Street', '555-0103', 4, 1, 3, 0, 0, 6, '2026-06-12', 'media', 'ESPERA', '2024-03-05', 1, 10, 1, '2026-06-04 20:21:29', '2026-06-12 00:25:56');
INSERT INTO `familias` VALUES (5, 'Wiggum Residence', '555-0104', 1, 1, 0, 0, 0, 6, '2026-06-08', 'muy_baja', 'ESPERA', '2024-04-20', 1, 13, 1, '2026-06-04 20:21:29', '2026-06-12 00:25:56');
INSERT INTO `familias` VALUES (6, 'Hibbert Residence', '555-0105', 4, 0, 2, 1, 1, 6, '2026-06-08', 'media', 'PRINCIPAL', '2024-05-11', 1, 16, 1, '2026-06-04 20:21:29', '2026-06-12 00:25:56');
INSERT INTO `familias` VALUES (11, 'Calle Jujuy 2220', '2364111113', 6, 1, NULL, NULL, NULL, NULL, NULL, 'media', 'PRINCIPAL', '2026-06-23', 1, 24, 1, '2026-06-24 00:18:10', '2026-06-24 00:31:17');
INSERT INTO `familias` VALUES (12, 'Mariano Moreno 1111', '2364111114', 3, 1, NULL, NULL, NULL, NULL, NULL, 'baja', 'ESPERA', '2026-06-23', 1, 22, 1, '2026-06-24 00:21:24', '2026-06-27 18:07:06');
INSERT INTO `familias` VALUES (14, 'ejemplo 123', '102030', 10, 0, NULL, NULL, NULL, NULL, NULL, 'ALTA', 'PRINCIPAL', '2026-06-04', 1, 28, 1, '2026-06-27 17:04:46', '2026-06-27 17:07:26');
INSERT INTO `familias` VALUES (15, 'ejemplo 123', '102030', 10, 2, NULL, NULL, NULL, NULL, NULL, 'ALTA', 'ESPERA', '2026-06-04', 1, 30, 1, '2026-06-27 17:11:03', '2026-06-27 18:56:06');
INSERT INTO `familias` VALUES (16, 'ejemplo 1234', '1020320', 10, 1, NULL, NULL, NULL, NULL, NULL, 'ALTA', 'PRINCIPAL', '2026-06-04', 1, NULL, 12, '2026-06-27 17:20:14', '2026-06-29 20:16:05');
INSERT INTO `familias` VALUES (17, 'Calle Spooner 410', '23032003', 7, 1, NULL, NULL, NULL, NULL, NULL, 'alta', 'ESPERA', '2026-06-27', 1, 31, 1, '2026-06-27 22:43:13', '2026-06-29 19:26:44');
INSERT INTO `familias` VALUES (18, 'Belgrano 111', '0000 1111', 2, 0, NULL, NULL, NULL, NULL, NULL, 'media', 'ESPERA', '2026-06-29', 1, 33, 1, '2026-06-29 19:05:54', '2026-06-29 19:07:02');
INSERT INTO `familias` VALUES (19, 'aloe 222', '5555555555', 1, 2, NULL, NULL, NULL, NULL, NULL, 'baja', 'PRINCIPAL', '2026-06-29', 1, 37, 1, '2026-06-29 19:34:55', '2026-06-29 20:14:50');
INSERT INTO `familias` VALUES (20, 'av siempreviva', '23642254', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'alta', 'PRINCIPAL', '2026-06-29', 1, NULL, 1, '2026-06-29 20:18:06', '2026-06-29 20:18:06');

-- ----------------------------
-- Table structure for integrantes
-- ----------------------------
DROP TABLE IF EXISTS `integrantes`;
CREATE TABLE `integrantes`  (
  `id_integrante` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `tipo_documento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_documento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `referente` tinyint(1) NOT NULL,
  `familia_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_integrante`) USING BTREE,
  UNIQUE INDEX `integrantes_numero_documento_unique`(`numero_documento` ASC) USING BTREE,
  INDEX `integrantes_familia_id_foreign`(`familia_id` ASC) USING BTREE,
  CONSTRAINT `integrantes_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of integrantes
-- ----------------------------
INSERT INTO `integrantes` VALUES (2, 'Homer', 'Simpson', '1956-05-12', 'DNI', 'SIM-001', 1, 2, '2026-06-04 20:21:29', '2026-06-04 20:21:29');
INSERT INTO `integrantes` VALUES (3, 'Marge', 'Simpson', '1956-03-19', 'DNI', 'SIM-002', 0, 2, '2026-06-04 20:21:29', '2026-06-04 20:21:29');
INSERT INTO `integrantes` VALUES (4, 'Bart', 'Simpson', '2010-04-01', 'DNI', 'SIM-003', 0, 2, '2026-06-04 20:21:29', '2026-06-12 00:16:09');
INSERT INTO `integrantes` VALUES (5, 'Lisa', 'Simpson', '2012-05-09', 'DNI', 'SIM-004', 0, 2, '2026-06-04 20:21:29', '2026-06-12 00:16:10');
INSERT INTO `integrantes` VALUES (6, 'Maggie', 'Simpson', '2018-01-12', 'DNI', 'SIM-005', 0, 2, '2026-06-04 20:21:29', '2026-06-12 00:16:10');
INSERT INTO `integrantes` VALUES (7, 'Ned', 'Flanders', '1959-02-01', 'DNI', 'FLA-001', 1, 3, '2026-06-04 20:21:29', '2026-06-04 20:21:29');
INSERT INTO `integrantes` VALUES (8, 'Rod', 'Flanders', '2011-07-07', 'DNI', 'FLA-002', 0, 3, '2026-06-04 20:21:29', '2026-06-12 00:16:10');
INSERT INTO `integrantes` VALUES (9, 'Todd', 'Flanders', '2013-09-15', 'DNI', 'FLA-003', 0, 3, '2026-06-04 20:21:29', '2026-06-12 00:16:10');
INSERT INTO `integrantes` VALUES (10, 'Kirk', 'Van Houten', '1959-08-01', 'DNI', 'VAN-001', 1, 4, '2026-06-04 20:21:29', '2026-06-04 20:21:29');
INSERT INTO `integrantes` VALUES (11, 'Luann', 'Van Houten', '1960-10-15', 'DNI', 'VAN-002', 0, 4, '2026-06-04 20:21:29', '2026-06-04 20:21:29');
INSERT INTO `integrantes` VALUES (12, 'Milhouse', 'Van Houten', '2011-02-20', 'DNI', 'VAN-003', 0, 4, '2026-06-04 20:21:29', '2026-06-12 00:16:10');
INSERT INTO `integrantes` VALUES (13, 'Clancy', 'Wiggum', '1954-01-21', 'DNI', 'WIG-001', 1, 5, '2026-06-04 20:21:29', '2026-06-04 20:21:29');
INSERT INTO `integrantes` VALUES (14, 'Sarah', 'Wiggum', '1956-11-02', 'DNI', 'WIG-002', 0, 5, '2026-06-04 20:21:29', '2026-06-04 20:21:29');
INSERT INTO `integrantes` VALUES (15, 'Ralph', 'Wiggum', '2012-02-28', 'DNI', 'WIG-003', 0, 5, '2026-06-04 20:21:29', '2026-06-12 00:16:10');
INSERT INTO `integrantes` VALUES (16, 'Julius', 'Hibbert', '1952-09-18', 'DNI', 'HIB-001', 1, 6, '2026-06-04 20:21:29', '2026-06-04 20:21:29');
INSERT INTO `integrantes` VALUES (17, 'Bernice', 'Hibbert', '1954-06-24', 'DNI', 'HIB-002', 0, 6, '2026-06-04 20:21:29', '2026-06-04 20:21:29');
INSERT INTO `integrantes` VALUES (20, 'Pablo', 'Ledesma', '2000-11-23', 'DNI', '40252022', 0, 11, '2026-06-24 00:18:53', '2026-06-24 00:31:17');
INSERT INTO `integrantes` VALUES (21, 'Jeremias', 'Ledesma', '2021-06-11', 'DNI', '58003025', 0, 11, '2026-06-24 00:19:21', '2026-06-24 00:19:21');
INSERT INTO `integrantes` VALUES (22, 'Marcos', 'Perez', '1996-11-14', 'DNI', '38040258', 1, 12, '2026-06-24 00:21:52', '2026-06-24 00:23:48');
INSERT INTO `integrantes` VALUES (23, 'Paz', 'Perez', '2016-11-22', 'DNI', '55205862', 0, 12, '2026-06-24 00:22:21', '2026-06-24 00:22:21');
INSERT INTO `integrantes` VALUES (24, 'Paz', 'Diaz', '2001-06-23', 'DNI', '42048568', 1, 11, '2026-06-24 00:30:37', '2026-06-24 00:31:17');
INSERT INTO `integrantes` VALUES (25, 'Hugo', 'Simpson', '2016-02-23', 'DNI', '23022016', 0, 2, '2026-06-26 18:32:19', '2026-06-26 18:32:19');
INSERT INTO `integrantes` VALUES (27, 'Diego', 'Rodriguez', '2005-03-01', 'DNI', '34543903', 0, 14, '2026-06-27 17:06:51', '2026-06-27 17:06:51');
INSERT INTO `integrantes` VALUES (28, 'Diego', 'Rodriguez', '2005-03-01', 'DNI', '35543903', 1, 14, '2026-06-27 17:07:26', '2026-06-27 17:07:26');
INSERT INTO `integrantes` VALUES (29, 'Martin', 'Rodriguez', '2015-03-01', 'DNI', '35901902', 0, 15, '2026-06-27 17:13:43', '2026-06-27 18:17:28');
INSERT INTO `integrantes` VALUES (30, 'Martin', 'cumpleaños', '2015-07-01', 'DNI', '908765412', 1, 15, '2026-06-27 18:17:28', '2026-06-27 18:17:28');
INSERT INTO `integrantes` VALUES (31, 'Peter', 'Griffin', '1962-02-11', 'PASAPORTE', '2554892', 1, 17, '2026-06-27 22:44:07', '2026-06-27 22:44:18');
INSERT INTO `integrantes` VALUES (32, 'Stewie', 'Griffin', '2010-02-25', 'DNI', '50589631', 0, 17, '2026-06-27 23:06:47', '2026-06-27 23:06:47');
INSERT INTO `integrantes` VALUES (33, 'marcos', 'diaz', '1997-06-27', 'DNI', '11111111', 1, 18, '2026-06-29 19:06:32', '2026-06-29 19:06:40');
INSERT INTO `integrantes` VALUES (34, 'anahi', 'sanchez', '1998-06-25', 'DNI', '5984268', 0, 19, '2026-06-29 19:35:31', '2026-06-29 19:48:11');
INSERT INTO `integrantes` VALUES (35, 'pequeño', 'niño', '2024-02-29', 'DNI', '52100015', 0, 19, '2026-06-29 19:39:57', '2026-06-29 19:39:57');
INSERT INTO `integrantes` VALUES (36, 'grande', 'adole', '2003-06-04', 'DNI', '25458752', 0, 19, '2026-06-29 19:40:43', '2026-06-29 19:40:43');
INSERT INTO `integrantes` VALUES (37, 'menor', 'edad', '2018-01-01', 'DNI', '22345678', 1, 19, '2026-06-29 19:48:11', '2026-06-29 19:48:11');
INSERT INTO `integrantes` VALUES (38, 'menor', 'de edad', '2026-05-07', 'DNI', '90876512', 0, 16, '2026-06-29 20:16:05', '2026-06-29 20:16:05');

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2026_06_04_000003_create_domain_tables', 2);
INSERT INTO `migrations` VALUES (5, '2026_06_04_000004_add_family_referente_and_unique_document_number', 3);
INSERT INTO `migrations` VALUES (6, '2026_06_08_000005_add_priorizacion_social_columns_to_familias', 4);
INSERT INTO `migrations` VALUES (7, '2026_06_11_000006_drop_categoria_etaria_from_integrantes', 4);

-- ----------------------------
-- Table structure for notificaciones
-- ----------------------------
DROP TABLE IF EXISTS `notificaciones`;
CREATE TABLE `notificaciones`  (
  `id_notificacion` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `motivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visto` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_notificacion`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notificaciones
-- ----------------------------
INSERT INTO `notificaciones` VALUES (17, '2026-06-12', 'La familia de Homer Simpson está mostrando Ausentismo critico', 1, '2026-06-12 18:38:15', '2026-06-26 18:17:33');
INSERT INTO `notificaciones` VALUES (18, '2026-06-12', 'La familia de Homer Simpson está mostrando Ausentismo critico', 1, '2026-06-12 18:56:13', '2026-06-26 18:53:29');
INSERT INTO `notificaciones` VALUES (19, '2026-06-12', 'La familia de Homer Simpson está mostrando Ausentismo critico', 1, '2026-06-12 19:03:09', '2026-06-26 18:53:29');
INSERT INTO `notificaciones` VALUES (20, '2026-06-12', 'La familia de Homer Simpson está mostrando Ausentismo critico', 1, '2026-06-12 19:04:47', '2026-06-26 18:53:28');
INSERT INTO `notificaciones` VALUES (21, '2026-06-12', 'La familia de Homer Simpson está mostrando Ausentismo critico. Se propone bajarla de la lista principal.', 1, '2026-06-12 19:06:44', '2026-06-26 18:53:25');
INSERT INTO `notificaciones` VALUES (22, '2026-06-25', 'La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.', 1, '2026-06-25 02:53:18', '2026-06-26 18:53:24');
INSERT INTO `notificaciones` VALUES (23, '2026-06-25', 'La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.', 1, '2026-06-25 02:58:14', '2026-06-26 18:53:23');
INSERT INTO `notificaciones` VALUES (24, '2026-06-26', 'La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.', 1, '2026-06-26 17:59:01', '2026-06-26 18:42:33');
INSERT INTO `notificaciones` VALUES (25, '2026-06-26', 'La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.', 1, '2026-06-26 18:40:42', '2026-06-26 18:42:29');
INSERT INTO `notificaciones` VALUES (26, '2026-06-26', 'La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.', 1, '2026-06-26 18:41:12', '2026-06-26 18:42:13');
INSERT INTO `notificaciones` VALUES (27, '2026-06-26', 'La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.', 0, '2026-06-26 19:01:20', '2026-06-26 19:01:20');
INSERT INTO `notificaciones` VALUES (28, '2026-06-26', 'La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.', 0, '2026-06-26 19:06:14', '2026-06-26 19:06:14');
INSERT INTO `notificaciones` VALUES (29, '2026-06-26', 'La familia de Marcos Perez está mostrando Ausentismo critico. Se propone bajarla de la lista principal.', 0, '2026-06-26 19:07:40', '2026-06-26 19:07:40');

-- ----------------------------
-- Table structure for participacion_comision
-- ----------------------------
DROP TABLE IF EXISTS `participacion_comision`;
CREATE TABLE `participacion_comision`  (
  `id_participacion_comision` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date NOT NULL,
  `estado` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `integrante_id` bigint UNSIGNED NOT NULL,
  `comision_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_participacion_comision`) USING BTREE,
  UNIQUE INDEX `participacion_comision_integrante_id_comision_id_unique`(`integrante_id` ASC, `comision_id` ASC) USING BTREE,
  INDEX `participacion_comision_comision_id_foreign`(`comision_id` ASC) USING BTREE,
  CONSTRAINT `participacion_comision_comision_id_foreign` FOREIGN KEY (`comision_id`) REFERENCES `comisiones` (`id_comision`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `participacion_comision_integrante_id_foreign` FOREIGN KEY (`integrante_id`) REFERENCES `integrantes` (`id_integrante`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of participacion_comision
-- ----------------------------
INSERT INTO `participacion_comision` VALUES (3, '2026-01-03', 'activo', 'Alta de participacion', 2, 2, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `participacion_comision` VALUES (4, '2026-01-17', 'activo', 'Alta de participacion', 3, 3, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `participacion_comision` VALUES (5, '2026-02-07', 'activo', 'Alta de participacion', 4, 4, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `participacion_comision` VALUES (6, '2026-02-21', 'activo', 'Alta de participacion', 7, 5, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `participacion_comision` VALUES (7, '2026-03-14', 'activo', 'Alta de participacion', 10, 6, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `participacion_comision` VALUES (8, '2026-04-11', 'inactivo', 'Baja posterior', 13, 2, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `participacion_comision` VALUES (9, '2026-05-16', 'activo', 'Alta de participacion', 16, 3, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `participacion_comision` VALUES (10, '2026-06-27', 'inactivo', 'Baja posterior', 17, 4, '2026-06-11 20:56:20', '2026-06-11 20:56:20');

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for pedidos_especiales
-- ----------------------------
DROP TABLE IF EXISTS `pedidos_especiales`;
CREATE TABLE `pedidos_especiales`  (
  `id_pedido_especial` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_carga` date NOT NULL,
  `registrado_por` bigint UNSIGNED NOT NULL,
  `familia_id` bigint UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_pedido_especial`) USING BTREE,
  INDEX `pedidos_especiales_registrado_por_foreign`(`registrado_por` ASC) USING BTREE,
  INDEX `pedidos_especiales_familia_id_foreign`(`familia_id` ASC) USING BTREE,
  CONSTRAINT `pedidos_especiales_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `pedidos_especiales_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pedidos_especiales
-- ----------------------------
INSERT INTO `pedidos_especiales` VALUES (1, 'Pedido de ejemplo', 'nuevo', '2026-06-04', 1, 5, '2026-06-29 19:21:12', '2026-06-29 19:21:12');

-- ----------------------------
-- Table structure for permisos
-- ----------------------------
DROP TABLE IF EXISTS `permisos`;
CREATE TABLE `permisos`  (
  `id_permiso` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `modulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_permiso`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permisos
-- ----------------------------
INSERT INTO `permisos` VALUES (1, 'Gestionar usuarios', 'usuarios', '2026-06-04 15:35:02', '2026-06-04 15:35:02');
INSERT INTO `permisos` VALUES (2, 'Gestionar roles', 'roles', '2026-06-04 15:35:02', '2026-06-04 15:35:02');
INSERT INTO `permisos` VALUES (3, 'Gestionar permisos', 'permisos', '2026-06-04 15:35:02', '2026-06-04 15:35:02');
INSERT INTO `permisos` VALUES (4, 'Gestionar notificaciones', 'notificaciones', '2026-06-04 15:35:02', '2026-06-04 15:35:02');
INSERT INTO `permisos` VALUES (5, 'Ver usuarios', 'usuarios', '2026-06-04 15:35:02', '2026-06-04 15:35:02');
INSERT INTO `permisos` VALUES (7, 'Evaluar prioridad social', 'priorizacion', '2026-06-11 20:55:09', '2026-06-11 20:55:09');
INSERT INTO `permisos` VALUES (9, 'Ver Familias', 'familias', '2026-06-12 10:55:48', '2026-06-12 10:55:51');
INSERT INTO `permisos` VALUES (10, 'Poner asistencia', 'familias', '2026-06-12 10:56:56', '2026-06-12 10:57:00');
INSERT INTO `permisos` VALUES (11, 'Alerta Ausentismo', 'notificaciones', '2026-06-12 13:14:41', '2026-06-12 13:14:45');
INSERT INTO `permisos` VALUES (12, 'Gestionar listas', 'familias', '2026-06-12 16:12:06', '2026-06-12 16:12:06');
INSERT INTO `permisos` VALUES (13, 'Gestionar Familias', 'familias', '2026-06-12 16:25:56', '2026-06-12 16:25:59');
INSERT INTO `permisos` VALUES (14, 'Ver comisiones', 'Comisiones', '2026-06-29 14:43:13', '2026-06-29 14:43:13');
INSERT INTO `permisos` VALUES (15, 'Gestionar comisiones', 'Comisiones', '2026-06-29 14:43:13', '2026-06-29 14:43:13');
INSERT INTO `permisos` VALUES (16, 'Gestionar participaciones', 'Comisiones', '2026-06-29 14:43:13', '2026-06-29 14:43:13');

-- ----------------------------
-- Table structure for registros_asistencia
-- ----------------------------
DROP TABLE IF EXISTS `registros_asistencia`;
CREATE TABLE `registros_asistencia`  (
  `id_registro_asistencia` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `familia_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `registrado_por` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_registro_asistencia`) USING BTREE,
  UNIQUE INDEX `registros_asistencia_familia_id_fecha_unique`(`familia_id` ASC, `fecha` ASC) USING BTREE,
  INDEX `registros_asistencia_familia_id_foreign`(`familia_id` ASC) USING BTREE,
  INDEX `registros_asistencia_registrado_por_foreign`(`registrado_por` ASC) USING BTREE,
  CONSTRAINT `registros_asistencia_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `registros_asistencia_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 247 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registros_asistencia
-- ----------------------------
INSERT INTO `registros_asistencia` VALUES (3, 2, '2026-01-03', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (4, 3, '2026-01-03', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (5, 4, '2026-01-03', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (6, 5, '2026-01-03', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (7, 6, '2026-01-03', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (9, 2, '2026-01-10', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (10, 3, '2026-01-10', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (11, 4, '2026-01-10', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (12, 5, '2026-01-10', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (13, 6, '2026-01-10', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (15, 2, '2026-01-17', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (16, 3, '2026-01-17', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (17, 4, '2026-01-17', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (18, 5, '2026-01-17', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (19, 6, '2026-01-17', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (21, 2, '2026-01-24', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (22, 3, '2026-01-24', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (23, 4, '2026-01-24', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (24, 5, '2026-01-24', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (25, 6, '2026-01-24', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (27, 2, '2026-01-31', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (28, 3, '2026-01-31', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (29, 4, '2026-01-31', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (30, 5, '2026-01-31', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (31, 6, '2026-01-31', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (33, 2, '2026-02-07', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (34, 3, '2026-02-07', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (35, 4, '2026-02-07', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (36, 5, '2026-02-07', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (37, 6, '2026-02-07', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (39, 2, '2026-02-14', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (40, 3, '2026-02-14', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (41, 4, '2026-02-14', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (42, 5, '2026-02-14', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (43, 6, '2026-02-14', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (45, 2, '2026-02-21', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (46, 3, '2026-02-21', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (47, 4, '2026-02-21', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (48, 5, '2026-02-21', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (49, 6, '2026-02-21', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (51, 2, '2026-02-28', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (52, 3, '2026-02-28', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (53, 4, '2026-02-28', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (54, 5, '2026-02-28', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (55, 6, '2026-02-28', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (57, 2, '2026-03-07', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (58, 3, '2026-03-07', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (59, 4, '2026-03-07', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (60, 5, '2026-03-07', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (61, 6, '2026-03-07', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (63, 2, '2026-03-14', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (64, 3, '2026-03-14', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (65, 4, '2026-03-14', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (66, 5, '2026-03-14', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (67, 6, '2026-03-14', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (69, 2, '2026-03-21', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (70, 3, '2026-03-21', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (71, 4, '2026-03-21', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (72, 5, '2026-03-21', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (73, 6, '2026-03-21', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (75, 2, '2026-03-28', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (76, 3, '2026-03-28', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (77, 4, '2026-03-28', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (78, 5, '2026-03-28', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (79, 6, '2026-03-28', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (81, 2, '2026-04-04', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (82, 3, '2026-04-04', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (83, 4, '2026-04-04', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (84, 5, '2026-04-04', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (85, 6, '2026-04-04', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (87, 2, '2026-04-11', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (88, 3, '2026-04-11', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (89, 4, '2026-04-11', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (90, 5, '2026-04-11', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (91, 6, '2026-04-11', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (93, 2, '2026-04-18', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (94, 3, '2026-04-18', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (95, 4, '2026-04-18', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (96, 5, '2026-04-18', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (97, 6, '2026-04-18', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (99, 2, '2026-04-25', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (100, 3, '2026-04-25', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (101, 4, '2026-04-25', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (102, 5, '2026-04-25', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (103, 6, '2026-04-25', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (105, 2, '2026-05-02', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (106, 3, '2026-05-02', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (107, 4, '2026-05-02', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (108, 5, '2026-05-02', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (109, 6, '2026-05-02', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (111, 2, '2026-05-09', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (112, 3, '2026-05-09', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (113, 4, '2026-05-09', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (114, 5, '2026-05-09', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (115, 6, '2026-05-09', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (117, 2, '2026-05-16', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (118, 3, '2026-05-16', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (119, 4, '2026-05-16', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (120, 5, '2026-05-16', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (121, 6, '2026-05-16', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (123, 2, '2026-05-23', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (124, 3, '2026-05-23', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (125, 4, '2026-05-23', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (126, 5, '2026-05-23', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (127, 6, '2026-05-23', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (129, 2, '2026-05-30', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (130, 3, '2026-05-30', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (131, 4, '2026-05-30', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (132, 5, '2026-05-30', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (133, 6, '2026-05-30', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (135, 2, '2026-06-06', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (136, 3, '2026-06-06', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (137, 4, '2026-06-06', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (138, 5, '2026-06-06', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (139, 6, '2026-06-06', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (141, 2, '2026-06-13', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (142, 3, '2026-06-13', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (143, 4, '2026-06-13', 'ausente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (144, 5, '2026-06-13', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (145, 6, '2026-06-13', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (160, 6, '2026-06-04', 'presente', 1, '2026-06-11 20:56:20', '2026-06-11 20:56:20');
INSERT INTO `registros_asistencia` VALUES (220, 12, '2026-06-13', 'ausente', 1, '2026-06-25 02:58:14', '2026-06-25 02:58:14');
INSERT INTO `registros_asistencia` VALUES (223, 11, '2026-06-25', 'presente', 5, '2026-06-25 21:34:22', '2026-06-25 21:34:22');
INSERT INTO `registros_asistencia` VALUES (224, 12, '2026-06-25', 'ausente', 5, '2026-06-25 21:34:22', '2026-06-25 21:34:22');
INSERT INTO `registros_asistencia` VALUES (225, 2, '2026-06-25', 'presente', 5, '2026-06-25 21:34:22', '2026-06-25 21:34:22');
INSERT INTO `registros_asistencia` VALUES (226, 6, '2026-06-25', 'ausente', 5, '2026-06-25 21:34:22', '2026-06-25 21:34:22');
INSERT INTO `registros_asistencia` VALUES (227, 12, '2026-06-26', 'presente', 5, '2026-06-26 17:59:01', '2026-06-26 19:07:44');
INSERT INTO `registros_asistencia` VALUES (228, 2, '2026-06-26', 'presente', 5, '2026-06-26 17:59:01', '2026-06-26 19:00:52');
INSERT INTO `registros_asistencia` VALUES (229, 11, '2026-06-26', 'presente', 5, '2026-06-26 17:59:01', '2026-06-26 19:01:20');
INSERT INTO `registros_asistencia` VALUES (230, 6, '2026-06-26', 'presente', 5, '2026-06-26 17:59:01', '2026-06-26 19:00:52');
INSERT INTO `registros_asistencia` VALUES (231, 2, '2026-06-27', 'presente', 8, '2026-06-26 18:40:42', '2026-06-26 18:40:42');
INSERT INTO `registros_asistencia` VALUES (232, 12, '2026-06-27', 'ausente', 8, '2026-06-26 18:40:42', '2026-06-26 18:40:42');
INSERT INTO `registros_asistencia` VALUES (233, 6, '2026-06-27', 'presente', 8, '2026-06-26 18:40:42', '2026-06-26 18:40:42');
INSERT INTO `registros_asistencia` VALUES (234, 11, '2026-06-27', 'presente', 8, '2026-06-26 18:40:42', '2026-06-26 18:40:42');
INSERT INTO `registros_asistencia` VALUES (235, 11, '2026-06-28', 'presente', 8, '2026-06-26 18:41:12', '2026-06-26 18:41:12');
INSERT INTO `registros_asistencia` VALUES (236, 12, '2026-06-28', 'ausente', 8, '2026-06-26 18:41:12', '2026-06-26 18:41:12');
INSERT INTO `registros_asistencia` VALUES (237, 2, '2026-06-28', 'presente', 8, '2026-06-26 18:41:12', '2026-06-26 18:41:12');
INSERT INTO `registros_asistencia` VALUES (238, 6, '2026-06-28', 'presente', 8, '2026-06-26 18:41:12', '2026-06-26 18:41:12');
INSERT INTO `registros_asistencia` VALUES (239, 12, '2026-07-09', 'presente', 5, '2026-06-26 19:09:21', '2026-06-26 19:09:21');
INSERT INTO `registros_asistencia` VALUES (240, 11, '2026-07-09', 'ausente', 5, '2026-06-26 19:09:21', '2026-06-26 19:09:21');
INSERT INTO `registros_asistencia` VALUES (241, 2, '2026-07-09', 'presente', 5, '2026-06-26 19:09:21', '2026-06-26 19:09:21');
INSERT INTO `registros_asistencia` VALUES (242, 6, '2026-07-09', 'presente', 5, '2026-06-26 19:09:21', '2026-06-26 19:09:21');
INSERT INTO `registros_asistencia` VALUES (243, 15, '2026-08-24', 'ausente', 1, '2026-06-27 18:52:46', '2026-06-27 18:52:46');
INSERT INTO `registros_asistencia` VALUES (244, 15, '2026-08-31', 'presente', 1, '2026-06-27 18:56:51', '2026-06-27 18:56:51');
INSERT INTO `registros_asistencia` VALUES (245, 15, '2026-08-30', 'ausente', 1, '2026-06-27 23:31:46', '2026-06-27 23:31:46');
INSERT INTO `registros_asistencia` VALUES (246, 15, '2026-09-05', 'ausente', 1, '2026-06-27 23:32:08', '2026-06-27 23:32:08');

-- ----------------------------
-- Table structure for rol_permiso
-- ----------------------------
DROP TABLE IF EXISTS `rol_permiso`;
CREATE TABLE `rol_permiso`  (
  `rol_id` bigint UNSIGNED NOT NULL,
  `permiso_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`rol_id`, `permiso_id`) USING BTREE,
  INDEX `rol_permiso_permiso_id_foreign`(`permiso_id` ASC) USING BTREE,
  CONSTRAINT `rol_permiso_permiso_id_foreign` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id_permiso`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `rol_permiso_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rol_permiso
-- ----------------------------
INSERT INTO `rol_permiso` VALUES (1, 1);
INSERT INTO `rol_permiso` VALUES (2, 1);
INSERT INTO `rol_permiso` VALUES (1, 2);
INSERT INTO `rol_permiso` VALUES (1, 3);
INSERT INTO `rol_permiso` VALUES (1, 4);
INSERT INTO `rol_permiso` VALUES (1, 5);
INSERT INTO `rol_permiso` VALUES (2, 5);
INSERT INTO `rol_permiso` VALUES (3, 5);
INSERT INTO `rol_permiso` VALUES (1, 7);
INSERT INTO `rol_permiso` VALUES (2, 7);
INSERT INTO `rol_permiso` VALUES (3, 7);
INSERT INTO `rol_permiso` VALUES (1, 9);
INSERT INTO `rol_permiso` VALUES (2, 9);
INSERT INTO `rol_permiso` VALUES (3, 9);
INSERT INTO `rol_permiso` VALUES (5, 9);
INSERT INTO `rol_permiso` VALUES (6, 9);
INSERT INTO `rol_permiso` VALUES (1, 10);
INSERT INTO `rol_permiso` VALUES (2, 10);
INSERT INTO `rol_permiso` VALUES (3, 10);
INSERT INTO `rol_permiso` VALUES (2, 11);
INSERT INTO `rol_permiso` VALUES (1, 12);
INSERT INTO `rol_permiso` VALUES (2, 12);
INSERT INTO `rol_permiso` VALUES (1, 13);
INSERT INTO `rol_permiso` VALUES (2, 13);
INSERT INTO `rol_permiso` VALUES (1, 14);
INSERT INTO `rol_permiso` VALUES (2, 14);
INSERT INTO `rol_permiso` VALUES (1, 15);
INSERT INTO `rol_permiso` VALUES (1, 16);
INSERT INTO `rol_permiso` VALUES (2, 16);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id_rol` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Administrador', 'Gestionan usuarios y configuraciones', '2026-06-04 15:35:02', '2026-06-04 15:35:02');
INSERT INTO `roles` VALUES (2, 'Coordinador', 'Administran familias y listas', '2026-06-04 15:35:02', '2026-06-04 15:35:02');
INSERT INTO `roles` VALUES (3, 'Encargado', 'Registran asistencias y operaciones diarias', '2026-06-04 15:35:02', '2026-06-04 15:35:02');
INSERT INTO `roles` VALUES (5, 'Voluntarios', 'Ayudante de comision', '2026-06-11 20:55:09', '2026-06-11 20:55:09');
INSERT INTO `roles` VALUES (6, 'Ayudante', 'Rol con acceso de solo lectura sobre familias.', '2026-06-12 16:12:06', '2026-06-12 16:12:06');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id` ASC) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------

-- ----------------------------
-- Table structure for usuario_notificacion
-- ----------------------------
DROP TABLE IF EXISTS `usuario_notificacion`;
CREATE TABLE `usuario_notificacion`  (
  `usuario_id` bigint UNSIGNED NOT NULL,
  `notificacion_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`usuario_id`, `notificacion_id`) USING BTREE,
  INDEX `usuario_notificacion_notificacion_id_foreign`(`notificacion_id` ASC) USING BTREE,
  CONSTRAINT `usuario_notificacion_notificacion_id_foreign` FOREIGN KEY (`notificacion_id`) REFERENCES `notificaciones` (`id_notificacion`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `usuario_notificacion_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario_notificacion
-- ----------------------------
INSERT INTO `usuario_notificacion` VALUES (1, 17);
INSERT INTO `usuario_notificacion` VALUES (5, 17);
INSERT INTO `usuario_notificacion` VALUES (5, 18);
INSERT INTO `usuario_notificacion` VALUES (5, 19);
INSERT INTO `usuario_notificacion` VALUES (5, 20);
INSERT INTO `usuario_notificacion` VALUES (5, 21);
INSERT INTO `usuario_notificacion` VALUES (5, 22);
INSERT INTO `usuario_notificacion` VALUES (5, 23);
INSERT INTO `usuario_notificacion` VALUES (5, 24);
INSERT INTO `usuario_notificacion` VALUES (5, 25);
INSERT INTO `usuario_notificacion` VALUES (5, 26);
INSERT INTO `usuario_notificacion` VALUES (5, 27);
INSERT INTO `usuario_notificacion` VALUES (5, 28);
INSERT INTO `usuario_notificacion` VALUES (5, 29);

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios`  (
  `id_usuario` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `contrasena` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `rol_id` bigint UNSIGNED NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`) USING BTREE,
  UNIQUE INDEX `usuarios_email_unique`(`email` ASC) USING BTREE,
  INDEX `usuarios_rol_id_foreign`(`rol_id` ASC) USING BTREE,
  CONSTRAINT `usuarios_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id_rol`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuarios
-- ----------------------------
INSERT INTO `usuarios` VALUES (1, 'Admin', 'Sistema', 'admin@example.com', NULL, '$2y$04$Pi/maFwkmabAlOmtpE7y3.LGhCA9vML2iW847nk2Irte6R4W98LRW', 1, 1, NULL, '2026-06-04 15:35:03', '2026-06-12 16:18:36');
INSERT INTO `usuarios` VALUES (5, 'María José', 'B', 'mariajose.b@example.com', NULL, '$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy', 1, 2, NULL, '2026-06-11 21:00:37', '2026-06-11 21:00:37');
INSERT INTO `usuarios` VALUES (6, 'Araceli', 'B', 'araceli.b@example.com', NULL, '$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy', 1, 3, NULL, '2026-06-11 21:00:37', '2026-06-11 21:00:37');
INSERT INTO `usuarios` VALUES (7, 'Sofía', 'M', 'sofia.m@example.com', NULL, '$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy', 1, 3, NULL, '2026-06-11 21:00:37', '2026-06-11 21:00:37');
INSERT INTO `usuarios` VALUES (8, 'Valentina', 'G', 'valentina.g@example.com', NULL, '$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy', 1, 3, NULL, '2026-06-11 21:00:37', '2026-06-11 21:00:37');
INSERT INTO `usuarios` VALUES (9, 'Cata', 'M', 'cata.m@example.com', NULL, '$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy', 1, 3, NULL, '2026-06-11 21:00:37', '2026-06-11 21:00:37');
INSERT INTO `usuarios` VALUES (10, 'Marisa', 'C', 'marisa.c@example.com', NULL, '$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy', 1, 3, NULL, '2026-06-11 21:00:37', '2026-06-11 21:00:37');
INSERT INTO `usuarios` VALUES (11, 'Estela', 'M', 'estela.m@example.com', NULL, '$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy', 1, 5, NULL, '2026-06-12 12:32:23', '2026-06-12 12:32:27');
INSERT INTO `usuarios` VALUES (12, 'Martina', 'G', 'martina.g@example.com', NULL, '$2y$12$/00yETAvkZXekfdBS.Fr7edmQS8oRX/3mFJzrdpmVXgfT03IMCQIy', 1, 5, NULL, '2026-06-12 12:33:10', '2026-06-12 12:33:14');

-- ----------------------------
-- Table structure for visita_domiciliaria_usuario
-- ----------------------------
DROP TABLE IF EXISTS `visita_domiciliaria_usuario`;
CREATE TABLE `visita_domiciliaria_usuario`  (
  `visita_domiciliaria_id` bigint UNSIGNED NOT NULL,
  `usuario_visitador` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`visita_domiciliaria_id`, `usuario_visitador`) USING BTREE,
  INDEX `visita_domiciliaria_usuario_usuario_visitador_foreign`(`usuario_visitador` ASC) USING BTREE,
  CONSTRAINT `visita_domiciliaria_usuario_usuario_visitador_foreign` FOREIGN KEY (`usuario_visitador`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `visita_domiciliaria_usuario_visita_domiciliaria_id_foreign` FOREIGN KEY (`visita_domiciliaria_id`) REFERENCES `visitas_domiciliarias` (`id_visita_domiciliaria`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visita_domiciliaria_usuario
-- ----------------------------

-- ----------------------------
-- Table structure for visitas_domiciliarias
-- ----------------------------
DROP TABLE IF EXISTS `visitas_domiciliarias`;
CREATE TABLE `visitas_domiciliarias`  (
  `id_visita_domiciliaria` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `familia_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_visita_domiciliaria`) USING BTREE,
  INDEX `visitas_domiciliarias_familia_id_foreign`(`familia_id` ASC) USING BTREE,
  CONSTRAINT `visitas_domiciliarias_familia_id_foreign` FOREIGN KEY (`familia_id`) REFERENCES `familias` (`id_familia`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visitas_domiciliarias
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
