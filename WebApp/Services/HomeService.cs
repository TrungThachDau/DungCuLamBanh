using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services
{
    public class HomeService(IHomeRepository repository, ILogger<HomeService> logger) : IHomeService
    {
        public async Task<List<BannerModel>> GetBannersAsync()
        {
            return await repository.Banners.ToListAsync();
        }

        public async Task<List<DungCuModel>> GetSaleOffProductsAsync()
        {
            return await repository.Products
                .Where(x => x.GiaKhuyenMai > 0 && x.SoLuong > 0)
                .Take(4)
                .ToListAsync();
        }

        public async Task<List<DungCuModel>> GetNewProductsAsync()
        {
            return await repository.Products
                .Where(x => x.SoLuong > 0)
                .OrderByDescending(x => x.Id_DungCu)
                .Take(4)
                .ToListAsync();
        }

        public async Task<List<decimal?>> GetDiscountPercentagesAsync()
        {
            return await repository.Products
                .Where(x => x.GiaKhuyenMai > 0)
                .Select(x => x.GiaKhuyenMai / x.Gia * 100)
                .ToListAsync();
        }
    }
}
