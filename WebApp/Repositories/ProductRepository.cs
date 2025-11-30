using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories
{
    public class ProductRepository(AppDbContext context) : IProductRepository
    {
        public IQueryable<DungCuModel> Products => context.DungCus.AsQueryable();
        public IQueryable<LoaiDungCuModel> Categories => context.LoaiDungCus.AsQueryable();
        public IQueryable<NhaSanXuatModel> Manufacturers => context.NhaSanXuats.AsQueryable();
        public IQueryable<ChiTietDonHangModel> OrderDetails => context.ChiTietDonHangs.AsQueryable();
        public IQueryable<YeuThichModel> Favorites => context.YeuThichs.AsQueryable();

        public async Task<T?> FindAsync<T>(params object[] keyValues) where T : class
        {
            return await context.Set<T>().FindAsync(keyValues);
        }
    }
}
