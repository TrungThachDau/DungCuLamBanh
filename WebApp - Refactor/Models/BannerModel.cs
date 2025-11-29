using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("Banner", Schema = "dbo")]
    public class BannerModel
    {
        [Key]
        [Required]
        [Column("Id_Banner")]
        public int Id_Banner { get; set; }
        [Column("TenBanner")]
        public string? TenBanner { get; set; }
        public string? DuongDan { get; set; }
        public string? LienKet { get; set; }

    }
}
