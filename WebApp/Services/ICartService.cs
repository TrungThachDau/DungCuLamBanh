using Microsoft.AspNetCore.Mvc.Rendering;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services
{
    public interface ICartService
    {
        // Cart Operations
        Task<DonHangModel?> GetUnpaidOrderAsync(string customerId);
        Task<int> GetCartItemCountAsync(string orderId);
        Task<List<ChiTietDonHangModel>> GetOrderDetailsAsync(string orderId);
        Task<bool> AddToCartAsync(int productId, int quantity, string customerId);
        Task<bool> UpdateQuantityAsync(int orderDetailId, int quantity, string customerId);
        Task<bool> RemoveFromCartAsync(int orderDetailId, string customerId);

        // Checkout
        Task<(List<SelectListItem> paymentMethods, KhachHangModel? customer, DonHangModel? order)> GetCheckoutDataAsync(string customerId);
        Task<decimal?> GetShippingRateAsync(string district);

        // Voucher
        Task<bool> ApplyVoucherAsync(string voucherCode, string customerId);

        // Payment
        Task<OrderDetailViewModel?> ProcessCODPaymentAsync(string customerId, string name, string phone, string email, string address, decimal shippingFee, decimal loyaltyPoints);
        
        // Email
        Task SendOrderEmailAsync(OrderDetailViewModel orderDetail, string emailTo);

        // Helper
        Task<KhachHangModel?> GetCustomerAsync(string customerId);
    }
}
