-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Mar 30, 2022 at 05:30 PM
-- Server version: 5.7.34
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

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
(1, 'perşembe', 8, 1648625959),
(2, 'dsfsdsf', 8, 1648625770),
(3, 'bu yeni metin olacak', 8, 1648025913),
(4, 'ses deneme 1 ', 8, 1557314573),
(5, 'merhaba', 8, 1557314762),
(6, 'Mesaj deneme 12314', 8, 1648560801),
(7, 'sdfghj', 8, 1557319917),
(8, 'ses deneme 1 ', 8, 1557320467),
(9, 'ses deneme 1 ', 8, 1557320484),
(10, 'deneme', 9, 1557321232),
(11, 'sdfghm', 9, 1557321233),
(12, 'bu bir mesaj', 8, 1557339246),
(13, 'test', 9, 1648025512),
(22, 'limon', 8, 1648642265),
(23, 'elma', 8, 1648642562);

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
(14, 'fgsfsdfs', '25b80b3556ca3a15353dd2fd312062fad27adcf5a1de51b75bdadea1fa8214ab', 'ekaratas', 'ekaratas@ankara.edu'),
(15, 'ankara', '569b96c4f396e9feba7a56c0bd0fc8837064d0ebd85436703933f390cf93ed2b', 'ankara', 'ankara@ankara.edu.tr'),
(18, 'erinc2', '25b80b3556ca3a15353dd2fd312062fad27adcf5a1de51b75bdadea1fa8214ab', 'erinç', 'ekaratas@ankara.edu.tw'),
(22, 'erinc3', '25b80b3556ca3a15353dd2fd312062fad27adcf5a1de51b75bdadea1fa8214ab', 'erinc3', 'erinc3@ankara.edu.tr'),
(23, 'ankara1', '4ad824167e11f4948b169c2213a5deb83e4fd3c2ad8336b3663407d07463a7eb', 'ankara1', 'ankara1@ankara.edu.tr'),
(24, 'ankara2', 'b04555c83b25b52585a0805da1671909f6123507195b7d57431fe6e332117d52', 'ankara2', 'ankara2@ankara.edu.tr'),
(25, 'ankara3', '5a1b1b914efb34367e4b9548cf55977b81f83aac22ac75fb1bcf9af8739b0f73', 'ankara3', 'ankara3@ankara.edu.tr'),
(26, 'ankara4', '47fb19524946396b9e9b8f7835e8c79c8d95687f7422254a5dba5b0864b864fb', 'ankara4', 'ankara4@ankara.edu.tr'),
(27, 'ankara5', 'd4bb2828ec64b072f77d49f5af74470f65501554cf3a9074f4c4e40b14ae6320', 'ankara5', 'ankara5@ankara.edu.tr');

-- --------------------------------------------------------

--
-- Stand-in structure for view `user_feed`
-- (See below for the actual view)
--
CREATE TABLE `user_feed` (
`feed_id` int(11)
,`feed` text
,`user_id_fk` int(11)
,`created` int(11)
,`user_id` int(11)
,`username` varchar(50)
,`name` varchar(200)
,`email` varchar(300)
);

-- --------------------------------------------------------

--
-- Structure for view `user_feed`
--
DROP TABLE IF EXISTS `user_feed`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user_feed`  AS SELECT `feed`.`feed_id` AS `feed_id`, `feed`.`feed` AS `feed`, `feed`.`user_id_fk` AS `user_id_fk`, `feed`.`created` AS `created`, `users`.`user_id` AS `user_id`, `users`.`username` AS `username`, `users`.`name` AS `name`, `users`.`email` AS `email` FROM (`users` join `feed` on((`users`.`user_id` = `feed`.`user_id_fk`))) ;

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
  MODIFY `feed_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `imagesData`
--
ALTER TABLE `imagesData`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
