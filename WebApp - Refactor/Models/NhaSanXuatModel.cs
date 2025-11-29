using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebDungCuLamBanh.Models
{
    [Table("NhaSanXuat", Schema = "dbo")]
    public class NhaSanXuatModel
    {
        [Key]
        [Required]
        public int Id_NhaSanXuat { get; set; }
        public string? TenNSX { get; set; }
        public string? DiaChi { get; set; }
        public string? Email { get; set; }
    }
}
