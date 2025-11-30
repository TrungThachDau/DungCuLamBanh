using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories
{
    public class CustomerRepository(AppDbContext context) : ICustomerRepository
    {
        public IQueryable<KhachHangModel> Customers => context.KhachHangs.AsQueryable();
        public IQueryable<DonHangModel> Orders => context.DonHangs.AsQueryable();
        public IQueryable<DonHangVanChuyenModel> ShippingOrders => context.DonHangVanChuyens.AsQueryable();
        public IQueryable<ChiTietDonHangModel> OrderDetails => context.ChiTietDonHangs.AsQueryable();
        public IQueryable<YeuThichModel> Favorites => context.YeuThichs.AsQueryable();
        public IQueryable<DungCuModel> Products => context.DungCus.AsQueryable();
        public IQueryable<MaGiamGiaModel> Vouchers => context.MaGiamGias.AsQueryable();
        public IQueryable<PTTTModel> PaymentMethods => context.PTTTs.AsQueryable();
        public IQueryable<CuocVanChuyenModel> ShippingRates => context.CuocVanChuyens.AsQueryable();

        public async Task<T?> FindAsync<T>(params object[] keyValues) where T : class
        {
            return await context.Set<T>().FindAsync(keyValues);
        }

        public Task AddAsync<T>(T entity) where T : class
        {
            context.Set<T>().Add(entity);
            return Task.CompletedTask;
        }

        public Task UpdateAsync<T>(T entity) where T : class
        {
            context.Set<T>().Update(entity);
            return Task.CompletedTask;
        }

        public Task RemoveAsync<T>(T entity) where T : class
        {
            context.Set<T>().Remove(entity);
            return Task.CompletedTask;
        }

        public Task SaveChangesAsync()
        {
            return context.SaveChangesAsync();
        }
    }
}
