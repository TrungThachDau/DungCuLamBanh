using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services
{
    public class OrderDetailData
    {
        public OrderDetailViewModel? ViewModel { get; set; }
        public decimal? TamTinh { get; set; }
        public decimal? Vat { get; set; }
        public decimal GiaTriGiam { get; set; }
        public decimal? TongTien { get; set; }
        public decimal? PhiVanChuyen { get; set; }
    }
}
