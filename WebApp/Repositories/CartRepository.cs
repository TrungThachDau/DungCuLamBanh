using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class CartRepository(AppDbContext context) : Repository<DonHangModel>(context), ICartRepository
{
    public IQueryable<DonHangModel> Orders => Context.DonHangs.AsQueryable();
    public IQueryable<ChiTietDonHangModel> OrderDetails => Context.ChiTietDonHangs.AsQueryable();
    public IQueryable<DonHangVanChuyenModel> ShippingOrders => Context.DonHangVanChuyens.AsQueryable();
    public IQueryable<KhachHangModel> Customers => Context.KhachHangs.AsQueryable();
    public IQueryable<DungCuModel> Products => Context.DungCus.AsQueryable();
    public IQueryable<MaGiamGiaModel> Vouchers => Context.MaGiamGias.AsQueryable();
    public IQueryable<PTTTModel> PaymentMethods => Context.PTTTs.AsQueryable();
    public IQueryable<CuocVanChuyenModel> ShippingRates => Context.CuocVanChuyens.AsQueryable();

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
