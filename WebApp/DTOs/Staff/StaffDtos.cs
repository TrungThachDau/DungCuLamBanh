using System.ComponentModel.DataAnnotations;

namespace WebDungCuLamBanh.DTOs.Staff;

public class StaffDto
{
    public string TenNguoiDung { get; set; } = string.Empty;
    public int? Quyen { get; set; }
    public string? Ten { get; set; }
    public string? Email { get; set; }
    public string? DiaChi { get; set; }
    public string? SoDienThoai { get; set; }
}

public class CreateStaffDto
{
    [Required(ErrorMessage = "Tên người dùng là bắt buộc")]
    public string TenNguoiDung { get; set; } = string.Empty;

    [Required(ErrorMessage = "Mật khẩu là bắt buộc")]
    public string MatKhau { get; set; } = string.Empty;

    public int? Quyen { get; set; } = 0;
    public string? Ten { get; set; }
    public string? Email { get; set; }
    public string? DiaChi { get; set; }
    public string? SoDienThoai { get; set; }
}

public class UpdateStaffDto
{
    [Required(ErrorMessage = "Tên người dùng là bắt buộc")]
    public string TenNguoiDung { get; set; } = string.Empty;

    public string? MatKhau { get; set; }
    public int? Quyen { get; set; }
    public string? Ten { get; set; }
    public string? Email { get; set; }
    public string? DiaChi { get; set; }
    public string? SoDienThoai { get; set; }
}
