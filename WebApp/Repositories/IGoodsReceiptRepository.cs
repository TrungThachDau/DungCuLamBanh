using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public interface IGoodsReceiptRepository : IRepository<HoaDonNhapHangModel>
{
    IQueryable<HoaDonNhapHangModel> ReceiptsWithSupplier { get; }
    IQueryable<CTHDNhapHangModel> ReceiptDetails { get; }
    IQueryable<DungCuModel> Products { get; }
    Task<HoaDonNhapHangModel?> GetReceiptWithDetailsAsync(string id);
    Task AddReceiptDetailAsync(CTHDNhapHangModel detail);
    Task RemoveReceiptDetailAsync(CTHDNhapHangModel detail);
    Task<CTHDNhapHangModel?> FindReceiptDetailAsync(string receiptId, int detailId);
}
