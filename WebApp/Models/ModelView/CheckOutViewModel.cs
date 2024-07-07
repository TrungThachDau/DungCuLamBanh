namespace WebDungCuLamBanh.Models.ModelView
{
    public class CheckOutViewModel
    {
        public DonHangModel DonHang { get; set; }
        public List<ChiTietDonHangModel> ChiTietDonHangs { get; set; }
        public DonHangVanChuyenModel DonHangVanChuyen { get; set; }
    }
}
