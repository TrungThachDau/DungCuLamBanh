    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
namespace WebDungCuLamBanh.Models
{
    [Table("SanPham", Schema = "dbo")]
    public class DungCuModel
    {
        [Key]
        [Required]
        [Column("Id_DungCu")]
        public int Id_DungCu { get; set; }
        [Column("TenDungCu")]
        public string? TenDungCu { get; set; }
        [Column("Gia")]
        //them thong bao khi gia bang 0
        [DisplayFormat(DataFormatString = "{0:0.##}")]
        public decimal? Gia { get; set; }
        [Column("SoLuong")]
        public int? SoLuong { get; set; }
        [Column("Id_LoaiDungCu")]
        public int? Id_LoaiDungCu { get; set; }
        [ForeignKey("Id_LoaiDungCu")]
        public LoaiDungCuModel? LoaiDungCu { get; set; }
        [Column("HinhAnh")]
        public string? HinhAnh
        {
            get; set;
        }
        [Column("MoTa")]
        public string? MoTa { get; set; }

        public int? Id_NhaCungCap { get; set; }
        [ForeignKey("Id_NhaCungCap")]
        public NhaCungCapModel? NhaCungCap { get; set; }

        public decimal? GiaKhuyenMai { get; set; }
        public decimal? GiaNhap { get; set; }
        public string? ThongTin { get; set; }
        [Column("Id_NhaSanXuat")]
        public int? Id_NhaSanXuat { get; set; }
        [ForeignKey("Id_NhaSanXuat")]
        public NhaSanXuatModel? NhaSanXuat { get; set; }
        public int? DaXoa { get; set; }
    }
}