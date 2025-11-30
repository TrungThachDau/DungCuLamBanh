using Firebase.Auth;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services
{
    public interface ICustomerService
    {
        // Authentication
        Task<UserCredential?> SignInAsync(string email, string password);
        Task<UserCredential?> SignInAnonymouslyAsync();
        Task<UserCredential?> SignUpAsync(KhachHangModel model, string password);
        Task<bool> ChangePasswordAsync(string email, string oldPassword, string newPassword);
        Task<bool> ResetPasswordAsync(string email);
        Task DeleteAccountAsync(string uid);

        // Customer Management
        Task<KhachHangModel?> GetCustomerAsync(string uid);
        Task<bool> UpdateCustomerAsync(KhachHangModel model);

        // Favorites
        Task<bool> AddToFavoriteAsync(int productId, string customerId);
        Task<bool> RemoveFromFavoriteAsync(int productId, string customerId);
        Task<List<YeuThichModel>> GetFavoriteProductsAsync(string customerId);

        // Order History
        Task<HistoryViewModel> GetOrderHistoryAsync(string customerId);
        Task<OrderDetailViewModel?> GetOrderDetailAsync(string orderId);

        // Helper Methods
        string HandleFirebaseException(Exception ex);
    }
}
