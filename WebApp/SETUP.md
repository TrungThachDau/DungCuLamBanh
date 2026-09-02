# Hướng dẫn khởi chạy dự án (WebDungCuLamBanh)

## Yêu cầu môi trường
- [.NET 10 SDK](https://dotnet.microsoft.com/download)
- SQL Server (local hoặc container) — 2019 trở lên
- (Tùy chọn) Docker + Docker Compose nếu muốn chạy bằng container

## 1. Clone & restore

```powershell
git clone <repo-url>
cd WebDungCuLamBanh/WebApp
dotnet restore
```

## 2. Cấu hình secrets (bắt buộc)

Dự án **không** lưu secret thật trong `appsettings.json`/`appsettings.Development.json`. Cần khai báo qua User Secrets (dev) hoặc biến môi trường (production/Docker).

### Chạy local bằng `dotnet run` — dùng User Secrets

```powershell
dotnet user-secrets init --project WebDungCuLamBanh.csproj
dotnet user-secrets set "Jwt:Key" "<chuỗi bí mật đủ mạnh>" --project WebDungCuLamBanh.csproj
dotnet user-secrets set "ConnectionStrings:DefaultConnection" "Server=localhost,1433;Database=qldungcu;User Id=sa;Password=<mật khẩu SQL>;MultipleActiveResultSets=true;Encrypt=false;TrustServerCertificate=true;" --project WebDungCuLamBanh.csproj
```

Các key cấu hình không nhạy cảm khác (`Jwt:Issuer`, `Jwt:Audience`, `Jwt:AccessTokenMinutes`) đã có sẵn trong [appsettings.json](appsettings.json).

### Chạy bằng Docker Compose

Tạo file `.env` (đã được `.gitignore` bỏ qua) tại thư mục gốc repo với nội dung:

```env
DB_CONNECTION_STRING=Server=sqlserver,1433;Database=qldungcu;User Id=sa;Password=<mật khẩu SQL>;MultipleActiveResultSets=true;Encrypt=false;TrustServerCertificate=true;
JWT_KEY=<chuỗi bí mật đủ mạnh>
SA_PASSWORD=<mật khẩu SQL, phải trùng với mật khẩu trong DB_CONNECTION_STRING>
```

Sau đó chạy:

```powershell
docker compose up --build
```

Ứng dụng sẽ chạy tại `http://localhost:8080`.

## 3. Khởi tạo database

Nếu chưa có database, áp dụng migration EF Core (nếu có) hoặc chạy script SQL có sẵn ở thư mục gốc repo (`script-DESKTOP-UBOAUDU.sql`):

```powershell
dotnet ef database update --project WebDungCuLamBanh.csproj
```

## 4. Chạy ứng dụng (local, không dùng Docker)

```powershell
dotnet run --project WebDungCuLamBanh.csproj
```

Mặc định:
- Web app (MVC): `https://localhost:<port>` (xem [Properties/launchSettings.json](Properties/launchSettings.json))
- Swagger UI (chỉ bật ở môi trường Development): `https://localhost:<port>/swagger`

## Ghi chú bảo mật
- Không commit file `.env` hoặc bất kỳ giá trị secret thật nào vào git.
- Đổi `Jwt:Key` và mật khẩu SQL Server trước khi deploy production — không dùng giá trị mẫu trong tài liệu này.
