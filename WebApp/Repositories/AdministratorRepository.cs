using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories
{
    public class AdministratorRepository(AppDbContext context) : IAdministratorRepository
    {
        public IQueryable<AdminModel> Admins => context.Admins.AsQueryable();
        public IQueryable<DungCuModel> Products => context.DungCus.AsQueryable();
        public IQueryable<LoaiDungCuModel> Categories => context.LoaiDungCus.AsQueryable();
        public IQueryable<KhuyenMaiModel> SaleOffs => context.KhuyenMai2s.AsQueryable();
        public IQueryable<ChiTietKhuyenMaiModel> SaleOffDetails => context.ChiTietKhuyenMais.AsQueryable();
        public IQueryable<MaGiamGiaModel> Vouchers => context.MaGiamGias.AsQueryable();
        public IQueryable<DonHangModel> Orders => context.DonHangs.AsQueryable();
        public IQueryable<DonHangVanChuyenModel> ShippingOrders => context.DonHangVanChuyens.AsQueryable();
        public IQueryable<TrangThaiVanChuyenModel> ShippingStatuses => context.TrangThaiVanChuyens.AsQueryable();
        public IQueryable<BannerModel> Banners => context.Banners.AsQueryable();
        public IQueryable<HoaDonNhapHangModel> ImportInvoices => context.HoaDonNhapHangs.AsQueryable();
        public IQueryable<ChiTietDonHangModel> OrderDetails => context.ChiTietDonHangs.AsQueryable();
        public IQueryable<NhaCungCapModel> Suppliers => context.NhaCungCaps.AsQueryable();
        public IQueryable<NhaSanXuatModel> Manufacturers => context.NhaSanXuats.AsQueryable();

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
