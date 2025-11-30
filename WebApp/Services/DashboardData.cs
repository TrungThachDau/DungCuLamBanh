using System.Linq;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services
{
    public class DashboardData
    {
        public decimal DoanhThuThangNay { get; set; }
        public decimal TienVatThangNay { get; set; }
        public decimal TienShipThangNay { get; set; }
        public decimal DoanhThuSauThuevaChiPhiThangNay { get; set; }
        public decimal TienNhapHangThangNay { get; set; }
        public decimal LoiNhuanThangNay { get; set; }
        public decimal VatThangNay { get; set; }
        public int DonHangChoXuLy { get; set; }
        public decimal DoanhThuLoc { get; set; }
        public decimal TienShipLoc { get; set; }
        public decimal DoanhThuSauThuevaChiPhiLoc { get; set; }
        public decimal TienNhapHangLoc { get; set; }
        public decimal TienLoiLoc { get; set; }
        public decimal VatLoc { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public decimal DoanhThuHomNay { get; set; }
        public decimal TienShipHomNay { get; set; }
        public decimal DoanhThuSauThuevaChiPhiHomNay { get; set; }
        public decimal TienNhapHangHomNay { get; set; }
        public decimal TienLoiHomNay { get; set; }
        public decimal VatHomNay { get; set; }
        public int ThangNay { get; set; }
        public IEnumerable<ProductSaleInfo> TopProducts { get; set; } = Enumerable.Empty<ProductSaleInfo>();
    }

    public class ProductSaleInfo
    {
        public int Id_DungCu { get; set; }
        public string TenSanPham { get; set; } = string.Empty;
        public int SoLuongBanDuoc { get; set; }
    }
}
