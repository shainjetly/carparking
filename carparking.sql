-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 10, 2022 at 06:38 PM
-- Server version: 5.7.34
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `carparking`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2022_08_23_042608_create_sessions_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `owners_api`
--

CREATE TABLE `owners_api` (
  `id` int(11) NOT NULL,
  `full_name` varchar(300) NOT NULL,
  `mobile_no` varchar(200) NOT NULL,
  `idcard_no` varchar(200) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `owners_api`
--

INSERT INTO `owners_api` (`id`, `full_name`, `mobile_no`, `idcard_no`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Mohamed Saameen', '7917008', 'A125328', 1, '2022-12-01 17:37:53', '2022-12-10 11:19:31'),
(2, 'Ahmed Naveen', '9777777', 'A123456', NULL, '2022-11-06 08:33:53', '2022-12-07 20:05:26'),
(3, 'Ahmed Shanoon', '7917008', 'A999999', 5, '2022-12-06 10:12:11', '2022-12-08 16:10:42');

-- --------------------------------------------------------

--
-- Table structure for table `owner_slots`
--

CREATE TABLE `owner_slots` (
  `owners_id` int(11) NOT NULL,
  `slot_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `owner_slots`
--

INSERT INTO `owner_slots` (`owners_id`, `slot_id`) VALUES
(3, 1),
(3, 2),
(1, 3),
(1, 11),
(3, 13),
(4, 4),
(1, 17);

-- --------------------------------------------------------

--
-- Table structure for table `parking_pool`
--

CREATE TABLE `parking_pool` (
  `id` int(10) UNSIGNED NOT NULL,
  `slot_id` int(11) NOT NULL,
  `time_from` time NOT NULL,
  `time_to` time NOT NULL,
  `status` varchar(200) NOT NULL,
  `reserved_by` int(11) DEFAULT NULL,
  `ai_status` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `parking_pool`
--

INSERT INTO `parking_pool` (`id`, `slot_id`, `time_from`, `time_to`, `status`, `reserved_by`, `ai_status`, `created_at`, `updated_at`) VALUES
(1, 1, '14:10:00', '16:00:00', 'NotAvailable', 0, NULL, '2022-12-08 10:43:41', '2022-12-09 16:31:28'),
(2, 2, '14:10:00', '11:00:00', 'NotAvailable', 0, NULL, '2022-12-08 15:46:35', '2022-12-09 16:31:28'),
(3, 3, '12:00:00', '15:00:00', 'NotAvailable', 0, NULL, '2022-12-08 15:48:02', '2022-12-08 15:48:02'),
(4, 4, '12:00:00', '15:00:00', 'NotAvailable', 0, NULL, '2022-12-08 15:48:02', '2022-12-09 16:31:28'),
(5, 11, '12:00:00', '15:00:00', 'NotAvailable', 0, NULL, '2022-12-08 15:48:02', '2022-12-09 16:31:28'),
(6, 13, '12:00:00', '15:00:00', 'NotAvailable', 0, NULL, '2022-12-08 15:48:02', '2022-12-09 16:31:28'),
(8, 16, '12:00:00', '15:00:00', 'NotAvailable', 0, NULL, '2022-12-08 15:48:02', '2022-12-09 16:31:28'),
(24, 3, '15:00:00', '16:00:00', 'NotAvailable', 0, NULL, '2022-12-09 14:32:49', '2022-12-09 14:32:49'),
(35, 3, '16:17:00', '17:17:00', 'NotAvailable', 0, NULL, '2022-12-09 16:17:40', '2022-12-09 18:48:34'),
(36, 3, '17:32:00', '18:12:00', 'NotAvailable', 0, NULL, '2022-12-09 16:18:58', '2022-12-09 18:48:34'),
(37, 3, '18:49:00', '19:49:00', 'NotAvailable', 0, NULL, '2022-12-09 18:49:21', '2022-12-09 20:34:41'),
(38, 3, '19:58:00', '20:05:00', 'NotAvailable', 0, NULL, '2022-12-09 18:54:08', '2022-12-09 20:34:41'),
(39, 3, '20:35:00', '00:11:00', 'Time Expired', 3, NULL, '2022-12-09 20:35:18', '2022-12-10 00:18:41'),
(42, 3, '01:41:00', '02:05:00', 'Time Expired', 3, NULL, '2022-12-10 01:41:18', '2022-12-10 02:07:43'),
(43, 17, '02:07:00', '03:07:00', 'Time Expired', 3, NULL, '2022-12-10 02:08:00', '2022-12-10 03:13:17'),
(45, 17, '03:57:00', '04:57:00', 'Time Expired', 3, 'Someone has just parked in this slot.', '2022-12-10 03:57:06', '2022-12-10 10:46:00'),
(46, 17, '11:19:00', '12:19:00', 'Reserved', 3, 'Someone has just parked in this slot.', '2022-12-10 11:21:34', '2022-12-10 11:28:36');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `registered_owners`
--

CREATE TABLE `registered_owners` (
  `owners_id` int(11) NOT NULL,
  `slot_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `registered_owners`
--

INSERT INTO `registered_owners` (`owners_id`, `slot_id`) VALUES
(1, 1),
(1, 2),
(2, 3),
(1, 1),
(1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('d43ppNx2mCYLYLWuozcxAqRpj7HWlvvl7PiiheST', NULL, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMUpIQWx2Wm9UUkQ2WlZrbDBOZ2lReUVYVDhMbkNNMERGdXo3V0x5MSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyMDoiaHR0cHM6Ly9lYy9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1670666948),
('E3LdR4FQvXWX1MvEw555upwFPCLJkFEXV11bQWJa', 3, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiaktiSHRCMERmenZuT0dzS0dHcFlNSHhaZjV3RldiM2RtWU9Uczc0RSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjM7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTAkbVVrVTF4RUpMMEJZaUxwNXBpR2liT2svN3RnT0VRMEZxQ2xJeGpEQ2VyeW9wd3g0MUhQVEsiO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjE3OiJodHRwczovL2VjL3Nob3dBaSI7fX0=', 1670653724);

-- --------------------------------------------------------

--
-- Table structure for table `slots`
--

CREATE TABLE `slots` (
  `id` int(10) UNSIGNED NOT NULL,
  `slot_name` varchar(300) NOT NULL,
  `ward` varchar(300) NOT NULL,
  `slot_number` varchar(200) NOT NULL,
  `latitude` varchar(200) NOT NULL,
  `longitude` varchar(200) NOT NULL,
  `image` varchar(250) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `slots`
--

INSERT INTO `slots` (`id`, `slot_name`, `ward`, `slot_number`, `latitude`, `longitude`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Majeedhiyya Anex Parking Lot', 'Henveyru', 'P-1234', '4.1772461', '73.5149296', 'public-park.jpg', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(2, 'Heenaamaage Parking', 'Henveyru', 'P-4726', '4.1748781', '73.5137429', 'parking.jpg', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(3, 'Ameenee Magu Parking Lot', 'Maafannu', 'P-3224\r\n', '4.1723271', '73.5023955', 'parking.jpg', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(4, 'Majeedhiyya Anex Parking Lot', 'Henveyru', 'P-8832', '4.1772461', '73.5149296', '', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(5, 'Majeedhiyya Anex Parking Lot', 'Henveyru', 'P-82794', '4.1772461', '73.5149296', '', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(6, 'Ameenee Magu Parking Lot', 'Maafannu', 'P-234234\r\n', '4.1723271', '73.5023955', '', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(7, 'Ameenee Magu Parking Lot', 'Maafannu', 'P-3343\r\n', '4.1723271', '73.5023955', '', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(8, 'Majeedhiyya Anex Parking Lot', 'Henveyru', 'P-2341\r\n', '4.1772461', '73.5149296', '', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(9, 'Heenaamaage Parking', 'Henveyru', 'P-64432', '4.1748781', '73.5137429', '', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(10, 'Heenaamaage Parking', 'Henveyru', 'P-1233', '4.1748781', '73.5137429', '', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(11, 'Carnivaa Parking', 'Henveyru', 'B1B4420_381', '4.1774315', '73.5175631', 'B1B4420_381.jpg', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(12, 'Buru Parking', 'Galolhu', 'P-23145', '4.1716022', '73.5088211', '', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(13, 'Carnivaa Parking', 'Henveyru', 'B1A6491_375', '4.1774315', '73.5175631', 'B1A6491_375.jpg', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(14, 'Buru Parking', 'Galolhu', 'B1A6298_06', '4.1716022', '73.5088211', 'B1A6298_06.jpg', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(16, 'Hardware Zone Parking Lot', 'Henveryru', 'B1A6121_212', '4.1720747824806', '73.51550022096231', 'B1A6298_06.jpg', '2022-12-06 18:46:59', '2022-12-06 18:46:59'),
(17, 'Finance Ministry Parking Lot', 'Maafannu', 'B1A1221_175', '4.171395997077292', '73.50821541622082', 'B1A6298_06.jpg', '2022-12-06 18:46:59', '2022-12-06 18:46:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile_number` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `mobile_number`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, 'Mohamed Saameen', 'shaamin@gmail.com', '7917008', NULL, '$2y$10$94mJbVXlcQbLCw2M2HhLouiOWspl7myydPR5gknxPu9z.OWcYzkLK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Mohamed Naveen', 'naveen@naveen.com', '9777777', NULL, '$2y$10$mUkU1xEJL0BYiLp5piGibOk/7tgOEQ0FqClIxjDCeryopwx41HPTK', NULL, NULL, NULL, NULL, NULL, NULL, '2022-12-06 14:54:22', '2022-12-06 14:54:22'),
(5, 'Ahmed Shanoon', 'shanoon@shanoon.com', '7917008', NULL, '$2y$10$joe8Nx8m5/Dkin0ZCuRpwu9f7VeaxOubcFYzeYR3GtDjH9/ua.6S6', NULL, NULL, NULL, NULL, NULL, NULL, '2022-12-08 11:09:02', '2022-12-08 11:09:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `owners_api`
--
ALTER TABLE `owners_api`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parking_pool`
--
ALTER TABLE `parking_pool`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `slots`
--
ALTER TABLE `slots`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `owners_api`
--
ALTER TABLE `owners_api`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `parking_pool`
--
ALTER TABLE `parking_pool`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `slots`
--
ALTER TABLE `slots`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
