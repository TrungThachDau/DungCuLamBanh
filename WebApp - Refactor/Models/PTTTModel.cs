using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("PhuongThucThanhToan", Schema = "dbo")]
    public class PTTTModel
    {
        [Key]
        [Required]
        public int Id_PTTT { get; set; }
        public string? TenPTTT { get; set; }
        public int? TinhTrang { get; set; }
    }
}
