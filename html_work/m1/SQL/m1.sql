-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.5.19-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- m1 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `m1` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `m1`;

-- 테이블 m1.subject 구조 내보내기
CREATE TABLE IF NOT EXISTS `subject` (
  `subject_no` int(11) NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(50) NOT NULL,
  `subject_time` int(11) NOT NULL,
  `updatedate` datetime NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`subject_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 m1.subject:~6 rows (대략적) 내보내기
DELETE FROM `subject`;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` (`subject_no`, `subject_name`, `subject_time`, `updatedate`, `createdate`) VALUES
	(1, '자바', 50, '2023-05-29 17:48:31', '2023-05-25 21:31:03'),
	(2, 'C#', 60, '2023-05-25 21:31:03', '2023-05-25 21:31:03'),
	(3, 'python', 40, '2023-05-25 21:31:03', '2023-05-25 21:31:03'),
	(4, 'DB', 40, '2023-05-25 21:31:03', '2023-05-25 21:31:03'),
	(5, 'HTML', 10, '2023-05-25 21:31:03', '2023-05-25 21:31:03'),
	(6, 'JS', 30, '2023-05-27 14:23:36', '2023-05-27 14:23:36');
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;

-- 테이블 m1.teacher 구조 내보내기
CREATE TABLE IF NOT EXISTS `teacher` (
  `teacher_no` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` varchar(50) NOT NULL,
  `teacher_name` varchar(50) NOT NULL,
  `teacher_history` text NOT NULL,
  `updatedate` datetime NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`teacher_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 m1.teacher:~12 rows (대략적) 내보내기
DELETE FROM `teacher`;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` (`teacher_no`, `teacher_id`, `teacher_name`, `teacher_history`, `updatedate`, `createdate`) VALUES
	(1, 'good', '구원이', '메모...', '2023-05-27 13:55:44', '2023-05-27 13:55:44'),
	(2, 'good', '구우원이', '메모...1', '2023-05-27 13:56:04', '2023-05-27 13:56:04'),
	(3, 'good', '구우우원이', '메모...2', '2023-05-27 13:56:04', '2023-05-27 13:56:04'),
	(4, 'good', '구원삼', '메모...3', '2023-05-27 13:56:05', '2023-05-27 13:56:05'),
	(5, 'good', '구원사', '메모...4', '2023-05-27 13:56:05', '2023-05-27 13:56:05'),
	(6, 'good', '구원오', '메모...5', '2023-05-27 13:56:05', '2023-05-27 13:56:05'),
	(7, 'good', '구이', '메모...6', '2023-05-27 13:56:05', '2023-05-27 13:56:05'),
	(8, 'good', '구원육', '메모...7', '2023-05-27 13:56:05', '2023-05-27 13:56:05'),
	(9, 'good', '구원칠', '메모...8', '2023-05-27 13:56:05', '2023-05-27 13:56:05'),
	(10, 'good', '구원구', '메모...9', '2023-05-27 13:56:05', '2023-05-27 13:56:05'),
	(11, 'good', '십원팔', '메모...9', '2023-05-27 13:56:05', '2023-05-27 13:56:05'),
	(12, 'good', '구우팔', '메모...10', '2023-05-27 13:56:05', '2023-05-27 13:56:05');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;

-- 테이블 m1.teacher_subject 구조 내보내기
CREATE TABLE IF NOT EXISTS `teacher_subject` (
  `teacher_subjectno` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_no` int(11) DEFAULT NULL,
  `subject_no` int(11) DEFAULT NULL,
  `updatedate` datetime DEFAULT NULL,
  `createdate` datetime DEFAULT NULL,
  PRIMARY KEY (`teacher_subjectno`) USING BTREE,
  KEY `FK__teacher` (`teacher_no`) USING BTREE,
  KEY `FK__subject` (`subject_no`) USING BTREE,
  CONSTRAINT `FK__subject` FOREIGN KEY (`subject_no`) REFERENCES `subject` (`subject_no`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK__teacher` FOREIGN KEY (`teacher_no`) REFERENCES `teacher` (`teacher_no`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 m1.teacher_subject:~12 rows (대략적) 내보내기
DELETE FROM `teacher_subject`;
/*!40000 ALTER TABLE `teacher_subject` DISABLE KEYS */;
INSERT INTO `teacher_subject` (`teacher_subjectno`, `teacher_no`, `subject_no`, `updatedate`, `createdate`) VALUES
	(1, 1, 1, '2023-05-27 13:57:34', '2023-05-27 13:57:34'),
	(2, 1, 2, '2023-05-27 13:57:51', '2023-05-27 13:57:51'),
	(3, 2, 1, '2023-05-27 13:58:29', '2023-05-27 13:58:29'),
	(4, 3, 3, '2023-05-27 13:58:29', '2023-05-27 13:58:29'),
	(5, 10, 5, '2023-05-27 13:58:29', '2023-05-27 13:58:29'),
	(6, 5, 2, '2023-05-27 13:58:29', '2023-05-27 13:58:29'),
	(7, 6, 4, '2023-05-27 13:58:29', '2023-05-27 13:58:29'),
	(8, 7, 2, '2023-05-27 13:58:29', '2023-05-27 13:58:29'),
	(9, 8, 3, '2023-05-27 13:58:29', '2023-05-27 13:58:29'),
	(10, 9, 1, '2023-05-27 13:58:29', '2023-05-27 13:58:29'),
	(11, 4, 5, '2023-05-27 13:58:29', '2023-05-27 13:58:29'),
	(12, 5, 5, '2023-05-27 13:58:29', '2023-05-27 13:58:29');
/*!40000 ALTER TABLE `teacher_subject` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
