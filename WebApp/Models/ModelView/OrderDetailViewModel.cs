namespace WebDungCuLamBanh.Models
{
    public class OrderDetailViewModel
    {
        public List<ChiTietDonHangModel> chiTietDonHangModel { get; set; }
        public DonHangModel donHangModel { get; set; }
        public DonHangVanChuyenModel donHangVanChuyenModel { get; set; }
    }
}
