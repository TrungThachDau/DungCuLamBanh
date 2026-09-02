using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services;

public class ProductService(IProductRepository repository, ILogger<ProductService> logger) : IProductService
{
    public async Task<(List<DungCuModel> products, int totalPages, int currentPage)> GetProductListAsync(
        string search, 
        string sortColumn, 
        int min, 
        int max, 
        int page, 
        string type, 
        string manufacturer)
    {
        try
        {
            IQueryable<DungCuModel> query = repository.Products
                .Include(p => p.LoaiDungCu)
                .Include(p => p.NhaSanXuat)
                .Where(p => p.DaXoa == 0 && p.SoLuong != 0);

            // Filter by price range
            if (min > 0 && max > 0)
            {
                query = query.Where(p => p.Gia >= min && p.Gia <= max);
            }

            // Filter by search keyword
            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(p => p.TenDungCu != null && p.TenDungCu.Contains(search));
            }

            // Filter by category
            if (!string.IsNullOrEmpty(type))
            {
                query = query.Where(p => p.LoaiDungCu != null && p.LoaiDungCu.TenLoaiDungCu != null && p.LoaiDungCu.TenLoaiDungCu.Contains(type));
            }

            // Filter by manufacturer
            if (!string.IsNullOrEmpty(manufacturer))
            {
                query = query.Where(p => p.NhaSanXuat != null && p.NhaSanXuat.TenNSX != null && p.NhaSanXuat.TenNSX.Contains(manufacturer));
            }

            // Get best selling products ranking
            var orderDetails = await repository.OrderDetails
                .GroupBy(p => p.Id_DungCu)
                .Select(p => new
                {
                    Id_DungCu = p.Key,
                    SoLuong = p.Sum(x => x.SoLuong)
                })
                .OrderByDescending(x => x.SoLuong)
                .ToListAsync();

            var productRank = orderDetails
                .Where(item => item.Id_DungCu.HasValue)
                .Select((item, index) => new { Id_DungCu = item.Id_DungCu!.Value, Rank = index + 1 })
                .ToDictionary(x => x.Id_DungCu, x => x.Rank);

            // Apply sorting
            query = sortColumn switch
            {
                "3" => query.OrderBy(p => p.TenDungCu),
                "4" => query.OrderByDescending(p => p.TenDungCu),
                "1" => query.OrderBy(p => p.TenDungCu),
                "2" => query.OrderByDescending(p => p.TenDungCu),
                "5" => query.OrderBy(p => p.Id_DungCu),
                "6" => query.OrderByDescending(p => p.Id_DungCu),
                "7" => query.OrderBy(p => productRank.ContainsKey(p.Id_DungCu) ? productRank[p.Id_DungCu] : int.MaxValue),
                _ => query.OrderByDescending(p => p.Id_LoaiDungCu),
            };

            // Pagination
            int totalItems = await query.CountAsync();
            
            if (totalItems == 0)
            {
                return (new List<DungCuModel>(), 0, page);
            }

            int itemsPerPage = 15;
            int totalPages = (int)Math.Ceiling((double)totalItems / itemsPerPage);

            if (page < 1) page = 1;
            if (page > totalPages) page = totalPages;

            int start = (page - 1) * itemsPerPage;
            var result = await query.Skip(start).Take(itemsPerPage).ToListAsync();

            return (result, totalPages, page);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error getting product list");
            return (new List<DungCuModel>(), 0, page);
        }
    }

    public async Task<(SelectList categories, SelectList manufacturers)> GetProductFiltersAsync()
    {
        var categories = new SelectList(await repository.Categories.ToListAsync(), "Id_LoaiDungCu", "TenLoaiDungCu");
        var manufacturers = new SelectList(await repository.Manufacturers.ToListAsync(), "Id_NhaSanXuat", "TenNSX");
        
        return (categories, manufacturers);
    }

    public async Task<DungCuModel?> GetProductDetailAsync(int id)
    {
        return await repository.Products
            .Include(p => p.LoaiDungCu)
            .Include(p => p.NhaCungCap)
            .Include(p => p.NhaSanXuat)
            .FirstOrDefaultAsync(m => m.Id_DungCu == id);
    }

    public async Task<bool> IsFavoriteAsync(int productId, string customerId)
    {
        if (string.IsNullOrEmpty(customerId)) return false;

        var favorite = await repository.Favorites
            .FirstOrDefaultAsync(p => p.Id_SanPham == productId && p.Id_KhachHang == customerId);

        return favorite != null;
    }

    public async Task<IEnumerable<DungCuModel>> GetAllActiveProductsAsync()
    {
        return await repository.Products
            .Where(p => p.DaXoa == 0)
            .ToListAsync();
    }

    public async Task<DungCuModel?> GetByIdAsync(int id)
    {
        return await repository.Products
            .Include(p => p.NhaCungCap)
            .Include(p => p.LoaiDungCu)
            .Include(p => p.NhaSanXuat)
            .FirstOrDefaultAsync(p => p.Id_DungCu == id);
    }

    public async Task<OperationResult<DungCuModel>> CreateAsync(DungCuModel model)
    {
        try
        {
            await repository.AddAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult<DungCuModel>.SuccessResult(model);
        }
        catch (Exception ex)
        {
            return OperationResult<DungCuModel>.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> UpdateAsync(DungCuModel model)
    {
        try
        {
            if (!await ExistsAsync(model.Id_DungCu))
            {
                return OperationResult.FailureResult("Không tìm thấy dụng cụ.");
            }

            await repository.UpdateAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult.SuccessResult();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!await ExistsAsync(model.Id_DungCu))
            {
                return OperationResult.FailureResult("Không tìm thấy dụng cụ.");
            }
            throw;
        }
        catch (Exception ex)
        {
            return OperationResult.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> DeleteAsync(int id)
    {
        try
        {
            var product = await repository.GetByIdAsync(id);
            if (product == null)
            {
                return OperationResult.FailureResult("Không tìm thấy dụng cụ.");
            }

            await repository.DeleteAsync(product);
            await repository.SaveChangesAsync();
            return OperationResult.SuccessResult();
        }
        catch (Exception ex)
        {
            return OperationResult.FailureResult(ex.Message);
        }
    }

    public async Task<IEnumerable<DungCuModel>> GetDiscountedProductsAsync()
    {
        return await repository.Products
            .Where(p => p.DaXoa == 0 && p.GiaKhuyenMai > 0)
            .ToListAsync();
    }

    public async Task<IEnumerable<DungCuModel>> GetNewProductsAsync(int count = 4)
    {
        return await repository.Products
            .Where(p => p.DaXoa == 0)
            .OrderByDescending(x => x.Id_DungCu)
            .Take(count)
            .ToListAsync();
    }

    public async Task<string> SearchProductForWebhookAsync(string productName)
    {
        var product = await repository.Products
            .FirstOrDefaultAsync(p => p.TenDungCu != null && p.TenDungCu.ToLower().Contains(productName.ToLower()));

        if (product != null)
        {
            return $"Sản phẩm {product.TenDungCu} có giá {product.Gia} VND.";
        }
        return $"Sản phẩm {productName} không tồn tại.";
    }

    public async Task<bool> ExistsAsync(int id)
    {
        return await repository.ExistsAsync(e => e.Id_DungCu == id);
    }
}
