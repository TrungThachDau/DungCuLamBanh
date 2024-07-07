using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("ChiTietDonHang", Schema = "dbo")]
    public class ChiTietDonHangModel
    {
        [Key]
        [Required]
        public int? Id_ChiTietDonHang { get; set; }
        public string? Id_DonHang { get; set; }
        public int? Id_DungCu { get; set; }
        [Range(1, 10, ErrorMessage = "Không thể mua quá nhiều.")]
        public int? SoLuong { get; set; }
        [DisplayFormat(DataFormatString = "{0:0.##}")]
        [Column(name: "Gia", TypeName = "decimal(18,0)")]
        public decimal? DonGia { get; set; }
        [ForeignKey("Id_DonHang")]
        public DonHangModel? DonHang { get; set; }
        [ForeignKey("Id_DungCu")]
        public DungCuModel? DungCu { get; set; }

    }

}
