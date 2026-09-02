namespace WebDungCuLamBanh.DTOs.Banner;

public class BannerDto
{
    public int Id_Banner { get; set; }
    public string? TenBanner { get; set; }
    public string? DuongDan { get; set; }
    public string? LienKet { get; set; }
}

public class CreateBannerDto
{
    public string? TenBanner { get; set; }
    public string? DuongDan { get; set; }
    public string? LienKet { get; set; }
}

public class UpdateBannerDto
{
    public int Id_Banner { get; set; }
    public string? TenBanner { get; set; }
    public string? DuongDan { get; set; }
    public string? LienKet { get; set; }
}
