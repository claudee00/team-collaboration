-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2026 at 05:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sport_court_booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `timeslot_id` int(11) NOT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `booking_status` enum('Pending','Confirmed','Cancelled') DEFAULT 'Pending',
  `total_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `timeslot_id`, `booking_date`, `booking_status`, `total_amount`) VALUES
(1, 2, 1, '2026-06-10 04:21:08', 'Cancelled', 20.00),
(2, 2, 2, '2026-06-10 09:16:27', 'Cancelled', 20.00),
(3, 5, 1, '2026-06-10 09:54:43', 'Cancelled', 20.00),
(4, 5, 3, '2026-06-10 10:10:56', 'Cancelled', 20.00),
(5, 5, 3, '2026-06-10 10:15:10', 'Cancelled', 20.00),
(6, 5, 1, '2026-06-10 10:17:07', 'Cancelled', 20.00),
(7, 5, 1, '2026-06-10 13:17:27', 'Confirmed', 20.00),
(8, 5, 2, '2026-06-10 13:17:56', 'Cancelled', 20.00);

-- --------------------------------------------------------

--
-- Table structure for table `courts`
--

CREATE TABLE `courts` (
  `court_id` int(11) NOT NULL,
  `court_name` varchar(100) NOT NULL,
  `court_type` enum('Badminton','Futsal','Basketball','Tennis') NOT NULL,
  `description` text DEFAULT NULL,
  `price_per_hour` decimal(10,2) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courts`
--

INSERT INTO `courts` (`court_id`, `court_name`, `court_type`, `description`, `price_per_hour`, `status`) VALUES
(1, 'Badminton Court A', 'Badminton', '', 20.00, 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('FPX','Credit Card','Debit Card','E-Wallet') DEFAULT NULL,
  `payment_status` enum('Paid','Unpaid') DEFAULT 'Unpaid',
  `payment_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `booking_id`, `amount`, `payment_method`, `payment_status`, `payment_date`) VALUES
(1, 1, 20.00, 'FPX', 'Paid', '2026-06-10 04:32:22'),
(3, 3, 20.00, 'FPX', 'Paid', '2026-06-10 09:55:08'),
(4, 6, 20.00, 'FPX', 'Paid', '2026-06-10 10:17:28'),
(5, 7, 20.00, 'FPX', 'Paid', '2026-06-10 13:17:37');

-- --------------------------------------------------------

--
-- Table structure for table `timeslots`
--

CREATE TABLE `timeslots` (
  `timeslot_id` int(11) NOT NULL,
  `court_id` int(11) NOT NULL,
  `slot_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `availability` enum('Available','Booked','Blocked') DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `timeslots`
--

INSERT INTO `timeslots` (`timeslot_id`, `court_id`, `slot_date`, `start_time`, `end_time`, `availability`) VALUES
(1, 1, '2026-06-11', '09:00:00', '10:00:00', 'Booked'),
(2, 1, '2026-06-11', '10:00:00', '11:00:00', 'Available'),
(3, 1, '2026-06-11', '11:00:00', '12:00:00', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('customer','admin') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `phone_number`, `password`, `role`, `created_at`) VALUES
(2, 'Ali', 'ali@gmail.com', '0123456789', '$2y$10$JScgq3EvvhSWyAlBANNECOta1nEPW4qKW4gC2UKk2YDiBShRWnLF6', 'customer', '2026-06-10 03:37:46'),
(4, 'Admin', 'admin@gmail.com', '0123456789', '$2y$10$XGdMbMXmeLQjZTgglYNcBOpB01dbmhvIXjy2BLXwTAwNO87NQALTe', 'admin', '2026-06-10 03:54:29'),
(5, 'Abu', 'abu@gmail.com', '0124568793', '$2y$10$AWG80.k5uh4FW6tob.RgN.VK4gnk.NT8JxtDRyXEEBrJ3D2B6GgjO', 'customer', '2026-06-10 09:54:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `timeslot_id` (`timeslot_id`);

--
-- Indexes for table `courts`
--
ALTER TABLE `courts`
  ADD PRIMARY KEY (`court_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `booking_id` (`booking_id`);

--
-- Indexes for table `timeslots`
--
ALTER TABLE `timeslots`
  ADD PRIMARY KEY (`timeslot_id`),
  ADD KEY `court_id` (`court_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `courts`
--
ALTER TABLE `courts`
  MODIFY `court_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `timeslots`
--
ALTER TABLE `timeslots`
  MODIFY `timeslot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`timeslot_id`) REFERENCES `timeslots` (`timeslot_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);

--
-- Constraints for table `timeslots`
--
ALTER TABLE `timeslots`
  ADD CONSTRAINT `timeslots_ibfk_1` FOREIGN KEY (`court_id`) REFERENCES `courts` (`court_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
