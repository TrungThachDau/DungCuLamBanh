using Microsoft.AspNetCore.Mvc.Rendering;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services;

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

    // API & CRUD methods
    Task<IEnumerable<DungCuModel>> GetAllActiveProductsAsync();
    Task<DungCuModel?> GetByIdAsync(int id);
    Task<OperationResult<DungCuModel>> CreateAsync(DungCuModel model);
    Task<OperationResult> UpdateAsync(DungCuModel model);
    Task<OperationResult> DeleteAsync(int id);
    Task<IEnumerable<DungCuModel>> GetDiscountedProductsAsync();
    Task<IEnumerable<DungCuModel>> GetNewProductsAsync(int count = 4);
    Task<string> SearchProductForWebhookAsync(string productName);
    Task<bool> ExistsAsync(int id);
}
