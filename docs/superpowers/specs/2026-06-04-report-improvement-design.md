# Design Spec: Bo sung Chuong 2 & Chuong 3 bao cao do an tot nghiep

## Muc tieu
Bo sung cac bieu do, thuc the, va noi dung con thieu trong Chuong 2 (Phan tich he thong) va Chuong 3 (Thiet ke he thong) cua bao cao do an tot nghiep, de bao cao phan anh dung he thong thuc te.

## Pham vi
- Giu nguyen tu dau den het Chuong 1
- Sua truc tiep file .docx goc
- Ket hop ca 2 phuong phap: phan tich co cau truc (DFD, ERD) + huong doi tuong (UML)

## Chuong 2: Phan tich he thong

### 2.1. Bo sung danh sach chuc nang (muc 2.1.1)
Them cac chuc nang thuc te con thieu:
- Quan ly hoc van (Education): CRUD hoc van cua ung vien
- Quan ly kinh nghiem (Experience): CRUD kinh nghiem lam viec
- Quan ly ky nang (Skill): CRUD ky nang cua ung vien
- Quan ly du an (Project): CRUD du an ca nhan
- Quan ly chung chi (Certificate): CRUD chung chi
- Quan ly giai thuong (Prize): CRUD giai thuong
- Quan ly hoat dong (Activity): CRUD hoat dong ngoai khoa
- Quan ly thong tin khac (Other): CRUD thong tin bo sung
- Quan ly CV/Resume truc tuyen: tao, sua, xoa CV
- Ung tuyen va nop ho so: nop don vao vi tri tuyen dung
- Tin nhan thong bao (Candidate Message): nhan thong bao xu ly ho so

### 2.2. Bo sung dac ta chuc nang (muc 2.2)
Them nhom 3: "Chuc nang quan ly ho so ung vien" voi dac ta:
- 2.2.3.1 Quan ly hoc van
- 2.2.3.2 Quan ly kinh nghiem
- 2.2.3.3 Quan ly ky nang
- 2.2.3.4 Quan ly du an
- 2.2.3.5 Quan ly chung chi
- 2.2.3.6 Quan ly giai thuong
- 2.2.3.7 Quan ly hoat dong
- 2.2.3.8 Quan ly CV/Resume

### 2.3. Them so do Use Case (muc moi 2.4)
Them muc "2.4. So do Use Case" sau muc 2.3:
- Mo ta 2 actor: Ung vien, Nha tuyen dung
- Liet ke cac use case cho tung actor
- Bang mo ta chi tiet tung use case

**Actor: Ung vien**
- Dang ky, Dang nhap, Dang xuat
- Cap nhat tai khoan, Cap nhat thong tin ca nhan
- Quan ly hoc van, kinh nghiem, ky nang, du an, chung chi, giai thuong, hoat dong
- Tao/sua/xoa CV truc tuyen
- Tim kiem viec lam, Luu tin tuyen dung
- Ung tuyen va nop ho so
- Xem thong bao ket qua

**Actor: Nha tuyen dung**
- Dang nhap, Dang xuat
- Cap nhat thong tin nha tuyen dung
- Tao/sua/doi trang thai tin tuyen dung
- Xem danh sach ung vien
- Xu ly ho so (chap nhan/tu choi/moi phong van)

### 2.4. Them 4 Sequence Diagram (muc moi 2.5)
Muc "2.5. So do tuan tu (Sequence Diagram)"

**SD1: Dang ky + Dang nhap**
Actor -> React UI -> Axios -> POST /api/register -> AuthController -> User Model -> DB
Actor -> React UI -> Axios -> POST /api/login -> AuthController -> JWT Token -> Response

**SD2: Tim kiem viec lam + Ung tuyen**
Actor -> React UI -> Axios -> GET /api/jobs?keyword=... -> JobController -> Job Model -> DB -> Response
Actor -> React UI -> Axios -> POST /api/jobs/{id}/apply -> JWT Middleware -> JobController -> job_applying table -> CandidateMessage -> Response

**SD3: Nha tuyen dung dang tin + xu ly ho so**
Actor -> React UI -> Axios -> POST /api/jobs -> JobController -> Job Model + job_industry + job_location + job_skill -> DB
Actor -> React UI -> GET /api/companies/getCandidateList -> EmployerController -> job_applying -> Response
Actor -> POST /api/companies/processApplying -> EmployerController -> Update status -> CandidateMessage -> Response

**SD4: Ung vien tao va quan ly CV/Resume**
Actor -> React UI -> Axios -> POST /api/resumes -> ResumeController -> Resume Model -> DB
Actor -> GET /api/educations/getByCurCandResumeId -> EducationController -> Education Model -> Response
(tuong tu cho experiences, skills, projects, certificates, prizes, activities, others)

## Chuong 3: Thiet ke he thong

### 3.1. Sua loi danh so hinh
- "Hinh 2.6" -> "Hinh 3.1" (so do kien truc tong the)
- Cap nhat lai so thu tu cac hinh tiep theo

### 3.2. Bo sung thuc the CSDL (muc 3.2.1)
Them ~14 thuc the con thieu voi thuoc tinh chi tiet (lay tu recruitment.sql):

- **Education**: candidate_id, school, major, start_date, end_date, description
- **Experience**: candidate_id, jtype_id, name, company, start_date, end_date, description
- **Skill**: candidate_id, name, description
- **Project**: candidate_id, name, start_date, end_date, description, image, link
- **Certificate**: candidate_id, name, image
- **Prize**: candidate_id, name, image
- **Activity**: candidate_id, organization, role, is_present, start_date, end_date, description, image, link
- **Other**: candidate_id, name, description
- **Industry**: id, name
- **Jlevel**: id, name
- **Jtype**: id, name
- **Location**: id, name
- **Resume**: id, candidate_id, name, avatar, position, email, dob, phone, gender, address, objective, ...
- **CandidateMessage**: id, candidate_id, job_id, content, isRead

### 3.3. Bo sung quan he N-N (muc 3.2.2)
Them cac quan he N-N voi bang trung gian:

- Job <-> Industry: bang job_industry (job_id, industry_id)
- Job <-> Location: bang job_location (job_id, location_id)
- Job <-> Skill: bang job_skill (job_id, jskill_id)
- Job <-> Tag: bang job_tag (job_id, jtag_id)
- Employer <-> Location: bang employer_location (employer_id, location_id)
- Candidate <-> Job (ung tuyen): bang job_applying (candidate_id, job_id, status, cv_image, created_at, updated_at)
- Candidate <-> Job (luu tin): bang saved_jobs (candidate_id, job_id)

### 3.4. Them Class Diagram (muc moi 3.x)
Mo ta cac Model class trong Laravel:
- User, Candidate, Employer, Job, Resume
- Education, Experience, Skill, Project, Certificate, Prize, Activity, Other
- Industry, Jlevel, Jtype, Location, Jskill, Jtag
- CandidateMessage

Voi relationships (hasOne, hasMany, belongsTo, belongsToMany)

### 3.5. Bo sung Data Dictionary (muc moi 3.x)
Bang mo ta chi tiet cau truc cac bang quan trong:
- users, candidates, employers, jobs, resumes, job_applying, saved_jobs
- Moi bang: ten cot, kieu du lieu, mo ta, rang buoc

## Ghi chu ky thuat
- Su dung python-docx de sua truc tiep file .docx
- Diagram duoc mo ta dang text/bang trong Word (nguoi dung tu ve hinh tu mo ta)
- Giu nguyen format, style cua bao cao goc
- Khong sua gi tu dau den het Chuong 1
