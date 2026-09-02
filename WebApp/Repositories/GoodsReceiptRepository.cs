using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class GoodsReceiptRepository(AppDbContext context) : Repository<HoaDonNhapHangModel>(context), IGoodsReceiptRepository
{
    public IQueryable<HoaDonNhapHangModel> ReceiptsWithSupplier =>
        Context.HoaDonNhapHangs.Include(h => h.NhaCungCap).AsQueryable();

    public IQueryable<CTHDNhapHangModel> ReceiptDetails =>
        Context.ChiTietHoaDonNhapHangs.Include(ct => ct.SanPham).AsQueryable();

    public IQueryable<DungCuModel> Products =>
        Context.DungCus.AsQueryable();

    public async Task<HoaDonNhapHangModel?> GetReceiptWithDetailsAsync(string id) =>
        await Context.HoaDonNhapHangs
            .Include(h => h.NhaCungCap)
            .FirstOrDefaultAsync(m => m.Id_HoaDonNhap == id);

    public async Task AddReceiptDetailAsync(CTHDNhapHangModel detail)
    {
        await Context.ChiTietHoaDonNhapHangs.AddAsync(detail);
    }

    public Task RemoveReceiptDetailAsync(CTHDNhapHangModel detail)
    {
        Context.ChiTietHoaDonNhapHangs.Remove(detail);
        return Task.CompletedTask;
    }

    public async Task<CTHDNhapHangModel?> FindReceiptDetailAsync(string receiptId, int detailId) =>
        await Context.ChiTietHoaDonNhapHangs
            .FirstOrDefaultAsync(ct => ct.Id_CTHDNhapHang == detailId && ct.Id_HoaDonNhap == receiptId);
}
