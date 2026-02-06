-- MySQL dump 10.13  Distrib 8.4.8, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nexopos
-- ------------------------------------------------------
-- Server version	8.4.8

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
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
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
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
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
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2018_08_08_100000_create_telescope_entries_table',1,NULL),(2,'2019_12_14_000001_create_personal_access_tokens_table',1,NULL),(4,'2014_10_13_000000_create_users_table',0,'core'),(5,'2017_07_28_130434_create_roles_table',0,'core'),(6,'2017_07_28_130610_create_permissions_table',0,'core'),(7,'2018_08_08_100000_create_telescope_entries_table',0,'core'),(8,'2019_08_19_000000_create_failed_jobs_table',0,'core'),(9,'2020_06_20_000000_create_permissions',0,'core'),(10,'2020_06_20_000000_create_roles',0,'core'),(11,'2020_10_11_122857_create_jobs_table',0,'core'),(12,'2020_11_04_124040_add_new_customers_permission_nov4',0,'core'),(13,'2020_11_11_151614_nov11_create_nexopos_users_attributes_table',0,'core'),(14,'2020_11_12_205243_nov12_create_order_permission',0,'core'),(15,'2020_11_25_203531_nov25_fix_report_permissions_attribution',0,'core'),(16,'2020_12_08_210001_dec8add_new_permissions',0,'core'),(17,'2020_12_19_221434_create_nexopos_modules_migrations_table',0,'core'),(18,'2021_01_07_143635_add_new_customer_permission_janv7_21',0,'core'),(19,'2021_03_09_165538_create_new_permissions_march_9',0,'core'),(20,'2021_05_25_175424_update_add_payment_type_permissions',0,'core'),(21,'2021_05_28_114827_create_new_report_permissions_may28',0,'core'),(22,'2021_06_24_053134_update_permissions_jun24',0,'core'),(23,'2021_07_31_153029_update_dashboard_days_report_jul31',0,'core'),(24,'2014_10_12_000000_create_medias_table',0,'create'),(25,'2017_12_29_174613_create_options_table',0,'create'),(26,'2020_06_20_000000_create_customers_groups_table',0,'create'),(27,'2020_06_20_000000_create_customers_table',0,'create'),(28,'2020_06_20_000000_create_expenses_categories_table',0,'create'),(29,'2020_06_20_000000_create_expenses_table',0,'create'),(30,'2020_06_20_000000_create_orders_addresses_table',0,'create'),(31,'2020_06_20_000000_create_orders_coupons_table',0,'create'),(32,'2020_06_20_000000_create_orders_metas_table',0,'create'),(33,'2020_06_20_000000_create_orders_payment_table',0,'create'),(34,'2020_06_20_000000_create_orders_products_table',0,'create'),(35,'2020_06_20_000000_create_orders_table',0,'create'),(36,'2020_06_20_000000_create_procurements_products_table',0,'create'),(37,'2020_06_20_000000_create_procurements_table',0,'create'),(38,'2020_06_20_000000_create_products_categories_table',0,'create'),(39,'2020_06_20_000000_create_products_gallery_table',0,'create'),(40,'2020_06_20_000000_create_products_history_table',0,'create'),(41,'2020_06_20_000000_create_products_metas_table',0,'create'),(42,'2020_06_20_000000_create_products_table',0,'create'),(43,'2020_06_20_000000_create_products_taxes_table',0,'create'),(44,'2020_06_20_000000_create_products_unit_quantities',0,'create'),(45,'2020_06_20_000000_create_providers_table',0,'create'),(46,'2020_06_20_000000_create_registers_history_table',0,'create'),(47,'2020_06_20_000000_create_registers_table',0,'create'),(48,'2020_06_20_000000_create_rewards_system_rules_table',0,'create'),(49,'2020_06_20_000000_create_rewards_system_table',0,'create'),(50,'2020_06_20_000000_create_taxes_table',0,'create'),(51,'2020_06_20_000000_create_units_group_table',0,'create'),(52,'2020_06_20_000000_create_units_table',0,'create'),(53,'2020_08_01_143801_create_customers_coupons_table',0,'create'),(54,'2020_10_10_224639_create_dashboard_table',0,'create'),(55,'2020_10_11_074631_create_nexopos_notifications_table',0,'create'),(56,'2020_10_17_231628_create_nexopos_orders_storage',0,'create'),(57,'2020_10_29_150642_create_nexopos_expenses_history_table',0,'create'),(58,'2020_11_17_120204_nov17_add_fields_to_nexopos_orders_products_table',0,'create'),(59,'2020_12_11_210734_create_nexopos_dashboard_months_table',0,'create'),(60,'2021_01_23_225101_create_coupons_table',0,'create'),(61,'2021_01_23_225713_create_customers_rewards_table',0,'create'),(62,'2021_02_21_144532_create_orders_instalments_table',0,'create'),(63,'2021_02_23_004748_create_new_instalments_permissions',0,'create'),(64,'2021_05_25_131104_create_nexopos_payments_types_table',0,'create'),(65,'2022_01_20_202253_create_user_role_relations_table',0,'create'),(66,'2022_05_13_142039_create_products_group_items_table',0,'create'),(67,'2022_10_12_083552_update_register_history_oct12_22',0,'create'),(68,'2022_10_28_093041_update_expense_table28_oct22',0,'create'),(69,'2022_11_25_071626_create_users_widgets_table',0,'create'),(70,'2023_10_31_120602_stock_history_detailed',0,'create'),(71,'2024_04_29_214452_create_transaction_balance_days_table',0,'create'),(72,'2024_04_29_214459_create_transaction_balance_months_table',0,'create'),(73,'2024_09_02_023528_create_accounting_table_actions',0,'create'),(74,'2025_01_22_113445_create_nexopos_orders_settings_table',0,'create'),(75,'2025_01_25_000000_create_payment_code_transactions_table',0,'create'),(76,'2025_07_19_232411_create_pending_aproval_table',0,'create'),(77,'2026_01_16_000002_create_scale_ranges_table',0,'create'),(78,'2025_03_08_132216_update_to_v6x',0,'update'),(79,'2026_01_16_000001_add_scale_plu_to_product_unit_quantities',0,'update'),(80,'2026_01_16_000003_add_scale_range_to_categories',0,'update'),(81,'2026_02_04_000001_add_linked_product_to_products_unit_quantities',0,'update'),(82,'2022_10_28_123458_setup_migration_table',2,NULL);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_coupons`
--

DROP TABLE IF EXISTS `nexopos_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_coupons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'discount',
  `discount_value` float NOT NULL DEFAULT '0',
  `valid_until` datetime DEFAULT NULL,
  `minimum_cart_value` float DEFAULT '0',
  `maximum_cart_value` float DEFAULT '0',
  `valid_hours_start` datetime DEFAULT NULL,
  `valid_hours_end` datetime DEFAULT NULL,
  `limit_usage` float NOT NULL DEFAULT '0',
  `groups_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customers_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_coupons`
--

LOCK TABLES `nexopos_coupons` WRITE;
/*!40000 ALTER TABLE `nexopos_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_coupons_categories`
--

DROP TABLE IF EXISTS `nexopos_coupons_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_coupons_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_coupons_categories`
--

LOCK TABLES `nexopos_coupons_categories` WRITE;
/*!40000 ALTER TABLE `nexopos_coupons_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_coupons_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_coupons_customers`
--

DROP TABLE IF EXISTS `nexopos_coupons_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_coupons_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` int NOT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_coupons_customers`
--

