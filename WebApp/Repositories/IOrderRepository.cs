using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public interface IOrderRepository : IRepository<DonHangModel>
{
    IQueryable<DonHangVanChuyenModel> ShippingOrders { get; }
    IQueryable<ChiTietDonHangModel> OrderDetails { get; }
    Task<List<DonHangVanChuyenModel>> GetOrdersByCustomerUidAsync(string uid);
    Task<DonHangModel?> GetOrderWithDetailsAsync(string orderId);
}
