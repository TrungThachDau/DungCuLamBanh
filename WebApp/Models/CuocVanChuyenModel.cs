using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebDungCuLamBanh.Models
{
    [Table("CuocVanChuyen", Schema = "dbo")]
    public class CuocVanChuyenModel
    {
        [Key]
        [Required]
        public int Id_CuocVanChuyen { get; set; }
        public string? KhuVuc { get; set; }
        public decimal? CuocVanChuyen { get; set; }
    }
}
