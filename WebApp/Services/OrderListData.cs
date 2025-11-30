using Microsoft.AspNetCore.Mvc.Rendering;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services
{
    public class OrderListData
    {
        public List<DonHangVanChuyenModel> Orders { get; set; } = [];
        public List<SelectListItem> ShippingStatusOptions { get; set; } = [];
        public int DonHangChuaGiao { get; set; }
        public int DonHangDaGiao { get; set; }
        public int DonHangDangGiao { get; set; }
        public int DonHangDaHuy { get; set; }
    }
}
