using System.ComponentModel.DataAnnotations;

namespace WebDungCuLamBanh.DTOs.Cart;

public class CartItemDto
{
    public int? Id_ChiTietDonHang { get; set; }
    public string? Id_DonHang { get; set; }
    public int? Id_DungCu { get; set; }
    public string? TenDungCu { get; set; }
    public string? HinhAnh { get; set; }
    public int? SoLuong { get; set; }
    public decimal? DonGia { get; set; }
}

public class CartSummaryDto
{
    public string? Id_DonHang { get; set; }
    public string? Id_KhachHang { get; set; }
    public List<CartItemDto> Items { get; set; } = [];
    public decimal? TamTinh { get; set; }
    public decimal? TienGiam { get; set; }
    public decimal? PhiVanChuyen { get; set; }
    public decimal? TongTien { get; set; }
    public string? MaGiamGia { get; set; }
}

public class AddToCartRequestDto
{
    [Required]
    public int Id_DungCu { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "Số lượng phải lớn hơn 0")]
    public int SoLuong { get; set; } = 1;
}

public class UpdateCartItemQuantityDto
{
    [Required]
    public int Id_ChiTietDonHang { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "Số lượng phải lớn hơn 0")]
    public int SoLuong { get; set; }
}

public class CheckoutRequestDto
{
    [Required(ErrorMessage = "Tên người nhận là bắt buộc")]
    public string TenNguoiNhan { get; set; } = string.Empty;

    [Required(ErrorMessage = "Số điện thoại là bắt buộc")]
    public string SoDienThoai { get; set; } = string.Empty;

    [Required(ErrorMessage = "Địa chỉ nhận hàng là bắt buộc")]
    public string DiaChiNhanHang { get; set; } = string.Empty;

    public string? GhiChu { get; set; }
    public int Id_PTTT { get; set; }
    public string? MaGiamGia { get; set; }
    public string? KhuVuc { get; set; }
}

public class ShippingFeeResultDto
{
    public string KhuVuc { get; set; } = string.Empty;
    public decimal CuocVanChuyen { get; set; }
}
