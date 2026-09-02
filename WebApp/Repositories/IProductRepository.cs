using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public interface IProductRepository : IRepository<DungCuModel>
{
    IQueryable<DungCuModel> Products { get; }
    IQueryable<LoaiDungCuModel> Categories { get; }
    IQueryable<NhaSanXuatModel> Manufacturers { get; }
    IQueryable<ChiTietDonHangModel> OrderDetails { get; }
    IQueryable<YeuThichModel> Favorites { get; }

    Task<T?> FindAsync<T>(params object[] keyValues) where T : class;
    Task AddAsync<T>(T entity) where T : class;
    Task UpdateAsync<T>(T entity) where T : class;
    Task RemoveAsync<T>(T entity) where T : class;
    new Task SaveChangesAsync();
}
