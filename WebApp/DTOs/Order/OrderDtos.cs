namespace WebDungCuLamBanh.DTOs.Order;

public class OrderDto
{
    public string Id_DonHang { get; set; } = string.Empty;
    public string? Id_KhachHang { get; set; }
    public string? TenKhachHang { get; set; }
    public string? EmailKhachHang { get; set; }
    public string? SoDienThoai { get; set; }
    public string? DiaChiNhanHang { get; set; }
    public DateTime? NgayDat { get; set; }
    public decimal? TongTien { get; set; }
    public decimal? TienGiamGia { get; set; }
    public decimal? PhiVanChuyen { get; set; }
    public string? TrangThai { get; set; }
    public int? Id_TrangThaiVanChuyen { get; set; }
    public string? TenTrangThaiVanChuyen { get; set; }
    public int? Id_PhuongThucThanhToan { get; set; }
    public string? TenPTTT { get; set; }
    public List<OrderDetailDto> Details { get; set; } = [];
}

public class OrderDetailDto
{
    public int? Id_ChiTietDonHang { get; set; }
    public string? Id_DonHang { get; set; }
    public int? Id_DungCu { get; set; }
    public string? TenDungCu { get; set; }
    public string? HinhAnh { get; set; }
    public int? SoLuong { get; set; }
    public decimal? DonGia { get; set; }
}

public class ChangeOrderStatusDto
{
    public int Dhvc { get; set; }
    public int Value { get; set; }
}
