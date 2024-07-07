using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("LoaiSanPham", Schema = "dbo")]
    public class LoaiDungCuModel
    {
        [Key]
        [Required]
        [Column("Id_LoaiDungCu")]
        public int Id_LoaiDungCu { get; set; }
        [Column("TenLoaiDungCu")]
        public string? TenLoaiDungCu { get; set; }
    }
}
