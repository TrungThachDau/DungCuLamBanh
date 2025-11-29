using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("SanPhamYeuThich", Schema = "dbo")]
    public class YeuThichModel
    {
        [Key]
        [Required]
        public int Id_SPYT { get; set; }
        public string? Id_KhachHang { get; set; }
        public int? Id_SanPham { get; set; }
        [ForeignKey("Id_SanPham")]
        public DungCuModel? SanPham { get; set; }
        [ForeignKey("Id_KhachHang")]
        public KhachHangModel? KhachHang { get; set; }
    }
}
