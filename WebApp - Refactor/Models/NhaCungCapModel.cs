using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("NhaCungCap", Schema = "dbo")]
    public class NhaCungCapModel
    {
        [Key]
        [Required]
        public int Id_NhaCungCap { get; set; }
        public string? TenNhaCungCap { get; set; }
        public string? DiaChi { get; set; }
        public string? SoDienThoai { get; set; }
        public string? Email { get; set; }
        [NotMapped]
        public string TenVaDiaChi => $"{TenNhaCungCap} - {DiaChi}";

    }
}
