using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("Admin", Schema = "dbo")]
    public class AdminModel
    {
        [Key]
        [Required]
        public string? TenNguoiDung { get; set; }
        [Required]
        public string? MatKhau { get; set; }
        public int Quyen { get; set; }
        public string? Ten { get; set; }
        public string? Email { get; set; }
        public string? DiaChi { get; set; }
        [Column("SDT")]
        public string? SoDienThoai { get; set; }

    }
}
