using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services
{
    public class SaleOffViewData
    {
        public KhuyenMaiModel? KhuyenMai { get; set; }
        public List<DungCuModel> Products { get; set; } = [];
        public List<ChiTietKhuyenMaiModel> Details { get; set; } = [];
    }
}
