-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 08, 2019 at 08:28 PM
-- Server version: 5.6.38
-- PHP Version: 7.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `emyo`
--

-- --------------------------------------------------------

--
-- Table structure for table `emailUsers`
--

CREATE TABLE `emailUsers` (
  `user_id` int(11) NOT NULL,
  `email` varchar(300) COLLATE utf8_turkish_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feed`
--

CREATE TABLE `feed` (
  `feed_id` int(11) NOT NULL,
  `feed` text COLLATE utf8_turkish_ci,
  `user_id_fk` int(11) DEFAULT NULL,
  `created` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `feed`
--

INSERT INTO `feed` (`feed_id`, `feed`, `user_id_fk`, `created`) VALUES
(1, 'test', 8, 1557314553),
(2, 'deneme', 8, 1557314559),
(3, 'huhuuuu', 8, 1557314563),
(4, 'ses deneme 1 ', 8, 1557314573),
(5, 'merhaba', 8, 1557314762),
(6, 'asdasdadasd', 8, 1557314780),
(7, 'sdfghj', 8, 1557319917),
(8, 'ses deneme 1 ', 8, 1557320467),
(9, 'ses deneme 1 ', 8, 1557320484),
(10, 'deneme', 9, 1557321232),
(11, 'sdfghm', 9, 1557321233),
(12, 'bu bir mesaj', 8, 1557339246),
(13, 'deneme deneme', 9, 1557339301);

-- --------------------------------------------------------

--
-- Table structure for table `imagesData`
--

CREATE TABLE `imagesData` (
  `img_id` int(11) NOT NULL,
  `b64` text COLLATE utf8_turkish_ci,
  `user_id_fk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_turkish_ci DEFAULT NULL,
  `password` varchar(300) COLLATE utf8_turkish_ci DEFAULT NULL,
  `name` varchar(200) COLLATE utf8_turkish_ci DEFAULT NULL,
  `email` varchar(300) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `name`, `email`) VALUES
(8, 'erinc', '25b80b3556ca3a15353dd2fd312062fad27adcf5a1de51b75bdadea1fa8214ab', 'Erinç Karataş', 'ekaratas@ankara.edu.tr'),
(9, 'bora', '25b80b3556ca3a15353dd2fd312062fad27adcf5a1de51b75bdadea1fa8214ab', 'Bora Karataş', 'bora@gmail.com'),
(11, 'test', 'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 'test', 'test@test.com'),
(12, 'deneme', '25b80b3556ca3a15353dd2fd312062fad27adcf5a1de51b75bdadea1fa8214ab', 'deneme', 'deneme@den.com'),
(13, 'emyo', '25b80b3556ca3a15353dd2fd312062fad27adcf5a1de51b75bdadea1fa8214ab', 'erinç karataş', 'elmadag@ankara.edu.tr'),
(14, 'fgsfsdfs', '25b80b3556ca3a15353dd2fd312062fad27adcf5a1de51b75bdadea1fa8214ab', 'ekaratas', 'ekaratas@ankara.edu');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `emailUsers`
--
ALTER TABLE `emailUsers`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `feed`
--
ALTER TABLE `feed`
  ADD PRIMARY KEY (`feed_id`);

--
-- Indexes for table `imagesData`
--
ALTER TABLE `imagesData`
  ADD PRIMARY KEY (`img_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `emailUsers`
--
ALTER TABLE `emailUsers`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feed`
--
ALTER TABLE `feed`
  MODIFY `feed_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `imagesData`
--
ALTER TABLE `imagesData`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;