-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 09 Des 2022 pada 12.12
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `selma`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `data_dummy` ()  BEGIN
   DECLARE i, n INT;
   DECLARE jalur INT;
   DECLARE no_pendaftar VARCHAR(20);
   DECLARE nama VARCHAR(100);
   DECLARE nisn VARCHAR(15);
   DECLARE nik VARCHAR(20);
   DECLARE tempat_lahir VARCHAR(60);
   DECLARE tanggal_lahir DATE;
   DECLARE jenis_kelamin VARCHAR(30);
   DECLARE no_hp VARCHAR(20);
   DECLARE id_prodi1 INT;
   DECLARE id_prodi2 INT;
   DECLARE nominal_bayar VARCHAR(15);
   DECLARE id_bank VARCHAR(10);     
   DECLARE is_bayar VARCHAR(10);
   
   DECLARE pendaftar_id INT;
   DECLARE tingkat_prestasi VARCHAR(30);
   DECLARE nama_prestasi VARCHAR(255);
   DECLARE tahun int;
   DECLARE url_dokumen VARCHAR(255);

   SET i = 0;
   
   
   SET n = 100;


   WHILE i < n DO

	SET jalur = (SELECT id_jalur FROM jalur_masuk ORDER BY RAND() LIMIT 1);
        SET no_pendaftar = (SELECT CONCAT('P', YEAR(CURRENT_DATE()), jalur, (i+1)));
        
        SET nama = (SELECT CONCAT('Dhea Putri Salsabila', (i+1)));
        SET nisn = (SELECT CONCAT('1234567', (i+1)));
        SET nik  = (SELECT CONCAT('350708120499', (i+1)));
        SET tempat_lahir = 'situbondo';
    
        SET tanggal_lahir = (SELECT '2001-11-15' - INTERVAL FLOOR(RAND() * 30) DAY);
        SET jenis_kelamin = 'Laki-Laki';
        SET no_hp = (SELECT CONCAT('081217801619', (i+1))); 
               
        SET id_prodi1 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
        SET id_prodi2 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
 
        SET nominal_bayar = 150000;
        SET id_bank = (SELECT id_bank FROM bank ORDER BY RAND() LIMIT 1);
        SET is_bayar = 1; 


        IF jalur = 1 THEN
           SET nominal_bayar = null;
           SET id_bank = NULL;
            SET is_bayar = 1; 
        END IF;

        IF (i+1) % 5 = 0 THEN
           SET jenis_kelamin = 'Perempuan';
           SET tempat_lahir = 'Jember';
        END IF;

        IF (i+1) % 3 = 0 THEN
           SET is_bayar = '0';
        END IF;
           
		INSERT INTO pendaftar (id_jalur, no_pendaftar, nama,  nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, id_prodi1, id_prodi2, nominal_bayar, id_bank, is_bayar)
                VALUES(jalur, no_pendaftar, nama,  nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, id_prodi1, id_prodi2, nominal_bayar, id_bank, is_bayar);
                SET pendaftar_id = (SELECT LAST_INSERT_ID());       

        IF jalur = 3 then
           SET tingkat_prestasi = 'NASIONAL';
           SET tahun = (SELECT YEAR(CURRENT_DATE()));

           IF (i+1) % 6 = 0 THEN
            SET tingkat_prestasi = 'INTERNASIONAL';
            SET tahun = ((SELECT YEAR(CURRENT_DATE())) - 1);
           END IF;
           SET nama_prestasi = (SELECT CONCAT('Prestasi', tingkat_prestasi,' ', nama));
           SET url_dokumen = (SELECT CONCAT('public/upload/prestasi/', pendaftar_id));
           INSERT INTO pendaftar_prestasi(id_pendaftar, tingkat_prestasi, nama_prestasi, tahun, url_dokumen)
           VALUES(pendaftar_id, tingkat_prestasi, nama_prestasi, tahun, url_dokumen);
        END IF;           


        SET i = i + 1;
   END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bank`
--

CREATE TABLE `bank` (
  `id_bank` int(11) NOT NULL,
  `bank` varchar(60) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `bank`
--

INSERT INTO `bank` (`id_bank`, `bank`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'BCA', '2022-12-05 09:24:54', NULL, NULL, NULL),
(2, 'MANDIRI', '2022-12-05 09:24:54', NULL, NULL, NULL),
(3, 'BNI', '2022-12-05 09:25:23', NULL, NULL, NULL),
(4, 'BRI', '2022-12-05 09:25:23', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `fakultas`
--

CREATE TABLE `fakultas` (
  `id_fakultas` int(11) NOT NULL,
  `id_perguruan_tinggi` int(11) NOT NULL,
  `nama_fakultas` varchar(225) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `fakultas`
--

INSERT INTO `fakultas` (`id_fakultas`, `id_perguruan_tinggi`, `nama_fakultas`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 1, 'TEKNIK & INFORMATIKA', '2022-12-05 09:28:28', NULL, NULL, NULL),
(2, 1, 'KOMUNIKASI & BAHASA', '2022-12-05 09:28:28', NULL, NULL, NULL),
(3, 1, 'EKONOMI & BISNIS', '2022-12-05 09:28:47', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jalur_masuk`
--

