using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("DonHangVanChuyen", Schema = "dbo")]
    public class DonHangVanChuyenModel
    {
        [Key]
        [Required]
        public int Id_DHVC { get; set; }
        public string? Id_DonHang { get; set; }
        [Column("PhuongThucThanhToan")]
        public int? ID_PhuongThucThanhToan { get; set; }
        public decimal? PhiVanChuyen { get; set; }
        public string? DiaChiVanChuyen { get; set; }
        [ForeignKey("Id_DonHang")]
        public DonHangModel? DonHang { get; set; }
        [ForeignKey("ID_PhuongThucThanhToan")]
        public PTTTModel? PhuongThucThanhToan { get; set; }
        public string? TenKhachHang { get; set; }
        public string? SoDienThoai { get; set; }
        public string? Email { get; set; }
        public int? TinhTrang { get; set; }
        [ForeignKey("TinhTrang")]
        public TrangThaiVanChuyenModel? TrangThaiVanChuyen { get; set; }

    }
}
