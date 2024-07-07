using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("HoaDonNhapHang", Schema = "dbo")]
    public class HoaDonNhapHangModel
    {
        [Key]
        [Required]
        public string Id_HoaDonNhap { get; set; }
        public int? Id_NhaCungCap { get; set; }
        public DateTime? NgayLapHoaDon { get; set; }
        public DateTime? NgayNhapHang { get; set; }
        public decimal? TongTien { get; set; }
        public int TrangThai { get; set; }
        public string? NhanVienLap { get;set;}

        [ForeignKey("Id_NhaCungCap")]
        public NhaCungCapModel? NhaCungCap { get; set; }
    }
}
