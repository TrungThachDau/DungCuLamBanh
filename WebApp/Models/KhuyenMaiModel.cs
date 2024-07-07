using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("KhuyenMai", Schema = "dbo")]
    public class KhuyenMaiModel
    {
        [Key]
        [Required]

        public int Id_KhuyenMai { get; set; }
        public string? TenKhuyenMai { get; set; }
        //Xuat thong bao gia tri tu 1 den 99
        public DateTime? NgayBatDau { get; set; }
        public DateTime? NgayKetThuc { get; set; }
        public int? TrangThai { get; set; }

    }
}
