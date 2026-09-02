using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class OrderRepository(AppDbContext context) : Repository<DonHangModel>(context), IOrderRepository
{
    public IQueryable<DonHangVanChuyenModel> ShippingOrders => Context.DonHangVanChuyens.AsQueryable();
    public IQueryable<ChiTietDonHangModel> OrderDetails => Context.ChiTietDonHangs.AsQueryable();

    public async Task<List<DonHangVanChuyenModel>> GetOrdersByCustomerUidAsync(string uid) =>
        await Context.DonHangVanChuyens
            .Where(d => d.DonHang.Id_KhachHang == uid)
            .Include(d => d.DonHang)
            .Include(d => d.DonHang.KhachHang)
            .Include(d => d.TrangThaiVanChuyen)
            .OrderByDescending(d => d.DonHang.NgayDat)
            .ToListAsync();

    public async Task<DonHangModel?> GetOrderWithDetailsAsync(string orderId) =>
        await Context.DonHangs
            .Include(d => d.KhachHang)
            .Include(d => d.PhuongThucThanhToan)
            .Include(d => d.GiamGia)
            .FirstOrDefaultAsync(d => d.Id_DonHang == orderId);
}
