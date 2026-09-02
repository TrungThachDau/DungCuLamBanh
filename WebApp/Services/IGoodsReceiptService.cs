using WebDungCuLamBanh.DTOs.GoodsReceipt;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services;

public interface IGoodsReceiptService
{
    Task<IEnumerable<HoaDonNhapHangModel>> GetAllAsync(string search = "");
    Task<HoaDonNhapHangModel?> GetByIdAsync(string id);
    Task<OperationResult<HoaDonNhapHangModel>> CreateAsync(HoaDonNhapHangModel model);
    Task<ReceiptDetailViewModelData?> GetReceiptDetailsAsync(string id);
    Task<OperationResult> AddProductToReceiptAsync(string maHD, int idSanPham, int soLuong, int donGia);
    Task<OperationResult> ImportProductsAsync(string maHD, string? nhanVienLap = null);
    Task<OperationResult> DeleteProductFromReceiptAsync(string maHD, int detailId);
    Task<bool> ExistsAsync(string id);
}

public class ReceiptDetailViewModelData
{
    public HoaDonNhapHangModel? HoaDon { get; set; }
    public List<CTHDNhapHangModel> ChiTiet { get; set; } = [];
    public List<DungCuModel> SanPham { get; set; } = [];
}
