using System.ComponentModel.DataAnnotations;

namespace WebDungCuLamBanh.DTOs.Supplier;

public class SupplierDto
{
    public int Id_NhaCungCap { get; set; }
    public string TenNhaCungCap { get; set; } = string.Empty;
    public string? DiaChi { get; set; }
    public string? SoDienThoai { get; set; }
    public string? Email { get; set; }
}

public class CreateSupplierDto
{
    [Required(ErrorMessage = "Tên nhà cung cấp không được để trống")]
    public string TenNhaCungCap { get; set; } = string.Empty;

    public string? DiaChi { get; set; }
    public string? SoDienThoai { get; set; }
    public string? Email { get; set; }
}

public class UpdateSupplierDto
{
    public int Id_NhaCungCap { get; set; }

    [Required(ErrorMessage = "Tên nhà cung cấp không được để trống")]
    public string TenNhaCungCap { get; set; } = string.Empty;

    public string? DiaChi { get; set; }
    public string? SoDienThoai { get; set; }
    public string? Email { get; set; }
}
