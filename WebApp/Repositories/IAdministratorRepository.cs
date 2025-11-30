using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories
{
    public interface IAdministratorRepository
    {
        IQueryable<AdminModel> Admins { get; }
        IQueryable<DungCuModel> Products { get; }
        IQueryable<LoaiDungCuModel> Categories { get; }
        IQueryable<KhuyenMaiModel> SaleOffs { get; }
        IQueryable<ChiTietKhuyenMaiModel> SaleOffDetails { get; }
        IQueryable<MaGiamGiaModel> Vouchers { get; }
        IQueryable<DonHangModel> Orders { get; }
        IQueryable<DonHangVanChuyenModel> ShippingOrders { get; }
        IQueryable<TrangThaiVanChuyenModel> ShippingStatuses { get; }
        IQueryable<BannerModel> Banners { get; }
        IQueryable<HoaDonNhapHangModel> ImportInvoices { get; }
        IQueryable<ChiTietDonHangModel> OrderDetails { get; }
        IQueryable<NhaCungCapModel> Suppliers { get; }
        IQueryable<NhaSanXuatModel> Manufacturers { get; }

        Task<T?> FindAsync<T>(params object[] keyValues) where T : class;
        Task AddAsync<T>(T entity) where T : class;
        Task UpdateAsync<T>(T entity) where T : class;
        Task RemoveAsync<T>(T entity) where T : class;
        Task SaveChangesAsync();
    }
}