CREATE TABLE `jalur_masuk` (
  `id_jalur` int(11) NOT NULL,
  `nama_jalur` varchar(255) NOT NULL,
  `is_tes` enum('1','0') NOT NULL,
  `is_mandiri` enum('1','0') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jalur_masuk`
--

INSERT INTO `jalur_masuk` (`id_jalur`, `nama_jalur`, `is_tes`, `is_mandiri`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'JALUR SNMPTN', '0', '0', '2022-12-05 09:22:12', NULL, NULL, NULL),
(2, 'JALUR MANDIRI TES', '1', '1', '2022-12-05 09:23:39', NULL, NULL, NULL),
(3, 'JALUR MANDIRI PRESTASI', '0', '1', '2022-12-05 09:23:39', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pendaftar`
--

CREATE TABLE `pendaftar` (
  `id_pendaftar` int(11) NOT NULL,
  `id_jalur` int(11) NOT NULL,
  `no_pendaftar` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nisn` varchar(15) DEFAULT NULL,
  `nik` varchar(20) DEFAULT NULL,
  `tempat_lahir` varchar(60) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `id_prodi1` int(11) NOT NULL,
  `id_prodi2` int(11) DEFAULT NULL,
  `nominal_bayar` decimal(12,2) DEFAULT NULL,
  `id_bank` int(11) DEFAULT NULL,
  `is_bayar` enum('1','0') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pendaftar`
--

INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `is_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 3, 'P202231', 'Dhea Putri Salsabila1', '12345671', '3507081204991', 'situbondo', '2001-10-30', 'Laki-laki', '0812178016191', 11, 5, '150000.00', NULL, '1', '2022-12-09 03:12:25', NULL, NULL, NULL),
(2, 1, 'P202212', 'Dhea Putri Salsabila2', '12345672', '3507081204992', 'situbondo', '2001-11-05', 'Laki-laki', '0812178016192', 2, 15, NULL, NULL, '1', '2022-12-09 03:12:25', NULL, NULL, NULL),
(3, 2, 'P202223', 'Dhea Putri Salsabila3', '12345673', '3507081204993', 'situbondo', '2001-11-13', 'Laki-laki', '0812178016193', 4, 13, '150000.00', NULL, '0', '2022-12-09 03:12:25', NULL, NULL, NULL),
(4, 3, 'P202234', 'Dhea Putri Salsabila4', '12345674', '3507081204994', 'situbondo', '2001-11-09', 'Laki-laki', '0812178016194', 13, 4, '150000.00', NULL, '1', '2022-12-09 03:12:25', NULL, NULL, NULL),
(5, 3, 'P202235', 'Dhea Putri Salsabila5', '12345675', '3507081204995', 'Jember', '2001-10-27', 'Perempuan', '0812178016195', 1, 5, '150000.00', NULL, '1', '2022-12-09 03:12:25', NULL, NULL, NULL),
(6, 3, 'P202236', 'Dhea Putri Salsabila6', '12345676', '3507081204996', 'situbondo', '2001-11-01', 'Laki-laki', '0812178016196', 6, 6, '150000.00', NULL, '0', '2022-12-09 03:12:25', NULL, NULL, NULL),
(7, 3, 'P202237', 'Dhea Putri Salsabila7', '12345677', '3507081204997', 'situbondo', '2001-10-22', 'Laki-laki', '0812178016197', 13, 12, '150000.00', NULL, '1', '2022-12-09 03:12:25', NULL, NULL, NULL),
(8, 1, 'P202218', 'Dhea Putri Salsabila8', '12345678', '3507081204998', 'situbondo', '2001-11-11', 'Laki-laki', '0812178016198', 2, 10, NULL, NULL, '1', '2022-12-09 03:12:25', NULL, NULL, NULL),
(9, 2, 'P202229', 'Dhea Putri Salsabila9', '12345679', '3507081204999', 'situbondo', '2001-10-28', 'Laki-laki', '0812178016199', 4, 1, '150000.00', NULL, '0', '2022-12-09 03:12:25', NULL, NULL, NULL),
(10, 2, 'P2022210', 'Dhea Putri Salsabila10', '123456710', '35070812049910', 'Jember', '2001-11-13', 'Perempuan', '08121780161910', 15, 9, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(11, 2, 'P2022211', 'Dhea Putri Salsabila11', '123456711', '35070812049911', 'situbondo', '2001-11-06', 'Laki-laki', '08121780161911', 11, 3, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(12, 3, 'P2022312', 'Dhea Putri Salsabila12', '123456712', '35070812049912', 'situbondo', '2001-11-10', 'Laki-laki', '08121780161912', 12, 7, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(13, 1, 'P2022113', 'Dhea Putri Salsabila13', '123456713', '35070812049913', 'situbondo', '2001-11-06', 'Laki-laki', '08121780161913', 1, 8, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(14, 2, 'P2022214', 'Dhea Putri Salsabila14', '123456714', '35070812049914', 'situbondo', '2001-10-28', 'Laki-laki', '08121780161914', 5, 10, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(15, 2, 'P2022215', 'Dhea Putri Salsabila15', '123456715', '35070812049915', 'Jember', '2001-10-28', 'Perempuan', '08121780161915', 10, 8, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(16, 1, 'P2022116', 'Dhea Putri Salsabila16', '123456716', '35070812049916', 'situbondo', '2001-11-03', 'Laki-laki', '08121780161916', 3, 14, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(17, 3, 'P2022317', 'Dhea Putri Salsabila17', '123456717', '35070812049917', 'situbondo', '2001-10-21', 'Laki-laki', '08121780161917', 11, 8, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(18, 2, 'P2022218', 'Dhea Putri Salsabila18', '123456718', '35070812049918', 'situbondo', '2001-11-07', 'Laki-laki', '08121780161918', 3, 10, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(19, 2, 'P2022219', 'Dhea Putri Salsabila19', '123456719', '35070812049919', 'situbondo', '2001-10-18', 'Laki-laki', '08121780161919', 6, 4, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(20, 3, 'P2022320', 'Dhea Putri Salsabila20', '123456720', '35070812049920', 'Jember', '2001-10-28', 'Perempuan', '08121780161920', 2, 6, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(21, 2, 'P2022221', 'Dhea Putri Salsabila21', '123456721', '35070812049921', 'situbondo', '2001-11-11', 'Laki-laki', '08121780161921', 1, 13, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(22, 2, 'P2022222', 'Dhea Putri Salsabila22', '123456722', '35070812049922', 'situbondo', '2001-11-11', 'Laki-laki', '08121780161922', 5, 5, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(23, 1, 'P2022123', 'Dhea Putri Salsabila23', '123456723', '35070812049923', 'situbondo', '2001-11-14', 'Laki-laki', '08121780161923', 12, 6, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(24, 1, 'P2022124', 'Dhea Putri Salsabila24', '123456724', '35070812049924', 'situbondo', '2001-10-23', 'Laki-laki', '08121780161924', 12, 9, NULL, NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(25, 2, 'P2022225', 'Dhea Putri Salsabila25', '123456725', '35070812049925', 'Jember', '2001-11-12', 'Perempuan', '08121780161925', 3, 13, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(26, 3, 'P2022326', 'Dhea Putri Salsabila26', '123456726', '35070812049926', 'situbondo', '2001-10-23', 'Laki-laki', '08121780161926', 10, 8, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(27, 1, 'P2022127', 'Dhea Putri Salsabila27', '123456727', '35070812049927', 'situbondo', '2001-10-27', 'Laki-laki', '08121780161927', 15, 1, NULL, NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(28, 1, 'P2022128', 'Dhea Putri Salsabila28', '123456728', '35070812049928', 'situbondo', '2001-10-26', 'Laki-laki', '08121780161928', 11, 11, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(29, 3, 'P2022329', 'Dhea Putri Salsabila29', '123456729', '35070812049929', 'situbondo', '2001-11-03', 'Laki-laki', '08121780161929', 12, 14, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(30, 3, 'P2022330', 'Dhea Putri Salsabila30', '123456730', '35070812049930', 'Jember', '2001-11-12', 'Perempuan', '08121780161930', 12, 1, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(31, 1, 'P2022131', 'Dhea Putri Salsabila31', '123456731', '35070812049931', 'situbondo', '2001-10-22', 'Laki-laki', '08121780161931', 6, 6, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(32, 1, 'P2022132', 'Dhea Putri Salsabila32', '123456732', '35070812049932', 'situbondo', '2001-11-03', 'Laki-laki', '08121780161932', 2, 5, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(33, 3, 'P2022333', 'Dhea Putri Salsabila33', '123456733', '35070812049933', 'situbondo', '2001-11-01', 'Laki-laki', '08121780161933', 9, 1, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(34, 2, 'P2022234', 'Dhea Putri Salsabila34', '123456734', '35070812049934', 'situbondo', '2001-10-22', 'Laki-laki', '08121780161934', 2, 13, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(35, 3, 'P2022335', 'Dhea Putri Salsabila35', '123456735', '35070812049935', 'Jember', '2001-10-26', 'Perempuan', '08121780161935', 3, 12, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(36, 3, 'P2022336', 'Dhea Putri Salsabila36', '123456736', '35070812049936', 'situbondo', '2001-10-29', 'Laki-laki', '08121780161936', 3, 14, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(37, 1, 'P2022137', 'Dhea Putri Salsabila37', '123456737', '35070812049937', 'situbondo', '2001-10-17', 'Laki-laki', '08121780161937', 12, 12, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(38, 1, 'P2022138', 'Dhea Putri Salsabila38', '123456738', '35070812049938', 'situbondo', '2001-10-19', 'Laki-laki', '08121780161938', 11, 6, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(39, 3, 'P2022339', 'Dhea Putri Salsabila39', '123456739', '35070812049939', 'situbondo', '2001-11-06', 'Laki-laki', '08121780161939', 8, 11, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(40, 1, 'P2022140', 'Dhea Putri Salsabila40', '123456740', '35070812049940', 'Jember', '2001-11-11', 'Perempuan', '08121780161940', 6, 12, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(41, 2, 'P2022241', 'Dhea Putri Salsabila41', '123456741', '35070812049941', 'situbondo', '2001-10-27', 'Laki-laki', '08121780161941', 7, 5, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(42, 1, 'P2022142', 'Dhea Putri Salsabila42', '123456742', '35070812049942', 'situbondo', '2001-10-18', 'Laki-laki', '08121780161942', 4, 12, NULL, NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(43, 2, 'P2022243', 'Dhea Putri Salsabila43', '123456743', '35070812049943', 'situbondo', '2001-11-09', 'Laki-laki', '08121780161943', 11, 8, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(44, 3, 'P2022344', 'Dhea Putri Salsabila44', '123456744', '35070812049944', 'situbondo', '2001-11-13', 'Laki-laki', '08121780161944', 10, 14, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(45, 2, 'P2022245', 'Dhea Putri Salsabila45', '123456745', '35070812049945', 'Jember', '2001-10-21', 'Perempuan', '08121780161945', 8, 12, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(46, 1, 'P2022146', 'Dhea Putri Salsabila46', '123456746', '35070812049946', 'situbondo', '2001-11-11', 'Laki-laki', '08121780161946', 5, 4, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(47, 3, 'P2022347', 'Dhea Putri Salsabila47', '123456747', '35070812049947', 'situbondo', '2001-10-20', 'Laki-laki', '08121780161947', 12, 4, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(48, 1, 'P2022148', 'Dhea Putri Salsabila48', '123456748', '35070812049948', 'situbondo', '2001-11-03', 'Laki-laki', '08121780161948', 1, 7, NULL, NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(49, 3, 'P2022349', 'Dhea Putri Salsabila49', '123456749', '35070812049949', 'situbondo', '2001-10-19', 'Laki-laki', '08121780161949', 15, 8, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(50, 1, 'P2022150', 'Dhea Putri Salsabila50', '123456750', '35070812049950', 'Jember', '2001-10-25', 'Perempuan', '08121780161950', 5, 7, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(51, 2, 'P2022251', 'Dhea Putri Salsabila51', '123456751', '35070812049951', 'situbondo', '2001-11-09', 'Laki-laki', '08121780161951', 13, 5, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(52, 1, 'P2022152', 'Dhea Putri Salsabila52', '123456752', '35070812049952', 'situbondo', '2001-11-05', 'Laki-laki', '08121780161952', 1, 11, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(53, 3, 'P2022353', 'Dhea Putri Salsabila53', '123456753', '35070812049953', 'situbondo', '2001-11-13', 'Laki-laki', '08121780161953', 15, 12, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(54, 2, 'P2022254', 'Dhea Putri Salsabila54', '123456754', '35070812049954', 'situbondo', '2001-11-08', 'Laki-laki', '08121780161954', 9, 3, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(55, 1, 'P2022155', 'Dhea Putri Salsabila55', '123456755', '35070812049955', 'Jember', '2001-11-13', 'Perempuan', '08121780161955', 14, 14, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(56, 1, 'P2022156', 'Dhea Putri Salsabila56', '123456756', '35070812049956', 'situbondo', '2001-11-08', 'Laki-laki', '08121780161956', 2, 5, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(57, 1, 'P2022157', 'Dhea Putri Salsabila57', '123456757', '35070812049957', 'situbondo', '2001-11-15', 'Laki-laki', '08121780161957', 6, 12, NULL, NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(58, 1, 'P2022158', 'Dhea Putri Salsabila58', '123456758', '35070812049958', 'situbondo', '2001-10-28', 'Laki-laki', '08121780161958', 11, 1, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(59, 3, 'P2022359', 'Dhea Putri Salsabila59', '123456759', '35070812049959', 'situbondo', '2001-10-26', 'Laki-laki', '08121780161959', 9, 13, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(60, 2, 'P2022260', 'Dhea Putri Salsabila60', '123456760', '35070812049960', 'Jember', '2001-11-02', 'Perempuan', '08121780161960', 7, 10, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(61, 2, 'P2022261', 'Dhea Putri Salsabila61', '123456761', '35070812049961', 'situbondo', '2001-10-25', 'Laki-laki', '08121780161961', 12, 7, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(62, 2, 'P2022262', 'Dhea Putri Salsabila62', '123456762', '35070812049962', 'situbondo', '2001-11-04', 'Laki-laki', '08121780161962', 12, 1, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(63, 3, 'P2022363', 'Dhea Putri Salsabila63', '123456763', '35070812049963', 'situbondo', '2001-10-19', 'Laki-laki', '08121780161963', 5, 7, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(64, 1, 'P2022164', 'Dhea Putri Salsabila64', '123456764', '35070812049964', 'situbondo', '2001-10-22', 'Laki-laki', '08121780161964', 13, 6, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(65, 1, 'P2022165', 'Dhea Putri Salsabila65', '123456765', '35070812049965', 'Jember', '2001-10-18', 'Perempuan', '08121780161965', 7, 12, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(66, 2, 'P2022266', 'Dhea Putri Salsabila66', '123456766', '35070812049966', 'situbondo', '2001-10-24', 'Laki-laki', '08121780161966', 12, 4, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(67, 1, 'P2022167', 'Dhea Putri Salsabila67', '123456767', '35070812049967', 'situbondo', '2001-10-19', 'Laki-laki', '08121780161967', 11, 7, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(68, 1, 'P2022168', 'Dhea Putri Salsabila68', '123456768', '35070812049968', 'situbondo', '2001-10-21', 'Laki-laki', '08121780161968', 3, 4, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(69, 1, 'P2022169', 'Dhea Putri Salsabila69', '123456769', '35070812049969', 'situbondo', '2001-10-31', 'Laki-laki', '08121780161969', 13, 4, NULL, NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(70, 2, 'P2022270', 'Dhea Putri Salsabila70', '123456770', '35070812049970', 'Jember', '2001-11-12', 'Perempuan', '08121780161970', 6, 3, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(71, 2, 'P2022271', 'Dhea Putri Salsabila71', '123456771', '35070812049971', 'situbondo', '2001-11-10', 'Laki-laki', '08121780161971', 8, 15, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(72, 1, 'P2022172', 'Dhea Putri Salsabila72', '123456772', '35070812049972', 'situbondo', '2001-10-22', 'Laki-laki', '08121780161972', 9, 6, NULL, NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(73, 1, 'P2022173', 'Dhea Putri Salsabila73', '123456773', '35070812049973', 'situbondo', '2001-11-09', 'Laki-laki', '08121780161973', 14, 10, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(74, 3, 'P2022374', 'Dhea Putri Salsabila74', '123456774', '35070812049974', 'situbondo', '2001-11-02', 'Laki-laki', '08121780161974', 8, 7, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(75, 2, 'P2022275', 'Dhea Putri Salsabila75', '123456775', '35070812049975', 'Jember', '2001-11-04', 'Perempuan', '08121780161975', 1, 8, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(76, 2, 'P2022276', 'Dhea Putri Salsabila76', '123456776', '35070812049976', 'situbondo', '2001-10-29', 'Laki-laki', '08121780161976', 5, 1, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(77, 3, 'P2022377', 'Dhea Putri Salsabila77', '123456777', '35070812049977', 'situbondo', '2001-11-07', 'Laki-laki', '08121780161977', 12, 1, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(78, 1, 'P2022178', 'Dhea Putri Salsabila78', '123456778', '35070812049978', 'situbondo', '2001-11-06', 'Laki-laki', '08121780161978', 2, 7, NULL, NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(79, 2, 'P2022279', 'Dhea Putri Salsabila79', '123456779', '35070812049979', 'situbondo', '2001-11-01', 'Laki-laki', '08121780161979', 3, 6, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(80, 3, 'P2022380', 'Dhea Putri Salsabila80', '123456780', '35070812049980', 'Jember', '2001-11-09', 'Perempuan', '08121780161980', 14, 3, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(81, 3, 'P2022381', 'Dhea Putri Salsabila81', '123456781', '35070812049981', 'situbondo', '2001-11-04', 'Laki-laki', '08121780161981', 13, 6, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(82, 2, 'P2022282', 'Dhea Putri Salsabila82', '123456782', '35070812049982', 'situbondo', '2001-10-31', 'Laki-laki', '08121780161982', 11, 7, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(83, 2, 'P2022283', 'Dhea Putri Salsabila83', '123456783', '35070812049983', 'situbondo', '2001-10-26', 'Laki-laki', '08121780161983', 14, 9, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(84, 2, 'P2022284', 'Dhea Putri Salsabila84', '123456784', '35070812049984', 'situbondo', '2001-10-30', 'Laki-laki', '08121780161984', 6, 2, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(85, 3, 'P2022385', 'Dhea Putri Salsabila85', '123456785', '35070812049985', 'Jember', '2001-11-06', 'Perempuan', '08121780161985', 12, 7, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(86, 2, 'P2022286', 'Dhea Putri Salsabila86', '123456786', '35070812049986', 'situbondo', '2001-11-06', 'Laki-laki', '08121780161986', 13, 1, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(87, 2, 'P2022287', 'Dhea Putri Salsabila87', '123456787', '35070812049987', 'situbondo', '2001-10-24', 'Laki-laki', '08121780161987', 10, 1, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(88, 3, 'P2022388', 'Dhea Putri Salsabila88', '123456788', '35070812049988', 'situbondo', '2001-11-03', 'Laki-laki', '08121780161988', 6, 6, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(89, 2, 'P2022289', 'Dhea Putri Salsabila89', '123456789', '35070812049989', 'situbondo', '2001-11-09', 'Laki-laki', '08121780161989', 6, 6, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(90, 3, 'P2022390', 'Dhea Putri Salsabila90', '123456790', '35070812049990', 'Jember', '2001-11-07', 'Perempuan', '08121780161990', 15, 9, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(91, 1, 'P2022191', 'Dhea Putri Salsabila91', '123456791', '35070812049991', 'situbondo', '2001-11-05', 'Laki-laki', '08121780161991', 7, 13, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(92, 2, 'P2022292', 'Dhea Putri Salsabila92', '123456792', '35070812049992', 'situbondo', '2001-11-03', 'Laki-laki', '08121780161992', 4, 3, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(93, 3, 'P2022393', 'Dhea Putri Salsabila93', '123456793', '35070812049993', 'situbondo', '2001-10-25', 'Laki-laki', '08121780161993', 8, 10, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(94, 1, 'P2022194', 'Dhea Putri Salsabila94', '123456794', '35070812049994', 'situbondo', '2001-11-03', 'Laki-laki', '08121780161994', 14, 10, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(95, 2, 'P2022295', 'Dhea Putri Salsabila95', '123456795', '35070812049995', 'Jember', '2001-11-14', 'Perempuan', '08121780161995', 1, 1, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(96, 2, 'P2022296', 'Dhea Putri Salsabila96', '123456796', '35070812049996', 'situbondo', '2001-11-11', 'Laki-laki', '08121780161996', 1, 9, '150000.00', NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(97, 3, 'P2022397', 'Dhea Putri Salsabila97', '123456797', '35070812049997', 'situbondo', '2001-10-22', 'Laki-laki', '08121780161997', 4, 10, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(98, 2, 'P2022298', 'Dhea Putri Salsabila98', '123456798', '35070812049998', 'situbondo', '2001-10-31', 'Laki-laki', '08121780161998', 15, 13, '150000.00', NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL),
(99, 1, 'P2022199', 'Dhea Putri Salsabila99', '123456799', '35070812049999', 'situbondo', '2001-10-20', 'Laki-laki', '08121780161999', 8, 1, NULL, NULL, '0', '2022-12-09 03:12:26', NULL, NULL, NULL),
(100, 1, 'P20221100', 'Dhea Putri Salsabila100', '1234567100', '350708120499100', 'Jember', '2001-11-09', 'Perempuan', '081217801619100', 7, 10, NULL, NULL, '1', '2022-12-09 03:12:26', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pendaftar_prestasi`
--

CREATE TABLE `pendaftar_prestasi` (
  `id` int(11) NOT NULL,
  `id_pendaftar` int(11) NOT NULL DEFAULT 0,
  `tingkat_prestasi` enum('Nasional','Internasional') NOT NULL DEFAULT 'Nasional',
  `nama_prestasi` varchar(255) NOT NULL,
  `tahun` int(11) NOT NULL,
  `url_dokumen` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pendaftar_prestasi`
--

INSERT INTO `pendaftar_prestasi` (`id`, `id_pendaftar`, `tingkat_prestasi`, `nama_prestasi`, `tahun`, `url_dokumen`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(37, 1, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila1', 2022, 'public/upload/prestasi/1', '2022-12-09 03:12:25', NULL, NULL, NULL),
(38, 4, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila4', 2022, 'public/upload/prestasi/4', '2022-12-09 03:12:25', NULL, NULL, NULL),
(39, 5, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila5', 2022, 'public/upload/prestasi/5', '2022-12-09 03:12:25', NULL, NULL, NULL),
(40, 6, 'Internasional', 'PrestasiINTERNASIONAL Dhea Putri Salsabila6', 2021, 'public/upload/prestasi/6', '2022-12-09 03:12:25', NULL, NULL, NULL),
(41, 7, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila7', 2022, 'public/upload/prestasi/7', '2022-12-09 03:12:25', NULL, NULL, NULL),
(42, 12, 'Internasional', 'PrestasiINTERNASIONAL Dhea Putri Salsabila12', 2021, 'public/upload/prestasi/12', '2022-12-09 03:12:26', NULL, NULL, NULL),
(43, 17, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila17', 2022, 'public/upload/prestasi/17', '2022-12-09 03:12:26', NULL, NULL, NULL),
(44, 20, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila20', 2022, 'public/upload/prestasi/20', '2022-12-09 03:12:26', NULL, NULL, NULL),
(45, 26, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila26', 2022, 'public/upload/prestasi/26', '2022-12-09 03:12:26', NULL, NULL, NULL),
(46, 29, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila29', 2022, 'public/upload/prestasi/29', '2022-12-09 03:12:26', NULL, NULL, NULL),
(47, 30, 'Internasional', 'PrestasiINTERNASIONAL Dhea Putri Salsabila30', 2021, 'public/upload/prestasi/30', '2022-12-09 03:12:26', NULL, NULL, NULL),
(48, 33, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila33', 2022, 'public/upload/prestasi/33', '2022-12-09 03:12:26', NULL, NULL, NULL),
(49, 35, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila35', 2022, 'public/upload/prestasi/35', '2022-12-09 03:12:26', NULL, NULL, NULL),
(50, 36, 'Internasional', 'PrestasiINTERNASIONAL Dhea Putri Salsabila36', 2021, 'public/upload/prestasi/36', '2022-12-09 03:12:26', NULL, NULL, NULL),
(51, 39, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila39', 2022, 'public/upload/prestasi/39', '2022-12-09 03:12:26', NULL, NULL, NULL),
(52, 44, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila44', 2022, 'public/upload/prestasi/44', '2022-12-09 03:12:26', NULL, NULL, NULL),
(53, 47, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila47', 2022, 'public/upload/prestasi/47', '2022-12-09 03:12:26', NULL, NULL, NULL),
(54, 49, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila49', 2022, 'public/upload/prestasi/49', '2022-12-09 03:12:26', NULL, NULL, NULL),
(55, 53, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila53', 2022, 'public/upload/prestasi/53', '2022-12-09 03:12:26', NULL, NULL, NULL),
(56, 59, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila59', 2022, 'public/upload/prestasi/59', '2022-12-09 03:12:26', NULL, NULL, NULL),
(57, 63, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila63', 2022, 'public/upload/prestasi/63', '2022-12-09 03:12:26', NULL, NULL, NULL),
(58, 74, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila74', 2022, 'public/upload/prestasi/74', '2022-12-09 03:12:26', NULL, NULL, NULL),
(59, 77, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila77', 2022, 'public/upload/prestasi/77', '2022-12-09 03:12:26', NULL, NULL, NULL),
(60, 80, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila80', 2022, 'public/upload/prestasi/80', '2022-12-09 03:12:26', NULL, NULL, NULL),
(61, 81, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila81', 2022, 'public/upload/prestasi/81', '2022-12-09 03:12:26', NULL, NULL, NULL),
(62, 85, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila85', 2022, 'public/upload/prestasi/85', '2022-12-09 03:12:26', NULL, NULL, NULL),
(63, 88, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila88', 2022, 'public/upload/prestasi/88', '2022-12-09 03:12:26', NULL, NULL, NULL),
(64, 90, 'Internasional', 'PrestasiINTERNASIONAL Dhea Putri Salsabila90', 2021, 'public/upload/prestasi/90', '2022-12-09 03:12:26', NULL, NULL, NULL),
(65, 93, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila93', 2022, 'public/upload/prestasi/93', '2022-12-09 03:12:26', NULL, NULL, NULL),
(66, 97, 'Nasional', 'PrestasiNASIONAL Dhea Putri Salsabila97', 2022, 'public/upload/prestasi/97', '2022-12-09 03:12:26', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `perguruan_tinggi`
--

CREATE TABLE `perguruan_tinggi` (
  `id_perguruan_tinggi` int(15) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `updated_by` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `perguruan_tinggi`
--

INSERT INTO `perguruan_tinggi` (`id_perguruan_tinggi`, `nama`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 'Universitas Malang', '2022-12-09 03:13:20', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `prodi`
--

CREATE TABLE `prodi` (
  `id_prodi` int(11) NOT NULL,
  `id_fakultas` int(11) NOT NULL,
  `nama_prodi` varchar(255) NOT NULL,
  `jenjang` enum('S1','S2') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `prodi`
--

INSERT INTO `prodi` (`id_prodi`, `id_fakultas`, `nama_prodi`, `jenjang`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 1, 'SISTEM INFORMASI', 'S1', '2022-12-05 09:30:55', NULL, NULL, NULL),
(2, 1, 'TEKNOLOGI INFORMASI', 'S1', '2022-12-05 09:30:55', NULL, NULL, NULL),
(3, 1, 'REKAYASA PERANGKAT LUNAK', 'S1', '2022-12-05 09:32:34', NULL, NULL, NULL),
(4, 1, 'ILMU KOMPUTER', 'S1', '2022-12-05 09:32:34', NULL, NULL, NULL),
(5, 2, 'ILMU KOMUNIKASI', 'S1', '2022-12-05 09:33:32', NULL, NULL, NULL),
(6, 2, 'SASTRA INGGRIS', 'S1', '2022-12-05 09:33:32', NULL, NULL, NULL),
(7, 3, 'MANAJEMEN', 'S1', '2022-12-05 09:34:14', NULL, NULL, NULL),
(8, 3, 'AKUNTANSI', 'S1', '2022-12-05 09:34:14', NULL, NULL, NULL),
(9, 3, 'PERHOTELAN', 'S1', '2022-12-05 09:35:02', NULL, NULL, NULL),
(10, 1, 'SISTEM INFORMASI', 'S2', '2022-12-05 09:36:00', NULL, NULL, NULL),
(11, 1, 'TEKNOLOGI KOMPUTER', 'S2', '2022-12-05 09:36:00', NULL, NULL, NULL),
(12, 2, 'PUBLIC RELATIONS', 'S2', '2022-12-05 09:36:36', NULL, NULL, NULL),
(13, 2, 'BAHASA INGGRIS', 'S2', '2022-12-05 09:36:36', NULL, NULL, NULL),
(14, 3, 'MANAJEMEN PAJAK', 'S2', '2022-12-05 09:37:31', NULL, NULL, NULL),
(15, 3, 'ADMINISTRASI PERKANTORAN', 'S2', '2022-12-05 09:37:31', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indeks untuk tabel `fakultas`
--
ALTER TABLE `fakultas`
  ADD PRIMARY KEY (`id_fakultas`),
  ADD KEY `id_perguruan_tinggi` (`id_perguruan_tinggi`);

--
-- Indeks untuk tabel `jalur_masuk`
--
ALTER TABLE `jalur_masuk`
  ADD PRIMARY KEY (`id_jalur`);

--
-- Indeks untuk tabel `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD PRIMARY KEY (`id_pendaftar`),
  ADD UNIQUE KEY `no_pendaftar` (`no_pendaftar`),
  ADD KEY `id_prodi1` (`id_prodi1`),
  ADD KEY `id_prodi2` (`id_prodi2`),
  ADD KEY `id_jalur` (`id_jalur`),
  ADD KEY `id_bank` (`id_bank`);

--
-- Indeks untuk tabel `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pendaftar` (`id_pendaftar`);

--
-- Indeks untuk tabel `perguruan_tinggi`
--
ALTER TABLE `perguruan_tinggi`
  ADD PRIMARY KEY (`id_perguruan_tinggi`);

--
-- Indeks untuk tabel `prodi`
--
ALTER TABLE `prodi`
  ADD PRIMARY KEY (`id_prodi`),
  ADD KEY `id_fakultas` (`id_fakultas`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `fakultas`
--
ALTER TABLE `fakultas`
  MODIFY `id_fakultas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `jalur_masuk`
--
ALTER TABLE `jalur_masuk`
  MODIFY `id_jalur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `pendaftar`
--
ALTER TABLE `pendaftar`
  MODIFY `id_pendaftar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT untuk tabel `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT untuk tabel `perguruan_tinggi`
--
ALTER TABLE `perguruan_tinggi`
  MODIFY `id_perguruan_tinggi` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `prodi`
--
ALTER TABLE `prodi`
  MODIFY `id_prodi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `fakultas`
--
ALTER TABLE `fakultas`
  ADD CONSTRAINT `fakultas_ibfk_1` FOREIGN KEY (`id_perguruan_tinggi`) REFERENCES `perguruan_tinggi` (`id_perguruan_tinggi`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD CONSTRAINT `pendaftar_ibfk_1` FOREIGN KEY (`id_prodi1`) REFERENCES `prodi` (`id_prodi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_2` FOREIGN KEY (`id_prodi2`) REFERENCES `prodi` (`id_prodi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_3` FOREIGN KEY (`id_jalur`) REFERENCES `jalur_masuk` (`id_jalur`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_4` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  ADD CONSTRAINT `pendaftar_prestasi_ibfk_1` FOREIGN KEY (`id_pendaftar`) REFERENCES `pendaftar` (`id_pendaftar`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `prodi`
--
ALTER TABLE `prodi`
  ADD CONSTRAINT `prodi_ibfk_1` FOREIGN KEY (`id_fakultas`) REFERENCES `fakultas` (`id_fakultas`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
