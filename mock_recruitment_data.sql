-- Mock data for Recruitment project
-- Import after running Laravel migrations.
-- Demo accounts:
--   Candidate: candidate.demo@example.com / password
--   Employer:  employer.demo@example.com  / password
--   Admin:     admin.demo@example.com     / password

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE candidate_messages;
TRUNCATE TABLE saved_jobs;
TRUNCATE TABLE job_applying;
TRUNCATE TABLE job_skill;
TRUNCATE TABLE job_tag;
TRUNCATE TABLE job_location;
TRUNCATE TABLE job_industry;
TRUNCATE TABLE employer_location;
TRUNCATE TABLE others;
TRUNCATE TABLE activities;
TRUNCATE TABLE prizes;
TRUNCATE TABLE certificates;
TRUNCATE TABLE skills;
TRUNCATE TABLE projects;
TRUNCATE TABLE experiences;
TRUNCATE TABLE educations;
TRUNCATE TABLE resumes;
TRUNCATE TABLE jobs;
TRUNCATE TABLE jskills;
TRUNCATE TABLE jtags;
TRUNCATE TABLE industries;
TRUNCATE TABLE jlevels;
TRUNCATE TABLE jtypes;
TRUNCATE TABLE locations;
TRUNCATE TABLE employers;
TRUNCATE TABLE candidates;
TRUNCATE TABLE users;
TRUNCATE TABLE personal_access_tokens;
TRUNCATE TABLE password_reset_tokens;
TRUNCATE TABLE failed_jobs;
TRUNCATE TABLE admin_audit_logs;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO users (id, email, email_verified_at, password, remember_token, role, is_active, created_at, updated_at) VALUES
(1, 'candidate.demo@example.com', '2026-06-10 09:00:00', '$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82', NULL, 1, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(2, 'linh.candidate@example.com', '2026-06-10 09:00:00', '$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82', NULL, 1, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(3, 'minh.candidate@example.com', '2026-06-10 09:00:00', '$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82', NULL, 1, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(4, 'thao.candidate@example.com', '2026-06-10 09:00:00', '$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82', NULL, 1, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(5, 'employer.demo@example.com', '2026-06-10 09:00:00', '$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82', NULL, 2, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(6, 'hr.novatech@example.com', '2026-06-10 09:00:00', '$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82', NULL, 2, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(7, 'hr.greenpay@example.com', '2026-06-10 09:00:00', '$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82', NULL, 2, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(8, 'admin.demo@example.com', '2026-06-10 09:00:00', '$2y$10$//7.4oKUAdz8MPgDmDHMBu2Cbx8M6x7JlHw7mqFJmraeLke/vRf82', NULL, 0, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00');

INSERT INTO candidates (id, user_id, firstname, lastname, gender, dob, phone, email, address, link, objective, avatar, created_at, updated_at) VALUES
(1, 1, 'Minh Anh', 'Nguyen', 1, '2001-08-15', '0912345678', 'candidate.demo@example.com', 'Cau Giay, Ha Noi', 'https://github.com/minhanh-dev', 'Tro thanh full-stack developer, xay dung san pham on dinh va de su dung.', 'avatar.jpg', '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(2, 2, 'Khanh Linh', 'Tran', 1, '2000-11-03', '0923456789', 'linh.candidate@example.com', 'Thanh Xuan, Ha Noi', 'https://linkedin.com/in/khanhlinh', 'Phat trien su nghiep trong linh vuc phan tich du lieu va san pham.', 'avatar.jpg', '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(3, 3, 'Quang Minh', 'Pham', 0, '1999-05-20', '0934567890', 'minh.candidate@example.com', 'Thu Duc, TP Ho Chi Minh', 'https://github.com/quangminh-qa', 'Tim kiem moi truong QA automation co quy trinh chuyen nghiep.', 'avatar.jpg', '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(4, 4, 'Phuong Thao', 'Le', 1, '2002-02-18', '0945678901', 'thao.candidate@example.com', 'Hai Chau, Da Nang', 'https://behance.net/phuongthao', 'Hoc hoi va phat trien trong vai tro UI UX Designer.', 'avatar.jpg', '2026-06-10 09:00:00', '2026-06-10 09:00:00');

INSERT INTO locations (id, name) VALUES
(1, 'Ha Noi'),
(2, 'TP Ho Chi Minh'),
(3, 'Da Nang'),
(4, 'Can Tho'),
(5, 'Remote');

INSERT INTO industries (id, name) VALUES
(1, 'CNTT - Phan mem'),
(2, 'Thuong mai dien tu'),
(3, 'Tai chinh - Fintech'),
(4, 'Marketing'),
(5, 'Giao duc'),
(6, 'Du lieu');

INSERT INTO jtypes (id, name) VALUES
(1, 'Full-time'),
(2, 'Part-time'),
(3, 'Internship'),
(4, 'Remote'),
(5, 'Hybrid');

INSERT INTO jlevels (id, name) VALUES
(1, 'Intern'),
(2, 'Junior'),
(3, 'Middle'),
(4, 'Senior'),
(5, 'Leader');

INSERT INTO jskills (id, name) VALUES
(1, 'PHP'),
(2, 'Laravel'),
(3, 'React'),
(4, 'JavaScript'),
(5, 'MySQL'),
(6, 'Docker'),
(7, 'Figma'),
(8, 'SQL'),
(9, 'Power BI'),
(10, 'Postman'),
(11, 'Selenium'),
(12, 'Node.js');

INSERT INTO jtags (id, name) VALUES
(1, 'Backend'),
(2, 'Frontend'),
(3, 'Remote'),
(4, 'Hot'),
(5, 'Data'),
(6, 'QA'),
(7, 'Design'),
(8, 'Fresher');

INSERT INTO employers (id, user_id, name, address, min_employees, max_employees, contact_name, phone, website, description, logo, image, is_hot, is_active, created_at, updated_at) VALUES
(5, 5, 'TechWorks Viet Nam', '123 Duy Tan, Cau Giay, Ha Noi', 100, 300, 'Nguyen Thu Ha', '02473001234', 'https://techworks.example.com', 'Cong ty san pham web va nen tang du lieu cho thi truong Viet Nam.', '/logo192.png', '/image/poster4.jpg', 1, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(6, 6, 'NovaTech Labs', '72 Nguyen Co Thach, Nam Tu Liem, Ha Noi', 50, 150, 'Tran Bao Nam', '02473005678', 'https://novatech.example.com', 'Doi ngu phat trien SaaS, mobile app va he thong tich hop cho doanh nghiep.', '/logo192.png', '/image/poster4.jpg', 1, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(7, 7, 'GreenPay Digital', '18 Le Loi, Quan 1, TP Ho Chi Minh', 200, 500, 'Le Mai Anh', '02873007890', 'https://greenpay.example.com', 'Nen tang thanh toan so va dich vu fintech cho doanh nghiep vua va nho.', '/logo192.png', '/image/poster4.jpg', 0, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00');

INSERT INTO employer_location (employer_id, location_id) VALUES
(5, 1),
(5, 5),
(6, 1),
(6, 3),
(7, 2),
(7, 5);

INSERT INTO jobs (id, employer_id, jtype_id, jlevel_id, jname, address, amount, min_salary, max_salary, yoe, gender, description, expire_at, is_hot, is_active, created_at, updated_at) VALUES
(1, 5, 1, 3, 'Laravel Backend Developer', '123 Duy Tan, Cau Giay, Ha Noi', 3, 18000000, 30000000, 2, NULL, 'Phat trien REST API bang Laravel, toi uu truy van MySQL, viet automated test va phoi hop voi frontend team.', '2026-09-30', 1, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(2, 5, 5, 3, 'React Frontend Developer', 'Hybrid tai Cau Giay, Ha Noi', 2, 16000000, 28000000, 2, NULL, 'Xay dung giao dien tuyen dung responsive, tich hop API, toi uu performance va cai thien trai nghiem nguoi dung.', '2026-10-15', 1, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(3, 6, 1, 2, 'QA Automation Engineer', '72 Nguyen Co Thach, Ha Noi', 2, 14000000, 24000000, 1, NULL, 'Thiet ke test case, kiem thu API, viet automation script va quan ly bug tren quy trinh Agile.', '2026-09-20', 0, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(4, 6, 3, 1, 'UI UX Intern', 'Da Nang hoac Remote', 2, 5000000, 8000000, 0, NULL, 'Ho tro user research, thiet ke wireframe, prototype va phoi hop cung frontend de hoan thien giao dien.', '2026-08-31', 0, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(5, 7, 4, 3, 'Data Analyst', 'Remote', 2, 15000000, 25000000, 1, NULL, 'Phan tich du lieu san pham, xay dung dashboard Power BI va dua ra insight cho doi ngu kinh doanh.', '2026-11-01', 1, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(6, 7, 1, 4, 'DevOps Engineer', '18 Le Loi, Quan 1, TP Ho Chi Minh', 1, 25000000, 42000000, 3, NULL, 'Van hanh CI/CD, container, logging va monitoring cho he thong thanh toan co luu luong cao.', '2026-10-30', 0, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(7, 5, 1, 5, 'Engineering Team Leader', '123 Duy Tan, Cau Giay, Ha Noi', 1, 40000000, 60000000, 5, NULL, 'Dan dat team backend/frontend, review kien truc, lap ke hoach sprint va phat trien nang luc ky su.', '2026-12-15', 0, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(8, 6, 2, 2, 'Content Marketing Executive', 'Da Nang', 2, 9000000, 15000000, 1, NULL, 'Len ke hoach noi dung, viet bai SEO, quan ly social channel va phoi hop voi team thiet ke.', '2026-08-20', 0, 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00');

INSERT INTO job_industry (job_id, industry_id) VALUES
(1, 1), (1, 2),
(2, 1), (2, 2),
(3, 1),
(4, 1), (4, 4),
(5, 3), (5, 6),
(6, 1), (6, 3),
(7, 1),
(8, 4);

INSERT INTO job_location (job_id, location_id) VALUES
(1, 1),
(2, 1), (2, 5),
(3, 1),
(4, 3), (4, 5),
(5, 5),
(6, 2),
(7, 1),
(8, 3);

INSERT INTO job_skill (job_id, skill_id) VALUES
(1, 1), (1, 2), (1, 5),
(2, 3), (2, 4),
(3, 10), (3, 11), (3, 8),
(4, 7),
(5, 8), (5, 9),
(6, 6), (6, 5),
(7, 1), (7, 2), (7, 12),
(8, 4);

INSERT INTO job_tag (job_id, tag_id) VALUES
(1, 1), (1, 4),
(2, 2), (2, 4),
(3, 6),
(4, 7), (4, 8),
(5, 3), (5, 5),
(6, 1),
(7, 1), (7, 4),
(8, 8);

INSERT INTO resumes (id, candidate_id, title, fullname, gender, dob, phone, email, address, link, avatar, objective, personalTitle, objectiveTitle, educationTitle, experienceTitle, projectTitle, skillTitle, certificateTitle, prizeTitle, activityTitle, cv_link, is_default, parts_order, created_at, updated_at) VALUES
(1, 1, 'Full-stack Developer CV', 'Nguyen Minh Anh', 1, '2001-08-15', '0912345678', 'candidate.demo@example.com', 'Cau Giay, Ha Noi', 'https://github.com/minhanh-dev', 'avatar.jpg', 'Ung dung kinh nghiem Laravel va React de xay dung san pham co chat luong.', 'Thong tin ca nhan', 'Muc tieu nghe nghiep', 'Hoc van', 'Kinh nghiem', 'Du an', 'Ky nang', 'Chung chi', 'Giai thuong', 'Hoat dong', NULL, 1, '["personal","objective","education","experience","project","skill","certificate","prize","activity","other"]', '2026-06-10 09:00:00', '2026-06-10 09:00:00'),
(2, 2, 'Data Analyst CV', 'Tran Khanh Linh', 1, '2000-11-03', '0923456789', 'linh.candidate@example.com', 'Thanh Xuan, Ha Noi', 'https://linkedin.com/in/khanhlinh', 'avatar.jpg', 'Bien du lieu thanh insight co gia tri cho san pham va kinh doanh.', 'Thong tin ca nhan', 'Muc tieu nghe nghiep', 'Hoc van', 'Kinh nghiem', 'Du an', 'Ky nang', 'Chung chi', 'Giai thuong', 'Hoat dong', NULL, 1, '["personal","objective","education","experience","project","skill"]', '2026-06-10 09:00:00', '2026-06-10 09:00:00');

INSERT INTO educations (id, candidate_id, resume_id, school, major, start_date, end_date, description) VALUES
(1, 1, NULL, 'Dai hoc Bach Khoa Ha Noi', 'Cong nghe thong tin', '2019-09-01', '2023-06-30', 'Tot nghiep loai gioi, tap trung vao web engineering va co so du lieu.'),
(2, 1, 1, 'Dai hoc Bach Khoa Ha Noi', 'Cong nghe thong tin', '2019-09-01', '2023-06-30', 'GPA 3.4/4.0, do an tot nghiep ve he thong tuyen dung truc tuyen.'),
(3, 2, NULL, 'Dai hoc Kinh te Quoc dan', 'He thong thong tin quan ly', '2018-09-01', '2022-06-30', 'Tap trung vao phan tich du lieu va business intelligence.'),
(4, 2, 2, 'Dai hoc Kinh te Quoc dan', 'He thong thong tin quan ly', '2018-09-01', '2022-06-30', 'Thuc hien nhieu project dashboard bang SQL va Power BI.');

INSERT INTO experiences (id, candidate_id, resume_id, name, company, start_date, end_date, description) VALUES
(1, 1, NULL, 'Backend Developer Intern', 'TechWorks Viet Nam', '2022-06-01', '2022-12-31', 'Tham gia phat trien API Laravel, viet migration va xu ly bug.'),
(2, 1, 1, 'Full-stack Developer', 'Freelance Team', '2023-01-01', '2025-12-31', 'Xay dung web dashboard voi Laravel, React, MySQL va CI/CD co ban.'),
(3, 2, NULL, 'Data Analyst Intern', 'GreenPay Digital', '2021-07-01', '2022-01-31', 'Lam sach du lieu giao dich, viet SQL query va tao dashboard bao cao.'),
(4, 2, 2, 'Junior Data Analyst', 'Insight Lab', '2022-03-01', '2025-12-31', 'Phan tich funnel nguoi dung, bao cao KPI va tu dong hoa file bao cao hang tuan.');

INSERT INTO skills (id, candidate_id, resume_id, name, proficiency, description) VALUES
(1, 1, NULL, 'Laravel', 85, 'Xay dung REST API, migration, queue va test.'),
(2, 1, NULL, 'React', 80, 'Component, hook, form va tich hop API.'),
(3, 1, 1, 'MySQL', 78, 'Thiet ke bang, index va toi uu truy van co ban.'),
(4, 2, NULL, 'SQL', 88, 'Query phan tich, CTE, window function.'),
(5, 2, 2, 'Power BI', 82, 'Dashboard tuong tac, data model va DAX co ban.'),
(6, 2, 2, 'Excel', 85, 'Pivot table, Power Query va bao cao van hanh.');

INSERT INTO projects (id, candidate_id, resume_id, name, prj_type, role, technologies, start_date, end_date, description, link) VALUES
(1, 1, 1, 'Recruitment Portal', 'Team', 'Backend Developer', 'Laravel, MySQL, JWT, React', '2023-02-01', '2023-06-30', 'Xay dung module auth, quan ly viec lam, ung tuyen va dashboard nha tuyen dung.', 'https://github.com/minhanh-dev/recruitment-portal'),
(2, 1, NULL, 'Personal Finance App', 'Personal', 'Full-stack Developer', 'React, Node.js, MySQL', '2024-01-01', '2024-05-30', 'Ung dung theo doi chi tieu ca nhan va thong ke theo danh muc.', 'https://github.com/minhanh-dev/finance-app'),
(3, 2, 2, 'Sales Analytics Dashboard', 'Team', 'Data Analyst', 'SQL, Power BI, Excel', '2023-05-01', '2023-09-30', 'Dashboard doanh thu, ty le chuyen doi va hieu qua chien dich marketing.', 'https://example.com/sales-dashboard');

INSERT INTO certificates (id, candidate_id, resume_id, name, receive_date, expire_date, image) VALUES
(1, 1, 1, 'Laravel Professional Certificate', '2024-03-15', NULL, NULL),
(2, 2, 2, 'Google Data Analytics Certificate', '2023-08-10', NULL, NULL);

INSERT INTO prizes (id, candidate_id, resume_id, name, receive_date, image) VALUES
(1, 1, 1, 'Top 5 University Hackathon', '2022-11-20', NULL),
(2, 2, 2, 'Best Dashboard Project', '2023-09-15', NULL);

INSERT INTO activities (id, candidate_id, resume_id, organization, role, is_present, start_date, end_date, description, link) VALUES
(1, 1, 1, 'Google Developer Student Club', 'Backend Mentor', 0, '2021-09-01', '2022-06-30', 'Huong dan thanh vien moi ve API, Git va quy trinh lam project.', 'https://gdsc.example.com'),
(2, 2, 2, 'Data Community Vietnam', 'Volunteer', 1, '2023-01-01', NULL, 'Ho tro to chuc workshop ve SQL va dashboard cho nguoi moi bat dau.', 'https://data-community.example.com');

INSERT INTO others (id, candidate_id, resume_id, name, description) VALUES
(1, 1, 1, 'So thich', 'Doc sach cong nghe, chay bo va chia se kien thuc lap trinh.'),
(2, 2, 2, 'So thich', 'Phan tich du lieu mo, viet blog va tham gia meetup cong dong.');

INSERT INTO job_applying (job_id, candidate_id, cv_link, cv_type, resume_id, internal_note, interview_at, source, status, created_at, updated_at) VALUES
(1, 1, 'http://localhost:3000/candidate/resumes/1', 'system', 1, 'Ung vien co kinh nghiem Laravel tot, can review them ve testing.', NULL, 'Website', 'pending', '2026-06-10 09:20:00', '2026-06-10 09:20:00'),
(2, 1, 'http://localhost:3000/candidate/resumes/1', 'system', 1, 'Da xem CV, phu hop frontend React.', NULL, 'Website', 'viewed', '2026-06-09 10:15:00', '2026-06-10 08:30:00'),
(3, 1, 'http://localhost:3000/candidate/resumes/1', 'system', 1, 'Hen phong van vong 1 voi QA lead.', '2026-06-15 14:00:00', 'Referral', 'interview', '2026-06-08 14:00:00', '2026-06-10 09:10:00'),
(5, 2, 'http://localhost:3000/candidate/resumes/2', 'system', 2, 'Ung vien data manh, da thong nhat offer.', NULL, 'LinkedIn', 'suitable', '2026-06-07 13:00:00', '2026-06-10 09:00:00'),
(6, 2, 'http://localhost:3000/candidate/resumes/2', 'system', 2, 'Chua co kinh nghiem DevOps phu hop.', NULL, 'Website', 'rejected', '2026-06-06 16:00:00', '2026-06-09 16:00:00'),
(4, 4, 'http://localhost:3000/candidate/resumes/1', 'system', 1, 'Can review portfolio UI truoc khi hen phong van.', NULL, 'Website', 'pending', '2026-06-10 11:00:00', '2026-06-10 11:00:00');

INSERT INTO saved_jobs (candidate_id, job_id) VALUES
(1, 1),
(1, 5),
(2, 5),
(3, 3),
(4, 4);

INSERT INTO candidate_messages (id, candidate_id, job_id, name, title, content, isRead, created_at, updated_at) VALUES
(1, 1, 2, 'Nha tuyen dung da xem ho so, vi tri React Frontend Developer, TechWorks Viet Nam', 'Ho so da duoc xem', 'TechWorks da xem CV cua ban. Hay tiep tuc theo doi trang thai ung tuyen.', 0, '2026-06-10 08:30:00', '2026-06-10 08:30:00'),
(2, 1, 3, 'Ho so duoc chap nhan, vi tri QA Automation Engineer, NovaTech Labs', 'Moi phong van', 'NovaTech moi ban tham gia phong van online vao 14:00 ngay 15/06/2026.', 0, '2026-06-10 09:10:00', '2026-06-10 09:10:00'),
(3, 2, 5, 'Chuc mung ban da duoc nhan, vi tri Data Analyst, GreenPay Digital', 'Ket qua ung tuyen', 'GreenPay danh gia cao kinh nghiem phan tich du lieu cua ban va se lien he de trao doi offer.', 1, '2026-06-10 09:00:00', '2026-06-10 09:00:00');
