using System.ComponentModel.DataAnnotations;

namespace WebDungCuLamBanh.DTOs.Voucher;

public class VoucherDto
{
    public string Id_MaGiamGia { get; set; } = string.Empty;
    public string? TenMaGiamGia { get; set; }
    public decimal GiaTriGiam { get; set; }
    public int LuotSuDung { get; set; }
}

public class CreateVoucherDto
{
    [Required(ErrorMessage = "Mã giảm giá không được để trống")]
    public string Id_MaGiamGia { get; set; } = string.Empty;

    public string? TenMaGiamGia { get; set; }
    public decimal GiaTriGiam { get; set; }
    public int LuotSuDung { get; set; }
}
