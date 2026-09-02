using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class AdministratorRepository(AppDbContext context) : Repository<AdminModel>(context), IAdministratorRepository
{
    public IQueryable<AdminModel> Admins => Context.Admins.AsQueryable();
    public IQueryable<DungCuModel> Products => Context.DungCus.AsQueryable();
    public IQueryable<LoaiDungCuModel> Categories => Context.LoaiDungCus.AsQueryable();
    public IQueryable<KhuyenMaiModel> SaleOffs => Context.KhuyenMai2s.AsQueryable();
    public IQueryable<ChiTietKhuyenMaiModel> SaleOffDetails => Context.ChiTietKhuyenMais.AsQueryable();
    public IQueryable<MaGiamGiaModel> Vouchers => Context.MaGiamGias.AsQueryable();
    public IQueryable<DonHangModel> Orders => Context.DonHangs.AsQueryable();
    public IQueryable<DonHangVanChuyenModel> ShippingOrders => Context.DonHangVanChuyens.AsQueryable();
    public IQueryable<TrangThaiVanChuyenModel> ShippingStatuses => Context.TrangThaiVanChuyens.AsQueryable();
    public IQueryable<BannerModel> Banners => Context.Banners.AsQueryable();
    public IQueryable<HoaDonNhapHangModel> ImportInvoices => Context.HoaDonNhapHangs.AsQueryable();
    public IQueryable<ChiTietDonHangModel> OrderDetails => Context.ChiTietDonHangs.AsQueryable();
    public IQueryable<NhaCungCapModel> Suppliers => Context.NhaCungCaps.AsQueryable();
    public IQueryable<NhaSanXuatModel> Manufacturers => Context.NhaSanXuats.AsQueryable();

    public async Task<T?> FindAsync<T>(params object[] keyValues) where T : class
    {
        return await Context.Set<T>().FindAsync(keyValues);
    }

    public Task AddAsync<T>(T entity) where T : class
    {
        Context.Set<T>().Add(entity);
        return Task.CompletedTask;
    }

    public Task UpdateAsync<T>(T entity) where T : class
    {
        Context.Set<T>().Update(entity);
        return Task.CompletedTask;
    }

    public Task RemoveAsync<T>(T entity) where T : class
    {
        Context.Set<T>().Remove(entity);
        return Task.CompletedTask;
    }

    public new Task SaveChangesAsync()
    {
        return Context.SaveChangesAsync();
    }
}
