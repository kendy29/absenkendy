-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for absenflut
CREATE DATABASE IF NOT EXISTS `absenflut` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `absenflut`;

-- Dumping structure for table absenflut.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table absenflut.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table absenflut.historyabsen
CREATE TABLE IF NOT EXISTS `historyabsen` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `indentity_id_users` bigint unsigned DEFAULT NULL,
  `opened` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `closed` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table absenflut.historyabsen: ~2 rows (approximately)
REPLACE INTO `historyabsen` (`id`, `indentity_id_users`, `opened`, `closed`, `month`, `year`, `date`, `created_at`, `updated_at`) VALUES
	(10, 21414556, '13:03:14', '13:25:47', 'January', '2024', 'Jumat 19 Januari 2024', '2024-01-19 05:03:16', '2024-01-19 05:25:47');

-- Dumping structure for table absenflut.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table absenflut.migrations: ~0 rows (approximately)
REPLACE INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_100000_create_password_resets_table', 1),
	(2, '2019_08_19_000000_create_failed_jobs_table', 1),
	(3, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(4, '2023_04_02_221620_create_profile_table', 1),
	(5, '2023_04_02_222810_create_historyabsen_table', 1),
	(6, '2023_04_02_223414_create_users_table', 1);

-- Dumping structure for table absenflut.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table absenflut.password_resets: ~0 rows (approximately)

-- Dumping structure for table absenflut.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `expires_at` timestamp NULL DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table absenflut.personal_access_tokens: ~9 rows (approximately)
REPLACE INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `expires_at`, `last_used_at`, `created_at`, `updated_at`) VALUES
	(1, 'App\\Models\\User', 1, 'auth_token', '7597ad8b3e38a99efcb85c501460052890e813d58c5e232472ba512d173371bf', '["*"]', NULL, NULL, '2024-01-16 03:21:13', '2024-01-16 03:21:13'),
	(2, 'App\\Models\\User', 1, 'auth_token', '4757f6b496b136c5c44fbbff1028e4553600352667b0c355634520b53136330c', '["*"]', NULL, '2024-01-16 03:30:05', '2024-01-16 03:26:33', '2024-01-16 03:30:05'),
	(3, 'App\\Models\\User', 2, 'auth_token', 'bb1973619104dc7dfb4359a0be145ab1658b0742986ba31892f4423943a296ef', '["*"]', NULL, '2024-01-16 08:23:20', '2024-01-16 03:30:33', '2024-01-16 08:23:20'),
	(4, 'App\\Models\\User', 1, 'auth_token', '0ec40c7a4a5e7f6b18688d8984fd8b6533262da6a47d49bef45bedb854c5ef64', '["*"]', NULL, '2024-01-17 07:10:16', '2024-01-16 08:23:57', '2024-01-17 07:10:16'),
	(5, 'App\\Models\\User', 2, 'auth_token', '879e51251b655df6ca7dbc47fc892abc560bcba04f4dda43ceb74136ca26dfe1', '["*"]', NULL, '2024-01-19 05:04:24', '2024-01-17 07:11:14', '2024-01-19 05:04:24'),
	(6, 'App\\Models\\User', 1, 'auth_token', 'a19c4fecef91916a1051d5ec66229ae8a94c2537df89498864d2ccbe3cf286bb', '["*"]', NULL, '2024-01-19 05:24:16', '2024-01-19 05:06:17', '2024-01-19 05:24:16'),
	(7, 'App\\Models\\User', 2, 'auth_token', '8ef8f37d728ce01ef3b168bae5855098fc4884583a6b0e109aeece5b60c3f9df', '["*"]', NULL, '2024-07-19 07:31:12', '2024-01-19 05:25:00', '2024-07-19 07:31:12'),
	(8, 'App\\Models\\User', 1, 'auth_token', '2975998434272f2d4a27cc00c9a4ec06b367e56c94809ca85e4529164c35c67b', '["*"]', NULL, '2024-07-19 07:36:18', '2024-07-19 07:34:35', '2024-07-19 07:36:18'),
	(9, 'App\\Models\\User', 3, 'auth_token', '3411f75e5cd9362e364f22c47023faba779f6e7ed69de79e27113162ead74363', '["*"]', NULL, '2024-07-19 07:38:02', '2024-07-19 07:36:34', '2024-07-19 07:38:02'),
	(10, 'App\\Models\\User', 1, 'auth_token', '7364dcab04102d9c440c43716d2c78b7a1f9e16192bee2c42cd4f3f1b219b70e', '["*"]', NULL, '2024-08-14 03:38:47', '2024-08-14 03:36:31', '2024-08-14 03:38:47');

-- Dumping structure for table absenflut.profile
CREATE TABLE IF NOT EXISTS `profile` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `indentity_id_users` bigint unsigned DEFAULT NULL,
  `agency_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `log_type` enum('0','1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `open` int NOT NULL DEFAULT '0',
  `permit` int NOT NULL DEFAULT '0',
  `leave` int NOT NULL DEFAULT '0',
  `grade` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_not_absen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_indentity_id_users_unique` (`indentity_id_users`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table absenflut.profile: ~2 rows (approximately)
REPLACE INTO `profile` (`id`, `indentity_id_users`, `agency_name`, `month`, `year`, `image`, `log_type`, `open`, `permit`, `leave`, `grade`, `date_not_absen`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES
	(1, 1000, NULL, 'August', '2025', NULL, '0', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '2024-07-19 07:34:55'),
	(4, 1111, 'hasmicro', 'August', '2024', NULL, '0', 0, 0, 0, 'junior', NULL, NULL, NULL, '2024-08-14 03:38:40', '2024-08-14 03:38:40');

-- Dumping structure for table absenflut.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `indentity_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `face_id` json DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_indentity_id_unique` (`indentity_id`),
  UNIQUE KEY `users_email_unique` (`email`),
  CONSTRAINT `users_indentity_id_foreign` FOREIGN KEY (`indentity_id`) REFERENCES `profile` (`indentity_id_users`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table absenflut.users: ~2 rows (approximately)
REPLACE INTO `users` (`id`, `indentity_id`, `name`, `face_id`, `email`, `email_verified_at`, `password`, `is_admin`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 1000, 'admin', NULL, 'admin@gmail.com', NULL, '$2y$10$.tALdGcavrQdGu9swwSWQO2OUm.Dl5DjF7kDJ6k1FvfknOaepDWKq', '1', NULL, NULL, NULL),
	(4, 1111, 'ken', NULL, 'ken@gmail.com', NULL, '$2y$10$5K78D13l4RX6ouqlkwQBz.pFnEmKmJjW9GIgUWyf5l623Jzo.Erru', '0', NULL, '2024-08-14 03:38:40', '2024-08-14 03:38:40');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
