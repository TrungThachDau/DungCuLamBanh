# Admin API Controllers

Các REST API controllers cho quản trị hệ thống. Tất cả endpoints đều trả về JSON.

## Base URL
```
https://localhost:{port}/api
```

## Authentication (JWT)
- **POST** `/api/Administrator/Login` để nhận JWT token cho admin (quyen = 1).
- Đính kèm token cho mọi request khác qua header: `Authorization: Bearer {token}`.

## Controllers

### 1. ManufactorController
Quản lý nhà sản xuất

- **GET** `/api/Manufactor` - Lấy danh sách tất cả nhà sản xuất
- **GET** `/api/Manufactor/{id}` - Lấy thông tin nhà sản xuất theo ID
- **POST** `/api/Manufactor` - Tạo nhà sản xuất mới
- **PUT** `/api/Manufactor/{id}` - Cập nhật nhà sản xuất
- **DELETE** `/api/Manufactor/{id}` - Xóa nhà sản xuất

**Ví dụ:**
```bash
# Lấy tất cả nhà sản xuất
curl -X GET https://localhost:7234/api/Manufactor

# Tạo nhà sản xuất mới
curl -X POST https://localhost:7234/api/Manufactor \
  -H "Content-Type: application/json" \
  -d '{"TenNSX":"ABC","DiaChi":"123 Street","Email":"abc@example.com"}'
```

### 2. SupplierController
Quản lý nhà cung cấp

- **GET** `/api/Supplier` - Lấy danh sách nhà cung cấp
- **GET** `/api/Supplier/{id}` - Lấy thông tin nhà cung cấp theo ID
- **POST** `/api/Supplier` - Tạo nhà cung cấp mới
- **PUT** `/api/Supplier/{id}` - Cập nhật nhà cung cấp
- **DELETE** `/api/Supplier/{id}` - Xóa nhà cung cấp

**Ví dụ:**
```bash
# Lấy tất cả nhà cung cấp
curl -X GET https://localhost:7234/api/Supplier

# Cập nhật nhà cung cấp
curl -X PUT https://localhost:7234/api/Supplier/1 \
  -H "Content-Type: application/json" \
  -d '{"Id_NhaCungCap":1,"TenNhaCungCap":"XYZ","DiaChi":"456 Street","SoDienThoai":"0123456789","Email":"xyz@example.com"}'
```

### 3. StaffController
Quản lý nhân viên/admin

- **GET** `/api/Staff` - Lấy danh sách nhân viên
- **GET** `/api/Staff/{id}` - Lấy thông tin nhân viên theo username
- **POST** `/api/Staff` - Tạo nhân viên mới
- **PUT** `/api/Staff/{id}` - Cập nhật thông tin nhân viên
- **DELETE** `/api/Staff/{id}` - Xóa nhân viên

**Ví dụ:**
```bash
# Lấy thông tin nhân viên
curl -X GET https://localhost:7234/api/Staff/admin01

# Tạo nhân viên mới
curl -X POST https://localhost:7234/api/Staff \
  -H "Content-Type: application/json" \
  -d '{"TenNguoiDung":"staff01","MatKhau":"123456","Quyen":1,"Ten":"Nguyen Van A","Email":"staff@example.com","DiaChi":"789 Street","SoDienThoai":"0987654321"}'
```

### 4. GoodsReceiptController
Quản lý hóa đơn nhập hàng

- **GET** `/api/GoodsReceipt?search={keyword}` - Lấy danh sách hóa đơn nhập (có thể tìm kiếm)
- **GET** `/api/GoodsReceipt/{id}` - Lấy thông tin hóa đơn nhập theo ID
- **GET** `/api/GoodsReceipt/{id}/Details` - Lấy chi tiết hóa đơn nhập (bao gồm sản phẩm)
- **POST** `/api/GoodsReceipt` - Tạo hóa đơn nhập mới
- **POST** `/api/GoodsReceipt/AddProduct` - Thêm sản phẩm vào hóa đơn nhập
- **POST** `/api/GoodsReceipt/Import` - Nhập hàng (cập nhật kho)
- **DELETE** `/api/GoodsReceipt/{maHD}/Product/{id}` - Xóa sản phẩm khỏi hóa đơn nhập
- **GET** `/api/GoodsReceipt/CheckTabs` - Lấy danh sách check tabs
- **POST** `/api/GoodsReceipt/CheckTabs` - Tạo check tab mới

**Ví dụ:**
```bash
# Tạo hóa đơn nhập mới
curl -X POST https://localhost:7234/api/GoodsReceipt \
  -H "Content-Type: application/json" \
  -d '{"Id_HoaDonNhap":"HDN001","Id_NhaCungCap":1}'

# Thêm sản phẩm vào hóa đơn
curl -X POST https://localhost:7234/api/GoodsReceipt/AddProduct \
  -H "Content-Type: application/json" \
  -d '{"MaHD":"HDN001","Id_SanPham":5,"SoLuong":10,"DonGia":50000}'

# Nhập hàng vào kho
curl -X POST "https://localhost:7234/api/GoodsReceipt/Import?maHD=HDN001&nhanVienLap=admin01"
```

