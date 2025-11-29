using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("DonHang", Schema = "dbo")]
    public class DonHangModel
    {
        [Key]
        [Required]
        public string? Id_DonHang { get; set; }
        public string? Id_KhachHang { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm}", ApplyFormatInEditMode = true)]
        public DateTime? NgayDat { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm}", ApplyFormatInEditMode = true)]
        public DateTime? NgayGiao { get; set; }
        public decimal? TienGiamGia { get; set; }
        public decimal? VAT { get; set; }
        public decimal? TienDiemThuong { get;set;}
        public decimal? TongTien { get; set; }
        public string? TrangThai { get; set; }
        [Column("PhuongThucThanhToan")]
        public int? Id_PhuongThucThanhToan { get; set; }

        public decimal? PhiVanChuyen { get; set; }
        public string? Id_MaGiamGia { get; set; }
        [ForeignKey("Id_KhachHang")]
        public KhachHangModel? KhachHang { get; set; }
        [ForeignKey("Id_PhuongThucThanhToan")]
        public PTTTModel? PhuongThucThanhToan { get; set; }
        [ForeignKey("Id_MaGiamGia")]
        public MaGiamGiaModel? GiamGia { get; set; }


    }
}
