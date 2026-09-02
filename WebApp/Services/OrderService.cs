using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services;

public class OrderService(IOrderRepository repository) : IOrderService
{
    public async Task<List<DonHangVanChuyenModel>> GetOrdersByCustomerUidAsync(string uid)
    {
        return await repository.GetOrdersByCustomerUidAsync(uid);
    }

    public async Task<DonHangModel?> GetOrderByIdAsync(string id)
    {
        return await repository.GetOrderWithDetailsAsync(id);
    }

    public async Task<bool> ExistsAsync(string id)
    {
        return await repository.ExistsAsync(e => e.Id_DonHang == id);
    }
}
