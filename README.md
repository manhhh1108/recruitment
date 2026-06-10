# Recruitment

Ứng dụng tuyển dụng gồm backend Laravel và frontend React.

## Cấu trúc

- `backend`: Laravel API, JWT auth, quản lý candidate/employer/admin.
- `frontend`: React app cho ứng viên, nhà tuyển dụng và admin.
- `recruitment.sql`: dữ liệu/database dump mẫu.

## Chạy backend

```bash
cd backend
composer install
copy .env.example .env
php artisan key:generate
php artisan jwt:secret
php artisan migrate
php artisan db:seed
php artisan storage:link
php artisan serve
```

Backend chạy tại `http://localhost:8000`.

## Chạy frontend

```bash
cd frontend
npm install
copy .env.example .env.local
npm start
```

Cập nhật `frontend/.env.local`:

```env
REACT_APP_API_URL=http://localhost:8000
REACT_APP_EMAILJS_SERVICE_ID=
REACT_APP_EMAILJS_TEMPLATE_ID=
REACT_APP_EMAILJS_PUBLIC_KEY=
```

Frontend chạy tại `http://localhost:3000`.

## Kiểm tra

```bash
cd backend
php artisan test

cd ../frontend
npm run build
```

## Import Mock Data

Sau khi chạy migration, có thể import dữ liệu mẫu đẹp cho MySQL:

```bash
mysql -u root recruitment < mock_recruitment_data.sql
```

Tài khoản trong file mock:

- Candidate: `candidate.demo@example.com` / `password`
- Employer: `employer.demo@example.com` / `password`
- Admin: `admin.demo@example.com` / `password`
