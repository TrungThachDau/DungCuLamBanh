using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("CTHDNhapHang", Schema = "dbo")]
    public class CTHDNhapHangModel
    {
        [Key]
        [Required]
        public int Id_CTHDNhapHang { get; set; }
        public string? Id_HoaDonNhap { get; set; }
        public int? Id_SanPham { get; set; }
        public int? SoLuong { get; set; }
        public decimal? DonGia { get; set; }
        public decimal? GiaTien { get; set; }
        [ForeignKey("Id_HoaDonNhap")]
        public HoaDonNhapHangModel? HoaDonNhapHang { get; set; }
        [ForeignKey("Id_SanPham")]
        public DungCuModel? SanPham { get; set; }



    }
}
