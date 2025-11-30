using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories
{
    public interface IProductRepository
    {
        IQueryable<DungCuModel> Products { get; }
        IQueryable<LoaiDungCuModel> Categories { get; }
        IQueryable<NhaSanXuatModel> Manufacturers { get; }
        IQueryable<ChiTietDonHangModel> OrderDetails { get; }
        IQueryable<YeuThichModel> Favorites { get; }

        Task<T?> FindAsync<T>(params object[] keyValues) where T : class;
    }
}
