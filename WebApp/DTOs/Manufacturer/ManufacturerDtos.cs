using System.ComponentModel.DataAnnotations;

namespace WebDungCuLamBanh.DTOs.Manufacturer;

public class ManufacturerDto
{
    public int Id_NhaSanXuat { get; set; }
    public string TenNSX { get; set; } = string.Empty;
    public string? DiaChi { get; set; }
    public string? Email { get; set; }
}

public class CreateManufacturerDto
{
    [Required(ErrorMessage = "Tên nhà sản xuất không được để trống")]
    public string TenNSX { get; set; } = string.Empty;

    public string? DiaChi { get; set; }
    public string? Email { get; set; }
}

public class UpdateManufacturerDto
{
    public int Id_NhaSanXuat { get; set; }

    [Required(ErrorMessage = "Tên nhà sản xuất không được để trống")]
    public string TenNSX { get; set; } = string.Empty;

    public string? DiaChi { get; set; }
    public string? Email { get; set; }
}
