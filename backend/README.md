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

Có thể khởi tạo database bằng **một trong hai cách** dưới đây.

### Cách 1: Import file SQL (khuyên dùng khi demo)

File `recruitment_demo_full.sql` đã bao gồm cấu trúc bảng và toàn bộ dữ liệu
demo: công ty, việc làm, ứng viên, CV, đơn ứng tuyển và tài khoản kiểm thử.

Với XAMPP trên Windows:

```powershell
C:\xampp\mysql\bin\mysql.exe -u root < recruitment_demo_full.sql
```

Hoặc khi lệnh `mysql` đã có trong `PATH`:

```bash
mysql -u root < recruitment_demo_full.sql
```

File SQL tự tạo database `recruitment` và có lệnh thay thế các bảng hiện tại.
Không import vào database đang chứa dữ liệu cần giữ lại.

### Cách 2: Laravel migration và seeder

Tạo database `recruitment`, sau đó chạy:

```bash
php artisan migrate
php artisan db:seed
```

Để chỉ bổ sung dữ liệu phục vụ trình bày:

```bash
php artisan db:seed --class=PresentationDemoSeeder
```

Để xóa dữ liệu ứng dụng và seed lại toàn bộ từ đầu:

```bash
php artisan db:seed --class=ResetDatabaseSeeder
```

Chỉ cần chọn import SQL hoặc chạy migration/seeder. Không cần thực hiện cả hai
cách trên cùng một database.

## Tài khoản kiểm thử

### Ứng viên

```text
Email: taianh.bui@example.com
Mật khẩu: TaiAnh@17112003
Vai trò đăng nhập: Ứng viên
```

Tài khoản có hồ sơ Bùi Đức Tài Anh, ngày sinh `17/11/2003`, hai CV, danh
sách việc đã lưu và các đơn ứng tuyển ở nhiều trạng thái.

### Nhà tuyển dụng

```text
Email: novatech@company.demo
Mật khẩu: Company@123
Vai trò đăng nhập: Nhà tuyển dụng
```

### Quản trị viên

```text
Email: admin.demo@example.com
Mật khẩu: password
Vai trò đăng nhập: Quản trị viên
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
