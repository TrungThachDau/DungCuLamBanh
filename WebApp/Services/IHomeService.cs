using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services
{
    public interface IHomeService
    {
        Task<List<BannerModel>> GetBannersAsync();
        Task<List<DungCuModel>> GetSaleOffProductsAsync();
        Task<List<DungCuModel>> GetNewProductsAsync();
        Task<List<decimal?>> GetDiscountPercentagesAsync();
    }
}
