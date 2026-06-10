-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: recruitment
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `recruitment`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `recruitment` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `recruitment`;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `resume_id` bigint(20) unsigned DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `is_present` tinyint(1) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `link` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` VALUES (1,1,1,'Google Developer Student Club','Backend Mentor',0,'2021-09-01','2022-06-30','Huong dan thanh vien moi ve API, Git va quy trinh lam project.','https://gdsc.example.com'),(2,2,2,'Data Community Vietnam','Volunteer',1,'2023-01-01',NULL,'Ho tro to chuc workshop ve SQL va dashboard cho nguoi moi bat dau.','https://data-community.example.com'),(7,2001,2001,'Câu lạc bộ Lập trình','Thành viên Ban kỹ thuật',0,'2022-10-01','2024-06-30','Hỗ trợ tổ chức workshop Git, REST API và nhập môn Laravel; hướng dẫn thành viên mới hoàn thiện dự án web đầu tiên.',NULL),(8,2001,2001,'Chương trình Tiếp sức mùa thi','Tình nguyện viên',0,'2023-06-15','2023-07-15','Hỗ trợ thí sinh và phụ huynh tại điểm thi, phối hợp điều phối đội tình nguyện.',NULL),(9,2001,2002,'Câu lạc bộ Lập trình','Thành viên Ban kỹ thuật',0,'2022-10-01','2024-06-30','Hỗ trợ tổ chức workshop Git, REST API và nhập môn Laravel; hướng dẫn thành viên mới hoàn thiện dự án web đầu tiên.',NULL),(10,2001,2002,'Chương trình Tiếp sức mùa thi','Tình nguyện viên',0,'2023-06-15','2023-07-15','Hỗ trợ thí sinh và phụ huynh tại điểm thi, phối hợp điều phối đội tình nguyện.',NULL);
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_audit_logs`
--

DROP TABLE IF EXISTS `admin_audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) unsigned NOT NULL,
  `action` varchar(80) NOT NULL,
  `target_type` varchar(80) NOT NULL,
  `target_id` bigint(20) unsigned DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_audit_logs`
--

