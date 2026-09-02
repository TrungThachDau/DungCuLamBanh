using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services;

public interface IOrderService
{
    Task<List<DonHangVanChuyenModel>> GetOrdersByCustomerUidAsync(string uid);
    Task<DonHangModel?> GetOrderByIdAsync(string id);
    Task<bool> ExistsAsync(string id);
}
