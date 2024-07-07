using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebDungCuLamBanh.Models
{
    [Table("TrangThaiVanChuyen", Schema = "dbo")]
    public class TrangThaiVanChuyenModel
    {
        [Key]
        public int Id_TrangThai { get; set; }
        public string? TenTrangThai { get; set; }
    }
}
