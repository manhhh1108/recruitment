# Recruitment Backend

Laravel API cho hệ thống tuyển dụng.

## Yêu cầu

- PHP 8.1+
- Composer
- MySQL/MariaDB

## Cài đặt

```bash
composer install
copy .env.example .env
php artisan key:generate
php artisan jwt:secret
```

Cập nhật `.env`:

```env
APP_URL=http://localhost:8000
FRONTEND_URL=http://localhost:3000
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=recruitment
DB_USERNAME=root
DB_PASSWORD=
```

## Database

Tạo database `recruitment`, sau đó chạy:

```bash
php artisan migrate
php artisan db:seed
```

Để xóa dữ liệu trong các bảng của ứng dụng và seed lại từ đầu:

```bash
php artisan db:seed --class=ResetDatabaseSeeder
```

Nếu cần dữ liệu mẫu đầy đủ từ file SQL có sẵn ở root project:

```bash
mysql -u root recruitment < ..\recruitment.sql
```

## Chạy server

```bash
php artisan storage:link
php artisan serve
```

API mặc định chạy tại `http://localhost:8000/api`.

## Test

```bash
php artisan test
```

Test hiện dùng cấu hình database trong `.env`. Nên chạy trên database test riêng nếu không muốn ảnh hưởng dữ liệu local.
