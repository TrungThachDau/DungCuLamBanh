using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories
{
    public interface ICartRepository
    {
        IQueryable<DonHangModel> Orders { get; }
        IQueryable<ChiTietDonHangModel> OrderDetails { get; }
        IQueryable<DonHangVanChuyenModel> ShippingOrders { get; }
        IQueryable<KhachHangModel> Customers { get; }
        IQueryable<DungCuModel> Products { get; }
        IQueryable<MaGiamGiaModel> Vouchers { get; }
        IQueryable<PTTTModel> PaymentMethods { get; }
        IQueryable<CuocVanChuyenModel> ShippingRates { get; }

        Task<T?> FindAsync<T>(params object[] keyValues) where T : class;
        Task AddAsync<T>(T entity) where T : class;
        Task UpdateAsync<T>(T entity) where T : class;
        Task RemoveAsync<T>(T entity) where T : class;
        Task SaveChangesAsync();
    }
}