### 5. AdministratorController
Quản lý tổng hợp hệ thống

#### Authentication
- **POST** `/api/Administrator/Login` - Đăng nhập admin

```bash
curl -X POST https://localhost:7234/api/Administrator/Login \
  -H "Content-Type: application/json" \
  -d '{"TenNguoiDung":"admin","MatKhau":"123456"}'
```

#### Dashboard
- **GET** `/api/Administrator/Dashboard?fromDate={date}&toDate={date}` - Lấy dữ liệu dashboard
- **GET** `/api/Administrator/EarningThisMonth` - Lấy doanh thu tháng này

#### Products
- **GET** `/api/Administrator/Product?search={keyword}` - Lấy danh sách sản phẩm
- **POST** `/api/Administrator/Product` - Tạo sản phẩm mới (FormData)
- **PUT** `/api/Administrator/Product/{id}` - Cập nhật sản phẩm (FormData)
- **DELETE** `/api/Administrator/Product/{id}` - Xóa sản phẩm (soft delete)
- **GET** `/api/Administrator/ProductFormOptions` - Lấy options cho form sản phẩm

```bash
# Tạo sản phẩm với hình ảnh
curl -X POST https://localhost:7234/api/Administrator/Product \
  -F "Id_LoaiDungCu=1" \
  -F "TenDungCu=Khuon banh" \
  -F "GiaBan=100000" \
  -F "SoLuong=50" \
  -F "imageInput=@/path/to/image.jpg"
```

#### Categories
- **GET** `/api/Administrator/Category` - Lấy danh sách danh mục
- **POST** `/api/Administrator/Category` - Tạo danh mục mới
- **DELETE** `/api/Administrator/Category/{id}` - Xóa danh mục

#### Sale Off (Khuyến mãi)
- **GET** `/api/Administrator/SaleOff` - Lấy danh sách khuyến mãi
- **POST** `/api/Administrator/SaleOff` - Tạo khuyến mãi mới
- **DELETE** `/api/Administrator/SaleOff/{id}` - Xóa khuyến mãi
- **GET** `/api/Administrator/SaleOff/{id}/Products` - Lấy danh sách sản phẩm trong khuyến mãi
- **POST** `/api/Administrator/SaleOff/AddProduct` - Thêm sản phẩm vào khuyến mãi
- **DELETE** `/api/Administrator/SaleOff/{idKhuyenMai}/Product/{idCTKM}` - Xóa sản phẩm khỏi khuyến mãi
- **POST** `/api/Administrator/SaleOff/Apply` - Áp dụng khuyến mãi

#### Vouchers
- **GET** `/api/Administrator/Voucher` - Lấy danh sách voucher
- **POST** `/api/Administrator/Voucher` - Tạo voucher mới
- **DELETE** `/api/Administrator/Voucher/{id}` - Xóa voucher

#### Orders
- **GET** `/api/Administrator/Orders` - Lấy tất cả đơn hàng
- **GET** `/api/Administrator/Orders/NotDelivered` - Lấy đơn hàng chưa giao
- **GET** `/api/Administrator/Orders/Delivered` - Lấy đơn hàng đã giao
- **GET** `/api/Administrator/Orders/{id}` - Lấy chi tiết đơn hàng
- **POST** `/api/Administrator/ChangeStatus` - Thay đổi trạng thái vận chuyển

```bash
# Thay đổi trạng thái đơn hàng
curl -X POST https://localhost:7234/api/Administrator/ChangeStatus \
  -H "Content-Type: application/json" \
  -d '{"Dhvc":123,"Value":2}'
```

#### Banners
- **GET** `/api/Administrator/Banner` - Lấy danh sách banner
- **POST** `/api/Administrator/Banner` - Tạo banner mới (FormData)
- **PUT** `/api/Administrator/Banner/{id}` - Cập nhật banner (FormData)
- **DELETE** `/api/Administrator/Banner/{id}` - Xóa banner

## Response Format

### Success Response
```json
{
  "success": true,
  "message": "Thao tác thành công",
  "data": { ... }
}
```

### Error Response
```json
{
  "success": false,
  "message": "Mô tả lỗi",
  "error": "Chi tiết lỗi"
}
```

## Testing với cURL

### Windows PowerShell
```powershell
# GET request
Invoke-RestMethod -Uri "https://localhost:7234/api/Manufactor" -Method Get

# POST request
$body = @{
    TenNSX = "Test"
    DiaChi = "Address"
    Email = "test@example.com"
} | ConvertTo-Json

Invoke-RestMethod -Uri "https://localhost:7234/api/Manufactor" -Method Post -Body $body -ContentType "application/json"
```

## Notes
- Tất cả controllers đều kế thừa từ `ControllerBase` (không phải `Controller`)
- Sử dụng `[ApiController]` attribute cho automatic model validation
- Route pattern: `/api/[controller]`
- Hỗ trợ cả JSON và FormData (cho upload file)
- Bảo vệ bởi JWT Bearer token, lấy token qua `/api/Administrator/Login` và gửi trong header `Authorization: Bearer {token}`
