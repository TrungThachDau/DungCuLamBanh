using System.ComponentModel.DataAnnotations;

namespace WebDungCuLamBanh.DTOs.Customer;

public class CustomerDto
{
    public string Id_KhachHang { get; set; } = string.Empty;
    public string? TenKhachHang { get; set; }
    public string? Email { get; set; }
    public string? DiaChi { get; set; }
    public string? SoDienThoai { get; set; }
    public decimal? DiemThuong { get; set; }
}

public class UpdateCustomerDto
{
    [Required(ErrorMessage = "Mã khách hàng là bắt buộc")]
    public string Id_KhachHang { get; set; } = string.Empty;

    public string? TenKhachHang { get; set; }
    public string? Email { get; set; }
    public string? DiaChi { get; set; }
    public string? SoDienThoai { get; set; }
}

public class CreateCustomerDto
{
    [Required(ErrorMessage = "Mã khách hàng là bắt buộc")]
    public string Id_KhachHang { get; set; } = string.Empty;

    public string? TenKhachHang { get; set; }
    public string? Email { get; set; }
    public string? DiaChi { get; set; }
    public string? SoDienThoai { get; set; }
}