LOCK TABLES `nexopos_coupons_customers` WRITE;
/*!40000 ALTER TABLE `nexopos_coupons_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_coupons_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_coupons_customers_groups`
--

DROP TABLE IF EXISTS `nexopos_coupons_customers_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_coupons_customers_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_coupons_customers_groups`
--

LOCK TABLES `nexopos_coupons_customers_groups` WRITE;
/*!40000 ALTER TABLE `nexopos_coupons_customers_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_coupons_customers_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_coupons_products`
--

DROP TABLE IF EXISTS `nexopos_coupons_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_coupons_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_coupons_products`
--

LOCK TABLES `nexopos_coupons_products` WRITE;
/*!40000 ALTER TABLE `nexopos_coupons_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_coupons_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_customers_account_history`
--

DROP TABLE IF EXISTS `nexopos_customers_account_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_customers_account_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `previous_amount` double NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `next_amount` double NOT NULL DEFAULT '0',
  `operation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_customers_account_history`
--

LOCK TABLES `nexopos_customers_account_history` WRITE;
/*!40000 ALTER TABLE `nexopos_customers_account_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_customers_account_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_customers_addresses`
--

DROP TABLE IF EXISTS `nexopos_customers_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_customers_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pobox` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_customers_addresses`
--

LOCK TABLES `nexopos_customers_addresses` WRITE;
/*!40000 ALTER TABLE `nexopos_customers_addresses` DISABLE KEYS */;
INSERT INTO `nexopos_customers_addresses` VALUES (1,68,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,68,'2026-01-26 12:06:04','2026-01-26 12:06:04'),(2,68,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,68,'2026-01-26 12:06:04','2026-01-26 12:06:04'),(3,69,'shipping',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,68,'2026-01-26 12:09:35','2026-01-26 12:09:35'),(4,69,'billing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,68,'2026-01-26 12:09:35','2026-01-26 12:09:35');
/*!40000 ALTER TABLE `nexopos_customers_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_customers_coupons`
--

DROP TABLE IF EXISTS `nexopos_customers_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_customers_coupons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usage` int NOT NULL DEFAULT '0',
  `limit_usage` int NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `author` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_customers_coupons`
--

LOCK TABLES `nexopos_customers_coupons` WRITE;
/*!40000 ALTER TABLE `nexopos_customers_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_customers_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_customers_groups`
--

DROP TABLE IF EXISTS `nexopos_customers_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_customers_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `reward_system_id` int DEFAULT '0',
  `minimal_credit_payment` int NOT NULL DEFAULT '0',
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_customers_groups`
--

LOCK TABLES `nexopos_customers_groups` WRITE;
/*!40000 ALTER TABLE `nexopos_customers_groups` DISABLE KEYS */;
INSERT INTO `nexopos_customers_groups` VALUES (1,'消费者',NULL,NULL,0,68,NULL,'2026-01-26 12:09:23','2026-01-26 12:09:23');
/*!40000 ALTER TABLE `nexopos_customers_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_customers_rewards`
--

DROP TABLE IF EXISTS `nexopos_customers_rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_customers_rewards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `reward_id` int NOT NULL,
  `reward_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `points` float NOT NULL,
  `target` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_customers_rewards`
--

LOCK TABLES `nexopos_customers_rewards` WRITE;
/*!40000 ALTER TABLE `nexopos_customers_rewards` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_customers_rewards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_dashboard_days`
--

DROP TABLE IF EXISTS `nexopos_dashboard_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_dashboard_days` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `total_unpaid_orders` float NOT NULL DEFAULT '0',
  `day_unpaid_orders` float NOT NULL DEFAULT '0',
  `total_unpaid_orders_count` float NOT NULL DEFAULT '0',
  `day_unpaid_orders_count` float NOT NULL DEFAULT '0',
  `total_paid_orders` float NOT NULL DEFAULT '0',
  `day_paid_orders` float NOT NULL DEFAULT '0',
  `total_paid_orders_count` float NOT NULL DEFAULT '0',
  `day_paid_orders_count` float NOT NULL DEFAULT '0',
  `total_partially_paid_orders` float NOT NULL DEFAULT '0',
  `day_partially_paid_orders` float NOT NULL DEFAULT '0',
  `total_partially_paid_orders_count` float NOT NULL DEFAULT '0',
  `day_partially_paid_orders_count` float NOT NULL DEFAULT '0',
  `total_income` float NOT NULL DEFAULT '0',
  `day_income` float NOT NULL DEFAULT '0',
  `total_discounts` float NOT NULL DEFAULT '0',
  `day_discounts` float NOT NULL DEFAULT '0',
  `day_taxes` float NOT NULL DEFAULT '0',
  `total_taxes` float NOT NULL DEFAULT '0',
  `total_wasted_goods_count` float NOT NULL DEFAULT '0',
  `day_wasted_goods_count` float NOT NULL DEFAULT '0',
  `total_wasted_goods` float NOT NULL DEFAULT '0',
  `day_wasted_goods` float NOT NULL DEFAULT '0',
  `total_expenses` float NOT NULL DEFAULT '0',
  `day_expenses` float NOT NULL DEFAULT '0',
  `day_of_year` int NOT NULL DEFAULT '0',
  `range_starts` datetime DEFAULT NULL,
  `range_ends` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_dashboard_days`
--

LOCK TABLES `nexopos_dashboard_days` WRITE;
/*!40000 ALTER TABLE `nexopos_dashboard_days` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_dashboard_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_dashboard_months`
--

DROP TABLE IF EXISTS `nexopos_dashboard_months`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_dashboard_months` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `month_taxes` float NOT NULL DEFAULT '0',
  `month_unpaid_orders` float NOT NULL DEFAULT '0',
  `month_unpaid_orders_count` float NOT NULL DEFAULT '0',
  `month_paid_orders` float NOT NULL DEFAULT '0',
  `month_paid_orders_count` float NOT NULL DEFAULT '0',
  `month_partially_paid_orders` float NOT NULL DEFAULT '0',
  `month_partially_paid_orders_count` float NOT NULL DEFAULT '0',
  `month_income` float NOT NULL DEFAULT '0',
  `month_discounts` float NOT NULL DEFAULT '0',
  `month_wasted_goods_count` float NOT NULL DEFAULT '0',
  `month_wasted_goods` float NOT NULL DEFAULT '0',
  `month_expenses` float NOT NULL DEFAULT '0',
  `total_wasted_goods` float NOT NULL DEFAULT '0',
  `total_unpaid_orders` float NOT NULL DEFAULT '0',
  `total_unpaid_orders_count` float NOT NULL DEFAULT '0',
  `total_paid_orders` float NOT NULL DEFAULT '0',
  `total_paid_orders_count` float NOT NULL DEFAULT '0',
  `total_partially_paid_orders` float NOT NULL DEFAULT '0',
  `total_partially_paid_orders_count` float NOT NULL DEFAULT '0',
  `total_income` float NOT NULL DEFAULT '0',
  `total_discounts` float NOT NULL DEFAULT '0',
  `total_taxes` float NOT NULL DEFAULT '0',
  `total_wasted_goods_count` float NOT NULL DEFAULT '0',
  `total_expenses` float NOT NULL DEFAULT '0',
  `month_of_year` int NOT NULL DEFAULT '0',
  `range_starts` datetime NOT NULL,
  `range_ends` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_dashboard_months`
--

LOCK TABLES `nexopos_dashboard_months` WRITE;
/*!40000 ALTER TABLE `nexopos_dashboard_months` DISABLE KEYS */;
INSERT INTO `nexopos_dashboard_months` VALUES (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,'2026-01-01 00:00:00','2026-01-31 23:59:59',NULL,NULL),(2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,'2026-02-01 00:00:00','2026-02-28 23:59:59',NULL,NULL),(3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,'2026-03-01 00:00:00','2026-03-31 23:59:59',NULL,NULL),(4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,'2026-04-01 00:00:00','2026-04-30 23:59:59',NULL,NULL),(5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,'2026-05-01 00:00:00','2026-05-31 23:59:59',NULL,NULL),(6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,'2026-06-01 00:00:00','2026-06-30 23:59:59',NULL,NULL),(7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,'2026-07-01 00:00:00','2026-07-31 23:59:59',NULL,NULL),(8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,'2026-08-01 00:00:00','2026-08-31 23:59:59',NULL,NULL),(9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,'2026-09-01 00:00:00','2026-09-30 23:59:59',NULL,NULL),(10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,'2026-10-01 00:00:00','2026-10-31 23:59:59',NULL,NULL),(11,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,'2026-11-01 00:00:00','2026-11-30 23:59:59',NULL,NULL),(12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,'2026-12-01 00:00:00','2026-12-31 23:59:59',NULL,NULL);
/*!40000 ALTER TABLE `nexopos_dashboard_months` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_dashboard_weeks`
--

DROP TABLE IF EXISTS `nexopos_dashboard_weeks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_dashboard_weeks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `total_gross_income` float NOT NULL DEFAULT '0',
  `total_taxes` float NOT NULL DEFAULT '0',
  `total_expenses` float NOT NULL DEFAULT '0',
  `total_net_income` float NOT NULL DEFAULT '0',
  `week_number` int NOT NULL DEFAULT '0',
  `range_starts` datetime DEFAULT NULL,
  `range_ends` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_dashboard_weeks`
--

LOCK TABLES `nexopos_dashboard_weeks` WRITE;
/*!40000 ALTER TABLE `nexopos_dashboard_weeks` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_dashboard_weeks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_medias`
--

DROP TABLE IF EXISTS `nexopos_medias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_medias` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nexopos_medias_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_medias`
--

LOCK TABLES `nexopos_medias` WRITE;
/*!40000 ALTER TABLE `nexopos_medias` DISABLE KEYS */;
INSERT INTO `nexopos_medias` VALUES (1,'','jpg','2026/01/',68,'2026-01-26 12:05:17','2026-01-26 12:05:17'),(2,'617444','png','2026/01/617444',68,'2026-01-26 12:05:19','2026-01-26 12:05:19'),(3,'508077','jpg','2026/01/508077',68,'2026-01-26 12:05:25','2026-01-26 12:05:25'),(4,'2l','jpg','2026/01/2l',68,'2026-01-26 12:05:29','2026-01-26 12:05:29'),(5,'2l123851','jpg','2026/01/2l123851',68,'2026-01-26 12:05:31','2026-01-26 12:05:31'),(6,'125l','jpg','2026/01/125l',68,'2026-01-26 12:05:33','2026-01-26 12:05:33'),(7,'741313','jpg','2026/01/741313',68,'2026-01-26 12:05:37','2026-01-26 12:05:37'),(8,'330ml','jpg','2026/01/330ml',68,'2026-01-26 12:05:43','2026-01-26 12:05:43'),(9,'125l771071','jpg','2026/01/125l771071',68,'2026-01-26 12:05:43','2026-01-26 12:05:43');
/*!40000 ALTER TABLE `nexopos_medias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_modules_migrations`
--

DROP TABLE IF EXISTS `nexopos_modules_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_modules_migrations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `namespace` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_modules_migrations`
--

LOCK TABLES `nexopos_modules_migrations` WRITE;
/*!40000 ALTER TABLE `nexopos_modules_migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_modules_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_notifications`
--

DROP TABLE IF EXISTS `nexopos_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#',
  `source` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system',
  `dismissable` tinyint(1) NOT NULL DEFAULT '1',
  `actions` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_notifications`
--

LOCK TABLES `nexopos_notifications` WRITE;
/*!40000 ALTER TABLE `nexopos_notifications` DISABLE KEYS */;
INSERT INTO `nexopos_notifications` VALUES (1,68,'ns.notifications.workers-disabled','任务调度已禁用','NexoPOS无法安排后台任务。这可能会限制必要的功能。单击此处了解如何修复它。','https://my.nexopos.com/en/documentation/troubleshooting/workers-or-async-requests-disabled?utm_source=nexopos&utm_campaign=warning&utm_medium=app','system',1,'[]','2026-01-26 11:57:50','2026-02-04 12:36:37'),(2,68,'ns.notifications.cron-disabled','Cron已禁用','NexoPOS上的Cron作业配置不正确。这可能会限制必要的功能。单击此处了解如何修复它。','https://my.nexopos.com/en/documentation/troubleshooting/workers-or-async-requests-disabled?utm_source=nexopos&utm_campaign=warning&utm_medium=app','system',1,'[]','2026-01-26 11:57:51','2026-02-04 12:36:37'),(3,68,'symlink-et2vqj8','Et2Vqj8: Symbolic Link Broken','The symbolic link for the module Et2Vqj8 is broken. The module assets might not load correctly.','https://my.nexopos.com/en/documentation/troubleshooting/broken-media-images?utm_source=nexopos&utm_campaign=warning&utm_medium=app','system',1,'[{\"url\": \"http://127.0.0.1:8000/api/modules/symlink?namespace=et2vqj8\", \"data\": {\"module\": {\"name\": \"Et2Vqj8\", \"path\": \"D:\\\\develop\\\\PHP_project\\\\NexoPOS-master\\\\modules\\\\Et2Vqj8\\\\\", \"files\": [\"Et2Vqj8Module.php\", \"config.xml\"], \"author\": \"NexoPOS\", \"actions\": [], \"enabled\": false, \"filters\": [], \"version\": \"1.0\", \"api-file\": false, \"commands\": [], \"requires\": [], \"namespace\": \"Et2Vqj8\", \"providers\": [], \"autoloaded\": false, \"index-file\": \"D:\\\\develop\\\\PHP_project\\\\NexoPOS-master\\\\modules\\\\Et2Vqj8\\\\Et2Vqj8Module.php\", \"migrations\": [\"Et2Vqj8/Migrations/DatabaseMigration.php\"], \"views-path\": \"D:\\\\develop\\\\PHP_project\\\\NexoPOS-master\\\\modules\\\\Et2Vqj8\\\\Resources\\\\Views\", \"description\": {\"en\": \"Changed description\"}, \"domain-file\": false, \"entry-class\": \"Modules\\\\Et2Vqj8\\\\Et2Vqj8Module\", \"routes-file\": false, \"config-files\": [], \"console-file\": false, \"relativePath\": \"modules\\\\Et2Vqj8\\\\\", \"has-languages\": false, \"all-migrations\": [\"Et2Vqj8/Migrations/DatabaseMigration.php\"], \"controllers-path\": \"D:\\\\develop\\\\PHP_project\\\\NexoPOS-master\\\\modules\\\\Et2Vqj8\\\\Http\\\\Controllers\", \"psr-4-compliance\": true, \"lang-relativePath\": \"modules\\\\Et2Vqj8\\\\Lang\", \"requires-composer\": false, \"composer-installed\": false, \"views-relativePath\": \"modules\\\\Et2Vqj8\\\\Views\", \"controllers-relativePath\": \"Et2Vqj8\\\\Http\\\\Controllers\"}}, \"label\": \"Fix Symbolic Link\"}]','2026-01-26 11:57:51','2026-01-26 11:57:51'),(4,68,'symlink-oditautasdkn','Odit autaSDkN: Symbolic Link Broken','The symbolic link for the module Odit autaSDkN is broken. The module assets might not load correctly.','https://my.nexopos.com/en/documentation/troubleshooting/broken-media-images?utm_source=nexopos&utm_campaign=warning&utm_medium=app','system',1,'[{\"url\": \"http://127.0.0.1:8000/api/modules/symlink?namespace=oditautasdkn\", \"data\": {\"module\": {\"name\": \"Odit autaSDkN\", \"path\": \"D:\\\\develop\\\\PHP_project\\\\NexoPOS-master\\\\modules\\\\OditAutaSDkN\\\\\", \"files\": [\"OditAutaSDkNModule.php\", \"config.xml\"], \"author\": \"NexoPOS\", \"actions\": [], \"enabled\": false, \"filters\": [], \"version\": \"1.0\", \"api-file\": false, \"commands\": [], \"requires\": [], \"namespace\": \"OditAutaSDkN\", \"providers\": [], \"autoloaded\": false, \"index-file\": \"D:\\\\develop\\\\PHP_project\\\\NexoPOS-master\\\\modules\\\\OditAutaSDkN\\\\OditAutaSDkNModule.php\", \"migrations\": [\"OditAutaSDkN/Migrations/DatabaseMigration.php\"], \"views-path\": \"D:\\\\develop\\\\PHP_project\\\\NexoPOS-master\\\\modules\\\\OditAutaSDkN\\\\Resources\\\\Views\", \"description\": {\"en\": \"Changed description\"}, \"domain-file\": false, \"entry-class\": \"Modules\\\\OditAutaSDkN\\\\OditAutaSDkNModule\", \"routes-file\": false, \"config-files\": [], \"console-file\": false, \"relativePath\": \"modules\\\\OditAutaSDkN\\\\\", \"has-languages\": false, \"all-migrations\": [\"OditAutaSDkN/Migrations/DatabaseMigration.php\"], \"controllers-path\": \"D:\\\\develop\\\\PHP_project\\\\NexoPOS-master\\\\modules\\\\OditAutaSDkN\\\\Http\\\\Controllers\", \"psr-4-compliance\": true, \"lang-relativePath\": \"modules\\\\OditAutaSDkN\\\\Lang\", \"requires-composer\": false, \"composer-installed\": false, \"views-relativePath\": \"modules\\\\OditAutaSDkN\\\\Views\", \"controllers-relativePath\": \"OditAutaSDkN\\\\Http\\\\Controllers\"}}, \"label\": \"Fix Symbolic Link\"}]','2026-01-26 11:57:51','2026-01-26 11:57:51');
/*!40000 ALTER TABLE `nexopos_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_options`
--

DROP TABLE IF EXISTS `nexopos_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_options` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `expire_on` datetime DEFAULT NULL,
  `array` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_options`
--

LOCK TABLES `nexopos_options` WRITE;
/*!40000 ALTER TABLE `nexopos_options` DISABLE KEYS */;
INSERT INTO `nexopos_options` VALUES (1,NULL,'ns_scale_barcode_product_length','4',NULL,0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(2,NULL,'ns_store_name','超世纪综合超市',NULL,0,'2026-01-22 21:02:40','2026-01-26 12:48:46'),(3,NULL,'ns_pos_allow_decimal_quantities','yes',NULL,0,'2026-01-22 21:02:40','2026-01-22 21:02:40'),(4,NULL,'ns_pos_quick_product','yes',NULL,0,'2026-01-22 21:02:40','2026-01-22 21:02:40'),(5,NULL,'ns_pos_show_quantity','no',NULL,0,'2026-01-22 21:02:40','2026-01-24 14:50:34'),(6,NULL,'ns_currency_precision','1',NULL,0,'2026-01-22 21:02:40','2026-01-26 12:49:40'),(7,NULL,'ns_pos_hide_empty_categories','no',NULL,0,'2026-01-22 21:02:41','2026-01-24 14:09:11'),(8,NULL,'ns_pos_unit_price_ediable','yes',NULL,0,'2026-01-22 21:02:41','2026-01-22 21:02:41'),(9,NULL,'ns_pos_order_types','[\"takeaway\"]',NULL,1,'2026-01-22 21:02:41','2026-01-25 14:17:06'),(10,NULL,'ns_pos_registers_default_change_payment_type','1',NULL,0,'2026-01-22 21:02:41','2026-01-22 21:02:41'),(11,NULL,'ns_store_language','zh-CN',NULL,0,'2026-01-22 21:02:41','2026-01-22 21:02:41'),(12,NULL,'ns_store_phone','13892184446',NULL,0,'2026-01-23 23:18:04','2026-01-23 23:18:04'),(13,NULL,'ns_default_theme','dark',NULL,0,'2026-01-23 23:18:05','2026-01-24 10:06:53'),(14,NULL,'ns_currency_symbol','$',NULL,0,'2026-01-23 23:18:05','2026-01-24 09:22:31'),(15,NULL,'ns_currency_iso','CNY  *',NULL,0,'2026-01-23 23:18:05','2026-02-04 03:51:14'),(16,NULL,'ns_currency_position','before',NULL,0,'2026-01-23 23:18:05','2026-01-23 23:18:05'),(17,NULL,'ns_currency_prefered','iso',NULL,0,'2026-01-23 23:18:05','2026-01-23 23:18:05'),(18,NULL,'ns_date_format','Y/m/d',NULL,0,'2026-01-23 23:18:05','2026-01-23 23:18:05'),(19,NULL,'ns_datetime_format','Y/m/d H:i',NULL,0,'2026-01-23 23:18:05','2026-01-23 23:18:05'),(20,NULL,'ns_datetime_timezone','Asia/Shanghai',NULL,0,'2026-01-23 23:18:05','2026-01-23 23:18:05'),(21,NULL,'ns_registration_role','2',NULL,0,'2026-01-23 23:18:06','2026-01-23 23:18:06'),(22,NULL,'ns_pos_layout','grocery_shop',NULL,0,'2026-01-24 07:19:01','2026-01-24 07:19:01'),(23,NULL,'ns_pos_complete_sale_audio','http://127.0.0.1:8000/audio/ding.mp3',NULL,0,'2026-01-24 07:19:02','2026-01-24 07:19:02'),(24,NULL,'ns_pos_new_item_audio','http://127.0.0.1:8000/audio/bubble.mp3',NULL,0,'2026-01-24 07:19:02','2026-01-24 07:19:02'),(25,NULL,'ns_pos_keyboard_cancel_order','[]',NULL,1,'2026-01-24 07:19:02','2026-01-24 07:19:02'),(26,NULL,'ns_pos_keyboard_hold_order','[]',NULL,1,'2026-01-24 07:19:02','2026-01-24 07:19:02'),(27,NULL,'ns_pos_keyboard_create_customer','[]',NULL,1,'2026-01-24 07:19:03','2026-01-24 07:19:03'),(28,NULL,'ns_pos_keyboard_payment','[]',NULL,1,'2026-01-24 07:19:03','2026-01-24 07:19:03'),(29,NULL,'ns_pos_keyboard_shipping','[]',NULL,1,'2026-01-24 07:19:03','2026-01-24 07:19:03'),(30,NULL,'ns_pos_keyboard_note','[]',NULL,1,'2026-01-24 07:19:03','2026-01-24 07:19:03'),(31,NULL,'ns_pos_keyboard_order_type','[]',NULL,1,'2026-01-24 07:19:03','2026-01-24 07:19:03'),(32,NULL,'ns_pos_keyboard_fullscreen','[]',NULL,1,'2026-01-24 07:19:03','2026-01-24 07:19:03'),(33,NULL,'ns_pos_keyboard_quick_search','[]',NULL,1,'2026-01-24 07:19:03','2026-01-24 07:19:03'),(34,NULL,'ns_pos_keyboard_toggle_merge','[]',NULL,1,'2026-01-24 07:19:03','2026-01-24 07:19:03'),(35,NULL,'ns_scale_barcode_enabled','no',NULL,0,'2026-01-24 07:19:04','2026-01-24 07:19:04'),(37,NULL,'ns_accounting_default_paid_expense_offset_account','1',NULL,0,'2026-01-24 09:22:30','2026-01-24 09:22:30'),(38,NULL,'ns_pos_items_merge','yes',NULL,0,'2026-01-25 08:29:00','2026-01-25 08:29:00'),(39,NULL,'ns_pos_price_with_tax','no',NULL,0,'2026-01-25 08:29:00','2026-01-25 08:29:00'),(40,NULL,'ns_pos_force_autofocus','yes',NULL,0,'2026-01-25 08:29:00','2026-01-25 08:29:00'),(41,NULL,'ns_customers_rewards_enabled','no',NULL,0,'2026-01-25 09:10:00','2026-01-25 09:10:00'),(42,NULL,'ns_customers_force_valid_email','no',NULL,0,'2026-01-25 09:10:00','2026-01-25 09:10:00'),(43,NULL,'ns_customers_force_unique_phone','no',NULL,0,'2026-01-25 09:10:01','2026-01-25 09:10:01'),(44,NULL,'ns_customers_default','69',NULL,0,'2026-01-25 09:10:01','2026-01-25 09:10:01'),(45,NULL,'ns_customers_default_group','1',NULL,0,'2026-01-25 09:10:01','2026-01-25 09:10:01'),(46,NULL,'ns_customers_credit_enabled','no',NULL,0,'2026-01-25 09:10:01','2026-01-25 09:10:01'),(47,NULL,'ns_orders_code_type','date_sequential',NULL,0,'2026-01-25 09:45:18','2026-01-25 09:45:18'),(48,NULL,'ns_orders_allow_unpaid','no',NULL,0,'2026-01-25 09:45:18','2026-01-25 09:45:18'),(49,NULL,'ns_orders_allow_partial','yes',NULL,0,'2026-01-25 09:45:18','2026-01-25 09:45:18'),(50,NULL,'ns_orders_strict_instalments','no',NULL,0,'2026-01-25 09:45:18','2026-01-25 09:45:18'),(51,NULL,'ns_reports_email','no',NULL,0,'2026-01-25 09:45:58','2026-01-25 09:45:58'),(52,NULL,'ns_invoice_receipt_template','default',NULL,0,'2026-01-25 09:46:32','2026-01-25 09:46:32'),(53,NULL,'ns_invoice_merge_similar_products','yes',NULL,0,'2026-01-25 09:46:32','2026-01-25 09:46:32'),(54,NULL,'ns_invoice_display_tax_breakdown','no',NULL,0,'2026-01-25 09:46:33','2026-01-25 09:46:33'),(55,NULL,'ns_payment_alipay_enabled','no',NULL,0,'2026-01-25 14:17:06','2026-01-25 14:17:06'),(56,NULL,'ns_payment_alipay_gateway','https://openapi.alipay.com/gateway.do',NULL,0,'2026-01-25 14:17:06','2026-01-25 14:17:06'),(57,NULL,'ns_payment_wechat_enabled','no',NULL,0,'2026-01-25 14:17:06','2026-01-25 14:17:06'),(58,NULL,'ns_pos_numpad','advanced',NULL,0,'2026-01-25 14:19:28','2026-01-25 14:19:28'),(59,NULL,'ns_store_rectangle_logo','http://127.0.0.1:8000/storage/2026/01/175246.png',NULL,0,'2026-01-25 14:30:20','2026-01-25 14:30:20'),(60,NULL,'ns_payment_wechat_mch_id','1105080749',NULL,0,'2026-01-25 15:33:41','2026-01-25 15:33:41'),(61,NULL,'ns_payment_wechat_api_key','eyJpdiI6Ik5KTDEvblUwRkxXM2JjZytpMWRxL0E9PSIsInZhbHVlIjoieVdRcmNGTFpCcnZCTi9wSDJnREJRVkw5eXorOFpNRTFMbGE4WDFFZ1Zpa0JjaWJhS0JHZk9rK1VrSDAvd1dZYyIsIm1hYyI6IjAyMDNiYzZjZGUxZGVjMWJiYTYxYzUyYTNiZjk4MzRlMGJiMzRhYWZhMWFiYzliNzI0NTE4Zjc5YTcyOTc2NWQiLCJ0YWciOiIifQ==',NULL,0,'2026-01-25 15:33:41','2026-01-26 12:50:45'),(62,NULL,'ns_payment_wechat_app_id','wxc7c5e33846951413',NULL,0,'2026-01-25 17:03:31','2026-01-25 17:03:31'),(63,NULL,'ns_pos_hide_exhausted_products','no',NULL,0,'2026-01-26 11:59:21','2026-01-26 11:59:21'),(64,NULL,'ns_invoice_receipt_logo','http://127.0.0.1:8000/storage/2026/01/.jpg',NULL,0,'2026-01-26 12:40:12','2026-01-26 12:40:12'),(65,NULL,'ns_store_city','富县',NULL,0,'2026-01-26 12:48:46','2026-01-26 12:48:46'),(67,NULL,'ns_pos_quick_product_default_unit','1',NULL,0,'2026-01-26 12:50:32','2026-01-26 12:50:32'),(68,NULL,'ns_orders_default_type','takeaway',NULL,0,'2026-01-26 12:51:16','2026-01-26 12:51:16');
/*!40000 ALTER TABLE `nexopos_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders`
--

DROP TABLE IF EXISTS `nexopos_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8mb4_unicode_ci,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `process_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `delivery_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `discount` float NOT NULL DEFAULT '0',
  `discount_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `support_instalments` tinyint(1) NOT NULL DEFAULT '1',
  `discount_percentage` float DEFAULT NULL,
  `shipping` float NOT NULL DEFAULT '0',
  `shipping_rate` float NOT NULL DEFAULT '0',
  `shipping_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_without_tax` float NOT NULL DEFAULT '0',
  `subtotal` float NOT NULL DEFAULT '0',
  `total_with_tax` float NOT NULL DEFAULT '0',
  `total_coupons` float NOT NULL DEFAULT '0',
  `total_cogs` float NOT NULL DEFAULT '0',
  `total` float NOT NULL DEFAULT '0',
  `tax_value` float NOT NULL DEFAULT '0',
  `products_tax_value` double NOT NULL DEFAULT '0',
  `tax_group_id` int DEFAULT NULL,
  `tax_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tendered` float NOT NULL DEFAULT '0',
  `change` float NOT NULL DEFAULT '0',
  `final_payment_date` datetime DEFAULT NULL,
  `total_instalments` int NOT NULL DEFAULT '0',
  `customer_id` int NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note_visibility` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_id` int DEFAULT NULL,
  `voidance_reason` text COLLATE utf8mb4_unicode_ci,
  `driver_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders`
--

LOCK TABLES `nexopos_orders` WRITE;
/*!40000 ALTER TABLE `nexopos_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_addresses`
--

DROP TABLE IF EXISTS `nexopos_orders_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pobox` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_addresses`
--

LOCK TABLES `nexopos_orders_addresses` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_count`
--

DROP TABLE IF EXISTS `nexopos_orders_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_count` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `count` int NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_count`
--

LOCK TABLES `nexopos_orders_count` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_coupons`
--

DROP TABLE IF EXISTS `nexopos_orders_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_coupons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_coupon_id` int NOT NULL,
  `coupon_id` int NOT NULL,
  `order_id` int NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_value` float NOT NULL,
  `minimum_cart_value` float NOT NULL DEFAULT '0',
  `maximum_cart_value` float NOT NULL DEFAULT '0',
  `limit_usage` int NOT NULL DEFAULT '0',
  `value` float NOT NULL DEFAULT '0',
  `author` int NOT NULL,
  `counted` tinyint(1) NOT NULL DEFAULT '0',
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_coupons`
--

LOCK TABLES `nexopos_orders_coupons` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_instalments`
--

DROP TABLE IF EXISTS `nexopos_orders_instalments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_instalments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `amount` float NOT NULL DEFAULT '0',
  `order_id` int DEFAULT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT '0',
  `payment_id` int DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_instalments`
--

LOCK TABLES `nexopos_orders_instalments` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_instalments` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_instalments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_metas`
--

DROP TABLE IF EXISTS `nexopos_orders_metas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_metas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_metas`
--

LOCK TABLES `nexopos_orders_metas` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_metas` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_metas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_payments`
--

DROP TABLE IF EXISTS `nexopos_orders_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `value` float NOT NULL DEFAULT '0',
  `author` int NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_payments`
--

LOCK TABLES `nexopos_orders_payments` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_products`
--

DROP TABLE IF EXISTS `nexopos_orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal',
  `product_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'product',
  `product_id` int NOT NULL,
  `order_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `unit_quantity_id` int NOT NULL,
  `product_category_id` int NOT NULL,
  `procurement_product_id` int DEFAULT NULL,
  `tax_group_id` int NOT NULL DEFAULT '0',
  `tax_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sold',
  `return_observations` text COLLATE utf8mb4_unicode_ci,
  `return_condition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `discount` float NOT NULL DEFAULT '0',
  `quantity` float NOT NULL,
  `discount_percentage` float NOT NULL DEFAULT '0',
  `unit_price` float NOT NULL DEFAULT '0',
  `price_with_tax` float NOT NULL DEFAULT '0',
  `price_without_tax` float NOT NULL DEFAULT '0',
  `wholesale_tax_value` float NOT NULL DEFAULT '0',
  `sale_tax_value` float NOT NULL DEFAULT '0',
  `tax_value` float NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '0',
  `total_price` float NOT NULL DEFAULT '0',
  `total_price_with_tax` float NOT NULL DEFAULT '0',
  `total_price_without_tax` float NOT NULL DEFAULT '0',
  `total_purchase_price` float NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_products`
--

LOCK TABLES `nexopos_orders_products` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_products_refunds`
--

DROP TABLE IF EXISTS `nexopos_orders_products_refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_products_refunds` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `order_refund_id` int NOT NULL,
  `order_product_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `product_id` int NOT NULL,
  `unit_price` float NOT NULL,
  `tax_value` float NOT NULL DEFAULT '0',
  `quantity` float NOT NULL,
  `total_price` float NOT NULL,
  `condition` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_products_refunds`
--

LOCK TABLES `nexopos_orders_products_refunds` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_products_refunds` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_products_refunds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_refunds`
--

DROP TABLE IF EXISTS `nexopos_orders_refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_refunds` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `author` int NOT NULL,
  `total` float NOT NULL,
  `tax_value` float NOT NULL DEFAULT '0',
  `shipping` float NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_refunds`
--

LOCK TABLES `nexopos_orders_refunds` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_refunds` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_refunds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_settings`
--

DROP TABLE IF EXISTS `nexopos_orders_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_settings`
--

LOCK TABLES `nexopos_orders_settings` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_storage`
--

DROP TABLE IF EXISTS `nexopos_orders_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_storage` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `unit_quantity_id` int DEFAULT NULL,
  `unit_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `session_identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_storage`
--

LOCK TABLES `nexopos_orders_storage` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_orders_taxes`
--

DROP TABLE IF EXISTS `nexopos_orders_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_orders_taxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tax_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `rate` double NOT NULL,
  `tax_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_value` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_orders_taxes`
--

LOCK TABLES `nexopos_orders_taxes` WRITE;
/*!40000 ALTER TABLE `nexopos_orders_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_orders_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_payment_code_transactions`
--

DROP TABLE IF EXISTS `nexopos_payment_code_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_payment_code_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `order_payment_id` bigint DEFAULT NULL,
  `payment_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,5) NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `response_data` text COLLATE utf8mb4_unicode_ci,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nexopos_payment_code_transactions_transaction_id_unique` (`transaction_id`),
  KEY `nexopos_payment_code_transactions_order_id_index` (`order_id`),
  KEY `nexopos_payment_code_transactions_created_at_index` (`created_at`),
  KEY `nexopos_payment_code_transactions_payment_type_index` (`payment_type`),
  KEY `nexopos_payment_code_transactions_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_payment_code_transactions`
--

LOCK TABLES `nexopos_payment_code_transactions` WRITE;
/*!40000 ALTER TABLE `nexopos_payment_code_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_payment_code_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_payments_types`
--

DROP TABLE IF EXISTS `nexopos_payments_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_payments_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` int NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `readonly` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_payments_types`
--

LOCK TABLES `nexopos_payments_types` WRITE;
/*!40000 ALTER TABLE `nexopos_payments_types` DISABLE KEYS */;
INSERT INTO `nexopos_payments_types` VALUES (1,'现金','CASH',0,NULL,68,1,0,'2026-01-26 12:01:29','2026-01-26 12:01:29');
/*!40000 ALTER TABLE `nexopos_payments_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_permissions`
--

DROP TABLE IF EXISTS `nexopos_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `namespace` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nexopos_permissions_name_unique` (`name`),
  UNIQUE KEY `nexopos_permissions_namespace_unique` (`namespace`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_permissions`
--

LOCK TABLES `nexopos_permissions` WRITE;
/*!40000 ALTER TABLE `nexopos_permissions` DISABLE KEYS */;
INSERT INTO `nexopos_permissions` VALUES (1,'Create Users','create.users','Can create users','2026-01-26 03:17:58','2026-01-26 03:17:58'),(2,'Read Users','read.users','Can read users','2026-01-26 03:17:58','2026-01-26 03:17:58'),(3,'Update Users','update.users','Can update users','2026-01-26 03:17:58','2026-01-26 03:17:58'),(4,'Delete Users','delete.users','Can delete users','2026-01-26 03:17:58','2026-01-26 03:17:58'),(5,'Create Roles','create.roles','Can create roles','2026-01-26 03:17:58','2026-01-26 03:17:58'),(6,'Read Roles','read.roles','Can read roles','2026-01-26 03:17:58','2026-01-26 03:17:58'),(7,'Update Roles','update.roles','Can update roles','2026-01-26 03:17:58','2026-01-26 03:17:58'),(8,'Delete Roles','delete.roles','Can delete roles','2026-01-26 03:17:58','2026-01-26 03:17:58'),(9,'Update Core','update.core','Can update core','2026-01-26 03:17:59','2026-01-26 03:17:59'),(10,'Manage Profile','manage.profile','Can manage profile','2026-01-26 03:17:59','2026-01-26 03:17:59'),(11,'Manage Modules','manage.modules','Can manage module : install, delete, update, migrate, enable, disable','2026-01-26 03:17:59','2026-01-26 03:17:59'),(12,'Manage Options','manage.options','Can manage options : read, update','2026-01-26 03:17:59','2026-01-26 03:17:59'),(13,'View Dashboard','read.dashboard','Can access the dashboard and see metrics','2026-01-26 03:17:59','2026-01-26 03:17:59'),(14,'Upload Medias','nexopos.upload.medias','Let the user upload medias.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(15,'See Medias','nexopos.see.medias','Let the user see medias.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(16,'Delete Medias','nexopos.delete.medias','Let the user delete medias.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(17,'Update Medias','nexopos.update.medias','Let the user update uploaded medias.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(18,'Create Categories','nexopos.create.categories','Let the user create products categories.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(19,'Delete Categories','nexopos.delete.categories','Let the user delete products categories.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(20,'Update Categories','nexopos.update.categories','Let the user update products categories.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(21,'Read Categories','nexopos.read.categories','Let the user read products categories.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(22,'Create Customers','nexopos.create.customers','Let the user create customers.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(23,'Delete Customers','nexopos.delete.customers','Let the user delete customers.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(24,'Update Customers','nexopos.update.customers','Let the user update customers.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(25,'Read Customers','nexopos.read.customers','Let the user read customers.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(26,'Import Customers','nexopos.import.customers','Let the user import customers.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(27,'Manage Customer Account History','nexopos.customers.manage-account-history','Can add, deduct amount from each customers account.','2026-01-26 03:17:59','2026-01-26 03:17:59'),(28,'Create Customers Groups','nexopos.create.customers-groups','Let the user create Customers Groups','2026-01-26 03:17:59','2026-01-26 03:17:59'),(29,'Delete Customers Groups','nexopos.delete.customers-groups','Let the user delete Customers Groups','2026-01-26 03:17:59','2026-01-26 03:17:59'),(30,'Update Customers Groups','nexopos.update.customers-groups','Let the user update Customers Groups','2026-01-26 03:18:00','2026-01-26 03:18:00'),(31,'Read Customers Groups','nexopos.read.customers-groups','Let the user read Customers Groups','2026-01-26 03:18:00','2026-01-26 03:18:00'),(32,'Create Coupons','nexopos.create.coupons','Let the user create coupons','2026-01-26 03:18:00','2026-01-26 03:18:00'),(33,'Delete Coupons','nexopos.delete.coupons','Let the user delete coupons','2026-01-26 03:18:00','2026-01-26 03:18:00'),(34,'Update Coupons','nexopos.update.coupons','Let the user update coupons','2026-01-26 03:18:00','2026-01-26 03:18:00'),(35,'Read Coupons','nexopos.read.coupons','Let the user read coupons','2026-01-26 03:18:00','2026-01-26 03:18:00'),(36,'Create Transaction Account','nexopos.create.transactions-account','Let the user create transactions account','2026-01-26 03:18:00','2026-01-26 03:18:00'),(37,'Delete Transactions Account','nexopos.delete.transactions-account','Let the user delete Transaction Account','2026-01-26 03:18:00','2026-01-26 03:18:00'),(38,'Update Transactions Account','nexopos.update.transactions-account','Let the user update Transaction Account','2026-01-26 03:18:00','2026-01-26 03:18:00'),(39,'Read Transactions Account','nexopos.read.transactions-account','Let the user read Transaction Account','2026-01-26 03:18:00','2026-01-26 03:18:00'),(40,'Create Transaction','nexopos.create.transactions','Let the user create transactions','2026-01-26 03:18:00','2026-01-26 03:18:00'),(41,'Delete Transaction','nexopos.delete.transactions','Let the user delete transactions','2026-01-26 03:18:00','2026-01-26 03:18:00'),(42,'Update Transaction','nexopos.update.transactions','Let the user update transactions','2026-01-26 03:18:01','2026-01-26 03:18:01'),(43,'Read Transaction','nexopos.read.transactions','Let the user read transactions','2026-01-26 03:18:01','2026-01-26 03:18:01'),(44,'Read Transactions History','nexopos.read.transactions-history','Give access to the transactions history.','2026-01-26 03:18:01','2026-01-26 03:18:01'),(45,'Delete Transactions History','nexopos.delete.transactions-history','Allow to delete an Transactions History.','2026-01-26 03:18:01','2026-01-26 03:18:01'),(46,'Update Transactions History','nexopos.update.transactions-history','Allow to the Transactions History.','2026-01-26 03:18:01','2026-01-26 03:18:01'),(47,'Create Transactions History','nexopos.create.transactions-history','Allow to create a Transactions History.','2026-01-26 03:18:01','2026-01-26 03:18:01'),(48,'Create Orders','nexopos.create.orders','Let the user create orders','2026-01-26 03:18:01','2026-01-26 03:18:01'),(49,'Delete Orders','nexopos.delete.orders','Let the user delete orders','2026-01-26 03:18:01','2026-01-26 03:18:01'),(50,'Update Orders','nexopos.update.orders','Let the user update orders','2026-01-26 03:18:01','2026-01-26 03:18:01'),(51,'Read Orders','nexopos.read.orders','Let the user read orders','2026-01-26 03:18:01','2026-01-26 03:18:01'),(52,'Void Order','nexopos.void.orders','Let the user void orders','2026-01-26 03:18:01','2026-01-26 03:18:01'),(53,'Refund Order','nexopos.refund.orders','Let the user refund orders','2026-01-26 03:18:01','2026-01-26 03:18:01'),(54,'Make Payment To orders','nexopos.make-payment.orders','Allow the user to make payments to orders.','2026-01-26 03:18:01','2026-01-26 03:18:01'),(55,'Create Procurements','nexopos.create.procurements','Let the user create procurements','2026-01-26 03:18:01','2026-01-26 03:18:01'),(56,'Delete Procurements','nexopos.delete.procurements','Let the user delete procurements','2026-01-26 03:18:01','2026-01-26 03:18:01'),(57,'Update Procurements','nexopos.update.procurements','Let the user update procurements','2026-01-26 03:18:01','2026-01-26 03:18:01'),(58,'Read Procurements','nexopos.read.procurements','Let the user read procurements','2026-01-26 03:18:01','2026-01-26 03:18:01'),(59,'Create Providers','nexopos.create.providers','Let the user create providers','2026-01-26 03:18:01','2026-01-26 03:18:01'),(60,'Delete Providers','nexopos.delete.providers','Let the user delete providers','2026-01-26 03:18:01','2026-01-26 03:18:01'),(61,'Update Providers','nexopos.update.providers','Let the user update providers','2026-01-26 03:18:01','2026-01-26 03:18:01'),(62,'Read Providers','nexopos.read.providers','Let the user read providers','2026-01-26 03:18:01','2026-01-26 03:18:01'),(63,'Create Products','nexopos.create.products','Let the user create products','2026-01-26 03:18:01','2026-01-26 03:18:01'),(64,'Delete Products','nexopos.delete.products','Let the user delete products','2026-01-26 03:18:01','2026-01-26 03:18:01'),(65,'Update Products','nexopos.update.products','Let the user update products','2026-01-26 03:18:01','2026-01-26 03:18:01'),(66,'Read Products','nexopos.read.products','Let the user read products','2026-01-26 03:18:02','2026-01-26 03:18:02'),(67,'Convert Products Units','nexopos.convert.products-units','Let the user convert products','2026-01-26 03:18:02','2026-01-26 03:18:02'),(68,'Read Product History','nexopos.read.products-history','Let the user read products history','2026-01-26 03:18:02','2026-01-26 03:18:02'),(69,'Adjust Product Stock','nexopos.make.products-adjustments','Let the user adjust product stock.','2026-01-26 03:18:02','2026-01-26 03:18:02'),(70,'Create Product Units/Unit Group','nexopos.create.products-units','Let the user create products units.','2026-01-26 03:18:02','2026-01-26 03:18:02'),(71,'Read Product Units/Unit Group','nexopos.read.products-units','Let the user read products units.','2026-01-26 03:18:02','2026-01-26 03:18:02'),(72,'Update Product Units/Unit Group','nexopos.update.products-units','Let the user update products units.','2026-01-26 03:18:02','2026-01-26 03:18:02'),(73,'Delete Product Units/Unit Group','nexopos.delete.products-units','Let the user delete products units.','2026-01-26 03:18:02','2026-01-26 03:18:02'),(74,'Create Registers','nexopos.create.registers','Let the user create registers','2026-01-26 03:18:02','2026-01-26 03:18:02'),(75,'Delete Registers','nexopos.delete.registers','Let the user delete registers','2026-01-26 03:18:02','2026-01-26 03:18:02'),(76,'Update Registers','nexopos.update.registers','Let the user update registers','2026-01-26 03:18:02','2026-01-26 03:18:02'),(77,'Read Registers','nexopos.read.registers','Let the user read registers','2026-01-26 03:18:02','2026-01-26 03:18:02'),(78,'Read Registers History','nexopos.read.registers-history','Let the user read registers history','2026-01-26 03:18:02','2026-01-26 03:18:02'),(79,'Read Use Registers','nexopos.use.registers','Let the user use registers','2026-01-26 03:18:02','2026-01-26 03:18:02'),(80,'Create Rewards','nexopos.create.rewards','Let the user create Rewards','2026-01-26 03:18:02','2026-01-26 03:18:02'),(81,'Delete Rewards','nexopos.delete.rewards','Let the user delete Rewards','2026-01-26 03:18:02','2026-01-26 03:18:02'),(82,'Update Rewards','nexopos.update.rewards','Let the user update Rewards','2026-01-26 03:18:02','2026-01-26 03:18:02'),(83,'Read Rewards','nexopos.read.rewards','Let the user read Rewards','2026-01-26 03:18:02','2026-01-26 03:18:02'),(84,'Create Taxes','nexopos.create.taxes','Let the user create taxes','2026-01-26 03:18:02','2026-01-26 03:18:02'),(85,'Delete Taxes','nexopos.delete.taxes','Let the user delete taxes','2026-01-26 03:18:02','2026-01-26 03:18:02'),(86,'Update Taxes','nexopos.update.taxes','Let the user update taxes','2026-01-26 03:18:02','2026-01-26 03:18:02'),(87,'Read Taxes','nexopos.read.taxes','Let the user read taxes','2026-01-26 03:18:03','2026-01-26 03:18:03'),(88,'See Sale Report','nexopos.reports.sales','Let you see the sales report','2026-01-26 03:18:03','2026-01-26 03:18:03'),(89,'See Products Report','nexopos.reports.products-report','Let you see the Products report','2026-01-26 03:18:03','2026-01-26 03:18:03'),(90,'See Best Report','nexopos.reports.best_sales','Let you see the best_sales report','2026-01-26 03:18:03','2026-01-26 03:18:03'),(91,'See Transaction Report','nexopos.reports.transactions','Let you see the transactions report','2026-01-26 03:18:03','2026-01-26 03:18:03'),(92,'See Yearly Sales','nexopos.reports.yearly','Allow to see the yearly sales.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(93,'See Customers','nexopos.reports.customers','Allow to see the customers','2026-01-26 03:18:03','2026-01-26 03:18:03'),(94,'See Inventory Tracking','nexopos.reports.inventory','Allow to see the inventory','2026-01-26 03:18:03','2026-01-26 03:18:03'),(95,'See Customers Statement','nexopos.reports.customers-statement','Allow to see the customers statement.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(96,'Read Sales by Payment Types','nexopos.reports.payment-types','Let the user read the report that shows sales by payment types.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(97,'Read Low Stock Report','nexopos.reports.low-stock','Let the user read the report that shows low stock.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(98,'Read Stock History','nexopos.reports.stock-history','Let the user read the stock history report.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(99,'Manage Order Payments','nexopos.manage-payments-types','Allow to create, update and delete payments type.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(100,'Edit Purchase Price','nexopos.pos.edit-purchase-price','Let the user edit the purchase price of products.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(101,'Edit Order Settings','nexopos.pos.edit-settings','Let the user edit the order settings.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(102,'Edit Product Discounts','nexopos.pos.products-discount','Let the user add discount on products.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(103,'Edit Cart Discounts','nexopos.pos.cart-discount','Let the user add discount on cart.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(104,'POS: Delete Order Products','nexopos.pos.delete-order-product','Let the user delete order products on POS.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(105,'Cart: Change Product Discount','nexopos.cart.product-discount','Allow access to cart: change product discount feature in POS cart.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(106,'Cart: Edit Product Price','nexopos.cart.product-price','Allow access to cart: edit product price feature in POS cart.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(107,'Cart: Use Wholesale Price','nexopos.cart.product-wholesale-price','Allow access to cart: use wholesale price feature in POS cart.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(108,'Cart: Product Delete','nexopos.cart.product-delete','Allow access to cart: product delete feature in POS cart.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(109,'Cart: Change Settings','nexopos.cart.settings','Allow access to cart: change settings feature in POS cart.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(110,'Cart: Set Taxes','nexopos.cart.taxes','Allow access to cart: set taxes feature in POS cart.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(111,'Cart: Add Comments','nexopos.cart.comments','Allow access to cart: add comments feature in POS cart.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(112,'Cart: Change Order Type','nexopos.cart.order-type','Allow access to cart: change order type feature in POS cart.','2026-01-26 03:18:03','2026-01-26 03:18:03'),(113,'Cart: Apply Coupons','nexopos.cart.coupons','Allow access to cart: apply coupons feature in POS cart.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(114,'Cart: Create Quick Product','nexopos.cart.products','Allow access to cart: create quick product feature in POS cart.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(115,'Cart: Void Order','nexopos.cart.void','Allow access to cart: void order feature in POS cart.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(116,'Cart: Apply Discount','nexopos.cart.discount','Allow access to cart: apply discount feature in POS cart.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(117,'Cart: Hold Order','nexopos.cart.hold','Allow access to cart: hold order feature in POS cart.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(118,'Widget: Incomplete Sale Card Widget','nexopos.see.incomplete-sale-card-widget','Will display a card of current and overall incomplete sales.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(119,'Widget: Expense Card Widget','nexopos.see.expense-card-widget','Will display a card of current and overwall expenses.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(120,'Widget: Sale Card Widget','nexopos.see.sale-card-widget','Will display current and overall sales.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(121,'Widget: Best Customers','nexopos.see.best-customers-widget','Will display all customers with the highest purchases.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(122,'Widget: Profile','nexopos.see.profile-widget','Will display a profile widget with user stats.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(123,'Widget: Orders Chart','nexopos.see.orders-chart-widget','Will display a chart of weekly sales.','2026-01-26 03:18:04','2026-01-26 03:18:04'),(124,'Widget: Orders Summary','nexopos.see.orders-summary-widget','Will display a summary of recent sales.','2026-01-26 03:18:05','2026-01-26 03:18:05'),(125,'Widget: Best Cashiers','nexopos.see.best-cashier-widget','Will display all cashiers who performs well.','2026-01-26 03:18:05','2026-01-26 03:18:05'),(126,'Read Cash Flow History','nexopos.read.cash-flow-history','Allow to the Cash Flow History.','2026-01-26 03:18:17','2026-01-26 03:18:17'),(127,'Delete Expense History','nexopos.delete.cash-flow-history','Allow to delete an expense history.','2026-01-26 03:18:17','2026-01-26 03:18:17'),(128,'Manage Customers Account','nexopos.customers.manage-account','Allow to manage customer virtual deposit account.','2026-01-26 03:18:18','2026-01-26 03:18:18'),(129,'Create Products Labels','nexopos.create.products-labels','Allow the user to create products labels','2026-01-26 03:18:18','2026-01-26 03:18:18'),(130,'Create Instalment','nexopos.create.orders-instalments','Allow the user to create instalments.','2026-01-26 03:18:57','2026-01-26 03:18:57'),(131,'Update Instalment','nexopos.update.orders-instalments','Allow the user to update instalments.','2026-01-26 03:18:57','2026-01-26 03:18:57'),(132,'Read Instalment','nexopos.read.orders-instalments','Allow the user to read instalments.','2026-01-26 03:18:57','2026-01-26 03:18:57'),(133,'Delete Instalment','nexopos.delete.orders-instalments','Allow the user to delete instalments.','2026-01-26 03:18:57','2026-01-26 03:18:57'),(134,'Create Permission Access','create.permissions-access','Can create permission access records','2026-01-26 03:19:04','2026-01-26 03:19:04'),(135,'Read Permission Access','read.permissions-access','Can read permission access records','2026-01-26 03:19:04','2026-01-26 03:19:04'),(136,'Update Permission Access','update.permissions-access','Can update permission access records','2026-01-26 03:19:04','2026-01-26 03:19:04'),(137,'Delete Permission Access','delete.permissions-access','Can delete permission access records','2026-01-26 03:19:04','2026-01-26 03:19:04');
/*!40000 ALTER TABLE `nexopos_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_permissions_access`
--

DROP TABLE IF EXISTS `nexopos_permissions_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_permissions_access` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `requester_id` int unsigned NOT NULL,
  `granter_id` int unsigned NOT NULL,
  `permission` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('granted','denied','pending','expired','used') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `expired_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nexopos_permissions_access_requester_id_index` (`requester_id`),
  KEY `nexopos_permissions_access_granter_id_index` (`granter_id`),
  KEY `nexopos_permissions_access_permission_index` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_permissions_access`
--

LOCK TABLES `nexopos_permissions_access` WRITE;
/*!40000 ALTER TABLE `nexopos_permissions_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_permissions_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_procurements`
--

DROP TABLE IF EXISTS `nexopos_procurements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_procurements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` int NOT NULL,
  `value` float NOT NULL DEFAULT '0',
  `cost` float NOT NULL DEFAULT '0',
  `tax_value` float NOT NULL DEFAULT '0',
  `invoice_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `automatic_approval` tinyint(1) DEFAULT '0',
  `delivery_time` datetime DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `delivery_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `total_items` int NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_procurements`
--

LOCK TABLES `nexopos_procurements` WRITE;
/*!40000 ALTER TABLE `nexopos_procurements` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_procurements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_procurements_products`
--

DROP TABLE IF EXISTS `nexopos_procurements_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_procurements_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gross_purchase_price` float NOT NULL DEFAULT '0',
  `net_purchase_price` float NOT NULL DEFAULT '0',
  `procurement_id` int NOT NULL,
  `product_id` int NOT NULL,
  `purchase_price` float NOT NULL DEFAULT '0',
  `quantity` float NOT NULL,
  `available_quantity` float NOT NULL,
  `tax_group_id` int DEFAULT NULL,
  `barcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `tax_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_value` float NOT NULL DEFAULT '0',
  `total_purchase_price` float NOT NULL DEFAULT '0',
  `unit_id` int NOT NULL,
  `convert_unit_id` int DEFAULT NULL,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_procurements_products`
--

LOCK TABLES `nexopos_procurements_products` WRITE;
/*!40000 ALTER TABLE `nexopos_procurements_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_procurements_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_products`
--

DROP TABLE IF EXISTS `nexopos_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_group_id` int DEFAULT NULL,
  `tax_value` float NOT NULL DEFAULT '0',
  `product_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'product',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tangible',
  `accurate_tracking` tinyint(1) NOT NULL DEFAULT '0',
  `auto_cogs` tinyint(1) NOT NULL DEFAULT '1',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `stock_management` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'enabled',
  `barcode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `thumbnail_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `parent_id` int NOT NULL DEFAULT '0',
  `unit_group` int NOT NULL,
  `on_expiration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'prevent_sales',
  `expires` tinyint(1) NOT NULL DEFAULT '0',
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_products`
--

LOCK TABLES `nexopos_products` WRITE;
/*!40000 ALTER TABLE `nexopos_products` DISABLE KEYS */;
INSERT INTO `nexopos_products` VALUES (1,'可口可乐 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6954767412573','ean13','--500l--jdsdh',NULL,NULL,2,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 11:54:03','2026-01-30 12:11:41'),(2,'可口可乐 2L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6954767413877','ean13','--2l--1LB0D',NULL,NULL,2,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 11:57:59','2026-01-30 11:57:59'),(3,'百事可乐  2L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6936571951769','ean13','--2l--c1z6d',NULL,NULL,2,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 11:59:48','2026-01-30 12:00:31'),(4,'百事可乐 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6936571910018','ean13','--500ml--Omb0e',NULL,NULL,2,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:01:45','2026-01-30 12:12:02'),(5,'雪碧 2L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6954767433073','ean13','--2l--HEzH7',NULL,NULL,2,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:05:23','2026-01-30 12:05:23'),(6,'康师傅 水蜜桃 2L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839998890','ean13','--2l--oyHyq',NULL,NULL,4,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:08:18','2026-01-30 12:19:30'),(7,'康师傅 水蜜桃 1L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839989904','ean13','--1l--jBX4G',NULL,NULL,4,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:10:46','2026-01-30 12:19:12'),(8,'康师傅 水蜜桃 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839905102','ean13','--500ml--XmPkS',NULL,NULL,4,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:13:28','2026-01-30 12:18:49'),(9,'美汁源 果粒橙 1.25 L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6954767400099','ean13','--125-l--tBDIH',NULL,NULL,4,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:15:07','2026-01-30 12:17:25'),(10,'康师傅 鲜橙多 2L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839998937','ean13','--2l--LUJFR',NULL,NULL,4,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:16:52','2026-01-30 12:18:23'),(11,'健力宝 330ml 罐','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6901010101180','ean13','--330ml--GScj5',NULL,NULL,5,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:24:26','2026-01-30 12:24:26'),(12,'红牛 250ml 罐','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6920202888883','ean13','--250ml--4J5vZ',NULL,NULL,5,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:25:35','2026-01-30 12:25:35'),(13,'农夫山泉 1.5L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921168520015','ean13','--15l--Nd3wg',NULL,NULL,7,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:28:15','2026-01-30 12:28:15'),(14,'康师傅 冰糖雪梨 1L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6920459989371','ean13','--1l--xVoGN',NULL,NULL,4,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:31:47','2026-01-30 12:31:47'),(15,'今麦郎 茶粹 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','06939729907793','ean13','--500ml--F8j5L',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:33:41','2026-01-30 12:33:41'),(16,'今麦郎 茶粹 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6939729907793','ean13','--500ml--PKIAQ',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:34:15','2026-01-30 12:34:15'),(17,'康师傅 冰红茶 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839905010','ean13','--500ml--Be7Iv',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:35:27','2026-01-30 12:35:27'),(18,'康师傅 茉莉蜜茶 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839993796','ean13','--500ml--w37ka',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:42:32','2026-01-30 12:42:32'),(19,'康师傅 绿茶 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839905164','ean13','--500ml--qyQ91',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:43:37','2026-01-30 12:43:37'),(20,'康师傅 茉莉清茶 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839998432','ean13','--500ml--6Na3b',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:44:54','2026-01-30 12:44:54'),(21,'焙好茶 凤凰单纵 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6934502304745','ean13','--500ml--NLIpC',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:50:33','2026-01-30 12:50:33'),(22,'康师傅 茉莉清茶 1L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839992065','ean13','--1l--iTT9t',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:51:57','2026-01-30 12:51:57'),(23,'康师傅 冰红茶 1L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839996360','ean13','--1l--qrvrT',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:52:54','2026-01-30 12:52:54'),(24,'康师傅 绿茶 1L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839996506','ean13','--1l--HOQEf',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:54:15','2026-01-30 12:54:15'),(25,'康师傅 茉莉清茶 1L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944839991983','ean13','--1l--ZDUDn',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 12:55:04','2026-01-30 12:55:04'),(26,'东鹏 补水啦 柠檬味 1L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6934502302277','ean13','--1l--erAgu',NULL,NULL,5,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:01:56','2026-01-30 13:01:56'),(27,'东鹏 补水啦 荔枝味 1L 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6934502302642','ean13','--1l--dkWad',NULL,NULL,5,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:03:00','2026-01-30 13:03:00'),(28,'营养快线 500g 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902083904685','ean13','--500g--iHLk2',NULL,NULL,6,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:05:10','2026-01-30 13:05:10'),(29,'东鹏 大咖 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6934502301812','ean13','--500ml--Dw68S',NULL,NULL,8,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:07:34','2026-01-30 13:07:34'),(30,'东鹏特饮 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6934502301850','ean13','--500ml--lxmgG',NULL,NULL,5,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:09:07','2026-01-30 13:09:07'),(31,'东方树叶 茉莉花茶 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921168558049','ean13','--500ml--LJjUz',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:10:35','2026-01-30 13:10:35'),(32,'脉动 青柠味 600ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902538004045','ean13','--600ml--LXWwR',NULL,NULL,5,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:12:00','2026-01-30 13:12:00'),(33,'尖叫 纤维型 550ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921168504022','ean13','--550ml--hhS1O',NULL,NULL,5,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:13:25','2026-01-30 13:13:25'),(34,'东方树叶 茉莉花茶 900ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921168598427','ean13','--900ml--jr24N',NULL,NULL,3,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:14:40','2026-01-30 13:14:40'),(35,'今麦郎 凉白开 550ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6939729902255','ean13','--550ml--a7at7',NULL,NULL,7,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:17:39','2026-01-30 13:17:39'),(36,'今麦郎 芒顿小镇 柠檬水 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6939729900039','ean13','--500ml--szLt6',NULL,NULL,7,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:20:31','2026-01-30 13:20:31'),(37,'今麦郎 芒顿小镇 蜜桃水 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6939729900008','ean13','--500ml--Ex5RO',NULL,NULL,7,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:21:11','2026-01-30 13:21:11'),(38,'农夫山泉 550ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921168509256','ean13','--550ml--l8MRP',NULL,NULL,7,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:22:24','2026-01-30 13:22:24'),(39,'哇哈哈 饮用矿泉水 596ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902083881405','ean13','--596ml--r9if3',NULL,NULL,7,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:23:50','2026-01-30 13:23:50'),(40,'今麦郎 蓝标 550ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6939729901388','ean13','--550ml--EoJfe',NULL,NULL,7,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:25:28','2026-01-30 13:25:28'),(41,'今麦郎 苏打水 450ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6939729902941','ean13','--450ml--TlaA2',NULL,NULL,7,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:26:51','2026-01-30 13:26:51'),(42,'哇哈哈 AD钙奶 220g 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902083881085','ean13','--ad-220g--TESZo',NULL,NULL,6,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:28:18','2026-01-30 13:28:18'),(43,'北京二锅头（30%vol）100ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6973752360897','ean13','--30vol100ml--LXFho',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:34:26','2026-01-30 13:34:26'),(44,'小郎酒 （45%vol）100ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6972119550360','ean13','--45vol100ml--9PvAc',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:35:55','2026-01-30 13:35:55'),(45,'北京二锅头（30%vol）500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6028461392995','ean13','--30vol500ml--vGQpK',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:37:11','2026-01-30 13:37:11'),(46,'盛世凤凰（52%vol）500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6951075601927','ean13','--52vol500ml--N6DZm',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:38:27','2026-01-30 13:38:27'),(47,'牛栏山 （42%vol）500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6906151600462','ean13','--42vol500ml--7ffsd',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:39:39','2026-01-30 13:41:29'),(48,'西凤酒（45%vol）375ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902212024789','ean13','--45vol375ml--4snpV',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:45:36','2026-01-30 13:45:36'),(49,'汾酒（53%vol）475ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6903431119546','ean13','--53vol475ml--UDenf',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:46:57','2026-01-30 13:46:57'),(50,'顺品郎 金盖装（53%vol）480ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6972119553576','ean13','--53vol480ml--6Jn7F',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:49:02','2026-01-30 13:49:02'),(51,'顺品郎 红（45%vol）480ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6972119554221','ean13','--45vol480ml--lAkr7',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:50:06','2026-01-30 13:50:06'),(52,'牛栏山（52%vol）375ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6906151625816','ean13','--52vol375ml--CWcKl',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:55:17','2026-01-30 13:55:17'),(53,'牛栏山（45%vol）500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6906151630513','ean13','--45vol500ml--ZcyzN',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:56:05','2026-01-30 13:56:05'),(54,'直罗烧酒（52%vol）500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6973695390098','ean13','--52vol500ml--IbMT7',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:58:09','2026-01-30 13:58:09'),(55,'高粱原浆（52%vol）2.5L 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6978587459969','ean13','--52vol25l--49gUp',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 13:59:50','2026-01-30 13:59:50'),(56,'卧龙泉 老白干 （50%vol）2L 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6925923570413','ean13','--50vol2l--jpf9n',NULL,NULL,10,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:01:23','2026-01-30 14:01:23'),(57,'长安花 纯香 菜籽油 5L 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6933664902394','ean13','--5l--9JE13',NULL,NULL,15,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:14:10','2026-01-30 14:14:10'),(58,'金龙鱼 纯香 菜籽油 5L 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6948195804758','ean13','--5l--FlQMB',NULL,NULL,15,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:16:25','2026-01-30 14:16:25'),(59,'筋冠 原味挂面 800g 包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6932759750025','ean13','--800g--SFQxU',NULL,NULL,14,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:18:02','2026-01-30 14:18:02'),(60,'卖心鸡蛋 挂面 800g 包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6941473524126','ean13','--800g--qgPOB',NULL,NULL,14,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:19:35','2026-01-30 14:19:35'),(61,'五得利 面粉（七星）25kg 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6934468005618','ean13','--25kg--tHlT4',NULL,NULL,16,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:22:20','2026-01-30 14:25:56'),(62,'新疆 明有小麦粉 25kg 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971142200006','ean13','--25kg--W29KY',NULL,NULL,16,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:23:40','2026-01-30 14:25:56'),(63,'长粒香米 5kg 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6940067600123','ean13','--5kg--HmTio',NULL,NULL,16,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:25:26','2026-01-30 14:25:56'),(64,'海天料酒 800ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902265803218','ean13','--800ml--GzctI',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:29:29','2026-01-30 14:29:29'),(65,'海天蚝油 700g 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902265360018','ean13','--700g--etSoe',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:30:49','2026-01-30 14:30:49'),(66,'海天 味极鲜 酱油 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902265503514','ean13','--500ml--5xRYo',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:31:49','2026-01-30 14:32:21'),(67,'5°原浆老陈醋 2.5L','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6972107853039','ean13','--5-25l--VUyBR',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:34:08','2026-01-30 14:34:08'),(68,'海天 生抽酱油 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902265501213','ean13','--500ml--lS5QV',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:35:37','2026-01-30 14:35:37'),(69,'海天 老抽酱油 500ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902265501114','ean13','--500ml--esASg',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:36:41','2026-01-30 14:36:41'),(70,'吴起荞麦香醋 420ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6926034406462','ean13','--420ml--5g3oZ',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:40:01','2026-01-30 14:40:01'),(71,'5°白醋 450ml 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902265452218','ean13','--5-450ml--hr2x4',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:41:11','2026-01-30 14:41:11'),(72,'84消毒液 500g 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6951667000084','ean13','--84-500g--Va4sw',NULL,NULL,21,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:47:20','2026-01-30 14:47:20'),(73,'雕牌 洗洁精 500g 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6910019001841','ean13','--500g--BC5c5',NULL,NULL,19,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:48:33','2026-01-30 14:48:33'),(74,'雕牌 洗洁精 1.5kg 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6910019010928','ean13','--15kg--5YLXe',NULL,NULL,19,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:49:28','2026-01-30 14:49:28'),(75,'立白 洗洁精 1kg 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6920174754483','ean13','--1kg--VXd15',NULL,NULL,19,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 14:53:52','2026-01-30 14:53:52'),(76,'鸿利 特制白毫王 225g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6976343190026','ean13','--225g--TOwzo',NULL,NULL,22,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 15:00:03','2026-01-30 15:00:40'),(77,'鸿利 条条香 225g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6976343190118','ean13','--225g--xgfQj',NULL,NULL,22,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 15:02:30','2026-01-30 15:05:03'),(78,'金鹏 精品白毫王 250g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6977335290038','ean13','--250g--zfJ19',NULL,NULL,22,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 15:06:10','2026-01-30 15:06:10'),(79,'金鹏 精制白毫王 225g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6977335290014','ean13','--225g--l8ASK',NULL,NULL,22,0,1,'prevent-sales',0,1,68,NULL,'2026-01-30 15:07:29','2026-01-30 15:07:48'),(80,'康师傅 红烧牛肉面 113g 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921774200776','ean13','--113g--kuVAG',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:25:51','2026-01-31 05:25:51'),(81,'康师傅 麻辣牛肉面 108g 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921774204378','ean13','--108g--L9lGr',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:26:51','2026-01-31 05:26:51'),(82,'康师傅 老坛酸菜面 122g 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921774214070','ean13','--122g--HiUUE',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:28:01','2026-01-31 05:28:01'),(83,'康师傅 番茄鸡蛋牛肉面 126g 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6937962111649','ean13','--126g--jElA3',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:29:18','2026-01-31 05:29:18'),(84,'康师傅 老母鸡汤面 115g 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6937962134631','ean13','--115g--LnCao',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:30:21','2026-01-31 05:30:21'),(85,'康师傅 油泼辣子酸汤面 127g 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921774241540','ean13','--127g--r1nBW',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:31:28','2026-01-31 05:31:28'),(86,'康师傅 麻辣牛肉面 102g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921774260862','ean13','--102g--y2f0d',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:34:44','2026-01-31 05:34:44'),(87,'康师傅 红烧牛肉面 105g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921774260060','ean13','--105g--TZjZf',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:35:39','2026-01-31 05:35:39'),(88,'康师傅 油泼辣子酸汤面 117g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921774297349','ean13','--117g--g1TI5',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:36:42','2026-01-31 05:36:42'),(89,'康师傅 西红柿炖牛腩面 104g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921774275095','ean13','--104g--sNRie',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:37:46','2026-01-31 05:37:46'),(90,'白象 老母鸡汤面 110g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6938957107586','ean13','--110g--sfGLa',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:40:54','2026-01-31 05:40:54'),(91,'白象 板面 卤香牛肉味 147g 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6977176952713','ean13','--147g--OTcpo',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:43:03','2026-01-31 05:48:59'),(92,'白象 板面 麻辣牛肉味 145g 桶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6977176952683','ean13','--145g--SBzNs',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:44:36','2026-01-31 05:48:42'),(93,'白象 经典火鸡面 119g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6938957106688','ean13','--119g--hrIIb',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:48:07','2026-01-31 05:48:07'),(94,'白象 老坛酸菜牛肉面 110g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6938957104561','ean13','--110g--t6wXd',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:50:07','2026-01-31 05:50:07'),(95,'可口乐 93g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6922444636505','ean13','--93g--d033l',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:51:48','2026-01-31 05:51:48'),(96,'薯博士 酱香烧烤味 36g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6933103400023','ean13','--36g--jL3YB',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:53:16','2026-01-31 05:53:47'),(97,'虾条 15g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6923775916823','ean13','--15g--BNKzI',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:54:57','2026-01-31 05:55:30'),(98,'江南style 薯片','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6936615701671','ean13','--style--iaPso',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 05:56:16','2026-01-31 05:56:16'),(99,'虾条 咖喱鸡汁味 35g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6933103407664','ean13','--35g--CwZC0',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:00:28','2026-01-31 06:00:28'),(100,'可可脆 薯片 40g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6970532806569','ean13','--40g--ahcMV',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:01:36','2026-01-31 06:01:36'),(101,'小鱼来了 薯片 60g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6934159504864','ean13','----5pxFs',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:02:59','2026-01-31 06:03:22'),(102,'酱香土豆 40g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6926237032062','ean13','--40g--ol2jN',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:04:12','2026-01-31 06:04:12'),(103,'一根葱 30g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6970716698010','ean13','--30g--eINRk',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:05:04','2026-01-31 06:05:04'),(104,'薯喔脆薯片 70g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6970061702059','ean13','--101g--exiYX',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:07:34','2026-01-31 06:08:16'),(105,'脆司令 香脆面 53g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6920189004290','ean13','--53g--uvyOE',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:09:50','2026-01-31 06:09:50'),(106,'大豫竹 52g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6920189007604','ean13','--52g--LT2J6',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:11:22','2026-01-31 06:11:22'),(107,'早餐奶 （230ml*16）箱','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6923644264987','ean13','--230ml16--uRp37',NULL,NULL,6,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:17:08','2026-01-31 06:17:08'),(108,'特仑苏 纯牛奶 （250ml*12）箱','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6923644266318','ean13','--250ml12--g1kS5',NULL,NULL,6,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:18:45','2026-01-31 06:18:45'),(109,'早餐饼干 800g 箱','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6901180964585','ean13','--800g--sTz8j',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:23:51','2026-01-31 06:23:51'),(110,'早餐饼干 167g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6901180339581','ean13','--167g--jKNvN',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:24:55','2026-01-31 06:24:55'),(111,'李救军 168g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6946362500021','ean13','--168g--D5vRS',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:29:27','2026-01-31 06:29:27'),(112,'香辣素肥肠 40g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6956406200046','ean13','--40g--iU2dV',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:30:28','2026-01-31 06:30:28'),(113,'龙卷风 36g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6973067146667','ean13','--36g--g13hx',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:31:17','2026-01-31 06:31:17'),(114,'成语接龙 饼干 208g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6931615505144','ean13','--208g--m55Tm',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:32:25','2026-01-31 06:32:25'),(115,'香飘飘 红豆奶茶 64g 杯','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6938888888615','ean13','--64g--0RkOi',NULL,NULL,6,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:34:00','2026-01-31 06:34:00'),(116,'香飘飘 红豆奶茶 （64g*3杯） 把','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6938888888042','ean13','--64g3--Oupdq',NULL,NULL,6,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:36:13','2026-01-31 06:36:13'),(117,'古诗棒棒饼 160g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6931615506936','ean13','--160g--UaZBf',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:42:27','2026-01-31 06:42:27'),(118,'蔬菜卷 22g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6928493701409','ean13','--22g--sRwCG',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:46:26','2026-01-31 06:46:26'),(119,'香飘飘 草莓味奶茶 80g 杯','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6938888888868','ean13','--80g--wElpq',NULL,NULL,6,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:47:52','2026-01-31 06:47:52'),(120,'香飘飘 麦香味奶茶 80g 杯','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6938888888844','ean13','--80g--Oy1qI',NULL,NULL,6,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:48:48','2026-01-31 06:48:48'),(121,'香飘飘 香芋味奶茶 80g 杯','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6938888888813','ean13','--80g--iLtAf',NULL,NULL,6,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:49:46','2026-01-31 06:49:46'),(122,'薯我开心 101g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6970500750047','ean13','--101g--A59wA',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:50:48','2026-01-31 06:50:48'),(123,'蘑克粒 蓝莓味 130g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6920132710414','ean13','--130g--Wh5JU',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:53:02','2026-01-31 06:53:02'),(124,'好吃点 香脆腰果饼 108g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6911988009777','ean13','--108g--3H3xy',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:53:58','2026-01-31 07:03:19'),(125,'可比克 烧烤味 薯片 45g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6911988006547','ean13','--45g--vDEgE',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:55:15','2026-01-31 06:55:15'),(126,'可比克 原滋味 薯片 45g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6911988006554','ean13','--45g--ujyqC',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:56:00','2026-01-31 06:56:00'),(127,'可比克 番茄味 薯片 45g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6911988006523','ean13','--45g--zcPm3',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:56:46','2026-01-31 06:56:46'),(128,'奥利奥 夹心饼干 97g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6901668935724','ean13','--97g--5BrO5',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 06:58:25','2026-01-31 06:58:25'),(129,'好吃点 香脆核桃饼 108g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6911988009784','ean13','--108g--mBGGh',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:04:08','2026-01-31 07:04:08'),(130,'迷你小麻花 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971039920017','ean13','----2znBc',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:05:42','2026-01-31 07:05:42'),(131,'三明治 草莓味 面包 48g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6972257010009','ean13','--48g--yqkm2',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:07:28','2026-01-31 07:07:28'),(132,'绿豆锅巴 150g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6973057210019','ean13','--150g--qMPAA',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:11:33','2026-01-31 07:11:33'),(133,'旺仔牛奶糖 15g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6936003512414','ean13','--15g--7NI2q',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:13:32','2026-01-31 07:13:32'),(134,'酥道膜片 36g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6928498300164','ean13','--36g--2F6Q5',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:14:54','2026-01-31 07:14:54'),(135,'笨笨狗 夹心米果 158g 包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6930742600975','ean13','--158g--jM0rD',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:15:55','2026-01-31 07:15:55'),(136,'麦烧 葱油味 120g 包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6905418008782','ean13','--120g--svk7r',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:16:51','2026-01-31 07:16:51'),(137,'喜之郎 果冻 120g 包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6926475200155','ean13','--120g--wmkQg',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:17:54','2026-01-31 07:17:54'),(138,'喜之郎 果冻 360g 包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6926475202449','ean13','--360g--4EGAJ',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:18:47','2026-01-31 07:18:47'),(139,'小地主 豆香锅巴 170g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6941158700197','ean13','--170g--2Bw29',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:20:10','2026-01-31 07:20:10'),(140,'脆笋 30g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6923236120332','ean13','--30g--5jr9X',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:21:24','2026-01-31 07:21:24'),(141,'俏嘴巴 清水鱼 12g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6939936691812','ean13','----S6GEj',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:22:14','2026-02-04 05:23:15'),(142,'魔芋爽 香辣素毛肚 18g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6935284400236','ean13','--18g--NL6er',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:26:31','2026-01-31 07:26:31'),(143,'嗦螺 32g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6974564330481','ean13','--32g--onzZl',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:27:57','2026-01-31 07:27:57'),(144,'猪扒脆 香辣味脆骨 16g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6931754806362','ean13','--16g--77XkW',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:29:39','2026-01-31 07:29:39'),(145,'老妈牛肉粒素 26g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6955908873772','ean13','--26g--zd7D2',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:30:47','2026-01-31 07:30:47'),(146,'魔芋贡菜 15g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6974085080940','ean13','--15g--mZYqj',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:31:35','2026-01-31 07:31:35'),(147,'麻酱 素毛肚 18g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6925678121373','ean13','--18g--uoqDF',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:32:43','2026-01-31 07:32:43'),(148,'麻酱 素脆爆肚 15g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6954446301464','ean13','--15g--57lR1',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:33:43','2026-01-31 07:33:43'),(149,'麻酱 鸡 20g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6922170805404','ean13','--20g--eq14J',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:34:56','2026-01-31 07:34:56'),(150,'火爆金针菇 26g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6922354299876','ean13','--26g--k1wpj',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:35:58','2026-01-31 07:35:58'),(151,'虎皮爆汁豆腐干 20g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6927460300270','ean13','--20g--5EmR9',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:37:38','2026-01-31 07:37:38'),(152,'金针菇脆肚 20g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6939424701870','ean13','--20g--vqUd4',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:38:55','2026-01-31 07:38:55'),(153,'火锅素毛肚 18g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6925678112821','ean13','--18g--yUw55',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:39:57','2026-01-31 07:39:57'),(154,'烤面筋 28g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6944556200191','ean13','--28g--7BVJm',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:40:56','2026-01-31 07:40:56'),(155,'伤心凉皮 22g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6923663963854','ean13','--22g--FnwsF',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:49:36','2026-01-31 07:49:36'),(156,'小鹏 香葱排骨 面制品 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6953442900046','ean13','----a0GKo',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:51:17','2026-01-31 07:51:17'),(157,'素大龙虾 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971689220000','ean13','----jkuAN',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:52:09','2026-01-31 07:52:35'),(158,'杰仔 菠菜王味 16g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6920293900006','ean13','--16g--xwSv1',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:53:49','2026-01-31 07:53:49'),(159,'过桥米线 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971623401649','ean13','----NgCjg',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:54:55','2026-01-31 07:54:55'),(160,'阳光海苔 26g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6923407683819','ean13','--26g--Cesti',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:55:48','2026-01-31 07:55:48'),(161,'青菜面 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6934937600016','ean13','----eTbpU',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:56:43','2026-01-31 07:57:09'),(162,'鸡排 20g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6940496400035','ean13','--20g--RzM19',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:57:49','2026-01-31 07:57:49'),(163,'牛佬大 素牛肉布丁 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6970248101750','ean13','----1mFLB',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 07:59:26','2026-01-31 07:59:26'),(164,'长沙 臭干子 18g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6938350838889','ean13','--18g--1H8Ql',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:00:49','2026-01-31 08:00:49'),(165,'海带风味 面制品 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6976743879996','ean13','----jl8Yf',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:02:15','2026-01-31 08:02:15'),(166,'巴西烤肉风味 面制品 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6976743870009','ean13','----lFJYR',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:03:02','2026-01-31 08:03:02'),(167,'甜甜圈 28g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6931031700239','ean13','--28g--yEkCO',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:03:50','2026-01-31 08:03:50'),(168,'绿豆饼 45g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6970150720087','ean13','--45g--LrAHm',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:04:57','2026-01-31 08:04:57'),(169,'脆脆鲨 威化饼 18.6g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6917878131504','ean13','--186g--ROhqJ',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:10:08','2026-01-31 08:10:08'),(170,'甄吉力 3+2 脆皮 饼干 25g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971876550095','ean13','--32-25g--Rhmub',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:12:05','2026-01-31 08:12:05'),(171,'黑金刚 巧克力 15g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6924097902259','ean13','--15g--AqToM',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:13:19','2026-01-31 08:13:19'),(172,'蒜香青豆 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6922839113918','ean13','----RVvv3',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:14:26','2026-01-31 08:14:26'),(173,'干吃奶片糖 13.5g 版','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6906496030634','ean13','--135g--w283j',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:15:41','2026-01-31 08:15:41'),(174,'欢乐豆 巧克力味糖 20g 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6972771420117','ean13','--20g--VM2QV',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:16:44','2026-01-31 08:16:44'),(175,'QQ糖 香橙味 20g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921299762018','ean13','--qq-20g--TAV2Z',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:17:53','2026-01-31 08:17:53'),(176,'QQ糖 荔枝味 20g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6921299762834','ean13','--qq-20g--2OPcE',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:18:41','2026-01-31 08:18:41'),(177,'QQ糖 可乐味 20g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6920952712087','ean13','--qq-20g--ugAvJ',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:21:31','2026-01-31 08:21:31'),(178,'阿尔卑斯 棒棒糖 10g 根','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6911316600409','ean13','--10g--8z6kk',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:22:43','2026-01-31 08:22:43'),(179,'爱博瑞 卫生纸 1600g 提','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6959766200497','ean13','--1600g--xExVC',NULL,NULL,18,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:33:27','2026-01-31 08:33:27'),(180,'纤礼 卫生纸 1700g 提','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6937192131103','ean13','--1700g--mMhIX',NULL,NULL,18,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:37:12','2026-01-31 08:37:12'),(181,'亿兰朵 抽纸（10包装）提','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6922773603346','ean13','--10--BlqZS',NULL,NULL,18,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:42:16','2026-01-31 08:42:16'),(182,'亿兰朵 抽纸 （300抽）包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6922773602073','ean13','--300--O7I9Y',NULL,NULL,18,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 08:47:08','2026-01-31 08:47:08'),(183,'莲花味精 100g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6901377001000','ean13','--100g--MAsKB',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:35:44','2026-01-31 10:35:44'),(184,'海藻碘 精制盐 350g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6926198012233','ean13','--350g--73lUA',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:37:01','2026-01-31 10:37:01'),(185,'王守义 十三香 45g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6906303888885','ean13','--45g--4l5hi',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:38:19','2026-01-31 10:38:19'),(186,'太太乐 鸡精 100g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6922130101188','ean13','--100g--J3uAS',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:39:51','2026-01-31 10:39:51'),(187,'生姜粉 50g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6917403341187','ean13','--50g--5dXta',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:42:34','2026-01-31 10:42:34'),(188,'五香粉 30g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6917403000138','ean13','--30g--Livsq',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:43:42','2026-01-31 10:43:42'),(189,'花椒粉 50g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6917403241180','ean13','--50g--rBDLq',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:44:28','2026-01-31 10:44:28'),(190,'炒菜王 103g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6930342500200','ean13','--103g--mMBiM',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:46:06','2026-01-31 10:46:06'),(191,'安琪 干酵母 15g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6917790975323','ean13','--15g--CBamt',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:57:32','2026-01-31 10:57:32'),(192,'红99 火锅料 400g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6933453800078','ean13','--99-400g--rgPrh',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:58:31','2026-01-31 10:58:31'),(193,'炖（卤）肉料 40g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971074000316','ean13','--40g--MFVG3',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 10:59:58','2026-01-31 10:59:58'),(194,'香料五组合 110g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6977226041626','ean13','--110g--ilsXX',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:01:22','2026-01-31 11:01:22'),(195,'食用纯碱 200g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971071890088','ean13','--200g--w62qn',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:02:42','2026-01-31 11:02:42'),(196,'淀粉 200g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6927687211151','ean13','--200g--44byS',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:03:34','2026-01-31 11:03:34'),(197,'舒肤佳 纯白清香型 100g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6903148144541','ean13','--100g--Fg07j',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:08:49','2026-01-31 11:08:49'),(198,'舒肤佳 柠檬清香型 100g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6903148144442','ean13','--100g--QErcU',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:09:51','2026-01-31 11:09:51'),(199,'舒肤佳 金银花/菊花自然爽洁香型 100g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6903148145593','ean13','--100g--pWSTf',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:11:44','2026-01-31 11:11:44'),(200,'春纪 牙刷 个','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6930114355007','ean13','----ymdh9',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:13:08','2026-01-31 11:13:08'),(201,'倍洁 CJ206 牙刷 个','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6930114352068','ean13','--cj206--sHuVQ',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:14:16','2026-01-31 11:14:57'),(202,'佳洁士 草本 牙膏 90g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6903148015834','ean13','--90g--jPhXw',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:16:35','2026-01-31 11:16:35'),(203,'冷酸灵 牙膏 90g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902132007060','ean13','--90g--vw4lJ',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:18:08','2026-01-31 11:18:08'),(204,'好来 牙膏 90g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','4891338005692','ean13','--90g--uyPHi',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:19:05','2026-01-31 11:19:05'),(205,'普斯特去渍亮白牙膏 130g 盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','5060106815668','ean13','--130g--m7sx7',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:20:10','2026-01-31 11:20:10'),(206,'云南白药 牙膏','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6901070600111','ean13','----1ZaOX',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:21:49','2026-01-31 11:21:49'),(207,'飘柔 芦荟精华 170g 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6903148225813','ean13','--170g--fDvgO',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:25:25','2026-01-31 11:28:06'),(208,'飘柔 兰花香型 170g 瓶','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6903148225790','ean13','--170g--mwVLB',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:28:49','2026-01-31 11:28:49'),(209,'茗象 高硼硅玻璃杯','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6976114861902','ean13','----cG4Oz',NULL,NULL,18,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:36:04','2026-01-31 11:36:33'),(210,'金顶皇后 扑克 副','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6941402408039','ean13','----wjrSL',NULL,NULL,18,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:41:16','2026-01-31 11:46:12'),(211,'绿箭口香糖','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6923450605660','ean13','----fgIYA',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:43:03','2026-01-31 11:43:03'),(212,'益达口香糖','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6923450614938','ean13','----WmHgW',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:43:54','2026-01-31 11:43:54'),(213,'3A扑克 副','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902774349016','ean13','--3a--UIge5',NULL,NULL,18,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:44:49','2026-01-31 11:45:58'),(214,'天旗扑克 副','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6970208389914','ean13','----jr5AD',NULL,NULL,18,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:47:31','2026-01-31 11:47:31'),(215,'婴儿手口湿巾 80抽 包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6976088420020','ean13','--80--EYkUx',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:53:37','2026-01-31 11:53:37'),(216,'贝乐滋 面巾纸 包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971549310018','ean13','----aDkum',NULL,NULL,20,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:55:15','2026-01-31 11:55:15'),(217,'洁美 纸杯 50只装 包','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6957098700111','ean13','--50--9yF8S',NULL,NULL,18,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 11:56:28','2026-01-31 11:56:28'),(218,'黑珍珠 奶油味 瓜子','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6978370090027','ean13','----0f8Oa',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:02:21','2026-01-31 12:02:21'),(219,'小 南瓜子','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971772150092','ean13','----35TTG',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:03:21','2026-01-31 12:03:21'),(220,'小官家 黑鸦味瓜子','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6977367570306','ean13','----mLdUX',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:04:07','2026-01-31 12:04:07'),(221,'洽洽 香瓜子 200g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6924187832657','ean13','--200g--C97xo',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:05:04','2026-02-04 05:01:49'),(222,'建军 香瓜子 200g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6924714888065','ean13','--200g--OIpGU',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:05:56','2026-02-04 05:02:37'),(223,'大 南瓜子 180g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6952339210800','ean13','--180g--mjsoP',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:06:38','2026-01-31 12:06:38'),(224,'金鸽 多味葵花籽 98g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6922133602965','ean13','--98g--IBhqK',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:07:56','2026-01-31 12:07:56'),(225,'坚老大 便利店 多味葵花子 160g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6978205940022','ean13','--160g--ma8gu',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:09:16','2026-01-31 12:09:16'),(226,'坚老大 便利店 原味葵花子 160g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6978205940015','ean13','--160g--vifR6',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:10:35','2026-01-31 12:10:35'),(227,'鹌鹑蛋 泡椒味 30g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6950155100640','ean13','--30g--Powx0',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:16:59','2026-01-31 12:17:57'),(228,'鹌鹑蛋 温州风味 30g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6950155100077','ean13','--30g--cpdMJ',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 12:18:53','2026-01-31 12:18:53'),(229,'双汇 泡面轻盐派 35g 根','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902890274070','ean13','--35g--GJVfy',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:19:47','2026-01-31 13:19:47'),(230,'双汇 王中王 火腿肠 35g 根','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902890235958','ean13','--35g--Gu8XL',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:21:17','2026-01-31 13:21:17'),(231,'双汇 王中王 火腿肠 65g 根','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6902890229360','ean13','--65g--fvL8Z',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:22:10','2026-01-31 13:22:10'),(232,'天宜 南瓜酥 35g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6972153271207','ean13','--35g--ZmVwc',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:23:30','2026-01-31 13:23:30'),(233,'烤牛馍 38g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6972153270026','ean13','--38g--riRck',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:24:40','2026-01-31 13:24:40'),(234,'八千里豆腐干 70g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6927460319074','ean13','--70g--ssttA',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:25:48','2026-01-31 13:25:48'),(235,'福鹏冰糖 260g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6952339230167','ean13','--260g--6GDhp',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:27:08','2026-01-31 13:27:08'),(236,'汇腾 米肠 28g 根','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6923426700696','ean13','--28g--LN6wL',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:28:45','2026-01-31 13:28:45'),(237,'五香蛋 35g 个','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6959203900621','ean13','--35g--Suvib',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:30:20','2026-01-31 13:30:20'),(238,'泡椒蛋 35g 个','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6959203900041','ean13','--35g--grWem',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:31:29','2026-01-31 13:31:29'),(239,'乌江 榨菜 60g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6901754220802','ean13','--60g--8JVhF',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:33:29','2026-01-31 13:33:29'),(240,'福鹏白糖 320g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6952339230181','ean13','--320g--UbBJw',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:34:49','2026-01-31 13:34:49'),(241,'福鹏赤沙糖 320g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6952339230174','ean13','--320g--avpZz',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:35:44','2026-01-31 13:35:44'),(242,'椒盐花生 150g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6936402300209','ean13','--150g--VbHLV',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:39:19','2026-01-31 13:39:19'),(243,'琨航酒香 花生豆 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6970580810242','ean13','----nBxXn',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:40:33','2026-01-31 13:40:33'),(244,'咸鸭蛋 60g 个','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971527830026','ean13','--60g--9kw80',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:41:59','2026-01-31 13:41:59'),(245,'香酥鸡爪 48g 个','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6932262200185','ean13','--48g--jkf9x',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:42:57','2026-01-31 13:42:57'),(246,'乡巴佬 麻辣腿 110g 个','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6973464340613','ean13','--110g--C4Psm',NULL,NULL,26,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:44:15','2026-01-31 13:44:15'),(247,'酸菜 200g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6933770863107','ean13','--200g--oxthG',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:45:37','2026-01-31 13:45:37'),(248,'小米辣 1000g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6924311514138','ean13','--1000g--Sg4Op',NULL,NULL,17,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:46:56','2026-01-31 13:46:56'),(249,'红油豇豆 90g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6971079290569','ean13','--90g--2hDNr',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:49:41','2026-01-31 13:49:41'),(250,'红油春笋 118g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6930484442017','ean13','--118g--dojba',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:50:27','2026-01-31 13:50:27'),(251,'下饭菜 118g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6930484442031','ean13','--118g--NZpCT',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:51:07','2026-01-31 13:51:07'),(252,'黄花什锦 118g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6930484442024','ean13','--118g--It0kU',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-01-31 13:51:56','2026-01-31 13:51:56'),(253,'可口乐 （93g * 50） 箱','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6922444636659','ean13','--93g-50--qCsNg',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-02-04 04:48:44','2026-02-04 04:48:44'),(254,'脆司令 香脆面 （53g * 40） 箱','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6920189004337','ean13','--53g-40--pNuuZ',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-02-04 04:56:23','2026-02-04 04:56:23'),(255,'海带风味 大 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6976743871112','ean13','----5kYU9',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-02-04 05:11:31','2026-02-04 05:11:31'),(256,'香辣烤脖 35g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6945812400423','ean13','--35g--m2X0S',NULL,NULL,24,0,1,'prevent-sales',0,1,68,NULL,'2026-02-04 05:17:27','2026-02-04 05:17:27'),(257,'猪宝贝 16g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6975108703013','ean13','--16g--4sSUL',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-02-04 05:20:19','2026-02-04 05:20:19'),(258,'俏嘴巴 清水鱼 （12g * 20）盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6939936691942','ean13','--12g-20--WHOG5',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-02-04 05:24:35','2026-02-04 05:24:35'),(259,'魔芋爽 香辣素毛肚 （18g * 20）盒','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6935284400274','ean13','--18g-20--1AMmc',NULL,NULL,27,0,1,'prevent-sales',0,1,68,NULL,'2026-02-04 05:35:17','2026-02-04 05:35:17'),(260,'香酥麻花 80g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6926462621024','ean13','--80g--bASze',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-02-04 05:49:09','2026-02-04 05:49:09'),(261,'麦香鸡味块 32g 袋','inclusive',NULL,0,'product','materialized',0,1,'available','enabled','6933103400344','ean13','--32g--HXELO',NULL,NULL,25,0,1,'prevent-sales',0,1,68,NULL,'2026-02-04 05:54:51','2026-02-04 05:54:51');
/*!40000 ALTER TABLE `nexopos_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_products_categories`
--

DROP TABLE IF EXISTS `nexopos_products_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_products_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int DEFAULT '0',
  `media_id` int NOT NULL DEFAULT '0',
  `preview_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `displays_on_pos` tinyint(1) NOT NULL DEFAULT '1',
  `scale_range_id` bigint unsigned DEFAULT NULL,
  `total_items` int NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_products_categories`
--

LOCK TABLES `nexopos_products_categories` WRITE;
/*!40000 ALTER TABLE `nexopos_products_categories` DISABLE KEYS */;
INSERT INTO `nexopos_products_categories` VALUES (1,'饮料',0,0,'http://127.0.0.1:8000/storage/2026/01/508077.jpg',1,NULL,0,NULL,68,NULL,'2026-01-26 12:26:42','2026-01-26 12:26:42'),(2,'碳酸饮料',1,0,'http://127.0.0.1:8000/storage/2026/01/741313.jpg',1,NULL,5,NULL,68,NULL,'2026-01-30 11:43:15','2026-01-30 12:05:23'),(3,'茶饮料',1,0,NULL,1,NULL,13,NULL,68,NULL,'2026-01-30 11:43:52','2026-01-30 13:14:40'),(4,'果汁/果味饮料',1,0,NULL,1,NULL,6,NULL,68,NULL,'2026-01-30 11:44:32','2026-01-30 12:31:47'),(5,'功能 / 电解质饮料',1,0,NULL,1,NULL,7,NULL,68,NULL,'2026-01-30 11:45:06','2026-01-30 13:13:25'),(6,'含乳饮料',1,0,NULL,1,NULL,9,NULL,68,NULL,'2026-01-30 11:45:26','2026-01-31 06:49:46'),(7,'瓶装水',1,0,NULL,1,NULL,8,NULL,68,NULL,'2026-01-30 11:45:50','2026-01-30 13:26:51'),(8,'咖啡饮料',1,0,NULL,1,NULL,1,NULL,68,NULL,'2026-01-30 13:06:24','2026-01-30 13:07:34'),(9,'酒',NULL,0,NULL,1,NULL,0,NULL,68,NULL,'2026-01-30 13:31:41','2026-01-30 13:31:41'),(10,'白酒',9,0,NULL,1,NULL,14,NULL,68,NULL,'2026-01-30 13:31:59','2026-01-30 14:01:24'),(11,'啤酒',9,0,NULL,1,NULL,0,NULL,68,NULL,'2026-01-30 13:32:12','2026-01-30 13:32:12'),(12,'红酒',9,0,NULL,1,NULL,0,NULL,68,NULL,'2026-01-30 13:32:25','2026-01-30 13:32:25'),(13,'粮油干货',NULL,0,NULL,1,NULL,0,NULL,68,NULL,'2026-01-30 14:10:02','2026-01-30 14:10:02'),(14,'挂面',13,0,NULL,1,NULL,2,NULL,68,NULL,'2026-01-30 14:11:09','2026-01-30 14:19:35'),(15,'食用油',13,0,NULL,1,NULL,2,NULL,68,NULL,'2026-01-30 14:11:24','2026-01-30 14:16:25'),(16,'面粉/大米',13,0,NULL,1,NULL,3,NULL,68,NULL,'2026-01-30 14:11:43','2026-01-30 14:25:26'),(17,'调味品',13,0,NULL,1,NULL,27,NULL,68,NULL,'2026-01-30 14:12:16','2026-01-31 13:46:56'),(18,'日化用品',NULL,0,NULL,1,NULL,27,NULL,68,NULL,'2026-01-30 14:43:39','2026-01-31 11:56:29'),(19,'清洁洗涤',18,0,NULL,1,NULL,3,NULL,68,NULL,'2026-01-30 14:44:19','2026-01-30 14:53:53'),(20,'个人护理',18,0,NULL,1,NULL,14,NULL,68,NULL,'2026-01-30 14:44:43','2026-01-31 11:55:15'),(21,'消杀用品',18,0,NULL,1,NULL,1,NULL,68,NULL,'2026-01-30 14:45:14','2026-01-30 14:47:20'),(22,'茶叶冲调',NULL,0,NULL,1,NULL,4,NULL,68,NULL,'2026-01-30 14:57:07','2026-01-30 15:07:29'),(23,'休闲食品',NULL,0,NULL,1,NULL,0,NULL,68,NULL,'2026-01-31 05:21:02','2026-01-31 05:21:02'),(24,'方便速食',23,0,NULL,1,NULL,37,NULL,68,NULL,'2026-01-31 05:22:00','2026-02-04 05:17:28'),(25,'休闲零食',23,0,NULL,1,NULL,50,NULL,68,NULL,'2026-01-31 05:22:40','2026-02-04 05:54:51'),(26,'坚果炒货',23,0,NULL,1,NULL,12,NULL,68,NULL,'2026-01-31 05:23:09','2026-01-31 13:44:15'),(27,'辣条',23,0,NULL,1,NULL,34,NULL,68,NULL,'2026-01-31 06:28:20','2026-02-04 05:35:17');
/*!40000 ALTER TABLE `nexopos_products_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_products_galleries`
--

DROP TABLE IF EXISTS `nexopos_products_galleries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_products_galleries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` int NOT NULL,
  `media_id` int DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int NOT NULL DEFAULT '0',
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_products_galleries`
--

LOCK TABLES `nexopos_products_galleries` WRITE;
/*!40000 ALTER TABLE `nexopos_products_galleries` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_products_galleries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_products_histories`
--

DROP TABLE IF EXISTS `nexopos_products_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_products_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `procurement_id` int DEFAULT NULL,
  `procurement_product_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `order_product_id` int DEFAULT NULL,
  `operation_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_id` int NOT NULL,
  `before_quantity` float DEFAULT NULL,
  `quantity` float NOT NULL,
  `after_quantity` float DEFAULT NULL,
  `unit_price` float NOT NULL,
  `total_price` float NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_products_histories`
--

LOCK TABLES `nexopos_products_histories` WRITE;
/*!40000 ALTER TABLE `nexopos_products_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_products_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_products_histories_combined`
--

DROP TABLE IF EXISTS `nexopos_products_histories_combined`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_products_histories_combined` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `product_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `initial_quantity` double NOT NULL DEFAULT '0',
  `sold_quantity` double NOT NULL DEFAULT '0',
  `procured_quantity` double NOT NULL DEFAULT '0',
  `defective_quantity` double NOT NULL DEFAULT '0',
  `final_quantity` double NOT NULL DEFAULT '0',
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_products_histories_combined`
--

LOCK TABLES `nexopos_products_histories_combined` WRITE;
/*!40000 ALTER TABLE `nexopos_products_histories_combined` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_products_histories_combined` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_products_metas`
--

DROP TABLE IF EXISTS `nexopos_products_metas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_products_metas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_products_metas`
--

LOCK TABLES `nexopos_products_metas` WRITE;
/*!40000 ALTER TABLE `nexopos_products_metas` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_products_metas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_products_subitems`
--

DROP TABLE IF EXISTS `nexopos_products_subitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_products_subitems` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL,
  `product_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `unit_quantity_id` int NOT NULL,
  `sale_price` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `total_price` double NOT NULL DEFAULT '0',
  `author` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_products_subitems`
--

LOCK TABLES `nexopos_products_subitems` WRITE;
/*!40000 ALTER TABLE `nexopos_products_subitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_products_subitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_products_taxes`
--

DROP TABLE IF EXISTS `nexopos_products_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_products_taxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `unit_quantity_id` int NOT NULL,
  `tax_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` float NOT NULL,
  `value` float NOT NULL,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_products_taxes`
--

LOCK TABLES `nexopos_products_taxes` WRITE;
/*!40000 ALTER TABLE `nexopos_products_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_products_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_products_unit_quantities`
--

DROP TABLE IF EXISTS `nexopos_products_unit_quantities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_products_unit_quantities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'product',
  `preview_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `unit_id` int NOT NULL,
  `barcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scale_plu` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_weighable` tinyint(1) NOT NULL DEFAULT '0',
  `quantity` float NOT NULL,
  `low_quantity` float NOT NULL DEFAULT '0',
  `stock_alert_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `sale_price` float NOT NULL DEFAULT '0',
  `sale_price_edit` float NOT NULL DEFAULT '0',
  `sale_price_without_tax` float NOT NULL DEFAULT '0',
  `sale_price_with_tax` float NOT NULL DEFAULT '0',
  `sale_price_tax` float NOT NULL DEFAULT '0',
  `wholesale_price` float NOT NULL DEFAULT '0',
  `wholesale_price_edit` float NOT NULL DEFAULT '0',
  `wholesale_price_with_tax` float NOT NULL DEFAULT '0',
  `wholesale_price_without_tax` float NOT NULL DEFAULT '0',
  `wholesale_price_tax` float NOT NULL DEFAULT '0',
  `custom_price` float NOT NULL DEFAULT '0',
  `custom_price_edit` float NOT NULL DEFAULT '0',
  `custom_price_with_tax` float NOT NULL DEFAULT '0',
  `custom_price_without_tax` float NOT NULL DEFAULT '0',
  `custom_price_tax` float NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `convert_unit_id` int DEFAULT NULL,
  `linked_product_id` bigint unsigned DEFAULT NULL,
  `conversion_quantity` int NOT NULL DEFAULT '1',
  `cogs` double NOT NULL DEFAULT '0',
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nexopos_products_unit_quantities_scale_plu_unique` (`scale_plu`),
  KEY `nexopos_products_unit_quantities_linked_product_id_foreign` (`linked_product_id`),
  CONSTRAINT `nexopos_products_unit_quantities_linked_product_id_foreign` FOREIGN KEY (`linked_product_id`) REFERENCES `nexopos_products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_products_unit_quantities`
--

LOCK TABLES `nexopos_products_unit_quantities` WRITE;
/*!40000 ALTER TABLE `nexopos_products_unit_quantities` DISABLE KEYS */;
INSERT INTO `nexopos_products_unit_quantities` VALUES (1,1,'product','',NULL,1,'6954767412573-1',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 11:54:03','2026-01-30 11:54:03'),(2,2,'product','',NULL,1,'6954767413877-2',NULL,0,0,0,0,8,8,8,8,0,6.5,6.5,6.5,6.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 11:58:00','2026-01-30 11:58:00'),(3,3,'product','',NULL,1,'6936571951769-3',NULL,0,0,0,0,8,8,8,8,0,6.5,6.5,6.5,6.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 11:59:48','2026-01-30 12:00:31'),(4,4,'product','',NULL,1,'6936571910018-4',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:01:45','2026-01-30 12:01:45'),(5,5,'product','',NULL,1,'6954767433073-5',NULL,0,0,0,0,8,8,8,8,0,6.5,6.5,6.5,6.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:05:23','2026-01-30 12:05:23'),(6,6,'product','',NULL,1,'6944839998890-6',NULL,0,0,0,0,8,8,8,8,0,6.5,6.5,6.5,6.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:08:18','2026-01-30 12:08:18'),(7,7,'product','',NULL,1,'6944839989904-7',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:10:46','2026-01-30 12:10:46'),(8,8,'product','',NULL,1,'6944839905102-8',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:13:28','2026-01-30 12:13:28'),(9,9,'product','',NULL,1,'6954767400099-9',NULL,0,0,0,0,9,9,9,9,0,7,7,7,7,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:15:08','2026-01-30 12:15:08'),(10,10,'product','',NULL,1,'6944839998937-10',NULL,0,0,0,0,8,8,8,8,0,6.5,6.5,6.5,6.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:16:52','2026-01-30 12:16:52'),(11,11,'product','',NULL,1,'6901010101180-11',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:24:26','2026-01-30 12:24:27'),(12,12,'product','',NULL,1,'6920202888883-12',NULL,0,0,0,0,6,6,6,6,0,5,5,5,5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:25:35','2026-01-30 12:25:35'),(13,13,'product','',NULL,1,'6921168520015-13',NULL,0,0,0,0,4,4,4,4,0,2,2,2,2,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:28:15','2026-01-30 12:28:15'),(14,14,'product','',NULL,1,'6920459989371-14',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:31:47','2026-01-30 12:31:47'),(15,15,'product','',NULL,1,'06939729907793-15',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:33:41','2026-01-30 12:33:41'),(16,16,'product','',NULL,1,'6939729907793-16',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:34:15','2026-01-30 12:34:16'),(17,17,'product','',NULL,1,'6944839905010-17',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:35:28','2026-01-30 12:35:28'),(18,18,'product','',NULL,1,'6944839993796-18',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:42:32','2026-01-30 12:42:32'),(19,19,'product','',NULL,1,'6944839905164-19',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:43:37','2026-01-30 12:43:37'),(20,20,'product','',NULL,1,'6944839998432-20',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:44:54','2026-01-30 12:44:54'),(21,21,'product','',NULL,1,'6934502304745-21',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:50:33','2026-01-30 12:50:33'),(22,22,'product','',NULL,1,'6944839992065-22',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:51:58','2026-01-30 12:51:58'),(23,23,'product','',NULL,1,'6944839996360-23',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:52:54','2026-01-30 12:52:54'),(24,24,'product','',NULL,1,'6944839996506-24',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:54:15','2026-01-30 12:54:15'),(25,25,'product','',NULL,1,'6944839991983-25',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 12:55:05','2026-01-30 12:55:06'),(26,26,'product','',NULL,1,'6934502302277-26',NULL,0,0,0,0,6,6,6,6,0,5,5,5,5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:01:56','2026-01-30 13:01:56'),(27,27,'product','',NULL,1,'6934502302642-27',NULL,0,0,0,0,6,6,6,6,0,5,5,5,5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:03:00','2026-01-30 13:03:00'),(28,28,'product','',NULL,1,'6902083904685-28',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:05:10','2026-01-30 13:05:10'),(29,29,'product','',NULL,1,'6934502301812-29',NULL,0,0,0,0,7,7,7,7,0,6,6,6,6,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:07:34','2026-01-30 13:07:34'),(30,30,'product','',NULL,1,'6934502301850-30',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:09:07','2026-01-30 13:09:07'),(31,31,'product','',NULL,1,'6921168558049-31',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:10:35','2026-01-30 13:10:35'),(32,32,'product','',NULL,1,'6902538004045-32',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:12:00','2026-01-30 13:12:00'),(33,33,'product','',NULL,1,'6921168504022-33',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:13:25','2026-01-30 13:13:25'),(34,34,'product','',NULL,1,'6921168598427-34',NULL,0,0,0,0,7,7,7,7,0,6,6,6,6,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:14:40','2026-01-30 13:14:40'),(35,35,'product','',NULL,1,'6939729902255-35',NULL,0,0,0,0,2,2,2,2,0,1,1,1,1,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:17:39','2026-01-30 13:17:39'),(36,36,'product','',NULL,1,'6939729900039-36',NULL,0,0,0,0,2,2,2,2,0,1,1,1,1,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:20:31','2026-01-30 13:20:32'),(37,37,'product','',NULL,1,'6939729900008-37',NULL,0,0,0,0,2,2,2,2,0,1,1,1,1,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:21:11','2026-01-30 13:21:11'),(38,38,'product','',NULL,1,'6921168509256-38',NULL,0,0,0,0,2,2,2,2,0,1,1,1,1,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:22:24','2026-01-30 13:22:24'),(39,39,'product','',NULL,1,'6902083881405-39',NULL,0,0,0,0,2,2,2,2,0,1,1,1,1,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:23:50','2026-01-30 13:23:50'),(40,40,'product','',NULL,1,'6939729901388-40',NULL,0,0,0,0,1,1,1,1,0,0.6,0.6,0.6,0.6,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:25:28','2026-01-30 13:25:28'),(41,41,'product','',NULL,1,'6939729902941-41',NULL,0,0,0,0,3,3,3,3,0,2,2,2,2,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:26:51','2026-01-30 13:26:51'),(42,42,'product','',NULL,1,'6902083881085-42',NULL,0,0,0,0,2,2,2,2,0,1.5,1.5,1.5,1.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:28:18','2026-01-30 13:28:18'),(43,43,'product','',NULL,1,'6973752360897-43',NULL,0,0,0,0,2,2,2,2,0,1,1,1,1,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:34:26','2026-01-30 13:34:26'),(44,44,'product','',NULL,1,'6972119550360-44',NULL,0,0,0,0,20,20,20,20,0,16,16,16,16,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:35:56','2026-01-30 13:35:56'),(45,45,'product','',NULL,1,'6028461392995-45',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:37:11','2026-01-30 13:37:11'),(46,46,'product','',NULL,1,'6951075601927-46',NULL,0,0,0,0,25,25,25,25,0,18,18,18,18,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:38:27','2026-01-30 13:38:27'),(47,47,'product','',NULL,1,'6906151600462-47',NULL,0,0,0,0,15,15,15,15,0,12,12,12,12,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:39:40','2026-01-30 13:39:40'),(48,48,'product','',NULL,1,'6902212024789-48',NULL,0,0,0,0,35,35,35,35,0,25,25,25,25,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:45:36','2026-01-30 13:45:36'),(49,49,'product','',NULL,1,'6903431119546-49',NULL,0,0,0,0,58,58,58,58,0,55,55,55,55,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:46:58','2026-01-30 13:46:58'),(50,50,'product','',NULL,1,'6972119553576-50',NULL,0,0,0,0,63,63,63,63,0,57,57,57,57,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:49:03','2026-01-30 13:49:03'),(51,51,'product','',NULL,1,'6972119554221-51',NULL,0,0,0,0,58,58,58,58,0,55,55,55,55,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:50:06','2026-01-30 13:50:06'),(52,52,'product','',NULL,1,'6906151625816-52',NULL,0,0,0,0,35,35,35,35,0,20,20,20,20,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:55:17','2026-01-30 13:55:17'),(53,53,'product','',NULL,1,'6906151630513-53',NULL,0,0,0,0,25,25,25,25,0,20,20,20,20,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:56:05','2026-01-30 13:56:05'),(54,54,'product','',NULL,1,'6973695390098-54',NULL,0,0,0,0,58,58,58,58,0,55,55,55,55,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:58:09','2026-01-30 13:58:09'),(55,55,'product','',NULL,1,'6978587459969-55',NULL,0,0,0,0,25,25,25,25,0,18,18,18,18,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 13:59:50','2026-01-30 13:59:50'),(56,56,'product','',NULL,1,'6925923570413-56',NULL,0,0,0,0,20,20,20,20,0,18,18,18,18,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:01:23','2026-01-30 14:01:23'),(57,57,'product','',NULL,1,'6933664902394-57',NULL,0,0,0,0,70,70,70,70,0,60,60,60,60,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:14:10','2026-01-30 14:14:10'),(58,58,'product','',NULL,1,'6948195804758-58',NULL,0,0,0,0,60,60,60,60,0,52,52,52,52,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:16:25','2026-01-30 14:16:25'),(59,59,'product','',NULL,1,'6932759750025-59',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:18:02','2026-01-30 14:19:55'),(60,60,'product','',NULL,1,'6941473524126-60',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:19:35','2026-01-30 14:19:35'),(61,61,'product','',NULL,1,'6934468005618-61',NULL,0,0,0,0,95,95,95,95,0,83,83,83,83,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:22:21','2026-01-30 14:22:21'),(62,62,'product','',NULL,1,'6971142200006-62',NULL,0,0,0,0,105,105,105,105,0,100,100,100,100,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:23:40','2026-01-30 14:23:40'),(63,63,'product','',NULL,1,'6940067600123-63',NULL,0,0,0,0,35,35,35,35,0,30,30,30,30,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:25:26','2026-01-30 14:25:26'),(64,64,'product','',NULL,1,'6902265803218-64',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:29:29','2026-01-30 14:29:29'),(65,65,'product','',NULL,1,'6902265360018-65',NULL,0,0,0,0,9,9,9,9,0,6,6,6,6,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:30:49','2026-01-30 14:30:49'),(66,66,'product','',NULL,1,'6902265503514-66',NULL,0,0,0,0,10,10,10,10,0,7,7,7,7,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:31:49','2026-01-30 14:31:49'),(67,67,'product','',NULL,1,'6972107853039-67',NULL,0,0,0,0,6,6,6,6,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:34:08','2026-01-30 14:34:08'),(68,68,'product','',NULL,1,'6902265501213-68',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:35:37','2026-01-30 14:35:38'),(69,69,'product','',NULL,1,'6902265501114-69',NULL,0,0,0,0,5,5,5,5,0,3.5,3.5,3.5,3.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:36:41','2026-01-30 14:36:41'),(70,70,'product','',NULL,1,'6926034406462-70',NULL,0,0,0,0,4,4,4,4,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:40:01','2026-01-30 14:40:01'),(71,71,'product','',NULL,1,'6902265452218-71',NULL,0,0,0,0,5,5,5,5,0,3,3,3,3,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:41:11','2026-01-30 14:41:11'),(72,72,'product','',NULL,1,'6951667000084-72',NULL,0,0,0,0,3,3,3,3,0,1.5,1.5,1.5,1.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:47:20','2026-01-30 14:47:20'),(73,73,'product','',NULL,1,'6910019001841-73',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:48:33','2026-01-30 14:48:33'),(74,74,'product','',NULL,1,'6910019010928-74',NULL,0,0,0,0,15,15,15,15,0,10,10,10,10,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:49:28','2026-01-30 14:49:28'),(75,75,'product','',NULL,1,'6920174754483-75',NULL,0,0,0,0,12,12,12,12,0,8,8,8,8,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 14:53:52','2026-01-30 14:53:52'),(76,76,'product','',NULL,1,'6976343190026-76',NULL,0,0,0,0,19,19,19,19,0,16,16,16,16,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 15:00:04','2026-01-30 15:00:40'),(77,77,'product','',NULL,1,'6976343190118-77',NULL,0,0,0,0,24,24,24,24,0,22,22,22,22,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 15:02:30','2026-01-30 15:05:03'),(78,78,'product','',NULL,1,'6977335290038-78',NULL,0,0,0,0,25,25,25,25,0,22,22,22,22,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 15:06:10','2026-01-30 15:06:10'),(79,79,'product','',NULL,1,'6977335290014-79',NULL,0,0,0,0,20,20,20,20,0,16,16,16,16,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-30 15:07:29','2026-01-30 15:07:48'),(80,80,'product','',NULL,1,'6921774200776-80',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:25:51','2026-01-31 05:25:51'),(81,81,'product','',NULL,1,'6921774204378-81',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:26:52','2026-01-31 05:26:52'),(82,82,'product','',NULL,1,'6921774214070-82',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:28:01','2026-01-31 05:28:01'),(83,83,'product','',NULL,1,'6937962111649-83',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:29:18','2026-01-31 05:29:18'),(84,84,'product','',NULL,1,'6937962134631-84',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:30:21','2026-01-31 05:30:21'),(85,85,'product','',NULL,1,'6921774241540-85',NULL,0,0,0,0,5,5,5,5,0,4,4,4,4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:31:28','2026-01-31 05:31:28'),(86,86,'product','',NULL,1,'6921774260862-86',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:34:44','2026-01-31 05:34:44'),(87,87,'product','',NULL,1,'6921774260060-87',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:35:39','2026-01-31 05:35:39'),(88,88,'product','',NULL,1,'6921774297349-88',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:36:42','2026-01-31 05:36:43'),(89,89,'product','',NULL,1,'6921774275095-89',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:37:47','2026-01-31 05:37:47'),(90,90,'product','',NULL,1,'6938957107586-90',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:40:54','2026-01-31 05:41:15'),(91,91,'product','',NULL,1,'6977176952713-91',NULL,0,0,0,0,6,6,6,6,0,5,5,5,5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:43:03','2026-01-31 05:43:03'),(92,92,'product','',NULL,1,'6977176952683-92',NULL,0,0,0,0,6,6,6,6,0,5,5,5,5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:44:36','2026-01-31 05:44:37'),(93,93,'product','',NULL,1,'6938957106688-93',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:48:07','2026-01-31 05:48:07'),(94,94,'product','',NULL,1,'6938957104561-94',NULL,0,0,0,0,2,2,2,2,0,1.5,1.5,1.5,1.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:50:08','2026-01-31 05:50:08'),(95,95,'product','',NULL,1,'6922444636505-95',NULL,0,0,0,0,1.5,1.5,1.5,1.5,0,1.2,1.2,1.2,1.2,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:51:48','2026-01-31 05:51:48'),(96,96,'product','',NULL,1,'6933103400023-96',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:53:17','2026-01-31 05:53:17'),(97,97,'product','',NULL,1,'6923775916823-97',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:54:59','2026-01-31 05:54:59'),(98,98,'product','',NULL,1,'6936615701671-98',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 05:56:16','2026-01-31 05:56:16'),(99,99,'product','',NULL,1,'6933103407664-99',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:00:28','2026-01-31 06:00:28'),(100,100,'product','',NULL,1,'6970532806569-100',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:01:36','2026-01-31 06:01:36'),(101,101,'product','',NULL,1,'6934159504864-101',NULL,0,0,0,0,4,4,4,4,0,3,3,3,3,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:02:59','2026-01-31 06:03:00'),(102,102,'product','',NULL,1,'6926237032062-102',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:04:12','2026-01-31 06:04:12'),(103,103,'product','',NULL,1,'6970716698010-103',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:05:04','2026-01-31 06:05:04'),(104,104,'product','',NULL,1,'6970061702059-104',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:07:34','2026-01-31 06:07:34'),(105,105,'product','',NULL,1,'6920189004290-105',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:09:51','2026-01-31 06:09:51'),(106,106,'product','',NULL,1,'6920189007604-106',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:11:22','2026-01-31 06:11:22'),(107,107,'product','',NULL,1,'6923644264987-107',NULL,0,0,0,0,40,40,40,40,0,35,35,35,35,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:17:08','2026-01-31 06:17:08'),(108,108,'product','',NULL,1,'6923644266318-108',NULL,0,0,0,0,55,55,55,55,0,40,40,40,40,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:18:45','2026-01-31 06:18:45'),(109,109,'product','',NULL,1,'6901180964585-109',NULL,0,0,0,0,15,15,15,15,0,13,13,13,13,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:23:51','2026-01-31 06:23:51'),(110,110,'product','',NULL,1,'6901180339581-110',NULL,0,0,0,0,3,3,3,3,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:24:55','2026-01-31 06:24:55'),(111,111,'product','',NULL,1,'6946362500021-111',NULL,0,0,0,0,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:29:27','2026-02-04 03:46:02'),(112,112,'product','',NULL,1,'6956406200046-112',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:30:28','2026-02-04 03:47:03'),(113,113,'product','',NULL,1,'6973067146667-113',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:31:18','2026-02-04 03:47:50'),(114,114,'product','',NULL,1,'6931615505144-114',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:32:25','2026-01-31 06:32:25'),(115,115,'product','',NULL,1,'6938888888615-115',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:34:00','2026-02-04 04:00:05'),(117,116,'product','',NULL,7,'6938888888042-117',NULL,0,0,0,0,15,15,15,15,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:40:03','2026-02-04 04:00:52'),(118,117,'product','',NULL,1,'6931615506936-118',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:42:27','2026-01-31 06:42:27'),(119,118,'product','',NULL,1,'6928493701409-119',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:46:26','2026-01-31 06:46:26'),(120,119,'product','',NULL,1,'6938888888868-120',NULL,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:47:52','2026-02-04 04:15:12'),(121,120,'product','',NULL,1,'6938888888844-121',NULL,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:48:48','2026-02-04 04:25:07'),(122,121,'product','',NULL,1,'6938888888813-122',NULL,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:49:46','2026-02-04 04:25:41'),(123,122,'product','',NULL,1,'6970500750047-123',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:50:48','2026-01-31 06:50:48'),(124,123,'product','',NULL,1,'6920132710414-124',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:53:04','2026-01-31 06:53:04'),(125,124,'product','',NULL,1,'6911988009777-125',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:53:58','2026-01-31 06:53:58'),(126,125,'product','',NULL,1,'6911988006547-126',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:55:15','2026-01-31 06:55:15'),(127,126,'product','',NULL,1,'6911988006554-127',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:56:00','2026-01-31 06:56:00'),(128,127,'product','',NULL,1,'6911988006523-128',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:56:47','2026-01-31 06:56:47'),(129,128,'product','',NULL,1,'6901668935724-129',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 06:58:26','2026-01-31 06:58:26'),(130,129,'product','',NULL,1,'6911988009784-130',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:04:08','2026-01-31 07:04:08'),(131,130,'product','',NULL,1,'6971039920017-131',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:05:42','2026-02-04 05:46:57'),(132,131,'product','',NULL,1,'6972257010009-132',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:07:28','2026-01-31 07:07:28'),(133,132,'product','',NULL,1,'6973057210019-133',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:11:34','2026-01-31 07:11:34'),(134,133,'product','',NULL,1,'6936003512414-134',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:13:32','2026-01-31 07:13:32'),(135,134,'product','',NULL,1,'6928498300164-135',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:14:54','2026-01-31 07:14:54'),(136,135,'product','',NULL,1,'6930742600975-136',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:15:55','2026-01-31 07:15:55'),(137,136,'product','',NULL,1,'6905418008782-137',NULL,0,0,0,0,4,4,4,4,0,3,3,3,3,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:16:51','2026-02-04 05:52:20'),(138,137,'product','',NULL,1,'6926475200155-138',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:17:54','2026-01-31 07:17:54'),(139,138,'product','',NULL,1,'6926475202449-139',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:18:48','2026-01-31 07:18:48'),(140,139,'product','',NULL,1,'6941158700197-140',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:20:11','2026-01-31 07:20:11'),(141,140,'product','',NULL,1,'6923236120332-141',NULL,0,0,0,0,1,1,1,1,0,0.7,0.7,0.7,0.7,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:21:25','2026-02-04 05:44:00'),(142,141,'product','',NULL,1,'6939936691812-142',NULL,0,0,0,0,1,1,1,1,0,0.7,0.7,0.7,0.7,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:22:14','2026-02-04 05:22:15'),(143,142,'product','',NULL,1,'6935284400236-143',NULL,0,0,0,0,1,1,1,1,0,0.7,0.7,0.7,0.7,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:26:32','2026-02-04 05:29:03'),(144,143,'product','',NULL,1,'6974564330481-144',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:27:57','2026-01-31 07:28:07'),(145,144,'product','',NULL,1,'6931754806362-145',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:29:39','2026-01-31 07:29:39'),(146,145,'product','',NULL,1,'6955908873772-146',NULL,0,0,0,0,1,1,1,1,0,0.75,0.75,0.75,0.75,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:30:47','2026-02-04 05:06:25'),(147,146,'product','',NULL,1,'6974085080940-147',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:31:35','2026-01-31 07:31:36'),(148,147,'product','',NULL,1,'6925678121373-148',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:32:43','2026-01-31 07:32:43'),(149,148,'product','',NULL,1,'6954446301464-149',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:33:43','2026-01-31 07:33:43'),(150,149,'product','',NULL,1,'6922170805404-150',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:34:57','2026-01-31 07:34:57'),(151,150,'product','',NULL,1,'6922354299876-151',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:35:58','2026-01-31 07:35:58'),(152,151,'product','',NULL,1,'6927460300270-152',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:37:38','2026-01-31 07:37:38'),(153,152,'product','',NULL,1,'6939424701870-153',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:38:55','2026-01-31 07:38:55'),(154,153,'product','',NULL,1,'6925678112821-154',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:39:57','2026-01-31 07:39:57'),(155,154,'product','',NULL,1,'6944556200191-155',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:40:56','2026-01-31 07:40:56'),(156,155,'product','',NULL,1,'6923663963854-156',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:49:36','2026-01-31 07:49:36'),(157,156,'product','',NULL,1,'6953442900046-157',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:51:17','2026-01-31 07:51:17'),(158,157,'product','',NULL,1,'6971689220000-158',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:52:09','2026-01-31 07:52:09'),(159,158,'product','',NULL,1,'6920293900006-159',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:53:49','2026-01-31 07:53:49'),(160,159,'product','',NULL,1,'6971623401649-160',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:54:55','2026-01-31 07:54:55'),(161,160,'product','',NULL,1,'6923407683819-161',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:55:49','2026-01-31 07:55:49'),(162,161,'product','',NULL,1,'6934937600016-162',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:56:43','2026-01-31 07:56:43'),(163,162,'product','',NULL,1,'6940496400035-163',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:57:49','2026-01-31 07:57:49'),(164,163,'product','',NULL,1,'6970248101750-164',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 07:59:26','2026-01-31 07:59:26'),(165,164,'product','',NULL,1,'6938350838889-165',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:00:49','2026-01-31 08:00:49'),(166,165,'product','',NULL,1,'6976743879996-166',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0.35,0.35,0.35,0.35,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:02:15','2026-02-04 05:13:59'),(167,166,'product','',NULL,1,'6976743870009-167',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0.35,0.35,0.35,0.35,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:03:02','2026-02-04 05:14:45'),(168,167,'product','',NULL,1,'6931031700239-168',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:03:50','2026-01-31 08:03:50'),(169,168,'product','',NULL,1,'6970150720087-169',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:04:57','2026-01-31 08:04:57'),(170,169,'product','',NULL,1,'6917878131504-170',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:10:09','2026-01-31 08:10:09'),(171,170,'product','',NULL,1,'6971876550095-171',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:12:05','2026-01-31 08:12:05'),(172,171,'product','',NULL,1,'6924097902259-172',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:13:19','2026-01-31 08:13:19'),(173,172,'product','',NULL,1,'6922839113918-173',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:14:26','2026-01-31 08:14:26'),(174,173,'product','',NULL,1,'6906496030634-174',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:15:41','2026-01-31 08:15:41'),(175,174,'product','',NULL,1,'6972771420117-175',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:16:44','2026-01-31 08:16:44'),(176,175,'product','',NULL,1,'6921299762018-176',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:17:54','2026-01-31 08:17:54'),(177,176,'product','',NULL,1,'6921299762834-177',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:18:41','2026-01-31 08:18:41'),(178,177,'product','',NULL,1,'6920952712087-178',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:21:31','2026-01-31 08:21:31'),(179,178,'product','',NULL,1,'6911316600409-179',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:22:43','2026-01-31 08:22:43'),(180,179,'product','',NULL,9,'6959766200497-180',NULL,0,0,0,0,20,20,20,20,0,16,16,16,16,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:33:27','2026-01-31 08:33:42'),(181,180,'product','',NULL,10,'6937192131103-181',NULL,0,0,0,0,22,22,22,22,0,16,16,16,16,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:37:13','2026-01-31 08:37:13'),(182,181,'product','',NULL,9,'6922773603346-182',NULL,0,0,0,0,25,25,25,25,0,20,20,20,20,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:42:16','2026-01-31 08:42:16'),(183,182,'product','',NULL,1,'6922773602073-183',NULL,0,0,0,0,2,2,2,2,0,1.5,1.5,1.5,1.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 08:47:08','2026-01-31 08:47:08'),(184,183,'product','',NULL,1,'6901377001000-184',NULL,0,0,0,0,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:35:44','2026-01-31 10:40:21'),(185,184,'product','',NULL,1,'6926198012233-185',NULL,0,0,0,0,1.5,1.5,1.5,1.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:37:01','2026-01-31 10:40:44'),(186,185,'product','',NULL,1,'6906303888885-186',NULL,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:38:19','2026-01-31 10:38:19'),(187,186,'product','',NULL,1,'6922130101188-187',NULL,0,0,0,0,6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:39:51','2026-01-31 10:39:51'),(188,187,'product','',NULL,1,'6917403341187-188',NULL,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:42:34','2026-01-31 10:42:34'),(189,188,'product','',NULL,1,'6917403000138-189',NULL,0,0,0,0,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:43:42','2026-01-31 10:43:42'),(190,189,'product','',NULL,1,'6917403241180-190',NULL,0,0,0,0,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:44:28','2026-01-31 10:44:28'),(191,190,'product','',NULL,1,'6930342500200-191',NULL,0,0,0,0,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:46:06','2026-01-31 10:46:06'),(192,191,'product','',NULL,1,'6917790975323-192',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:57:32','2026-01-31 10:57:32'),(193,192,'product','',NULL,1,'6933453800078-193',NULL,0,0,0,0,13,13,13,13,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:58:31','2026-01-31 10:58:31'),(194,193,'product','',NULL,1,'6971074000316-194',NULL,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 10:59:58','2026-01-31 10:59:58'),(195,194,'product','',NULL,1,'6977226041626-195',NULL,0,0,0,0,10,10,10,10,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:01:22','2026-01-31 11:01:22'),(196,195,'product','',NULL,1,'6971071890088-196',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:02:42','2026-01-31 11:02:42'),(197,196,'product','',NULL,1,'6927687211151-197',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:03:34','2026-01-31 11:03:34'),(198,197,'product','',NULL,1,'6903148144541-198',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:08:49','2026-01-31 11:08:49'),(199,198,'product','',NULL,1,'6903148144442-199',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:09:51','2026-01-31 11:09:52'),(200,199,'product','',NULL,1,'6903148145593-200',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:11:44','2026-01-31 11:11:44'),(201,200,'product','',NULL,1,'6930114355007-201',NULL,0,0,0,0,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:13:08','2026-01-31 11:13:08'),(202,201,'product','',NULL,1,'6930114352068-202',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:14:16','2026-01-31 11:14:16'),(203,202,'product','',NULL,1,'6903148015834-203',NULL,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:16:35','2026-01-31 11:22:19'),(204,203,'product','',NULL,1,'6902132007060-204',NULL,0,0,0,0,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:18:08','2026-01-31 11:23:00'),(205,204,'product','',NULL,1,'4891338005692-205',NULL,0,0,0,0,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:19:05','2026-01-31 11:23:21'),(206,205,'product','',NULL,1,'5060106815668-206',NULL,0,0,0,0,16,16,16,16,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:20:10','2026-01-31 11:23:38'),(207,206,'product','',NULL,1,'6901070600111-207',NULL,0,0,0,0,20,20,20,20,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:21:50','2026-01-31 11:21:50'),(208,207,'product','',NULL,1,'6903148225813-208',NULL,0,0,0,0,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:25:25','2026-01-31 11:25:25'),(209,208,'product','',NULL,1,'6903148225790-209',NULL,0,0,0,0,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:28:49','2026-01-31 11:28:49'),(210,209,'product','',NULL,1,'6976114861902-210',NULL,0,0,0,0,22,22,22,22,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:36:04','2026-01-31 11:36:04'),(211,210,'product','',NULL,1,'6941402408039-211',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:41:16','2026-01-31 11:41:16'),(212,211,'product','',NULL,1,'6923450605660-212',NULL,0,0,0,0,2.5,2.5,2.5,2.5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:43:03','2026-01-31 11:43:03'),(213,212,'product','',NULL,1,'6923450614938-213',NULL,0,0,0,0,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:43:55','2026-01-31 11:43:55'),(214,213,'product','',NULL,1,'6902774349016-214',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:44:50','2026-01-31 11:44:50'),(215,214,'product','',NULL,1,'6970208389914-215',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:47:31','2026-01-31 11:47:31'),(216,215,'product','',NULL,1,'6976088420020-216',NULL,0,0,0,0,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:53:37','2026-01-31 11:53:37'),(217,216,'product','',NULL,1,'6971549310018-217',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:55:15','2026-01-31 11:55:15'),(218,217,'product','',NULL,1,'6957098700111-218',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 11:56:28','2026-01-31 11:56:29'),(219,218,'product','',NULL,1,'6978370090027-219',NULL,0,0,0,0,1,1,1,1,0,0.9,0.9,0.9,0.9,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:02:21','2026-02-04 05:42:17'),(220,219,'product','',NULL,1,'6971772150092-220',NULL,0,0,0,0,1,1,1,1,0,0.75,0.75,0.75,0.75,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:03:21','2026-01-31 12:03:21'),(221,220,'product','',NULL,1,'6977367570306-221',NULL,0,0,0,0,1,1,1,1,0,0.7,0.7,0.7,0.7,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:04:07','2026-02-04 05:25:59'),(222,221,'product','',NULL,1,'6924187832657-222',NULL,0,0,0,0,8,8,8,8,0,7,7,7,7,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:05:04','2026-02-04 04:59:55'),(223,222,'product','',NULL,1,'6924714888065-223',NULL,0,0,0,0,5,5,5,5,0,4.5,4.5,4.5,4.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:05:57','2026-02-04 05:02:37'),(224,223,'product','',NULL,1,'6952339210800-224',NULL,0,0,0,0,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:06:38','2026-01-31 12:06:38'),(225,224,'product','',NULL,1,'6922133602965-225',NULL,0,0,0,0,6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:07:57','2026-01-31 12:07:57'),(226,225,'product','',NULL,1,'6978205940022-226',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:09:16','2026-01-31 12:09:16'),(227,226,'product','',NULL,1,'6978205940015-227',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:10:35','2026-01-31 12:10:35'),(228,227,'product','',NULL,1,'6950155100640-228',NULL,0,0,0,0,1,1,1,1,0,0.8,0.8,0.8,0.8,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:16:59','2026-01-31 12:16:59'),(229,228,'product','',NULL,1,'6950155100077-229',NULL,0,0,0,0,1,1,1,1,0,0.8,0.8,0.8,0.8,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 12:18:53','2026-01-31 12:18:53'),(230,229,'product','',NULL,1,'6902890274070-230',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:19:47','2026-01-31 13:19:47'),(231,230,'product','',NULL,1,'6902890235958-231',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:21:17','2026-01-31 13:21:17'),(232,231,'product','',NULL,1,'6902890229360-232',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:22:10','2026-01-31 13:22:10'),(233,232,'product','',NULL,1,'6972153271207-233',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:23:30','2026-01-31 13:23:30'),(234,233,'product','',NULL,1,'6972153270026-234',NULL,0,0,0,0,1,1,1,1,0,0.7,0.7,0.7,0.7,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:24:40','2026-02-04 05:27:48'),(235,234,'product','',NULL,1,'6927460319074-235',NULL,0,0,0,0,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:25:48','2026-01-31 13:25:48'),(236,235,'product','',NULL,1,'6952339230167-236',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:27:08','2026-01-31 13:27:08'),(237,236,'product','',NULL,1,'6923426700696-237',NULL,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:28:46','2026-01-31 13:28:46'),(238,237,'product','',NULL,1,'6959203900621-238',NULL,0,0,0,0,1,1,1,1,0,0.8,0.8,0.8,0.8,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:30:20','2026-02-04 05:39:15'),(239,238,'product','',NULL,1,'6959203900041-239',NULL,0,0,0,0,1,1,1,1,0,0.8,0.8,0.8,0.8,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:31:29','2026-02-04 05:38:44'),(240,239,'product','',NULL,1,'6901754220802-240',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:33:30','2026-01-31 13:33:30'),(241,240,'product','',NULL,1,'6952339230181-241',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:34:49','2026-01-31 13:34:49'),(242,241,'product','',NULL,1,'6952339230174-242',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:35:44','2026-01-31 13:35:44'),(243,242,'product','',NULL,1,'6936402300209-243',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:39:19','2026-01-31 13:39:19'),(244,243,'product','',NULL,1,'6970580810242-244',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:40:33','2026-01-31 13:40:33'),(245,244,'product','',NULL,1,'6971527830026-245',NULL,0,0,0,0,2,2,2,2,0,1.5,1.5,1.5,1.5,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:41:59','2026-02-04 05:38:12'),(246,245,'product','',NULL,1,'6932262200185-246',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:42:57','2026-01-31 13:42:57'),(247,246,'product','',NULL,1,'6973464340613-247',NULL,0,0,0,0,6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:44:15','2026-01-31 13:44:15'),(248,247,'product','',NULL,1,'6933770863107-248',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:45:37','2026-01-31 13:45:38'),(249,248,'product','',NULL,1,'6924311514138-249',NULL,0,0,0,0,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:46:56','2026-01-31 13:46:56'),(250,249,'product','',NULL,1,'6971079290569-250',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:49:41','2026-01-31 13:49:41'),(251,250,'product','',NULL,1,'6930484442017-251',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:50:27','2026-01-31 13:50:28'),(252,251,'product','',NULL,1,'6930484442031-252',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:51:07','2026-01-31 13:51:08'),(253,252,'product','',NULL,1,'6930484442024-253',NULL,0,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-01-31 13:51:56','2026-01-31 13:51:56'),(254,253,'product','',NULL,12,'6922444636659-254',NULL,0,0,0,0,75,75,75,75,0,60,60,60,60,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-02-04 04:48:44','2026-02-04 04:48:44'),(255,254,'product','',NULL,13,'6920189004337-255',NULL,0,0,0,0,40,40,40,40,0,32,32,32,32,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-02-04 04:56:23','2026-02-04 04:56:23'),(256,255,'product','',NULL,1,'6976743871112-256',NULL,0,0,0,0,1,1,1,1,0,0.75,0.75,0.75,0.75,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-02-04 05:11:31','2026-02-04 05:11:31'),(257,256,'product','',NULL,1,'6945812400423-257',NULL,0,0,0,0,1,1,1,1,0,0.8,0.8,0.8,0.8,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-02-04 05:17:27','2026-02-04 05:17:27'),(258,257,'product','',NULL,1,'6975108703013-258',NULL,0,0,0,0,0.5,0.5,0.5,0.5,0,0.4,0.4,0.4,0.4,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-02-04 05:20:19','2026-02-04 05:20:19'),(260,258,'product','',NULL,14,'6939936691942-260',NULL,0,0,0,0,20,20,20,20,0,14,14,14,14,0,0,0,0,0,0,1,NULL,141,1,0,NULL,'2026-02-04 05:34:22','2026-02-04 11:56:14'),(261,259,'product','',NULL,14,'6935284400274-261',NULL,0,0,0,0,20,20,20,20,0,14,14,14,14,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-02-04 05:35:17','2026-02-04 05:35:17'),(262,260,'product','',NULL,1,'6926462621024-262',NULL,0,0,0,0,3,3,3,3,0,2.3,2.3,2.3,2.3,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-02-04 05:49:09','2026-02-04 05:49:09'),(263,261,'product','',NULL,1,'6933103400344-263',NULL,0,0,0,0,1,1,1,1,0,0.8,0.8,0.8,0.8,0,0,0,0,0,0,1,NULL,NULL,1,0,NULL,'2026-02-04 05:54:51','2026-02-04 05:54:51');
/*!40000 ALTER TABLE `nexopos_products_unit_quantities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_providers`
--

DROP TABLE IF EXISTS `nexopos_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_providers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `amount_due` float NOT NULL DEFAULT '0',
  `amount_paid` float NOT NULL DEFAULT '0',
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nexopos_providers_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_providers`
--

LOCK TABLES `nexopos_providers` WRITE;
/*!40000 ALTER TABLE `nexopos_providers` DISABLE KEYS */;
INSERT INTO `nexopos_providers` VALUES (1,'洪钦','毕',NULL,'13992186064',NULL,NULL,68,NULL,0,0,NULL,'2026-01-26 12:57:57','2026-01-26 12:57:57');
/*!40000 ALTER TABLE `nexopos_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_registers`
--

DROP TABLE IF EXISTS `nexopos_registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_registers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'closed',
  `description` text COLLATE utf8mb4_unicode_ci,
  `used_by` int DEFAULT NULL,
  `author` int NOT NULL,
  `balance` float NOT NULL DEFAULT '0',
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_registers`
--

LOCK TABLES `nexopos_registers` WRITE;
/*!40000 ALTER TABLE `nexopos_registers` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_registers_history`
--

DROP TABLE IF EXISTS `nexopos_registers_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_registers_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `register_id` int NOT NULL,
  `payment_id` int DEFAULT NULL,
  `payment_type_id` int NOT NULL DEFAULT '0',
  `order_id` int DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` int NOT NULL,
  `value` float NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance_before` float NOT NULL DEFAULT '0',
  `transaction_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance_after` float NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_registers_history`
--

LOCK TABLES `nexopos_registers_history` WRITE;
/*!40000 ALTER TABLE `nexopos_registers_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_registers_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_rewards_system`
--

DROP TABLE IF EXISTS `nexopos_rewards_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_rewards_system` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `author` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` float NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `coupon_id` int DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_rewards_system`
--

LOCK TABLES `nexopos_rewards_system` WRITE;
/*!40000 ALTER TABLE `nexopos_rewards_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_rewards_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_rewards_system_rules`
--

DROP TABLE IF EXISTS `nexopos_rewards_system_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_rewards_system_rules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from` float NOT NULL,
  `to` float NOT NULL,
  `reward` float NOT NULL,
  `reward_id` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_rewards_system_rules`
--

LOCK TABLES `nexopos_rewards_system_rules` WRITE;
/*!40000 ALTER TABLE `nexopos_rewards_system_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_rewards_system_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_role_permission`
--

DROP TABLE IF EXISTS `nexopos_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_role_permission` (
  `permission_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_role_permission`
--

LOCK TABLES `nexopos_role_permission` WRITE;
/*!40000 ALTER TABLE `nexopos_role_permission` DISABLE KEYS */;
INSERT INTO `nexopos_role_permission` VALUES (1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,1),(10,2),(10,3),(10,4),(10,5),(11,2),(12,2),(13,2),(13,3),(13,4),(13,5),(14,2),(15,2),(16,2),(17,2),(18,2),(18,3),(19,2),(19,3),(20,2),(20,3),(21,2),(21,3),(22,2),(22,3),(23,2),(23,3),(24,2),(24,3),(25,2),(25,3),(26,2),(26,3),(27,2),(27,3),(27,4),(28,2),(28,3),(29,2),(29,3),(30,2),(30,3),(31,2),(31,3),(32,2),(32,3),(33,2),(33,3),(34,2),(34,3),(35,2),(35,3),(36,2),(36,3),(37,2),(37,3),(38,2),(38,3),(39,2),(39,3),(40,2),(40,3),(41,2),(41,3),(42,2),(42,3),(43,2),(43,3),(44,2),(44,3),(45,2),(45,3),(46,2),(46,3),(47,2),(47,3),(48,2),(48,3),(48,4),(49,2),(49,3),(50,2),(50,3),(50,4),(51,2),(51,3),(51,4),(52,2),(52,3),(52,4),(53,2),(53,3),(53,4),(54,2),(54,3),(54,4),(55,2),(55,3),(56,2),(56,3),(57,2),(57,3),(58,2),(58,3),(59,2),(59,3),(60,2),(60,3),(61,2),(61,3),(62,2),(62,3),(63,2),(63,3),(64,2),(64,3),(65,2),(65,3),(66,2),(66,3),(67,2),(67,3),(68,2),(68,3),(69,2),(69,3),(70,2),(70,3),(71,2),(71,3),(72,2),(72,3),(73,2),(73,3),(74,2),(74,3),(75,2),(75,3),(76,2),(76,3),(77,2),(77,3),(78,2),(78,3),(79,2),(79,3),(80,2),(80,3),(81,2),(81,3),(82,2),(82,3),(83,2),(83,3),(84,2),(84,3),(85,2),(85,3),(86,2),(86,3),(87,2),(87,3),(88,2),(88,3),(89,2),(89,3),(90,2),(90,3),(91,2),(91,3),(92,2),(92,3),(93,2),(93,3),(94,2),(94,3),(95,2),(95,3),(96,2),(96,3),(97,2),(97,3),(98,2),(98,3),(99,2),(99,3),(100,2),(100,3),(100,4),(101,2),(101,3),(101,4),(102,2),(102,3),(102,4),(103,2),(103,3),(103,4),(104,2),(104,3),(104,4),(110,2),(110,3),(113,2),(113,3),(114,2),(114,3),(118,2),(118,3),(119,2),(119,3),(120,2),(120,3),(121,2),(121,3),(122,1),(122,2),(122,3),(122,4),(122,5),(123,2),(123,3),(124,2),(124,3),(125,2),(125,3),(126,2),(126,3),(127,2),(127,3),(128,2),(128,3),(129,2),(129,3),(130,2),(130,3),(131,2),(131,3),(132,2),(132,3),(133,2),(133,3),(134,2),(135,2),(136,2),(137,2);
/*!40000 ALTER TABLE `nexopos_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_roles`
--

DROP TABLE IF EXISTS `nexopos_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `namespace` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `reward_system_id` int DEFAULT NULL,
  `minimal_credit_payment` double NOT NULL DEFAULT '0',
  `author` int DEFAULT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nexopos_roles_name_unique` (`name`),
  UNIQUE KEY `nexopos_roles_namespace_unique` (`namespace`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_roles`
--

LOCK TABLES `nexopos_roles` WRITE;
/*!40000 ALTER TABLE `nexopos_roles` DISABLE KEYS */;
INSERT INTO `nexopos_roles` VALUES (1,'User','user','Basic user role.',NULL,0,NULL,1,'2026-01-26 03:18:05','2026-01-26 03:18:05'),(2,'Administrator','admin','Master role which can perform all actions like create users, install/update/delete modules and much more.',NULL,0,NULL,1,'2026-01-26 03:18:05','2026-01-26 03:18:05'),(3,'Store Administrator','nexopos.store.administrator','Has a control over an entire store of NexoPOS.',NULL,0,NULL,1,'2026-01-26 03:18:10','2026-01-26 03:18:10'),(4,'Store Cashier','nexopos.store.cashier','Has a control over the sale process.',NULL,0,NULL,1,'2026-01-26 03:18:15','2026-01-26 03:18:15'),(5,'Store Customer','nexopos.store.customer','Can purchase orders and manage his profile.',NULL,0,NULL,1,'2026-01-26 03:18:16','2026-01-26 03:18:16');
/*!40000 ALTER TABLE `nexopos_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_scale_ranges`
--

DROP TABLE IF EXISTS `nexopos_scale_ranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_scale_ranges` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `range_start` int unsigned NOT NULL,
  `range_end` int unsigned NOT NULL,
  `next_scale_plu` int unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_scale_ranges`
--

LOCK TABLES `nexopos_scale_ranges` WRITE;
/*!40000 ALTER TABLE `nexopos_scale_ranges` DISABLE KEYS */;
INSERT INTO `nexopos_scale_ranges` VALUES (1,'Test Range',1,99,1,'Range for testing and development purposes',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(2,'Fruits & Vegetables',100,999,100,'Fresh produce that requires weighing',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(3,'Meat & Poultry',1000,1999,1000,'Fresh meat and poultry products',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(4,'Seafood',2000,2999,2000,'Fresh fish and seafood products',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(5,'Bakery',3000,3999,3000,'Bakery items sold by weight',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(6,'Deli & Cheese',4000,4999,4000,'Deli meats and cheese products',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(7,'Bulk Foods',5000,5999,5000,'Bulk food items like nuts, grains, and spices',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(8,'Prepared Foods',6000,6999,6000,'Ready-to-eat prepared foods',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(9,'Organic Products',7000,7999,7000,'Certified organic products',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(10,'Specialty Items',8000,8999,8000,'Specialty and gourmet products',0,'2026-01-26 03:19:05','2026-01-26 03:19:05'),(11,'General Weighable',9000,9999,9000,'General category for weighable products',0,'2026-01-26 03:19:05','2026-01-26 03:19:05');
/*!40000 ALTER TABLE `nexopos_scale_ranges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_taxes`
--

DROP TABLE IF EXISTS `nexopos_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_taxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `rate` float NOT NULL,
  `tax_group_id` int NOT NULL,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_taxes`
--

LOCK TABLES `nexopos_taxes` WRITE;
/*!40000 ALTER TABLE `nexopos_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_taxes_groups`
--

DROP TABLE IF EXISTS `nexopos_taxes_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_taxes_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_taxes_groups`
--

LOCK TABLES `nexopos_taxes_groups` WRITE;
/*!40000 ALTER TABLE `nexopos_taxes_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_taxes_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_transactions`
--

DROP TABLE IF EXISTS `nexopos_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `media_id` int NOT NULL DEFAULT '0',
  `value` float NOT NULL DEFAULT '0',
  `recurring` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `group_id` int DEFAULT NULL,
  `occurrence` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occurrence_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_transactions`
--

LOCK TABLES `nexopos_transactions` WRITE;
/*!40000 ALTER TABLE `nexopos_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_transactions_accounts`
--

DROP TABLE IF EXISTS `nexopos_transactions_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_transactions_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `sub_category_id` int DEFAULT NULL,
  `category_identifier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_transactions_accounts`
--

LOCK TABLES `nexopos_transactions_accounts` WRITE;
/*!40000 ALTER TABLE `nexopos_transactions_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_transactions_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_transactions_actions_rules`
--

DROP TABLE IF EXISTS `nexopos_transactions_actions_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_transactions_actions_rules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `on` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` enum('increase','decrease') COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int NOT NULL,
  `do` enum('increase','decrease') COLLATE utf8mb4_unicode_ci NOT NULL,
  `offset_account_id` int NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_transactions_actions_rules`
--

LOCK TABLES `nexopos_transactions_actions_rules` WRITE;
/*!40000 ALTER TABLE `nexopos_transactions_actions_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_transactions_actions_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_transactions_balance_days`
--

DROP TABLE IF EXISTS `nexopos_transactions_balance_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_transactions_balance_days` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `opening_balance` double NOT NULL DEFAULT '0',
  `income` double NOT NULL DEFAULT '0',
  `expense` double NOT NULL DEFAULT '0',
  `closing_balance` double NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_transactions_balance_days`
--

LOCK TABLES `nexopos_transactions_balance_days` WRITE;
/*!40000 ALTER TABLE `nexopos_transactions_balance_days` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_transactions_balance_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_transactions_balance_months`
--

DROP TABLE IF EXISTS `nexopos_transactions_balance_months`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_transactions_balance_months` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `opening_balance` double NOT NULL DEFAULT '0',
  `income` double NOT NULL DEFAULT '0',
  `expense` double NOT NULL DEFAULT '0',
  `closing_balance` double NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_transactions_balance_months`
--

LOCK TABLES `nexopos_transactions_balance_months` WRITE;
/*!40000 ALTER TABLE `nexopos_transactions_balance_months` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_transactions_balance_months` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_transactions_histories`
--

DROP TABLE IF EXISTS `nexopos_transactions_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_transactions_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int DEFAULT NULL,
  `operation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_reflection` tinyint(1) NOT NULL DEFAULT '0',
  `reflection_source_id` int DEFAULT NULL,
  `transaction_account_id` int DEFAULT NULL,
  `procurement_id` int DEFAULT NULL,
  `order_refund_id` int DEFAULT NULL,
  `order_payment_id` int DEFAULT NULL,
  `order_refund_product_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `order_product_id` int DEFAULT NULL,
  `register_history_id` int DEFAULT NULL,
  `customer_account_history_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `value` float NOT NULL DEFAULT '0',
  `trigger_date` datetime DEFAULT NULL,
  `rule_id` int DEFAULT NULL,
  `author` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_transactions_histories`
--

LOCK TABLES `nexopos_transactions_histories` WRITE;
/*!40000 ALTER TABLE `nexopos_transactions_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexopos_transactions_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_units`
--

DROP TABLE IF EXISTS `nexopos_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_units` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `group_id` int NOT NULL,
  `value` float NOT NULL,
  `preview_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_unit` tinyint(1) NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nexopos_units_identifier_unique` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_units`
--

LOCK TABLES `nexopos_units` WRITE;
/*!40000 ALTER TABLE `nexopos_units` DISABLE KEYS */;
INSERT INTO `nexopos_units` VALUES (1,'件','PIECE',NULL,68,1,1,NULL,1,NULL,'2026-01-26 12:17:10','2026-01-26 12:17:10'),(2,'箱_24件装','BOX_24',NULL,68,1,24,NULL,0,NULL,'2026-01-26 12:17:49','2026-01-26 12:17:49'),(3,'箱_12件装','BOX_12',NULL,68,1,12,NULL,0,NULL,'2026-01-26 12:21:26','2026-01-26 12:21:26'),(4,'打_8件装','DOZEN_8',NULL,68,1,8,NULL,0,NULL,'2026-01-26 12:24:01','2026-01-26 12:24:01'),(5,'打_9件装','DOZEN_9',NULL,68,1,9,NULL,0,NULL,'2026-01-26 12:24:34','2026-01-26 12:24:34'),(6,'打_12件装','DOZEN_12',NULL,68,1,12,NULL,0,NULL,'2026-01-26 12:25:46','2026-01-26 12:25:46'),(7,'把_3件装','BA_3',NULL,68,1,3,NULL,0,NULL,'2026-01-31 06:38:10','2026-01-31 06:38:10'),(8,'把_4件装','BA_4',NULL,68,1,4,NULL,0,NULL,'2026-01-31 06:38:57','2026-01-31 06:38:57'),(9,'提_10卷/包装','TI_10',NULL,68,1,10,NULL,0,NULL,'2026-01-31 08:30:59','2026-01-31 08:30:59'),(10,'提_12卷/包装','TI_12',NULL,68,1,12,NULL,0,NULL,'2026-01-31 08:36:19','2026-01-31 08:36:19'),(11,'盒_10副装','HE_10',NULL,68,1,10,NULL,0,NULL,'2026-01-31 11:50:52','2026-01-31 11:50:52'),(12,'箱_50件装','BOX_50',NULL,68,1,50,NULL,0,NULL,'2026-02-04 04:45:57','2026-02-04 04:45:57'),(13,'箱_40件装','BOX_40',NULL,68,1,40,NULL,0,NULL,'2026-02-04 04:55:34','2026-02-04 04:55:34'),(14,'盒_20件装','HE_20',NULL,68,1,20,NULL,0,NULL,'2026-02-04 05:32:22','2026-02-04 05:32:22');
/*!40000 ALTER TABLE `nexopos_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_units_groups`
--

DROP TABLE IF EXISTS `nexopos_units_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_units_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `author` int NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_units_groups`
--

LOCK TABLES `nexopos_units_groups` WRITE;
/*!40000 ALTER TABLE `nexopos_units_groups` DISABLE KEYS */;
INSERT INTO `nexopos_units_groups` VALUES (1,'物品数量归类',NULL,68,NULL,'2026-01-26 12:15:40','2026-01-26 12:15:40');
/*!40000 ALTER TABLE `nexopos_units_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_users`
--

DROP TABLE IF EXISTS `nexopos_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `author` int DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_id` int DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pobox` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activation_expiration` datetime DEFAULT NULL,
  `total_sales_count` int NOT NULL DEFAULT '0',
  `total_sales` float NOT NULL DEFAULT '0',
  `birth_date` datetime DEFAULT NULL,
  `purchases_amount` double NOT NULL DEFAULT '0',
  `owed_amount` double NOT NULL DEFAULT '0',
  `credit_limit_amount` double NOT NULL DEFAULT '0',
  `account_amount` double NOT NULL DEFAULT '0',
  `activation_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nexopos_users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_users`
--

LOCK TABLES `nexopos_users` WRITE;
/*!40000 ALTER TABLE `nexopos_users` DISABLE KEYS */;
INSERT INTO `nexopos_users` VALUES (68,'wenyuan',1,68,'biwenyuan@aliyun.com','$2y$10$LqgatOP9J.yxXY0AiBwO8OIVKsM8OQDtGjH8hVz5Q3yUbmV.W9ppK',NULL,'','','','','',NULL,31,320940,NULL,0,0,0,0,'','','2026-01-22 21:02:32','2026-01-25 08:58:58'),(69,'customer-70@127.0.0.1',0,68,'bwy989969@163.com','$2y$10$irvRaitoPwF.8KciTl4m..fqDAx1XXbcCbJU4ASJ0fF5k/PRgjWOS',1,'散客','无名氏',NULL,NULL,NULL,NULL,0,0,'2026-01-26 20:08:30',0,0,0,0,NULL,NULL,'2026-01-26 12:09:35','2026-01-26 12:09:35');
/*!40000 ALTER TABLE `nexopos_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_users_attributes`
--

DROP TABLE IF EXISTS `nexopos_users_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_users_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `avatar_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_users_attributes`
--

LOCK TABLES `nexopos_users_attributes` WRITE;
/*!40000 ALTER TABLE `nexopos_users_attributes` DISABLE KEYS */;
INSERT INTO `nexopos_users_attributes` VALUES (1,68,'http://127.0.0.1:8000/storage/2026/01/.jpg','dark','zh-CN');
/*!40000 ALTER TABLE `nexopos_users_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_users_roles_relations`
--

DROP TABLE IF EXISTS `nexopos_users_roles_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_users_roles_relations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_users_roles_relations`
--

LOCK TABLES `nexopos_users_roles_relations` WRITE;
/*!40000 ALTER TABLE `nexopos_users_roles_relations` DISABLE KEYS */;
INSERT INTO `nexopos_users_roles_relations` VALUES (1,2,68,'2026-01-22 21:02:33','2026-01-22 21:02:33'),(2,5,69,'2026-01-26 12:09:35','2026-01-26 12:09:35');
/*!40000 ALTER TABLE `nexopos_users_roles_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexopos_users_widgets`
--

DROP TABLE IF EXISTS `nexopos_users_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nexopos_users_widgets` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `class_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexopos_users_widgets`
--

LOCK TABLES `nexopos_users_widgets` WRITE;
/*!40000 ALTER TABLE `nexopos_users_widgets` DISABLE KEYS */;
INSERT INTO `nexopos_users_widgets` VALUES ('019bfa2c-cf03-7139-854a-b16caf4594ca','nsIncompleteSaleCardWidget','first-column','App\\Widgets\\IncompleteSaleCardWidget',0,68,'2026-01-26 11:59:59','2026-01-26 11:59:59'),('019bfa2c-dfac-7358-be60-9f7d6ffcbf03','nsExpenseCardWidget','second-column','App\\Widgets\\ExpenseCardWidget',0,68,'2026-01-26 12:00:03','2026-01-26 12:00:03'),('019bfa2c-efbc-7085-8b1e-19e416895e0b','nsSaleCardWidget','third-column','App\\Widgets\\SaleCardWidget',0,68,'2026-01-26 12:00:07','2026-01-26 12:00:07'),('019bfa2d-0b10-71ba-a1ec-ae9bd44f5f39','nsBestCustomers','first-column','App\\Widgets\\BestCustomersWidget',2,68,'2026-01-26 12:00:14','2026-02-04 04:31:28'),('019bfa2d-1d76-731e-a0a4-6b96cb68850d','nsProfileWidget','second-column','App\\Widgets\\ProfileWidget',1,68,'2026-01-26 12:00:19','2026-01-26 12:00:19'),('019bfa2d-2dda-7388-84fe-374a10596360','nsOrdersChart','third-column','App\\Widgets\\OrdersChartWidget',1,68,'2026-01-26 12:00:23','2026-01-26 12:00:23'),('019bfa2d-440b-7255-957b-0199d5246473','nsOrdersSummary','first-column','App\\Widgets\\OrdersSummaryWidget',1,68,'2026-01-26 12:00:29','2026-02-04 04:31:28'),('019bfa2d-50a9-738d-8cae-7bc202b70716','nsBestCashiers','second-column','App\\Widgets\\BestCashiersWidget',2,68,'2026-01-26 12:00:32','2026-01-26 12:00:32');
/*!40000 ALTER TABLE `nexopos_users_widgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telescope_entries`
--

DROP TABLE IF EXISTS `telescope_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescope_entries` (
  `sequence` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `family_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `should_display_on_index` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`sequence`),
  UNIQUE KEY `telescope_entries_uuid_unique` (`uuid`),
  KEY `telescope_entries_batch_id_index` (`batch_id`),
  KEY `telescope_entries_family_hash_index` (`family_hash`),
  KEY `telescope_entries_created_at_index` (`created_at`),
  KEY `telescope_entries_type_should_display_on_index_index` (`type`,`should_display_on_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telescope_entries`
--

LOCK TABLES `telescope_entries` WRITE;
/*!40000 ALTER TABLE `telescope_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `telescope_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telescope_entries_tags`
--

DROP TABLE IF EXISTS `telescope_entries_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescope_entries_tags` (
  `entry_uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `telescope_entries_tags_entry_uuid_tag_index` (`entry_uuid`,`tag`),
  KEY `telescope_entries_tags_tag_index` (`tag`),
  CONSTRAINT `telescope_entries_tags_entry_uuid_foreign` FOREIGN KEY (`entry_uuid`) REFERENCES `telescope_entries` (`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telescope_entries_tags`
--

LOCK TABLES `telescope_entries_tags` WRITE;
/*!40000 ALTER TABLE `telescope_entries_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `telescope_entries_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telescope_monitoring`
--

DROP TABLE IF EXISTS `telescope_monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescope_monitoring` (
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telescope_monitoring`
--

LOCK TABLES `telescope_monitoring` WRITE;
/*!40000 ALTER TABLE `telescope_monitoring` DISABLE KEYS */;
/*!40000 ALTER TABLE `telescope_monitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'nexopos'
--

--
-- Dumping routines for database 'nexopos'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-04 21:14:48
