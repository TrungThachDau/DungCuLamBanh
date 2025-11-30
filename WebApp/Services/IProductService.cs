using Microsoft.AspNetCore.Mvc.Rendering;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services
{
    public interface IProductService
    {
        Task<(List<DungCuModel> products, int totalPages, int currentPage)> GetProductListAsync(
            string search, 
            string sortColumn, 
            int min, 
            int max, 
            int page, 
            string type, 
            string manufacturer);

        Task<(SelectList categories, SelectList manufacturers)> GetProductFiltersAsync();

        Task<DungCuModel?> GetProductDetailAsync(int id);

        Task<bool> IsFavoriteAsync(int productId, string customerId);
    }
}
