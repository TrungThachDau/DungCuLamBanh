namespace WebDungCuLamBanh.Models
{
    public class HistoryViewModel
    {
        public KhachHangModel? khachHangModel { get; set; }
        public List<DonHangModel> donHangModel { get; set; }
        public List<ChiTietDonHangModel> chiTietDonHangModel { get; set; }
        public List<DonHangVanChuyenModel> donHangVanChuyenModels { get; set; }
    }
}
