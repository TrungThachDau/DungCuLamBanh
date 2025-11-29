using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("ChiTietKhuyenMai", Schema = "dbo")]
    public class ChiTietKhuyenMaiModel
    {
        [Key]
        [Required]
        public int Id_CTKM { get;set;}
        public int Id_KhuyenMai { get; set; }
        public int Id_SanPham { get; set; }
        public int GiaTriGiam { get; set; }
        [ForeignKey("Id_KhuyenMai")]
        public KhuyenMaiModel KhuyenMai { get; set; }
        [ForeignKey("Id_SanPham")]
        public DungCuModel SanPham { get; set; }
    }
}
