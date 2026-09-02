using System.ComponentModel.DataAnnotations;

namespace WebDungCuLamBanh.DTOs.Product;

public class ProductDto
{
    public int Id_DungCu { get; set; }
    public string TenDungCu { get; set; } = string.Empty;
    public string? HinhAnh { get; set; }
    public decimal? Gia { get; set; }
    public decimal? GiaKhuyenMai { get; set; }
    public decimal? GiaNhap { get; set; }
    public int? SoLuong { get; set; }
    public string? MoTa { get; set; }
    public int? Id_LoaiDungCu { get; set; }
    public string? TenLoaiDungCu { get; set; }
    public int? Id_NhaCungCap { get; set; }
    public string? TenNhaCungCap { get; set; }
    public int? Id_NhaSanXuat { get; set; }
    public string? TenNhaSanXuat { get; set; }
    public int? DaXoa { get; set; }
}

public class CreateProductDto
{
    [Required(ErrorMessage = "Tên dụng cụ không được để trống")]
    public string TenDungCu { get; set; } = string.Empty;

    public decimal? Gia { get; set; }
    public decimal? GiaKhuyenMai { get; set; }
    public decimal? GiaNhap { get; set; }
    public int? SoLuong { get; set; }
    public string? MoTa { get; set; }
    public int? Id_LoaiDungCu { get; set; }
    public int? Id_NhaCungCap { get; set; }
    public int? Id_NhaSanXuat { get; set; }
}

public class UpdateProductDto
{
    public int Id_DungCu { get; set; }

    [Required(ErrorMessage = "Tên dụng cụ không được để trống")]
    public string TenDungCu { get; set; } = string.Empty;

    public string? HinhAnh { get; set; }
    public decimal? Gia { get; set; }
    public decimal? GiaKhuyenMai { get; set; }
    public decimal? GiaNhap { get; set; }
    public int? SoLuong { get; set; }
    public string? MoTa { get; set; }
    public int? Id_LoaiDungCu { get; set; }
    public int? Id_NhaCungCap { get; set; }
    public int? Id_NhaSanXuat { get; set; }
}

public class CategoryDto
{
    public int Id_LoaiDungCu { get; set; }
    public string TenLoaiDungCu { get; set; } = string.Empty;
}

public class SaleOffDto
{
    public int Id_KhuyenMai { get; set; }
    public string? TenKhuyenMai { get; set; }
    public int? PhanTramKM { get; set; }
    public DateTime? NgayBatDau { get; set; }
    public DateTime? NgayKetThuc { get; set; }
    public int? TrangThai { get; set; }
}

public class SaleOffDetailDto
{
    public int Id_CTKM { get; set; }
    public int? Id_KhuyenMai { get; set; }
    public int? Id_SanPham { get; set; }
    public string? TenSanPham { get; set; }
    public decimal? Gia { get; set; }
    public decimal? GiaKhuyenMai { get; set; }
}
