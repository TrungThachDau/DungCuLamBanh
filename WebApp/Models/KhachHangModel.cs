using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebDungCuLamBanh.Models
{
    [Table("KhachHang", Schema = "dbo")]
    public class KhachHangModel
    {
        [Key]
        [Required]
        [Column("Id_KhachHang")]
        public string? Id_KhachHang { get; set; }
        [Column("TenKhachHang")]
        public string? TenKhachHang { get; set; }
        [Column("Email")]
        public string? Email { get; set; }
        [Column("SoDienThoai")]
        public string? SoDienThoai { get; set; }

        [Column("DiaChi")]
        public string? DiaChi { get; set; }
        [Column("DiemThuong")]
        public decimal? DiemThuong { get; set; }

    }
}