LOCK TABLES `admin_audit_logs` WRITE;
/*!40000 ALTER TABLE `admin_audit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_messages`
--

DROP TABLE IF EXISTS `candidate_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidate_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `job_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_messages`
--

LOCK TABLES `candidate_messages` WRITE;
/*!40000 ALTER TABLE `candidate_messages` DISABLE KEYS */;
INSERT INTO `candidate_messages` VALUES (1,1,2,'Nha tuyen dung da xem ho so, vi tri React Frontend Developer, TechWorks Viet Nam','Ho so da duoc xem','TechWorks da xem CV cua ban. Hay tiep tuc theo doi trang thai ung tuyen.',1,'2026-06-10 01:30:00','2026-06-10 16:49:16'),(2,1,3,'Ho so duoc chap nhan, vi tri QA Automation Engineer, NovaTech Labs','Moi phong van','NovaTech moi ban tham gia phong van online vao 14:00 ngay 15/06/2026.',1,'2026-06-10 02:10:00','2026-06-10 16:49:11'),(3,2,5,'Chuc mung ban da duoc nhan, vi tri Data Analyst, GreenPay Digital','Ket qua ung tuyen','GreenPay danh gia cao kinh nghiem phan tich du lieu cua ban va se lien he de trao doi offer.',1,'2026-06-10 02:00:00','2026-06-10 02:00:00');
/*!40000 ALTER TABLE `candidate_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidates` (
  `id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `firstname` varchar(40) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `gender` tinyint(3) unsigned DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` char(10) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `link` text DEFAULT NULL,
  `objective` text DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidates`
--

LOCK TABLES `candidates` WRITE;
/*!40000 ALTER TABLE `candidates` DISABLE KEYS */;
INSERT INTO `candidates` VALUES (1,1,'Minh Anh','Nguyen',1,'2001-08-15','0912345678','candidate.demo@example.com','Cau Giay, Ha Noi','https://github.com/minhanh-dev','Tro thanh full-stack developer, xay dung san pham on dinh va de su dung.','avatar.jpg','2026-06-10 02:00:00','2026-06-10 02:00:00'),(2,2,'Khanh Linh','Tran',1,'2000-11-03','0923456789','linh.candidate@example.com','Thanh Xuan, Ha Noi','https://linkedin.com/in/khanhlinh','Phat trien su nghiep trong linh vuc phan tich du lieu va san pham.','avatar.jpg','2026-06-10 02:00:00','2026-06-10 02:00:00'),(3,3,'Quang Minh','Pham',0,'1999-05-20','0934567890','minh.candidate@example.com','Thu Duc, TP Ho Chi Minh','https://github.com/quangminh-qa','Tim kiem moi truong QA automation co quy trinh chuyen nghiep.','avatar.jpg','2026-06-10 02:00:00','2026-06-10 02:00:00'),(4,4,'Phuong Thao','Le',1,'2002-02-18','0945678901','thao.candidate@example.com','Hai Chau, Da Nang','https://behance.net/phuongthao','Hoc hoi va phat trien trong vai tro UI UX Designer.','avatar.jpg','2026-06-10 02:00:00','2026-06-10 02:00:00'),(2001,2001,'Tài Anh','Bùi Đức',0,'2003-11-17','0987654321','taianh.bui@example.com','Cầu Giấy, Hà Nội','https://github.com/taianh-bui','Lập trình viên trẻ định hướng Backend và Full-stack, yêu thích xây dựng REST API, tối ưu cơ sở dữ liệu và phát triển sản phẩm có trải nghiệm người dùng tốt.','https://ui-avatars.com/api/?name=Bui+Duc+Tai+Anh&size=512&background=0F4C81&color=ffffff&bold=true','2026-06-10 17:07:34','2026-06-10 17:07:34');
/*!40000 ALTER TABLE `candidates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `resume_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `receive_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `image` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates`
--

LOCK TABLES `certificates` WRITE;
/*!40000 ALTER TABLE `certificates` DISABLE KEYS */;
INSERT INTO `certificates` VALUES (1,1,1,'Laravel Professional Certificate','2024-03-15',NULL,NULL),(2,2,2,'Google Data Analytics Certificate','2023-08-10',NULL,NULL),(7,2001,2001,'Laravel API Development','2024-10-15',NULL,NULL),(8,2001,2001,'TOEIC 720','2024-03-20','2026-03-20',NULL),(9,2001,2002,'Laravel API Development','2024-10-15',NULL,NULL),(10,2001,2002,'TOEIC 720','2024-03-20','2026-03-20',NULL);
/*!40000 ALTER TABLE `certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `educations`
--

DROP TABLE IF EXISTS `educations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `educations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `resume_id` bigint(20) unsigned DEFAULT NULL,
  `school` varchar(100) DEFAULT NULL,
  `major` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `educations`
--

LOCK TABLES `educations` WRITE;
/*!40000 ALTER TABLE `educations` DISABLE KEYS */;
INSERT INTO `educations` VALUES (1,1,NULL,'Dai hoc Bach Khoa Ha Noi','Cong nghe thong tin','2019-09-01','2023-06-30','Tot nghiep loai gioi, tap trung vao web engineering va co so du lieu.'),(2,1,1,'Dai hoc Bach Khoa Ha Noi','Cong nghe thong tin','2019-09-01','2023-06-30','GPA 3.4/4.0, do an tot nghiep ve he thong tuyen dung truc tuyen.'),(3,2,NULL,'Dai hoc Kinh te Quoc dan','He thong thong tin quan ly','2018-09-01','2022-06-30','Tap trung vao phan tich du lieu va business intelligence.'),(4,2,2,'Dai hoc Kinh te Quoc dan','He thong thong tin quan ly','2018-09-01','2022-06-30','Thuc hien nhieu project dashboard bang SQL va Power BI.'),(9,2001,2001,'Đại học Công nghệ - Đại học Quốc gia Hà Nội','Công nghệ thông tin - Kỹ thuật phần mềm','2021-09-01','2025-06-30','GPA: 3.35/4.0. Học phần nổi bật: Cấu trúc dữ liệu và giải thuật, Cơ sở dữ liệu, Phát triển ứng dụng Web, Công nghệ phần mềm, Mạng máy tính.'),(10,2001,2002,'Đại học Công nghệ - Đại học Quốc gia Hà Nội','Công nghệ thông tin - Kỹ thuật phần mềm','2021-09-01','2025-06-30','GPA: 3.35/4.0. Học phần nổi bật: Cấu trúc dữ liệu và giải thuật, Cơ sở dữ liệu, Phát triển ứng dụng Web, Công nghệ phần mềm, Mạng máy tính.');
/*!40000 ALTER TABLE `educations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employer_location`
--

DROP TABLE IF EXISTS `employer_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employer_location` (
  `employer_id` bigint(20) unsigned NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`employer_id`,`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employer_location`
--

LOCK TABLES `employer_location` WRITE;
/*!40000 ALTER TABLE `employer_location` DISABLE KEYS */;
INSERT INTO `employer_location` VALUES (5,1),(5,5),(6,1),(6,3),(7,2),(7,5),(2101,1),(2102,1),(2103,1),(2104,9),(2105,9),(2106,1),(2107,10),(2108,10),(2109,1),(2110,10),(2111,11),(2112,12);
/*!40000 ALTER TABLE `employer_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employers`
--

DROP TABLE IF EXISTS `employers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employers` (
  `id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(150) NOT NULL,
  `address` varchar(255) NOT NULL,
  `min_employees` int(10) unsigned DEFAULT NULL,
  `max_employees` int(10) unsigned DEFAULT NULL,
  `contact_name` varchar(60) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `logo` text NOT NULL,
  `image` text DEFAULT NULL,
  `is_hot` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employers`
--

LOCK TABLES `employers` WRITE;
/*!40000 ALTER TABLE `employers` DISABLE KEYS */;
INSERT INTO `employers` VALUES (5,5,'TechWorks Viet Nam','123 Duy Tan, Cau Giay, Ha Noi',100,300,'Nguyen Thu Ha','02473001234','https://techworks.example.com','Cong ty san pham web va nen tang du lieu cho thi truong Viet Nam.','/logo192.png','/image/poster4.jpg',1,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(6,6,'NovaTech Labs','72 Nguyen Co Thach, Nam Tu Liem, Ha Noi',50,150,'Tran Bao Nam','02473005678','https://novatech.example.com','Doi ngu phat trien SaaS, mobile app va he thong tich hop cho doanh nghiep.','/logo192.png','/image/poster4.jpg',1,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(7,7,'GreenPay Digital','18 Le Loi, Quan 1, TP Ho Chi Minh',200,500,'Le Mai Anh','02873007890','https://greenpay.example.com','Nen tang thanh toan so va dich vu fintech cho doanh nghiep vua va nho.','/logo192.png','/image/poster4.jpg',0,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(2101,2101,'NovaTech Solutions','Tòa Discovery Complex, 302 Cầu Giấy, Hà Nội',150,300,'Phòng Tuyển dụng','0240002101','https://novatech.example.com','Công ty công nghệ phát triển nền tảng quản trị doanh nghiệp, thương mại điện tử và giải pháp chuyển đổi số cho khách hàng trong khu vực Đông Nam Á.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=NovaTech+Solutions&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',1,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2102,2102,'VietData AI','Keangnam Landmark 72, Nam Từ Liêm, Hà Nội',80,180,'Phòng Tuyển dụng','0240002102','https://vietdata.example.com','Doanh nghiệp nghiên cứu dữ liệu lớn và trí tuệ nhân tạo, cung cấp nền tảng phân tích dữ liệu, OCR và trợ lý số cho doanh nghiệp.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=VietData+AI&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',1,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2103,2103,'BlueWave Digital Bank','194 Trần Quang Khải, Hoàn Kiếm, Hà Nội',800,1500,'Phòng Tuyển dụng','0240002103','https://bluewave.example.com','Ngân hàng số tập trung vào trải nghiệm khách hàng, thanh toán không tiền mặt, quản trị rủi ro và các sản phẩm tài chính cá nhân hiện đại.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=BlueWave+Digital+Bank&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',1,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2104,2104,'GreenLog Logistics','15 Bạch Đằng, Hải Châu, Đà Nẵng',300,600,'Phòng Tuyển dụng','0240002104','https://greenlog.example.com','Đơn vị logistics ứng dụng công nghệ trong quản lý kho, vận tải đa phương thức và tối ưu chuỗi cung ứng toàn quốc.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=GreenLog+Logistics&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',0,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2105,2105,'PixelCraft Studio','28 Nguyễn Văn Linh, Hải Châu, Đà Nẵng',40,100,'Phòng Tuyển dụng','0240002105','https://pixelcraft.example.com','Studio thiết kế sản phẩm số chuyên UI/UX, nhận diện thương hiệu, thiết kế web và ứng dụng di động cho startup quốc tế.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=PixelCraft+Studio&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',1,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2106,2106,'Sunrise Commerce','36 Hoàng Cầu, Đống Đa, Hà Nội',200,450,'Phòng Tuyển dụng','0240002106','https://sunrise-commerce.example.com','Hệ sinh thái bán lẻ đa kênh vận hành các thương hiệu tiêu dùng, sàn thương mại điện tử và mạng lưới phân phối trên toàn quốc.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=Sunrise+Commerce&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',0,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2107,2107,'MediCare Pharma','Khu Công nghệ cao, Thủ Đức, Hồ Chí Minh',500,900,'Phòng Tuyển dụng','0240002107','https://medicare-pharma.example.com','Công ty dược phẩm và chăm sóc sức khỏe phát triển hệ thống phân phối, quản lý nhà thuốc và nền tảng tư vấn sức khỏe trực tuyến.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=MediCare+Pharma&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',1,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2108,2108,'CloudNine Technology','Etown Central, Quận 4, Hồ Chí Minh',120,250,'Phòng Tuyển dụng','0240002108','https://cloudnine.example.com','Nhà cung cấp hạ tầng cloud, dịch vụ managed service, an toàn thông tin và giải pháp vận hành hệ thống cho doanh nghiệp.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=CloudNine+Technology&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',1,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2109,2109,'BrightPath Education','82 Duy Tân, Cầu Giấy, Hà Nội',100,220,'Phòng Tuyển dụng','0240002109','https://brightpath.example.com','Doanh nghiệp EdTech phát triển nền tảng học trực tuyến, hệ thống quản lý đào tạo và nội dung số cho sinh viên và người đi làm.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=BrightPath+Education&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',0,1,'2026-06-10 17:07:35','2026-06-10 17:07:35'),(2110,2110,'Orbit Media Vietnam','18A Cộng Hòa, Tân Bình, Hồ Chí Minh',70,160,'Phòng Tuyển dụng','0240002110','https://orbitmedia.example.com','Digital agency cung cấp chiến lược thương hiệu, quảng cáo đa nền tảng, social media và sản xuất nội dung sáng tạo.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=Orbit+Media+Vietnam&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',1,1,'2026-06-10 17:07:35','2026-06-10 17:07:35'),(2111,2111,'FutureTel Communications','Lê Hồng Phong, Ngô Quyền, Hải Phòng',1000,2500,'Phòng Tuyển dụng','0240002111','https://futuretel.example.com','Doanh nghiệp viễn thông phát triển hạ tầng mạng, dịch vụ số, IoT và giải pháp kết nối cho khách hàng cá nhân và doanh nghiệp.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=FutureTel+Communications&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',0,1,'2026-06-10 17:07:35','2026-06-10 17:07:35'),(2112,2112,'PeopleFirst HR','Becamex Tower, Thủ Dầu Một, Bình Dương',50,120,'Phòng Tuyển dụng','0240002112','https://peoplefirst.example.com','Công ty tư vấn nhân sự cung cấp dịch vụ tuyển dụng, đào tạo, xây dựng thương hiệu tuyển dụng và phần mềm quản trị nguồn nhân lực.\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.','https://ui-avatars.com/api/?name=PeopleFirst+HR&size=256&background=0F4C81&color=ffffff&bold=true','https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',0,1,'2026-06-10 17:07:35','2026-06-10 17:07:35');
/*!40000 ALTER TABLE `employers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiences`
--

DROP TABLE IF EXISTS `experiences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiences` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `resume_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiences`
--

LOCK TABLES `experiences` WRITE;
/*!40000 ALTER TABLE `experiences` DISABLE KEYS */;
INSERT INTO `experiences` VALUES (1,1,NULL,'Backend Developer Intern','TechWorks Viet Nam','2022-06-01','2022-12-31','Tham gia phat trien API Laravel, viet migration va xu ly bug.'),(2,1,1,'Full-stack Developer','Freelance Team','2023-01-01','2025-12-31','Xay dung web dashboard voi Laravel, React, MySQL va CI/CD co ban.'),(3,2,NULL,'Data Analyst Intern','GreenPay Digital','2021-07-01','2022-01-31','Lam sach du lieu giao dich, viet SQL query va tao dashboard bao cao.'),(4,2,2,'Junior Data Analyst','Insight Lab','2022-03-01','2025-12-31','Phan tich funnel nguoi dung, bao cao KPI va tu dong hoa file bao cao hang tuan.'),(9,2001,2001,'Backend Developer Intern','NovaTech Solutions','2024-06-01','2024-09-30','Phát triển REST API bằng Laravel; thiết kế migration và quan hệ Eloquent; tối ưu truy vấn MySQL; kiểm thử API bằng Postman; làm việc theo Git Flow và Scrum.'),(10,2001,2001,'Freelance Web Developer','Dự án cá nhân và nhóm','2023-10-01','2025-03-31','Xây dựng website quản lý bán hàng và tuyển dụng; phân tích yêu cầu, thiết kế database, phát triển backend Laravel, tích hợp ReactJS và triển khai bản demo.'),(11,2001,2002,'Backend Developer Intern','NovaTech Solutions','2024-06-01','2024-09-30','Phát triển REST API bằng Laravel; thiết kế migration và quan hệ Eloquent; tối ưu truy vấn MySQL; kiểm thử API bằng Postman; làm việc theo Git Flow và Scrum.'),(12,2001,2002,'Freelance Web Developer','Dự án cá nhân và nhóm','2023-10-01','2025-03-31','Xây dựng website quản lý bán hàng và tuyển dụng; phân tích yêu cầu, thiết kế database, phát triển backend Laravel, tích hợp ReactJS và triển khai bản demo.');
/*!40000 ALTER TABLE `experiences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
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
-- Table structure for table `industries`
--

DROP TABLE IF EXISTS `industries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `industries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `industries`
--

LOCK TABLES `industries` WRITE;
/*!40000 ALTER TABLE `industries` DISABLE KEYS */;
INSERT INTO `industries` VALUES (1,'CNTT - Phan mem'),(2,'Thuong mai dien tu'),(3,'Tai chinh - Fintech'),(4,'Marketing'),(5,'Giao duc'),(6,'Du lieu'),(10,'CNTT-Phần mềm'),(11,'Ngân hàng'),(12,'Vận chuyển / Giao nhận / Kho vận'),(13,'Mỹ thuật / Nghệ thuật / Thiết kế'),(14,'Bán hàng / Kinh doanh'),(15,'Dược phẩm'),(16,'CNTT-Phần cứng / Mạng'),(17,'Tư vấn'),(18,'Tiếp thị / Marketing'),(19,'Bưu chính viễn thông'),(20,'Nhân sự');
/*!40000 ALTER TABLE `industries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jlevels`
--

DROP TABLE IF EXISTS `jlevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jlevels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jlevels`
--

LOCK TABLES `jlevels` WRITE;
/*!40000 ALTER TABLE `jlevels` DISABLE KEYS */;
INSERT INTO `jlevels` VALUES (1,'Intern'),(2,'Junior'),(3,'Middle'),(4,'Senior'),(5,'Leader'),(9,'Nhân viên'),(10,'Thực tập sinh');
/*!40000 ALTER TABLE `jlevels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_applying`
--

DROP TABLE IF EXISTS `job_applying`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_applying` (
  `job_id` bigint(20) unsigned NOT NULL,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `cv_link` text DEFAULT NULL,
  `cv_type` varchar(20) NOT NULL DEFAULT 'upload',
  `resume_id` bigint(20) unsigned DEFAULT NULL,
  `internal_note` text DEFAULT NULL,
  `interview_at` datetime DEFAULT NULL,
  `source` varchar(60) DEFAULT NULL,
  `status` enum('pending','viewed','suitable','rejected','interview','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`job_id`,`candidate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_applying`
--

LOCK TABLES `job_applying` WRITE;
/*!40000 ALTER TABLE `job_applying` DISABLE KEYS */;
INSERT INTO `job_applying` VALUES (1,1,'http://localhost:3000/candidate/resumes/1','system',1,'Ung vien co kinh nghiem Laravel tot, can review them ve testing.',NULL,'Website','pending','2026-06-10 02:20:00','2026-06-10 02:20:00'),(2,1,'http://localhost:3000/candidate/resumes/1','system',1,'Da xem CV, phu hop frontend React.',NULL,'Website','viewed','2026-06-09 03:15:00','2026-06-10 01:30:00'),(3,1,'http://localhost:3000/candidate/resumes/1','system',1,'Hen phong van vong 1 voi QA lead.','2026-06-15 14:00:00','Referral','interview','2026-06-08 07:00:00','2026-06-10 02:10:00'),(4,4,'http://localhost:3000/candidate/resumes/1','system',1,'Can review portfolio UI truoc khi hen phong van.',NULL,'Website','pending','2026-06-10 04:00:00','2026-06-10 04:00:00'),(5,2,'http://localhost:3000/candidate/resumes/2','system',2,'Ung vien data manh, da thong nhat offer.',NULL,'LinkedIn','suitable','2026-06-07 06:00:00','2026-06-10 02:00:00'),(6,2,'http://localhost:3000/candidate/resumes/2','system',2,'Chua co kinh nghiem DevOps phu hop.',NULL,'Website','rejected','2026-06-06 09:00:00','2026-06-09 09:00:00'),(3001,2001,'http://localhost:3000/candidate/resumes/2001','system',2001,NULL,NULL,'Website','viewed','2026-06-08 17:07:35','2026-06-10 17:07:35'),(3003,2001,'http://localhost:3000/candidate/resumes/2001','system',2001,'Ứng viên có nền tảng backend phù hợp, cần trao đổi thêm về kinh nghiệm thực tế.','2026-06-14 00:07:35','Website','interview','2026-06-06 17:07:35','2026-06-10 17:07:35'),(3007,2001,'http://localhost:3000/candidate/resumes/2001','system',2001,NULL,NULL,'Job Fair','pending','2026-06-02 17:07:35','2026-06-10 17:07:35'),(3028,2001,'http://localhost:3000/candidate/resumes/2001','system',2001,NULL,NULL,'Referral','suitable','2026-06-05 17:07:35','2026-06-10 17:07:35'),(3048,2001,'http://localhost:3000/candidate/resumes/2001','system',2001,NULL,NULL,'Website','rejected','2026-06-09 17:07:35','2026-06-10 17:07:35');
/*!40000 ALTER TABLE `job_applying` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_industry`
--

DROP TABLE IF EXISTS `job_industry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_industry` (
  `job_id` bigint(20) unsigned NOT NULL,
  `industry_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`job_id`,`industry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_industry`
--

LOCK TABLES `job_industry` WRITE;
/*!40000 ALTER TABLE `job_industry` DISABLE KEYS */;
INSERT INTO `job_industry` VALUES (1,1),(1,2),(2,1),(2,2),(3,1),(4,1),(4,4),(5,3),(5,6),(6,1),(6,3),(7,1),(8,4),(3001,10),(3002,10),(3003,10),(3004,10),(3005,10),(3006,10),(3007,10),(3008,10),(3009,11),(3010,11),(3011,11),(3012,11),(3013,12),(3014,12),(3015,12),(3016,12),(3017,13),(3018,13),(3019,13),(3020,13),(3021,14),(3022,14),(3023,14),(3024,14),(3025,15),(3026,15),(3027,15),(3028,15),(3029,16),(3030,16),(3031,16),(3032,16),(3033,17),(3034,17),(3035,17),(3036,17),(3037,18),(3038,18),(3039,18),(3040,18),(3041,19),(3042,19),(3043,19),(3044,19),(3045,20),(3046,20),(3047,20),(3048,20);
/*!40000 ALTER TABLE `job_industry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_location`
--

DROP TABLE IF EXISTS `job_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_location` (
  `job_id` bigint(20) unsigned NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`job_id`,`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_location`
--

LOCK TABLES `job_location` WRITE;
/*!40000 ALTER TABLE `job_location` DISABLE KEYS */;
INSERT INTO `job_location` VALUES (1,1),(2,1),(2,5),(3,1),(4,3),(4,5),(5,5),(6,2),(7,1),(8,3),(3001,1),(3002,1),(3003,1),(3004,1),(3005,1),(3006,1),(3007,1),(3008,1),(3009,1),(3010,1),(3011,1),(3012,1),(3013,9),(3014,9),(3015,9),(3016,9),(3017,9),(3018,9),(3019,9),(3020,9),(3021,1),(3022,1),(3023,1),(3024,1),(3025,10),(3026,10),(3027,10),(3028,10),(3029,10),(3030,10),(3031,10),(3032,10),(3033,1),(3034,1),(3035,1),(3036,1),(3037,10),(3038,10),(3039,10),(3040,10),(3041,11),(3042,11),(3043,11),(3044,11),(3045,12),(3046,12),(3047,12),(3048,12);
/*!40000 ALTER TABLE `job_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_skill`
--

DROP TABLE IF EXISTS `job_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_skill` (
  `job_id` bigint(20) unsigned NOT NULL,
  `skill_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`job_id`,`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_skill`
--

LOCK TABLES `job_skill` WRITE;
/*!40000 ALTER TABLE `job_skill` DISABLE KEYS */;
INSERT INTO `job_skill` VALUES (1,1),(1,2),(1,5),(2,3),(2,4),(3,8),(3,10),(3,11),(4,7),(5,8),(5,9),(6,5),(6,6),(7,1),(7,2),(7,12),(8,4),(3001,1),(3001,2),(3001,5),(3001,13),(3002,3),(3002,4),(3002,13),(3002,14),(3003,15),(3003,16),(3003,17),(3004,6),(3004,18),(3004,19),(3004,20),(3005,15),(3005,16),(3005,17),(3006,6),(3006,8),(3006,21),(3006,22),(3007,6),(3007,8),(3007,21),(3007,22),(3008,8),(3008,10),(3008,11),(3008,23),(3009,5),(3009,24),(3009,25),(3009,26),(3010,15),(3010,16),(3010,17),(3011,15),(3011,16),(3011,17),(3012,15),(3012,16),(3012,17),(3013,15),(3013,16),(3013,17),(3014,15),(3014,16),(3014,17),(3015,15),(3015,16),(3015,17),(3016,8),(3016,13),(3016,27),(3016,28),(3017,7),(3017,29),(3017,30),(3018,7),(3018,29),(3018,30),(3019,3),(3019,4),(3019,13),(3019,14),(3020,15),(3020,30),(3020,31),(3021,15),(3021,16),(3021,17),(3022,15),(3022,16),(3022,17),(3023,15),(3023,16),(3023,17),(3024,15),(3024,16),(3024,17),(3025,15),(3025,16),(3025,17),(3026,15),(3026,16),(3026,17),(3027,15),(3027,16),(3027,17),(3028,8),(3028,13),(3028,27),(3028,28),(3029,6),(3029,18),(3029,19),(3029,20),(3030,18),(3030,20),(3030,32),(3030,33),(3031,18),(3031,34),(3031,35),(3031,36),(3032,8),(3032,13),(3032,27),(3032,28),(3033,15),(3033,16),(3033,17),(3034,7),(3034,29),(3034,30),(3035,3),(3035,4),(3035,13),(3035,14),(3036,15),(3036,16),(3036,17),(3037,15),(3037,16),(3037,17),(3038,15),(3038,16),(3038,17),(3039,15),(3039,16),(3039,17),(3040,7),(3040,29),(3040,30),(3041,18),(3041,20),(3041,32),(3041,33),(3042,8),(3042,13),(3042,27),(3042,28),(3043,15),(3043,16),(3043,17),(3044,15),(3044,16),(3044,17),(3045,15),(3045,16),(3045,17),(3046,15),(3046,16),(3046,17),(3047,15),(3047,16),(3047,17),(3048,1),(3048,2),(3048,5),(3048,13);
/*!40000 ALTER TABLE `job_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_tag`
--

DROP TABLE IF EXISTS `job_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_tag` (
  `job_id` bigint(20) unsigned NOT NULL,
  `tag_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`job_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_tag`
--

LOCK TABLES `job_tag` WRITE;
/*!40000 ALTER TABLE `job_tag` DISABLE KEYS */;
INSERT INTO `job_tag` VALUES (1,1),(1,4),(2,2),(2,4),(3,6),(4,7),(4,8),(5,3),(5,5),(6,1),(7,1),(7,4),(8,8),(3001,9),(3001,10),(3002,9),(3002,10),(3003,11),(3003,12),(3004,9),(3004,10),(3005,11),(3005,12),(3006,9),(3006,10),(3007,9),(3007,10),(3008,9),(3008,10),(3009,9),(3009,10),(3010,11),(3010,12),(3011,11),(3011,12),(3012,11),(3012,12),(3013,11),(3013,12),(3014,11),(3014,12),(3015,11),(3015,12),(3016,9),(3016,10),(3017,13),(3017,14),(3018,13),(3018,14),(3019,9),(3019,10),(3020,15),(3020,16),(3021,11),(3021,12),(3022,11),(3022,12),(3023,11),(3023,12),(3024,11),(3024,12),(3025,11),(3025,12),(3026,11),(3026,12),(3027,11),(3027,12),(3028,9),(3028,10),(3029,9),(3029,10),(3030,9),(3030,10),(3031,9),(3031,10),(3032,9),(3032,10),(3033,11),(3033,12),(3034,13),(3034,14),(3035,9),(3035,10),(3036,11),(3036,12),(3037,11),(3037,12),(3038,11),(3038,12),(3039,11),(3039,12),(3040,13),(3040,14),(3041,9),(3041,10),(3042,9),(3042,10),(3043,11),(3043,12),(3044,11),(3044,12),(3045,11),(3045,12),(3046,11),(3046,12),(3047,11),(3047,12),(3048,9),(3048,10);
/*!40000 ALTER TABLE `job_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `employer_id` bigint(20) unsigned NOT NULL,
  `jtype_id` bigint(20) unsigned NOT NULL,
  `jlevel_id` bigint(20) unsigned NOT NULL,
  `jname` varchar(150) NOT NULL,
  `address` text NOT NULL,
  `amount` int(10) unsigned DEFAULT NULL,
  `min_salary` int(10) unsigned DEFAULT NULL,
  `max_salary` int(10) unsigned DEFAULT NULL,
  `yoe` tinyint(3) unsigned DEFAULT NULL,
  `gender` tinyint(3) unsigned DEFAULT NULL,
  `description` longtext NOT NULL,
  `expire_at` date NOT NULL,
  `is_hot` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3052 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (1,5,1,3,'Laravel Backend Developer','123 Duy Tan, Cau Giay, Ha Noi',3,18000000,30000000,2,NULL,'Phat trien REST API bang Laravel, toi uu truy van MySQL, viet automated test va phoi hop voi frontend team.','2026-09-30',1,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(2,5,5,3,'React Frontend Developer','Hybrid tai Cau Giay, Ha Noi',2,16000000,28000000,2,NULL,'Xay dung giao dien tuyen dung responsive, tich hop API, toi uu performance va cai thien trai nghiem nguoi dung.','2026-10-15',1,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(3,6,1,2,'QA Automation Engineer','72 Nguyen Co Thach, Ha Noi',2,14000000,24000000,1,NULL,'Thiet ke test case, kiem thu API, viet automation script va quan ly bug tren quy trinh Agile.','2026-09-20',0,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(4,6,3,1,'UI UX Intern','Da Nang hoac Remote',2,5000000,8000000,0,NULL,'Ho tro user research, thiet ke wireframe, prototype va phoi hop cung frontend de hoan thien giao dien.','2026-08-31',0,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(5,7,4,3,'Data Analyst','Remote',2,15000000,25000000,1,NULL,'Phan tich du lieu san pham, xay dung dashboard Power BI va dua ra insight cho doi ngu kinh doanh.','2026-11-01',1,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(6,7,1,4,'DevOps Engineer','18 Le Loi, Quan 1, TP Ho Chi Minh',1,25000000,42000000,3,NULL,'Van hanh CI/CD, container, logging va monitoring cho he thong thanh toan co luu luong cao.','2026-10-30',0,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(7,5,1,5,'Engineering Team Leader','123 Duy Tan, Cau Giay, Ha Noi',1,40000000,60000000,5,NULL,'Dan dat team backend/frontend, review kien truc, lap ke hoach sprint va phat trien nang luc ky su.','2026-12-15',0,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(8,6,2,2,'Content Marketing Executive','Da Nang',2,9000000,15000000,1,NULL,'Len ke hoach noi dung, viet bai SEO, quan ly social channel va phoi hop voi team thiet ke.','2026-08-20',0,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(3001,2101,9,9,'Backend Developer (PHP/Laravel)','Tòa Discovery Complex, 302 Cầu Giấy, Hà Nội',2,16,32,2,NULL,'VỊ TRÍ: Backend Developer (PHP/Laravel)\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của NovaTech Solutions.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: PHP, Laravel, MySQL, REST API.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-09-06',0,1,'2026-06-09 17:07:34','2026-06-10 17:07:34'),(3002,2101,9,9,'Frontend Developer (ReactJS)','Tòa Discovery Complex, 302 Cầu Giấy, Hà Nội',4,16,32,2,NULL,'VỊ TRÍ: Frontend Developer (ReactJS)\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của NovaTech Solutions.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: JavaScript, React, HTML/CSS, REST API.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-20',0,1,'2026-06-08 17:07:34','2026-06-10 17:07:34'),(3003,2101,9,9,'Business Analyst','Tòa Discovery Complex, 302 Cầu Giấy, Hà Nội',1,10,24,1,NULL,'VỊ TRÍ: Business Analyst\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của NovaTech Solutions.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-27',0,1,'2026-06-07 17:07:34','2026-06-10 17:07:34'),(3004,2101,9,9,'DevOps Engineer','Tòa Discovery Complex, 302 Cầu Giấy, Hà Nội',3,16,32,2,NULL,'VỊ TRÍ: DevOps Engineer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của NovaTech Solutions.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Docker, Linux, CI/CD, Cloud.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-03',1,1,'2026-06-06 17:07:34','2026-06-10 17:07:34'),(3005,2102,9,9,'Data Analyst','Keangnam Landmark 72, Nam Từ Liêm, Hà Nội',1,10,24,1,NULL,'VỊ TRÍ: Data Analyst\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của VietData AI.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-10',0,1,'2026-06-05 17:07:34','2026-06-10 17:07:34'),(3006,2102,9,9,'Machine Learning Engineer','Keangnam Landmark 72, Nam Từ Liêm, Hà Nội',3,16,32,2,NULL,'VỊ TRÍ: Machine Learning Engineer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của VietData AI.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Python, SQL, Machine Learning, Docker.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-17',0,1,'2026-06-04 17:07:34','2026-06-10 17:07:34'),(3007,2102,9,9,'Python Backend Developer','Keangnam Landmark 72, Nam Từ Liêm, Hà Nội',5,16,32,2,NULL,'VỊ TRÍ: Python Backend Developer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của VietData AI.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Python, SQL, Machine Learning, Docker.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-24',0,1,'2026-06-03 17:07:34','2026-06-10 17:07:34'),(3008,2102,9,9,'QA Automation Engineer','Keangnam Landmark 72, Nam Từ Liêm, Hà Nội',2,16,32,2,NULL,'VỊ TRÍ: QA Automation Engineer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của VietData AI.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Postman, Selenium, SQL, Automation Test.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-31',1,1,'2026-06-02 17:07:34','2026-06-10 17:07:34'),(3009,2103,9,9,'Java Backend Developer','194 Trần Quang Khải, Hoàn Kiếm, Hà Nội',5,16,32,2,NULL,'VỊ TRÍ: Java Backend Developer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của BlueWave Digital Bank.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Java, Spring Boot, MySQL, Microservices.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-09-07',0,1,'2026-06-01 17:07:34','2026-06-10 17:07:34'),(3010,2103,9,9,'Chuyên viên Phân tích nghiệp vụ','194 Trần Quang Khải, Hoàn Kiếm, Hà Nội',2,10,24,1,NULL,'VỊ TRÍ: Chuyên viên Phân tích nghiệp vụ\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của BlueWave Digital Bank.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-21',0,1,'2026-05-31 17:07:34','2026-06-10 17:07:34'),(3011,2103,9,9,'Chuyên viên An toàn thông tin','194 Trần Quang Khải, Hoàn Kiếm, Hà Nội',4,10,24,1,NULL,'VỊ TRÍ: Chuyên viên An toàn thông tin\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của BlueWave Digital Bank.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-28',0,1,'2026-05-30 17:07:34','2026-06-10 17:07:34'),(3012,2103,9,9,'Digital Marketing Executive','194 Trần Quang Khải, Hoàn Kiếm, Hà Nội',1,10,24,1,NULL,'VỊ TRÍ: Digital Marketing Executive\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của BlueWave Digital Bank.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-04',1,1,'2026-05-29 17:07:34','2026-06-10 17:07:34'),(3013,2104,9,9,'Supply Chain Analyst','15 Bạch Đằng, Hải Châu, Đà Nẵng',4,10,24,1,NULL,'VỊ TRÍ: Supply Chain Analyst\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của GreenLog Logistics.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-11',0,1,'2026-05-28 17:07:34','2026-06-10 17:07:34'),(3014,2104,9,9,'Điều phối vận tải','15 Bạch Đằng, Hải Châu, Đà Nẵng',1,10,24,1,NULL,'VỊ TRÍ: Điều phối vận tải\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của GreenLog Logistics.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-18',0,1,'2026-05-27 17:07:34','2026-06-10 17:07:34'),(3015,2104,9,9,'Nhân viên Quản lý kho','15 Bạch Đằng, Hải Châu, Đà Nẵng',3,10,24,1,NULL,'VỊ TRÍ: Nhân viên Quản lý kho\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của GreenLog Logistics.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-25',0,1,'2026-05-26 17:07:34','2026-06-10 17:07:34'),(3016,2104,9,9,'Software Engineer - Logistics Platform','15 Bạch Đằng, Hải Châu, Đà Nẵng',5,16,32,2,NULL,'VỊ TRÍ: Software Engineer - Logistics Platform\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của GreenLog Logistics.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Git, SQL, REST API, Agile.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-09-01',1,1,'2026-05-25 17:07:34','2026-06-10 17:07:34'),(3017,2105,9,9,'UI/UX Designer','28 Nguyễn Văn Linh, Hải Châu, Đà Nẵng',3,11,22,1,NULL,'VỊ TRÍ: UI/UX Designer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của PixelCraft Studio.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Figma, Sáng tạo nội dung, Làm việc nhóm.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-09-08',0,1,'2026-05-24 17:07:34','2026-06-10 17:07:34'),(3018,2105,9,9,'Graphic Designer','28 Nguyễn Văn Linh, Hải Châu, Đà Nẵng',5,11,22,1,NULL,'VỊ TRÍ: Graphic Designer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của PixelCraft Studio.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Figma, Sáng tạo nội dung, Làm việc nhóm.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-22',0,1,'2026-05-23 17:07:34','2026-06-10 17:07:34'),(3019,2105,9,9,'Frontend Developer','28 Nguyễn Văn Linh, Hải Châu, Đà Nẵng',2,16,32,2,NULL,'VỊ TRÍ: Frontend Developer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của PixelCraft Studio.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: JavaScript, React, HTML/CSS, REST API.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-29',0,1,'2026-05-22 17:07:34','2026-06-10 17:07:34'),(3020,2105,10,10,'Product Designer Intern','28 Nguyễn Văn Linh, Hải Châu, Đà Nẵng',4,4,8,0,NULL,'VỊ TRÍ: Product Designer Intern\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của PixelCraft Studio.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 0 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Làm việc nhóm, Tư duy học hỏi.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-05',1,1,'2026-05-21 17:07:34','2026-06-10 17:07:34'),(3021,2106,9,9,'E-commerce Executive','36 Hoàng Cầu, Đống Đa, Hà Nội',2,10,24,1,NULL,'VỊ TRÍ: E-commerce Executive\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của Sunrise Commerce.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-12',0,1,'2026-05-20 17:07:34','2026-06-10 17:07:34'),(3022,2106,9,9,'Key Account Executive','36 Hoàng Cầu, Đống Đa, Hà Nội',4,10,24,1,NULL,'VỊ TRÍ: Key Account Executive\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của Sunrise Commerce.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-19',0,1,'2026-05-19 17:07:34','2026-06-10 17:07:34'),(3023,2106,9,9,'Performance Marketing','36 Hoàng Cầu, Đống Đa, Hà Nội',1,10,24,1,NULL,'VỊ TRÍ: Performance Marketing\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của Sunrise Commerce.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-26',0,1,'2026-05-18 17:07:34','2026-06-10 17:07:34'),(3024,2106,9,9,'Customer Experience Specialist','36 Hoàng Cầu, Đống Đa, Hà Nội',3,10,24,1,NULL,'VỊ TRÍ: Customer Experience Specialist\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của Sunrise Commerce.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-09-02',1,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(3025,2107,9,9,'Dược sĩ Tư vấn','Khu Công nghệ cao, Thủ Đức, Hồ Chí Minh',1,10,24,1,NULL,'VỊ TRÍ: Dược sĩ Tư vấn\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của MediCare Pharma.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-16',0,1,'2026-06-09 17:07:34','2026-06-10 17:07:34'),(3026,2107,9,9,'Medical Representative','Khu Công nghệ cao, Thủ Đức, Hồ Chí Minh',3,10,24,1,NULL,'VỊ TRÍ: Medical Representative\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của MediCare Pharma.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-23',0,1,'2026-06-08 17:07:34','2026-06-10 17:07:34'),(3027,2107,9,9,'Product Marketing Executive','Khu Công nghệ cao, Thủ Đức, Hồ Chí Minh',5,10,24,1,NULL,'VỊ TRÍ: Product Marketing Executive\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của MediCare Pharma.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-30',0,1,'2026-06-07 17:07:34','2026-06-10 17:07:34'),(3028,2107,9,9,'Full-stack Developer - HealthTech','Khu Công nghệ cao, Thủ Đức, Hồ Chí Minh',2,16,32,2,NULL,'VỊ TRÍ: Full-stack Developer - HealthTech\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của MediCare Pharma.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Git, SQL, REST API, Agile.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-06',1,1,'2026-06-06 17:07:34','2026-06-10 17:07:34'),(3029,2108,9,9,'Cloud Engineer','Etown Central, Quận 4, Hồ Chí Minh',5,16,32,2,NULL,'VỊ TRÍ: Cloud Engineer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của CloudNine Technology.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Docker, Linux, CI/CD, Cloud.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-13',0,1,'2026-06-05 17:07:35','2026-06-10 17:07:35'),(3030,2108,9,9,'System Administrator','Etown Central, Quận 4, Hồ Chí Minh',2,16,32,2,NULL,'VỊ TRÍ: System Administrator\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của CloudNine Technology.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Networking, Linux, Cloud, Monitoring.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-20',0,1,'2026-06-04 17:07:35','2026-06-10 17:07:35'),(3031,2108,9,9,'Security Engineer','Etown Central, Quận 4, Hồ Chí Minh',4,16,32,2,NULL,'VỊ TRÍ: Security Engineer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của CloudNine Technology.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Network Security, Linux, SIEM, Incident Response.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-27',0,1,'2026-06-03 17:07:35','2026-06-10 17:07:35'),(3032,2108,9,9,'Technical Support Engineer','Etown Central, Quận 4, Hồ Chí Minh',1,16,32,2,NULL,'VỊ TRÍ: Technical Support Engineer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của CloudNine Technology.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Git, SQL, REST API, Agile.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-09-03',1,1,'2026-06-02 17:07:35','2026-06-10 17:07:35'),(3033,2109,9,9,'Academic Advisor','82 Duy Tân, Cầu Giấy, Hà Nội',4,10,24,1,NULL,'VỊ TRÍ: Academic Advisor\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của BrightPath Education.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-17',0,1,'2026-06-01 17:07:35','2026-06-10 17:07:35'),(3034,2109,9,9,'Content Creator','82 Duy Tân, Cầu Giấy, Hà Nội',1,11,22,1,NULL,'VỊ TRÍ: Content Creator\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của BrightPath Education.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Figma, Sáng tạo nội dung, Làm việc nhóm.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-24',0,1,'2026-05-31 17:07:35','2026-06-10 17:07:35'),(3035,2109,9,9,'React Native Developer','82 Duy Tân, Cầu Giấy, Hà Nội',3,16,32,2,NULL,'VỊ TRÍ: React Native Developer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của BrightPath Education.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: JavaScript, React, HTML/CSS, REST API.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-31',0,1,'2026-05-30 17:07:35','2026-06-10 17:07:35'),(3036,2109,9,9,'Customer Success Executive','82 Duy Tân, Cầu Giấy, Hà Nội',5,10,24,1,NULL,'VỊ TRÍ: Customer Success Executive\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của BrightPath Education.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-07',1,1,'2026-05-29 17:07:35','2026-06-10 17:07:35'),(3037,2110,9,9,'Social Media Executive','18A Cộng Hòa, Tân Bình, Hồ Chí Minh',3,10,24,1,NULL,'VỊ TRÍ: Social Media Executive\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của Orbit Media Vietnam.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-14',0,1,'2026-05-28 17:07:35','2026-06-10 17:07:35'),(3038,2110,9,9,'SEO Specialist','18A Cộng Hòa, Tân Bình, Hồ Chí Minh',5,10,24,1,NULL,'VỊ TRÍ: SEO Specialist\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của Orbit Media Vietnam.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-21',0,1,'2026-05-27 17:07:35','2026-06-10 17:07:35'),(3039,2110,9,9,'Account Executive','18A Cộng Hòa, Tân Bình, Hồ Chí Minh',2,10,24,1,NULL,'VỊ TRÍ: Account Executive\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của Orbit Media Vietnam.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-28',0,1,'2026-05-26 17:07:35','2026-06-10 17:07:35'),(3040,2110,9,9,'Video Editor','18A Cộng Hòa, Tân Bình, Hồ Chí Minh',4,11,22,1,NULL,'VỊ TRÍ: Video Editor\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của Orbit Media Vietnam.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Figma, Sáng tạo nội dung, Làm việc nhóm.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-09-04',1,1,'2026-05-25 17:07:35','2026-06-10 17:07:35'),(3041,2111,9,9,'Network Engineer','Lê Hồng Phong, Ngô Quyền, Hải Phòng',2,16,32,2,NULL,'VỊ TRÍ: Network Engineer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của FutureTel Communications.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Networking, Linux, Cloud, Monitoring.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-18',0,1,'2026-05-24 17:07:35','2026-06-10 17:07:35'),(3042,2111,9,9,'IoT Developer','Lê Hồng Phong, Ngô Quyền, Hải Phòng',4,16,32,2,NULL,'VỊ TRÍ: IoT Developer\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của FutureTel Communications.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Git, SQL, REST API, Agile.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-07-25',0,1,'2026-05-23 17:07:35','2026-06-10 17:07:35'),(3043,2111,9,9,'Nhân viên Kinh doanh B2B','Lê Hồng Phong, Ngô Quyền, Hải Phòng',1,10,24,1,NULL,'VỊ TRÍ: Nhân viên Kinh doanh B2B\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của FutureTel Communications.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-01',0,1,'2026-05-22 17:07:35','2026-06-10 17:07:35'),(3044,2111,9,9,'Chuyên viên Chăm sóc khách hàng','Lê Hồng Phong, Ngô Quyền, Hải Phòng',3,10,24,1,NULL,'VỊ TRÍ: Chuyên viên Chăm sóc khách hàng\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của FutureTel Communications.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-08',1,1,'2026-05-21 17:07:35','2026-06-10 17:07:35'),(3045,2112,9,9,'Recruitment Consultant','Becamex Tower, Thủ Dầu Một, Bình Dương',1,10,24,1,NULL,'VỊ TRÍ: Recruitment Consultant\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của PeopleFirst HR.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-15',0,1,'2026-05-20 17:07:35','2026-06-10 17:07:35'),(3046,2112,9,9,'HR Executive','Becamex Tower, Thủ Dầu Một, Bình Dương',3,10,24,1,NULL,'VỊ TRÍ: HR Executive\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của PeopleFirst HR.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-22',0,1,'2026-05-19 17:07:35','2026-06-10 17:07:35'),(3047,2112,9,9,'Employer Branding Specialist','Becamex Tower, Thủ Dầu Một, Bình Dương',5,10,24,1,NULL,'VỊ TRÍ: Employer Branding Specialist\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của PeopleFirst HR.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 1 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: Giao tiếp, Phân tích, Microsoft Office.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-08-29',0,1,'2026-05-18 17:07:35','2026-06-10 17:07:35'),(3048,2112,9,9,'PHP Developer - HRM Platform','Becamex Tower, Thủ Dầu Một, Bình Dương',2,16,32,2,NULL,'VỊ TRÍ: PHP Developer - HRM Platform\n\nMÔ TẢ CÔNG VIỆC\n- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của PeopleFirst HR.\n- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\nYÊU CẦU\n- Có từ 2 năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n- Kiến thức/kỹ năng ưu tiên: PHP, Laravel, MySQL, REST API.\n- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\nQUYỀN LỢI\n- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.','2026-09-05',1,1,'2026-06-10 17:07:35','2026-06-10 17:07:35');
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jskills`
--

DROP TABLE IF EXISTS `jskills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jskills` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jskills`
--

LOCK TABLES `jskills` WRITE;
/*!40000 ALTER TABLE `jskills` DISABLE KEYS */;
INSERT INTO `jskills` VALUES (1,'PHP'),(2,'Laravel'),(3,'React'),(4,'JavaScript'),(5,'MySQL'),(6,'Docker'),(7,'Figma'),(8,'SQL'),(9,'Power BI'),(10,'Postman'),(11,'Selenium'),(12,'Node.js'),(13,'REST API'),(14,'HTML/CSS'),(15,'Giao tiếp'),(16,'Phân tích'),(17,'Microsoft Office'),(18,'Linux'),(19,'CI/CD'),(20,'Cloud'),(21,'Python'),(22,'Machine Learning'),(23,'Automation Test'),(24,'Java'),(25,'Spring Boot'),(26,'Microservices'),(27,'Git'),(28,'Agile'),(29,'Sáng tạo nội dung'),(30,'Làm việc nhóm'),(31,'Tư duy học hỏi'),(32,'Networking'),(33,'Monitoring'),(34,'Network Security'),(35,'SIEM'),(36,'Incident Response');
/*!40000 ALTER TABLE `jskills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jtags`
--

DROP TABLE IF EXISTS `jtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jtags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jtags`
--

LOCK TABLES `jtags` WRITE;
/*!40000 ALTER TABLE `jtags` DISABLE KEYS */;
INSERT INTO `jtags` VALUES (1,'Backend'),(2,'Frontend'),(3,'Remote'),(4,'Hot'),(5,'Data'),(6,'QA'),(7,'Design'),(8,'Fresher'),(9,'Technology'),(10,'Hybrid'),(11,'Full-time'),(12,'Professional'),(13,'Creative'),(14,'Portfolio'),(15,'Internship'),(16,'On-site');
/*!40000 ALTER TABLE `jtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jtypes`
--

DROP TABLE IF EXISTS `jtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jtypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jtypes`
--

LOCK TABLES `jtypes` WRITE;
/*!40000 ALTER TABLE `jtypes` DISABLE KEYS */;
INSERT INTO `jtypes` VALUES (1,'Full-time'),(2,'Part-time'),(3,'Internship'),(4,'Remote'),(5,'Hybrid'),(9,'Nhân viên chính thức'),(10,'Thực tập');
/*!40000 ALTER TABLE `jtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Ha Noi'),(2,'TP Ho Chi Minh'),(3,'Da Nang'),(4,'Can Tho'),(5,'Remote'),(9,'Đà Nẵng'),(10,'Hồ Chí Minh'),(11,'Hải Phòng'),(12,'Bình Dương');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_reset_tokens_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2023_05_15_105930_create-candidates-table',1),(6,'2023_05_18_015317_create-employers-table',1),(7,'2023_05_18_015349_create-jobs-table',1),(8,'2023_05_18_015455_create-industries-table',1),(9,'2023_05_18_015519_create-locations-table',1),(10,'2023_05_18_015540_create-jtypes-table',1),(11,'2023_05_18_015605_create-jlevels-table',1),(12,'2023_05_18_015642_create-jtags-table',1),(13,'2023_05_18_015700_create-jskills-table',1),(14,'2023_05_18_015757_create-job-applying-table',1),(15,'2023_05_18_020112_create-educations-table',1),(16,'2023_05_18_020158_create-experiences-table',1),(17,'2023_05_18_020221_create-projects-table',1),(18,'2023_05_18_020306_create-skills-table',1),(19,'2023_05_18_020332_create-certificates-table',1),(20,'2023_05_18_020356_create-prizes-table',1),(21,'2023_05_18_020429_create-activities-table',1),(22,'2023_05_18_031155_create-job-tag-table',1),(23,'2023_05_18_031210_create-job-skill-table',1),(24,'2023_06_01_020423_create-employer-location-table',1),(25,'2023_06_01_031704_create-job-industry-table',1),(26,'2023_06_02_013037_create-job-location-table',1),(27,'2023_07_14_082259_create_candidate_messages_table',1),(28,'2023_07_18_155830_create-saved-jobs-table',1),(29,'2024_01_05_154802_create_others_table',1),(30,'2024_01_05_155307_create_resumes_table',1),(31,'2026_06_09_000001_update_job_applying_statuses',1),(32,'2026_06_09_000002_add_cv_fields_to_job_applying',1),(33,'2026_06_10_000001_create_admin_audit_logs_table',2),(34,'2026_06_10_000002_add_pipeline_fields_to_job_applying',2),(35,'2026_06_10_000003_add_is_default_to_resumes',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `others`
--

DROP TABLE IF EXISTS `others`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `others` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `resume_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `others`
--

LOCK TABLES `others` WRITE;
/*!40000 ALTER TABLE `others` DISABLE KEYS */;
INSERT INTO `others` VALUES (1,1,1,'So thich','Doc sach cong nghe, chay bo va chia se kien thuc lap trinh.'),(2,2,2,'So thich','Phan tich du lieu mo, viet blog va tham gia meetup cong dong.'),(7,2001,2001,'Điểm mạnh','Tư duy logic, chủ động tìm hiểu công nghệ, có trách nhiệm với deadline, giao tiếp và phối hợp nhóm tốt.'),(8,2001,2001,'Sở thích','Đọc tài liệu công nghệ, xây dựng side project, chạy bộ và tham gia hoạt động cộng đồng.'),(9,2001,2002,'Điểm mạnh','Tư duy logic, chủ động tìm hiểu công nghệ, có trách nhiệm với deadline, giao tiếp và phối hợp nhóm tốt.'),(10,2001,2002,'Sở thích','Đọc tài liệu công nghệ, xây dựng side project, chạy bộ và tham gia hoạt động cộng đồng.');
/*!40000 ALTER TABLE `others` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
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
-- Table structure for table `prizes`
--

DROP TABLE IF EXISTS `prizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prizes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `resume_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `receive_date` date DEFAULT NULL,
  `image` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prizes`
--

LOCK TABLES `prizes` WRITE;
/*!40000 ALTER TABLE `prizes` DISABLE KEYS */;
INSERT INTO `prizes` VALUES (1,1,1,'Top 5 University Hackathon','2022-11-20',NULL),(2,2,2,'Best Dashboard Project','2023-09-15',NULL),(7,2001,2001,'Top 10 cuộc thi Web Development cấp khoa','2024-05-25',NULL),(8,2001,2001,'Sinh viên giỏi năm học 2023-2024','2024-09-05',NULL),(9,2001,2002,'Top 10 cuộc thi Web Development cấp khoa','2024-05-25',NULL),(10,2001,2002,'Sinh viên giỏi năm học 2023-2024','2024-09-05',NULL);
/*!40000 ALTER TABLE `prizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `resume_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `prj_type` varchar(60) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `technologies` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `link` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,1,1,'Recruitment Portal','Team','Backend Developer','Laravel, MySQL, JWT, React','2023-02-01','2023-06-30','Xay dung module auth, quan ly viec lam, ung tuyen va dashboard nha tuyen dung.','https://github.com/minhanh-dev/recruitment-portal'),(2,1,NULL,'Personal Finance App','Personal','Full-stack Developer','React, Node.js, MySQL','2024-01-01','2024-05-30','Ung dung theo doi chi tieu ca nhan va thong ke theo danh muc.','https://github.com/minhanh-dev/finance-app'),(3,2,2,'Sales Analytics Dashboard','Team','Data Analyst','SQL, Power BI, Excel','2023-05-01','2023-09-30','Dashboard doanh thu, ty le chuyen doi va hieu qua chien dich marketing.','https://example.com/sales-dashboard'),(10,2001,2001,'Recruitment Web Platform','Đồ án tốt nghiệp','Backend Developer / Database Designer','Laravel 10, PHP 8.1, MySQL, JWT, Redis, Pusher, ReactJS','2025-01-01','2025-06-30','Xây dựng hệ thống tuyển dụng với ba vai trò. Phát triển 112 API routes, xác thực JWT, quản lý nhiều CV, tìm kiếm việc làm, pipeline ứng tuyển, dashboard thống kê, thông báo và audit log.','https://github.com/taianh-bui/recruitment-web'),(11,2001,2001,'E-commerce Management API','Dự án cá nhân','Full-stack Developer','Laravel, ReactJS, MySQL, Docker','2024-02-01','2024-05-31','Thiết kế API quản lý sản phẩm, tồn kho, đơn hàng và phân quyền; xây dựng dashboard quản trị; áp dụng validation, pagination và transaction.','https://github.com/taianh-bui/ecommerce-management'),(12,2001,2001,'Student Task Management','Dự án nhóm','Team Leader / Backend Developer','Node.js, Express, MongoDB, Socket.IO','2023-08-01','2023-12-15','Ứng dụng quản lý công việc nhóm có bảng Kanban, thông báo thời gian thực và phân quyền thành viên. Điều phối nhóm 4 người và quản lý source code trên GitHub.','https://github.com/taianh-bui/student-task-management'),(13,2001,2002,'Recruitment Web Platform','Đồ án tốt nghiệp','Backend Developer / Database Designer','Laravel 10, PHP 8.1, MySQL, JWT, Redis, Pusher, ReactJS','2025-01-01','2025-06-30','Xây dựng hệ thống tuyển dụng với ba vai trò. Phát triển 112 API routes, xác thực JWT, quản lý nhiều CV, tìm kiếm việc làm, pipeline ứng tuyển, dashboard thống kê, thông báo và audit log.','https://github.com/taianh-bui/recruitment-web'),(14,2001,2002,'E-commerce Management API','Dự án cá nhân','Full-stack Developer','Laravel, ReactJS, MySQL, Docker','2024-02-01','2024-05-31','Thiết kế API quản lý sản phẩm, tồn kho, đơn hàng và phân quyền; xây dựng dashboard quản trị; áp dụng validation, pagination và transaction.','https://github.com/taianh-bui/ecommerce-management'),(15,2001,2002,'Student Task Management','Dự án nhóm','Team Leader / Backend Developer','Node.js, Express, MongoDB, Socket.IO','2023-08-01','2023-12-15','Ứng dụng quản lý công việc nhóm có bảng Kanban, thông báo thời gian thực và phân quyền thành viên. Điều phối nhóm 4 người và quản lý source code trên GitHub.','https://github.com/taianh-bui/student-task-management');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resumes`
--

DROP TABLE IF EXISTS `resumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resumes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `title` varchar(60) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `gender` tinyint(3) unsigned DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` char(10) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `link` text DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `objective` text DEFAULT NULL,
  `personalTitle` varchar(60) DEFAULT NULL,
  `objectiveTitle` varchar(60) DEFAULT NULL,
  `educationTitle` varchar(60) DEFAULT NULL,
  `experienceTitle` varchar(60) DEFAULT NULL,
  `projectTitle` varchar(60) DEFAULT NULL,
  `skillTitle` varchar(60) DEFAULT NULL,
  `certificateTitle` varchar(60) DEFAULT NULL,
  `prizeTitle` varchar(60) DEFAULT NULL,
  `activityTitle` varchar(60) DEFAULT NULL,
  `cv_link` text DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `parts_order` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`parts_order`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resumes`
--

LOCK TABLES `resumes` WRITE;
/*!40000 ALTER TABLE `resumes` DISABLE KEYS */;
INSERT INTO `resumes` VALUES (1,1,'Full-stack Developer CV','Nguyen Minh Anh',1,'2001-08-15','0912345678','candidate.demo@example.com','Cau Giay, Ha Noi','https://github.com/minhanh-dev','avatar.jpg','Ung dung kinh nghiem Laravel va React de xay dung san pham co chat luong.','Thong tin ca nhan','Muc tieu nghe nghiep','Hoc van','Kinh nghiem','Du an','Ky nang','Chung chi','Giai thuong','Hoat dong',NULL,1,'[\"personal\",\"objective\",\"education\",\"experience\",\"project\",\"skill\",\"certificate\",\"prize\",\"activity\",\"other\"]','2026-06-10 02:00:00','2026-06-10 02:00:00'),(2,2,'Data Analyst CV','Tran Khanh Linh',1,'2000-11-03','0923456789','linh.candidate@example.com','Thanh Xuan, Ha Noi','https://linkedin.com/in/khanhlinh','avatar.jpg','Bien du lieu thanh insight co gia tri cho san pham va kinh doanh.','Thong tin ca nhan','Muc tieu nghe nghiep','Hoc van','Kinh nghiem','Du an','Ky nang','Chung chi','Giai thuong','Hoat dong',NULL,1,'[\"personal\",\"objective\",\"education\",\"experience\",\"project\",\"skill\"]','2026-06-10 02:00:00','2026-06-10 02:00:00'),(2001,2001,'Backend Developer - Bùi Đức Tài Anh','Bùi Đức Tài Anh',0,'2003-11-17','0987654321','taianh.bui@example.com','Cầu Giấy, Hà Nội','https://github.com/taianh-bui','https://ui-avatars.com/api/?name=Bui+Duc+Tai+Anh&size=512&background=0F4C81&color=ffffff&bold=true','Mong muốn phát triển theo hướng Backend Developer chuyên sâu với PHP/Laravel và Node.js. Trong 2 năm tới, mục tiêu là làm chủ thiết kế REST API, tối ưu MySQL, kiểm thử tự động và quy trình CI/CD; đồng thời đóng góp vào các sản phẩm có giá trị thực tế.','THÔNG TIN CÁ NHÂN','MỤC TIÊU NGHỀ NGHIỆP','HỌC VẤN','KINH NGHIỆM LÀM VIỆC','DỰ ÁN NỔI BẬT','KỸ NĂNG CHUYÊN MÔN','CHỨNG CHỈ','THÀNH TÍCH','HOẠT ĐỘNG',NULL,1,'[\"personal\",\"objective\",\"skill\",\"experience\",\"project\",\"education\",\"certificate\",\"prize\",\"activity\",\"other\"]','2026-06-10 17:07:35','2026-06-10 17:07:35'),(2002,2001,'Full-stack Developer - Bùi Đức Tài Anh','Bùi Đức Tài Anh',0,'2003-11-17','0987654321','taianh.bui@example.com','Cầu Giấy, Hà Nội','https://github.com/taianh-bui','https://ui-avatars.com/api/?name=Bui+Duc+Tai+Anh&size=512&background=0F4C81&color=ffffff&bold=true','Tìm kiếm vị trí Full-stack Developer để vận dụng Laravel, ReactJS và kỹ năng thiết kế cơ sở dữ liệu, hướng tới xây dựng sản phẩm hoàn chỉnh từ giao diện đến backend.','GIỚI THIỆU','ĐỊNH HƯỚNG','HỌC VẤN','KINH NGHIỆM','DỰ ÁN','CÔNG NGHỆ','CHỨNG CHỈ','THÀNH TÍCH','HOẠT ĐỘNG',NULL,0,'[\"personal\",\"objective\",\"experience\",\"project\",\"skill\",\"education\",\"certificate\",\"activity\"]','2026-06-10 17:07:35','2026-06-10 17:07:35');
/*!40000 ALTER TABLE `resumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_jobs`
--

DROP TABLE IF EXISTS `saved_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_jobs` (
  `candidate_id` bigint(20) unsigned NOT NULL,
  `job_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`candidate_id`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_jobs`
--

LOCK TABLES `saved_jobs` WRITE;
/*!40000 ALTER TABLE `saved_jobs` DISABLE KEYS */;
INSERT INTO `saved_jobs` VALUES (1,1),(1,5),(2,5),(3,3),(4,4),(2001,3001),(2001,3002),(2001,3005),(2001,3007),(2001,3014),(2001,3025),(2001,3048);
/*!40000 ALTER TABLE `saved_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skills` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` bigint(20) unsigned NOT NULL,
  `resume_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `proficiency` tinyint(3) unsigned DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` VALUES (1,1,NULL,'Laravel',85,'Xay dung REST API, migration, queue va test.'),(2,1,NULL,'React',80,'Component, hook, form va tich hop API.'),(3,1,1,'MySQL',78,'Thiet ke bang, index va toi uu truy van co ban.'),(4,2,NULL,'SQL',88,'Query phan tich, CTE, window function.'),(5,2,2,'Power BI',82,'Dashboard tuong tac, data model va DAX co ban.'),(6,2,2,'Excel',85,'Pivot table, Power Query va bao cao van hanh.'),(25,2001,2001,'PHP',88,'Laravel, Eloquent ORM, REST API, Composer'),(26,2001,2001,'Laravel',90,'Routing, Middleware, JWT, Queue, Event, Feature Test'),(27,2001,2001,'MySQL',85,'Thiết kế quan hệ, index, transaction, tối ưu truy vấn'),(28,2001,2001,'JavaScript',78,'ES6+, async/await, Axios, DOM'),(29,2001,2001,'ReactJS',75,'Component, Hook, Router, quản lý state'),(30,2001,2001,'Git/GitHub',85,'Git Flow, pull request, xử lý conflict'),(31,2001,2001,'Docker',68,'Container hóa môi trường phát triển'),(32,2001,2001,'Tiếng Anh',72,'Đọc hiểu tài liệu kỹ thuật và giao tiếp cơ bản'),(33,2001,2002,'PHP',88,'Laravel, Eloquent ORM, REST API, Composer'),(34,2001,2002,'Laravel',90,'Routing, Middleware, JWT, Queue, Event, Feature Test'),(35,2001,2002,'MySQL',85,'Thiết kế quan hệ, index, transaction, tối ưu truy vấn'),(36,2001,2002,'JavaScript',78,'ES6+, async/await, Axios, DOM'),(37,2001,2002,'ReactJS',75,'Component, Hook, Router, quản lý state'),(38,2001,2002,'Git/GitHub',85,'Git Flow, pull request, xử lý conflict'),(39,2001,2002,'Docker',68,'Container hóa môi trường phát triển'),(40,2001,2002,'Tiếng Anh',72,'Đọc hiểu tài liệu kỹ thuật và giao tiếp cơ bản');
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `role` tinyint(3) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'candidate.demo@example.com','2026-06-10 02:00:00','$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82',NULL,1,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(2,'linh.candidate@example.com','2026-06-10 02:00:00','$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82',NULL,1,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(3,'minh.candidate@example.com','2026-06-10 02:00:00','$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82',NULL,1,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(4,'thao.candidate@example.com','2026-06-10 02:00:00','$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82',NULL,1,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(5,'employer.demo@example.com','2026-06-10 02:00:00','$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82',NULL,2,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(6,'hr.novatech@example.com','2026-06-10 02:00:00','$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82',NULL,2,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(7,'hr.greenpay@example.com','2026-06-10 02:00:00','$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82',NULL,2,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(8,'admin.demo@example.com','2026-06-10 02:00:00','$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82',NULL,0,1,'2026-06-10 02:00:00','2026-06-10 02:00:00'),(2001,'taianh.bui@example.com','2026-06-10 17:07:34','$2y$10$6txh5VJlTY4UaRiszLHAkuT6.oB1VMwySJrNbrr2/ZNp0j8S7DpAK',NULL,1,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2101,'novatech@company.demo','2026-06-10 17:07:34','$2y$10$3AjiN5UfOzhpQK4vEXvuvep1HAxXNNZFTiC8TBQg0rTY520XQGxNS',NULL,2,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2102,'vietdata@company.demo','2026-06-10 17:07:34','$2y$10$rqNAqVfY9EkpM5DDHjJJjuPSFZhOpe/ztNfzFJe1kT3rOsUL0JH8C',NULL,2,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2103,'bluewave@company.demo','2026-06-10 17:07:34','$2y$10$uPyIRlKciLFsCRVLy1zcnuxjttjT/j4sOA0nNLErnJgcoyTh/OIiu',NULL,2,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2104,'greenlog@company.demo','2026-06-10 17:07:34','$2y$10$w8jWzbvpcIqKRCujzZZLO.YpSWGyE2jwjSSakeL4VxMsQC5AaCok.',NULL,2,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2105,'pixelcraft@company.demo','2026-06-10 17:07:34','$2y$10$w6vzRZeRbHhNzsNejeEFPOp.akklNDqYOWGRqEXAncyBdSGnOpKjm',NULL,2,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2106,'sunrise@company.demo','2026-06-10 17:07:34','$2y$10$GMxo2foC.JqSboI3HgH8YOlxdDhSzJzxme4mz8xl/hrzUnQSf4kF2',NULL,2,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2107,'medicare@company.demo','2026-06-10 17:07:34','$2y$10$vABQ48in5bRQwvoJ.roxMOCB4idcK.0BurwZaLyaS11bUWO9A1XNy',NULL,2,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2108,'cloudnine@company.demo','2026-06-10 17:07:34','$2y$10$KnNpULbLCNIuexssZyTwtugkkSHcCGo3VIsOVJnYfI6iWYTOcfTf2',NULL,2,1,'2026-06-10 17:07:34','2026-06-10 17:07:34'),(2109,'brightpath@company.demo','2026-06-10 17:07:35','$2y$10$D2MI/hENqNEocKqPpndHS.9XdtopABLWzo9KpGRe8.rhYThv6x4yW',NULL,2,1,'2026-06-10 17:07:35','2026-06-10 17:07:35'),(2110,'orbitmedia@company.demo','2026-06-10 17:07:35','$2y$10$NZ.DPkRisdiquh4.dwDzy.h7x08aMX/YDgllsWS8ivIVwPDYpyWA.',NULL,2,1,'2026-06-10 17:07:35','2026-06-10 17:07:35'),(2111,'futuretel@company.demo','2026-06-10 17:07:35','$2y$10$3UalqqcoXYZxI9lh1P.K..iI/IQCMnz4EWljeeCDyxcoBvpsA4sTe',NULL,2,1,'2026-06-10 17:07:35','2026-06-10 17:07:35'),(2112,'peoplefirst@company.demo','2026-06-10 17:07:35','$2y$10$4Kq0d2ermqijmtlHf5mKc.fmICxgcv3DfJ2LrSjNKWU9vn.soqhQq',NULL,2,1,'2026-06-10 17:07:35','2026-06-10 17:07:35');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'recruitment'
--

--
-- Dumping routines for database 'recruitment'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-11  0:11:21
