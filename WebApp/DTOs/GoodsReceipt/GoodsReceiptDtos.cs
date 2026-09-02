using System.ComponentModel.DataAnnotations;

namespace WebDungCuLamBanh.DTOs.GoodsReceipt;

public class GoodsReceiptDto
{
    public string Id_HoaDonNhap { get; set; } = string.Empty;
    public int? Id_NhaCungCap { get; set; }
    public string? TenNhaCungCap { get; set; }
    public DateTime? NgayLapHoaDon { get; set; }
    public DateTime? NgayNhapHang { get; set; }
    public string? NhanVienLap { get; set; }
    public decimal? TongTien { get; set; }
    public int TrangThai { get; set; }
    public List<GoodsReceiptDetailDto> Details { get; set; } = [];
}

public class GoodsReceiptDetailDto
{
    public int Id_CTHDNhapHang { get; set; }
    public string? Id_HoaDonNhap { get; set; }
    public int? Id_SanPham { get; set; }
    public string? TenSanPham { get; set; }
    public int? SoLuong { get; set; }
    public decimal? DonGia { get; set; }
    public decimal? GiaTien { get; set; }
}

public class CreateGoodsReceiptDto
{
    [Required(ErrorMessage = "Mã hóa đơn nhập là bắt buộc")]
    public string Id_HoaDonNhap { get; set; } = string.Empty;

    [Required(ErrorMessage = "Nhà cung cấp là bắt buộc")]
    public int? Id_NhaCungCap { get; set; }
}

public class AddReceiptItemDto
{
    [Required]
    public string MaHD { get; set; } = string.Empty;

    [Required]
    public int Id_SanPham { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "Số lượng phải lớn hơn 0")]
    public int SoLuong { get; set; }

    [Range(0, double.MaxValue, ErrorMessage = "Đơn giá không hợp lệ")]
    public decimal DonGia { get; set; }
}
