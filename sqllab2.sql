-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 20, 2022 at 06:05 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sqllab1`
--

-- --------------------------------------------------------

--
-- Table structure for table `agents`
--

CREATE TABLE `agents` (
  `ID` int(11) NOT NULL,
  `Agentname` varchar(50) NOT NULL,
  `Agent-pwd` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `agents`:
--

-- --------------------------------------------------------

--
-- Table structure for table `agenttask`
--

CREATE TABLE `agenttask` (
  `ID` int(11) NOT NULL,
  `complaint-id` int(11) NOT NULL,
  `employee-id` int(11) NOT NULL,
  `complaint-status` enum('Open','Closed','','') NOT NULL DEFAULT 'Open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `agenttask`:
--   `employee-id`
--       `employees` -> `ID`
--   `complaint-id`
--       `complaints` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Complaint` mediumtext NOT NULL,
  `Posting-date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `complaints`:
--   `ID`
--       `userdetails` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `ID` int(11) NOT NULL,
  `Employee-name` varchar(50) NOT NULL,
  `Employee-Pwd` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `employees`:
--

-- --------------------------------------------------------

--
-- Table structure for table `employeetask`
--

CREATE TABLE `employeetask` (
  `ID` int(11) NOT NULL,
  `Agent-id` int(11) NOT NULL,
  `complaint-id` int(11) NOT NULL,
  `complaint-status` enum('Completed','In Progress','Stuck','') NOT NULL DEFAULT 'In Progress'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `employeetask`:
--   `complaint-id`
--       `agents` -> `ID`
--   `Agent-id`
--       `agents` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `userdetails`
--

CREATE TABLE `userdetails` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` char(20) NOT NULL,
  `E-mail` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELATIONSHIPS FOR TABLE `userdetails`:
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agents`
--
ALTER TABLE `agents`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `agenttask`
--
ALTER TABLE `agenttask`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `employee-id` (`employee-id`),
  ADD KEY `complaint-id` (`complaint-id`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `employeetask`
--
ALTER TABLE `employeetask`
  ADD KEY `complaint-id` (`complaint-id`),
  ADD KEY `Agent-id` (`Agent-id`);

--
-- Indexes for table `userdetails`
--
ALTER TABLE `userdetails`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `E-mail` (`E-mail`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agenttask`
--
ALTER TABLE `agenttask`
  ADD CONSTRAINT `agenttask_ibfk_1` FOREIGN KEY (`employee-id`) REFERENCES `employees` (`ID`),
  ADD CONSTRAINT `agenttask_ibfk_2` FOREIGN KEY (`complaint-id`) REFERENCES `complaints` (`ID`);

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `userdetails` (`ID`);

--
-- Constraints for table `employeetask`
--
ALTER TABLE `employeetask`
  ADD CONSTRAINT `employeetask_ibfk_1` FOREIGN KEY (`complaint-id`) REFERENCES `agents` (`ID`),
  ADD CONSTRAINT `employeetask_ibfk_2` FOREIGN KEY (`Agent-id`) REFERENCES `agents` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
