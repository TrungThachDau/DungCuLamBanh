using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("MaGiamGia", Schema = "dbo")]
    public class MaGiamGiaModel
    {
        [Key]
        [Required]
        public string Id_MaGiamGia { get; set; }
        public string? TenMaGiamGia { get; set; }
        public decimal GiaTriGiam { get; set; }
        public int LuotSuDung { get; set; }
    }
}
