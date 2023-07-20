-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2023 at 03:25 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `getsurvey`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `surveycount` ()   BEGIN
	DECLARE first_name varchar(30);
	DECLARE last_name varchar(30);
DECLARE count INT(5);
    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR SELECT users.firstname, users.lastname, COUNT(surveys.user_id) FROM users
JOIN surveys ON surveys.user_id = users.user_id 
GROUP BY users.firstname;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = 1;
    OPEN cur;
    CREATE TEMPORARY TABLE users_name(full_name VARCHAR(60), survey_count INT(5));
   	fetch_loop : LOOP
    FETCH cur INTO first_name, last_name, count;
    IF done THEN
    	LEAVE fetch_loop;
    END IF;
    INSERT INTO users_name(full_name, survey_count) VALUES (CONCAT(first_name, " ", last_name),count);
    END LOOP;
    CLOSE cur;
    SELECT full_name, survey_count FROM users_name;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `call_name` (`id` INT(5)) RETURNS VARCHAR(60) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  RETURN (SELECT CONCAT (firstname, " ", lastname) FROM users WHERE user_id = id)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `surveys`
--

CREATE TABLE `surveys` (
  `survey_id` int(20) NOT NULL,
  `title` varchar(1000) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `description` text DEFAULT NULL,
  `user_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `surveys`
--

INSERT INTO `surveys` (`survey_id`, `title`, `status`, `description`, `user_id`) VALUES
(1, 'Pengenalan Teknologi Canggih', 1, 'Survey mengenai teknologi canggih dan perkembangannya.', 1),
(2, 'Masa Depan Kecerdasan Buatan', 1, 'Survey mengenai AI dan potensinya untuk mengubah dunia.', 1),
(3, 'Kecanggihan Internet of Things', 1, 'Survey tentang IoT dan bagaimana ia terhubung dalam kehidupan sehari-hari.', 1),
(4, 'Revolusi 5G: Transformasi Komunikasi', 1, 'Survey mengenai jaringan 5G dan dampaknya pada teknologi dan komunikasi.', 2),
(5, 'Penerapan Teknologi Blockchain', 1, 'Survey tentang teknologi blockchain dan potensinya di berbagai industri.', 2),
(6, 'Kemajuan Teknologi Robotika', 1, 'Survey tentang robotika dan peranannya dalam otomatisasi industri.', 2),
(7, 'Keamanan Cyber di Era Digital', 1, 'Survey tentang tantangan keamanan siber dan upaya melindungi data.', 2),
(8, 'Kesenjangan Teknologi di Dunia', 1, 'Survey tentang kesenjangan digital dan upaya mengatasinya.', 3),
(9, 'Mendahului dengan Teknologi Quantum', 1, 'Survey tentang komputasi kuantum dan implikasinya pada ilmu pengetahuan dan industri.', 3),
(10, 'Potensi Internet di Luar Angkasa', 1, 'Survey tentang konektivitas internet di luar angkasa dan eksplorasi ruang angkasa.', 3),
(11, 'Berkembangnya Teknologi Nanoteknologi', 1, 'Survey tentang nanoteknologi dan aplikasinya dalam berbagai bidang.', 4),
(12, 'Era Mobil Listrik dan Kendaraan Otonom', 1, 'Survey tentang perubahan transportasi dengan adopsi mobil listrik dan otonom.', 4),
(13, 'Kekuatan Teknologi Biometrik', 1, 'Survey tentang identifikasi biometrik dan penggunaannya dalam keamanan dan kehidupan sehari-hari.', 4),
(14, 'Revolution Industri 4.0', 1, 'Survey tentang industri 4.0 dan transformasi digital pada sektor manufaktur.', 5),
(15, 'Penerapan Realitas Virtual dan Augmented', 1, 'Survey tentang VR dan AR serta penggunaannya dalam pendidikan dan hiburan.', 5),
(16, 'Penggunaan Teknologi 3D Printing', 1, 'Survey tentang 3D printing dan potensinya dalam mencetak berbagai objek.', 5),
(17, 'Eksplorasi Teknologi Quantum Computing', 1, 'Survey tentang komputasi kuantum dan penelitiannya dalam mengatasi masalah kompleks.', 5),
(18, 'Penerapan Teknologi Big Data', 1, 'Survey tentang big data dan analisis data untuk mendapatkan wawasan bisnis.', 6),
(19, 'Peran Teknologi Dalam Perubahan Sosial', 1, 'Survey tentang bagaimana teknologi membentuk masyarakat dan budaya.', 7),
(20, 'Keamanan dan Privasi di Era Teknologi', 1, 'Survey tentang tantangan privasi dan keamanan dalam era digital.', 8),
(21, 'Masa Depan Teknologi Kesehatan', 1, 'Survey tentang inovasi teknologi di bidang kesehatan dan perawatan medis.', 9),
(22, 'Robotika dalam Industri Manufaktur', 1, 'Survey tentang penerapan robotika di lini produksi industri.', 10),
(23, 'Perkembangan Teknologi Energi Terbarukan', 1, 'Survey tentang teknologi energi terbarukan seperti surya, angin, dan hidrogen.', 10),
(24, 'Aplikasi Teknologi dalam Pertanian', 1, 'Survey tentang teknologi digital dan IoT dalam sektor pertanian.', 10),
(25, 'Peran Teknologi dalam Pendidikan Jarak Jauh', 1, 'Survey tentang penerapan teknologi dalam pendidikan jarak jauh.', 10),
(26, 'Teknologi Terapan di Bidang Medis', 1, 'Survey tentang teknologi yang digunakan dalam bidang medis untuk diagnosis dan perawatan.', 10),
(27, 'Keuntungan dan Tantangan Teknologi Cloud Computing', 1, 'Survey tentang keuntungan dan tantangan penggunaan cloud computing.', 11),
(28, 'Penerapan Teknologi Smart City', 1, 'Survey tentang konsep smart city dan integrasi teknologi dalam kota.', 11),
(29, 'Peran Teknologi dalam Pengembangan Kendaraan Listrik', 1, 'Survey tentang teknologi yang digunakan dalam pengembangan mobil listrik.', 12),
(30, 'Revolusi Teknologi dalam Industri Keuangan', 1, 'Survey tentang perkembangan teknologi di sektor keuangan.', 12),
(31, 'Pemanfaatan Teknologi AI di Dunia Bisnis', 1, 'Survey tentang kecerdasan buatan dalam meningkatkan efisiensi bisnis.', 13),
(32, 'Tantangan dan Potensi Teknologi Quantum Computing', 1, 'Survey tentang tantangan dan potensi komputasi kuantum.', 14),
(33, 'Masa Depan Teknologi Kendaraan Otonom', 1, 'Survey tentang masa depan transportasi dengan kendaraan otonom.', 14),
(34, 'Revolution 3D Printing dalam Industri', 1, 'Survey tentang dampak teknologi 3D printing di berbagai sektor industri.', 14),
(35, 'Mendahului dengan Teknologi Dalam Pendidikan', 1, 'Survey tentang penerapan teknologi dalam pembelajaran dan pengembangan kurikulum.', 15),
(36, 'Peran Teknologi dalam Penyediaan Energi', 1, 'Survey tentang teknologi yang digunakan dalam menyediakan energi.', 15),
(37, 'Era Digitalisasi dan Transformasi Bisnis', 1, 'Survey tentang transformasi digital dalam bisnis dan model operasi.', 15),
(38, 'Masa Depan Teknologi Internet of Things', 1, 'Survey tentang potensi IoT untuk menghubungkan segala sesuatu.', 16),
(39, 'Inovasi Teknologi di Industri Kesehatan', 1, 'Survey tentang inovasi teknologi yang mendorong kemajuan di bidang kesehatan.', 16),
(40, 'Penerapan Teknologi Augmented Reality di Industri', 1, 'Survey tentang pemanfaatan augmented reality dalam berbagai sektor industri.', 16),
(41, 'Keamanan Cyber dan Perlindungan Data', 1, 'Survey tentang tantangan keamanan siber dan perlindungan data sensitif.', 16),
(42, 'Penerapan Teknologi dalam Pelayanan Publik', 1, 'Survey tentang penggunaan teknologi untuk meningkatkan pelayanan publik.', 16),
(43, 'Pemanfaatan Teknologi Dalam Transportasi Publik', 1, 'Survey tentang teknologi yang diterapkan dalam transportasi umum.', 16),
(44, 'Kemajuan Teknologi dalam Bidang Kesehatan', 1, 'Survey tentang penggunaan teknologi dalam diagnosis dan perawatan medis.', 16),
(45, 'Teknologi dan Inovasi di Dunia Pendidikan', 1, 'Survey tentang penerapan teknologi dalam proses pembelajaran.', 16),
(46, 'Manfaat dan Tantangan Teknologi Terapan', 0, 'Survey tentang manfaat dan tantangan teknologi dalam kehidupan sehari-hari.', 16),
(47, 'Revolusi Teknologi dalam Industri Otomotif', 0, 'Survey tentang inovasi teknologi dalam industri otomotif.', 17),
(48, 'Penerapan Teknologi Dalam Olahraga', 0, 'Survey tentang teknologi yang diterapkan dalam bidang olahraga.', 17),
(49, 'Keamanan Data dan Privasi di Era Digital', 0, 'Survey tentang tantangan keamanan data dan privasi dalam era digital.', 17),
(50, 'Peran Teknologi dalam Pembangunan Berkelanjutan', 1, 'Survey tentang kontribusi teknologi dalam upaya pembangunan berkelanjutan.', 17);

--
-- Triggers `surveys`
--
DELIMITER $$
CREATE TRIGGER `after_update_surveys` AFTER UPDATE ON `surveys` FOR EACH ROW INSERT INTO surveys_log (survey_id, title, status, description, user_id, date)
    VALUES (OLD.survey_id, OLD.title, OLD.status, OLD.description, OLD.user_id, NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `surveys_log`
--

CREATE TABLE `surveys_log` (
  `log_id` int(11) NOT NULL,
  `survey_id` int(11) DEFAULT NULL,
  `title` varchar(1000) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `surveys_log`
--

INSERT INTO `surveys_log` (`log_id`, `survey_id`, `title`, `status`, `description`, `user_id`, `date`) VALUES
(1, 50, 'Peran Teknologi dalam Pembangunan Berkelanjutan', 0, 'Survey tentang kontribusi teknologi dalam upaya pembangunan berkelanjutan.', 17, '2023-07-20 17:02:55');

-- --------------------------------------------------------

--
-- Table structure for table `survey_answers`
--

CREATE TABLE `survey_answers` (
  `answer_id` int(20) NOT NULL,
  `surveyor` varchar(10) DEFAULT NULL,
  `survey_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `survey_answers`
--

INSERT INTO `survey_answers` (`answer_id`, `surveyor`, `survey_id`) VALUES
(1, 'Adi', 1),
(2, 'Ani', 1),
(3, 'Budi', 1),
(4, 'Joko', 1),
(5, 'Dewi', 2),
(6, 'Siti', 2),
(7, 'Rina', 3),
(8, 'Andi', 3),
(9, 'Hadi', 3),
(10, 'Desi', 4),
(11, 'Rini', 4),
(12, 'Maya', 4),
(13, 'Yuni', 8),
(14, 'Putri', 8),
(15, 'Agus', 8),
(16, 'Rini', 8);

-- --------------------------------------------------------

--
-- Table structure for table `survey_questions`
--

CREATE TABLE `survey_questions` (
  `question_id` int(20) NOT NULL,
  `type` varchar(45) NOT NULL,
  `question` varchar(1000) NOT NULL,
  `description` text DEFAULT NULL,
  `options` text DEFAULT NULL,
  `survey_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `survey_questions`
--

INSERT INTO `survey_questions` (`question_id`, `type`, `question`, `description`, `options`, `survey_id`) VALUES
(1, 'text', 'Pernahkah Anda menggunakan atau berinteraksi dengan teknologi canggih dalam kehidupan sehari-hari?', 'jika iya, jelaskan dan berilah contohnya', '', 1),
(2, 'text', 'Menurut Anda, apa manfaat utama dari penggunaan teknologi canggih dalam masyarakat?', 'jelaskan secara singkat', '', 1),
(3, 'checkbox', 'Berapa banyak Anda tertarik untuk mempelajari lebih lanjut tentang teknologi canggih?', 'pilih sesuai preferensi anda', 'Sangat Tertarik,Tertarik, Netral, Tidak Tertarik, Sangat Tidak Tertarik', 1),
(4, 'select', 'Seberapa akrab Anda dengan istilah \"Kecerdasan Buatan\" (Artificial Intelligence/AI)?', 'pilih sesuai preferensi anda', 'Sangat Akrab, Cukup Akrab, Kurang Akrab, Tidak Tahu Sama Sekali', 2),
(5, 'text', 'Menurut Anda, apa manfaat utama dari pemanfaatan kecerdasan buatan dalam berbagai bidang?', 'jelaskan secara singkat', '', 2),
(6, 'select', 'Seberapa akrab Anda dengan istilah \"Internet of Things\" (IoT)?', 'pilih sesuai preferensi anda', 'Sangat Akrab, Cukup Akrab, Kurang Akrab, Tidak Tahu Sama Sekali', 3),
(7, 'checkbox', 'Seberapa tertarik Anda untuk mempelajari lebih lanjut tentang Internet of Things (IoT)?', 'pilih sesuai preferensi anda', 'Sangat Tertarik,Tertarik, Netral, Tidak Tertarik, Sangat Tidak Tertarik', 3),
(8, 'checkbox', 'Apakah Anda memiliki pemahaman yang baik tentang bagaimana teknologi 5G berbeda dari generasi sebelumnya (misalnya, 4G)?', 'pilih sesuai preferensi anda', 'Sangat Paham, Paham, Sedikit Paham, Tidak Paham, Tidak Tahu Sama Sekali', 4),
(9, 'textarea', 'Apa harapan Anda tentang bagaimana teknologi 5G dapat membawa transformasi dalam cara kita berkomunikasi dan berinteraksi di masa depan?', 'jelaskan secara detail', '', 4),
(10, 'textarea', 'Apakah perusahaan Anda telah menjalankan atau berencana untuk menerapkan teknologi blockchain dalam operasionalnya?', 'jika iya, jelaskan dan berilah contohnya', '', 5),
(11, 'textarea', 'Sejauh mana perusahaan Anda mengenal dan memahami konsep dasar teknologi blockchain?', 'jika iya, jelaskan dan berilah contohnya', '', 5),
(12, 'textarea', 'Apakah Anda telah melakukan uji coba atau implementasi teknologi blockchain di perusahaan Anda?', ' Jika ya, jelaskan seberapa sukses implementasinya', '', 5),
(13, 'textarea', 'Bagaimana Anda mengevaluasi potensi manfaat dari penerapan teknologi blockchain terhadap efisiensi operasional dan pengurangan biaya?', 'jelaskan secara detail', '', 5),
(14, 'select', 'Apakah Anda mengenal teknologi robotika?', 'pilih opsi dibawah ini', 'ya, tidak', 6),
(15, 'select', 'Seberapa familiar Anda dengan perkembangan terkini dalam bidang robotika?', 'pilih opsi dibawah ini', 'Sangat familiar, Cukup familiar, Kurang familiar, Tidak familiar sama sekali', 6),
(16, 'select', 'Bagaimana tingkat kepercayaan Anda terhadap kemajuan teknologi robotika dalam meningkatkan kehidupan sehari-hari?', 'pilih opsi dibawah ini', 'Sangat percaya, Cukup percaya, Tidak yakin, Tidak percaya sama sekali', 6),
(17, 'checkbox', 'Pernahkah Anda menjadi korban kejahatan cyber atau serangan siber? ', 'Pilih semua yang berlaku', ' Ya, serangan malware/ransomware; Ya, pencurian data pribadi; Ya, phishing (penipuan online); Ya, serangan DDoS (Denial of Service); Ya, peretasan akun online (hacking); Tidak pernah menjadi korban serangan cyber', 7),
(18, 'checkbox', 'Apakah Anda menggunakan autentikasi dua faktor (2FA) untuk akun online yang mendukungnya?', 'Pilih semua yang berlaku', ' Ya, untuk sebagian besar akun online saya; Ya, untuk beberapa akun online tertentu saja; Tidak, saya tidak tahu apa itu autentikasi dua faktor (2FA); Tidak, saya tidak merasa perlu menggunakan autentikasi dua faktor', 7),
(19, 'select', 'Apakah Anda percaya bahwa ada kesenjangan teknologi antara negara-negara maju dan negara-negara berkembang?', 'pilih opsi dibawah ini', ' Ya; Tidak; Tidak yakin', 8),
(20, 'text', 'Berikan contoh proyek atau inisiatif teknologi di negara berkembang yang menurut Anda berhasil mengatasi kesenjangan teknologi.', 'jelaskan secara singkat', '', 8),
(21, 'text', 'Apakah Anda memiliki pemahaman dasar tentang teknologi quantum?', 'jelaskan secara singkat', '', 9),
(22, 'text', 'Berikan contoh kasus penggunaan atau aplikasi potensial teknologi quantum yang menurut Anda menarik.', 'jelaskan secara singkat', '', 9);

-- --------------------------------------------------------

--
-- Table structure for table `survey_question_answers`
--

CREATE TABLE `survey_question_answers` (
  `qa_id` int(20) NOT NULL,
  `question_id` int(20) NOT NULL,
  `answer_id` int(20) NOT NULL,
  `answer` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `survey_question_answers`
--

INSERT INTO `survey_question_answers` (`qa_id`, `question_id`, `answer_id`, `answer`) VALUES
(1, 1, 1, 'Ya, saya menggunakan smartphone untuk berkomunikasi dan mengakses internet setiap hari.'),
(2, 1, 2, 'Ya, saya menggunakan perangkat pintar di rumah seperti lampu pintar atau asisten virtual.'),
(3, 1, 3, 'Ya, saya menggunakan kartu pembayaran nirkontak untuk transaksi sehari-hari.'),
(4, 1, 4, 'Ya, saya menggunakan teknologi canggih dalam kendaraan saya seperti fitur parkir otomatis'),
(5, 2, 1, 'Kemudahan Akses dan Komunikasi: Teknologi canggih, seperti internet dan smartphone, telah mengubah cara orang berkomunikasi dan berinteraksi. Informasi dapat diakses dengan cepat, dan komunikasi dapat dilakukan dalam waktu nyata dari mana saja di dunia.'),
(6, 2, 2, 'Inovasi dan Perkembangan: Teknologi canggih mendorong inovasi dan perkembangan di berbagai sektor, termasuk kesehatan, pendidikan, transportasi, dan industri lainnya. Hal ini membuka peluang baru dan menciptakan lapangan kerja yang inovatif.'),
(7, 2, 3, 'Akses ke Informasi dan Pendidikan: Teknologi canggih telah memungkinkan akses lebih mudah ke berbagai sumber informasi dan pendidikan. Ini membantu dalam proses belajar dan meningkatkan kesadaran masyarakat tentang isu-isu global.'),
(8, 2, 4, 'Peningkatan Efisiensi: Teknologi canggih memungkinkan proses lebih cepat, lebih efisien, dan otomatisasi tugas-tugas yang sebelumnya memerlukan waktu dan usaha manusia. Ini membantu meningkatkan produktivitas dan mengurangi biaya operasional.'),
(9, 3, 1, 'Sangat Tertarik'),
(10, 3, 2, 'Tertarik'),
(11, 3, 3, 'Tidak Tertarik'),
(12, 3, 4, 'Netral'),
(13, 4, 5, 'Sangat Akrab'),
(14, 4, 6, 'Cukup Akrab'),
(15, 5, 5, 'Dalam banyak sektor, AI telah membantu meningkatkan efisiensi proses dengan mengotomatisasi tugas-tugas yang sebelumnya membutuhkan waktu dan usaha manusia. Contohnya adalah pemrosesan data, analisis besar, dan tugas rutin lainnya, sehingga memungkinkan manusia fokus pada tugas-tugas kreatif dan strategis.'),
(16, 5, 6, 'Dalam sektor layanan, AI digunakan untuk meningkatkan kualitas pelayanan pelanggan. Chatbot, misalnya, dapat memberikan dukungan pelanggan secara cepat dan efisien, 24/7, tanpa memerlukan interaksi manusia secara langsung.'),
(17, 6, 7, 'Sangat Akrab'),
(18, 6, 8, 'Cukup Akrab'),
(19, 6, 9, 'Tidak Tahu Sama Sekali'),
(20, 7, 7, 'Netral'),
(21, 7, 8, 'Tidak Tertarik'),
(22, 7, 9, 'Sangat Tidak Tertarik'),
(23, 8, 10, 'Sangat Tidak Paham'),
(24, 8, 11, 'Netral'),
(25, 8, 12, 'Sangat Paham'),
(26, 9, 10, 'Kecepatan tinggi dan keterhubungan yang lebih baik, memungkinkan akses informasi dan konten dengan cepat dan responsif.'),
(27, 9, 11, 'Latensi rendah untuk pengalaman aplikasi yang lebih lancar dan real-time.'),
(28, 9, 12, 'Mendorong inovasi di berbagai sektor, seperti telemedicine, kendaraan otonom, dan industri manufaktur.'),
(29, 19, 13, 'Tidak yakin'),
(30, 19, 14, 'Tidak yakin'),
(31, 19, 15, 'Tidak'),
(32, 19, 16, 'Ya'),
(33, 20, 13, 'Pemerintah Bangladesh memperluas jaringan telekomunikasi dan internet di seluruh negara untuk meningkatkan konektivitas dan akses masyarakat terhadap teknologi.'),
(34, 20, 14, 'Program pelatihan keterampilan digital diluncurkan untuk mengedukasi masyarakat tentang teknologi informasi dan komunikasi. Pendidikan tentang teknologi diberikan di sekolah-sekolah dan pusat-pusat pelatihan di berbagai daerah.'),
(35, 20, 15, 'Pemerintah Bangladesh telah menerapkan sistem e-government untuk meningkatkan efisiensi dan transparansi dalam administrasi publik.'),
(36, 20, 16, 'Dukungan diberikan kepada industri e-commerce dan startup teknologi, yang membantu mendorong pertumbuhan ekonomi digital di negara tersebut.');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(20) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `firstname`, `lastname`, `email`) VALUES
(1, 'Ahmad', 'Wijaya', 'ahmadwijaya@gmail.com'),
(2, 'Budi', 'Santoso', 'budisantoso@gmail.com'),
(3, 'Citra', 'Kusuma', 'citrakusuma@gmail.com'),
(4, 'Dewi', 'Sari', 'dewisari@gmail.com'),
(5, 'Eko', 'Saputra', 'ekosaputra@gmail.com'),
(6, 'Fahmi', 'Hidayat', 'fahmihidayat@gmail.com'),
(7, 'Gita', 'Wardani', 'gitawardani@gmail.com'),
(8, 'Hendra', 'Kurniawan', 'hendrakurniawan@gmail.com'),
(9, 'Indah', 'Puspitasari', 'indahpuspitasari@gmail.com'),
(10, 'Joko', 'Suryono', 'jokosuryono@gmail.com'),
(11, 'Kartika', 'Dewi', 'kartikadewi@gmail.com'),
(12, 'Lutfi', 'Ramadhan', 'lutfiramadhan@gmail.com'),
(13, 'Mira', 'Anggraeni', 'miraanggraeni@gmail.com'),
(14, 'Nur', 'Hidayah', 'nurhidayah@gmail.com'),
(15, 'Oscar', 'Wijaya', 'oscarwijaya@gmail.com'),
(16, 'Putri', 'Sari', 'putrisari@gmail.com'),
(17, 'Rahmat', 'Santoso', 'rahmatsantoso@gmail.com'),
(18, 'Siti', 'Rahayu', 'sitirahayu@gmail.com'),
(19, 'Taufik', 'Setiawan', 'taufiksetiawan@gmail.com'),
(20, 'Ulfa', 'Nurhadi', 'ulfanurhadi@gmail.com');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_question_new`
-- (See below for the actual view)
--
CREATE TABLE `v_question_new` (
`question_id` int(20)
,`type` varchar(45)
,`question` varchar(1000)
,`description` text
,`options` text
,`survey_id` int(20)
,`user_id` int(20)
,`firstname` varchar(30)
,`lastname` varchar(30)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure for view `v_question_new`
--
DROP TABLE IF EXISTS `v_question_new`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_question_new`  AS SELECT `survey_questions`.`question_id` AS `question_id`, `survey_questions`.`type` AS `type`, `survey_questions`.`question` AS `question`, `survey_questions`.`description` AS `description`, `survey_questions`.`options` AS `options`, `survey_questions`.`survey_id` AS `survey_id`, `users`.`user_id` AS `user_id`, `users`.`firstname` AS `firstname`, `users`.`lastname` AS `lastname`, `users`.`email` AS `email` FROM (`survey_questions` join `users` on(`users`.`user_id` = `survey_questions`.`survey_id`)) WHERE `survey_questions`.`survey_id` = '5' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `surveys`
--
ALTER TABLE `surveys`
  ADD PRIMARY KEY (`survey_id`),
  ADD KEY `i_1` (`user_id`);

--
-- Indexes for table `surveys_log`
--
ALTER TABLE `surveys_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `survey_answers`
--
ALTER TABLE `survey_answers`
  ADD PRIMARY KEY (`answer_id`),
  ADD KEY `survey_id` (`survey_id`);

--
-- Indexes for table `survey_questions`
--
ALTER TABLE `survey_questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `survey_id` (`survey_id`);

--
-- Indexes for table `survey_question_answers`
--
ALTER TABLE `survey_question_answers`
  ADD PRIMARY KEY (`qa_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `answer_id` (`answer_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `surveys`
--
ALTER TABLE `surveys`
  MODIFY `survey_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `surveys_log`
--
ALTER TABLE `surveys_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `survey_answers`
--
ALTER TABLE `survey_answers`
  MODIFY `answer_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `survey_questions`
--
ALTER TABLE `survey_questions`
  MODIFY `question_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `survey_question_answers`
--
ALTER TABLE `survey_question_answers`
  MODIFY `qa_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `surveys`
--
ALTER TABLE `surveys`
  ADD CONSTRAINT `surveys_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `survey_answers`
--
ALTER TABLE `survey_answers`
  ADD CONSTRAINT `survey_answers_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `surveys` (`survey_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `survey_questions`
--
ALTER TABLE `survey_questions`
  ADD CONSTRAINT `survey_questions_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `surveys` (`survey_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `survey_question_answers`
--
ALTER TABLE `survey_question_answers`
  ADD CONSTRAINT `survey_question_answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `survey_questions` (`question_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `survey_question_answers_ibfk_2` FOREIGN KEY (`answer_id`) REFERENCES `survey_answers` (`answer_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
