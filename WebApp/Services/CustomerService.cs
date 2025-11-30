using Firebase.Auth;
using Firebase.Auth.Providers;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services
{
    public class CustomerService(ICustomerRepository repository, ILogger<CustomerService> logger) : ICustomerService
    {
        private static readonly FirebaseAuthConfig config = new FirebaseAuthConfig()
        {
            ApiKey = "AIzaSyDByy95_HvWxluru48av1inYpYKWMMhVuI",
            AuthDomain = "qldclb-770f5.firebaseapp.com",
            Providers = new FirebaseAuthProvider[]
            {
                new EmailProvider()
            }
        };

        // Authentication Methods
        public async Task<UserCredential?> SignInAsync(string email, string password)
        {
            try
            {
                var client = new FirebaseAuthClient(config);
                var result = await client.SignInWithEmailAndPasswordAsync(email, password);
                return result;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error signing in user");
                throw;
            }
        }

        public async Task<UserCredential?> SignInAnonymouslyAsync()
        {
            try
            {
                var client = new FirebaseAuthClient(config);
                var result = await client.SignInAnonymouslyAsync();
                return result;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error signing in anonymously");
                throw;
            }
        }

        public async Task<UserCredential?> SignUpAsync(KhachHangModel model, string password)
        {
            try
            {
                var client = new FirebaseAuthClient(config);
                var result = await client.CreateUserWithEmailAndPasswordAsync(model.Email, password);
                
                if (result != null)
                {
                    var user = new KhachHangModel()
                    {
                        TenKhachHang = model.TenKhachHang,
                        Email = model.Email,
                        Id_KhachHang = result.User.Uid,
                        DiaChi = "",
                        SoDienThoai = "",
                        DiemThuong = 0,
                    };

                    await repository.AddAsync(user);
                    await repository.SaveChangesAsync();
                }
                
                return result;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error signing up user");
                throw;
            }
        }

        public async Task<bool> ChangePasswordAsync(string email, string oldPassword, string newPassword)
        {
            try
            {
                var client = new FirebaseAuthClient(config);
                var result = await client.SignInWithEmailAndPasswordAsync(email, oldPassword);
                
                if (result != null)
                {
                    await result.User.ChangePasswordAsync(newPassword);
                    return true;
                }
                
                return false;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error changing password");
                return false;
            }
        }

        public async Task<bool> ResetPasswordAsync(string email)
        {
            try
            {
                var client = new FirebaseAuthClient(config);
                await client.ResetEmailPasswordAsync(email);
                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error resetting password");
                return false;
            }
        }

        public async Task DeleteAccountAsync(string uid)
        {
            try
            {
                var client = new FirebaseAuthClient(config);
                var accountModel = await repository.FindAsync<KhachHangModel>(uid);
                
                if (accountModel != null)
                {
                    await repository.RemoveAsync(accountModel);
                    await repository.SaveChangesAsync();
                }
                
                await client.User.DeleteAsync();
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error deleting account");
                throw;
            }
        }

        // Customer Management Methods
        public async Task<KhachHangModel?> GetCustomerAsync(string uid)
        {
            return await repository.Customers.FirstOrDefaultAsync(k => k.Id_KhachHang == uid);
        }

        public async Task<bool> UpdateCustomerAsync(KhachHangModel model)
        {
            try
            {
                await repository.UpdateAsync(model);
                await repository.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error updating customer");
                return false;
            }
        }

        // Favorites Methods
        public async Task<bool> AddToFavoriteAsync(int productId, string customerId)
        {
            try
            {
                var favorite = await repository.Favorites
                    .FirstOrDefaultAsync(yt => yt.Id_SanPham == productId && yt.Id_KhachHang == customerId);
                
                if (favorite != null)
                {
                    return false; // Already exists
                }

                var yeuthich = new YeuThichModel()
                {
                    Id_SanPham = productId,
                    Id_KhachHang = customerId
                };
                
                await repository.AddAsync(yeuthich);
                await repository.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error adding to favorites");
                return false;
            }
        }

        public async Task<bool> RemoveFromFavoriteAsync(int productId, string customerId)
        {
            try
            {
                var favorite = await repository.Favorites
                    .FirstOrDefaultAsync(yt => yt.Id_SanPham == productId && yt.Id_KhachHang == customerId);
                
                if (favorite == null)
                {
                    return false; // Not found
                }

                await repository.RemoveAsync(favorite);
                await repository.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error removing from favorites");
                return false;
            }
        }

        public async Task<List<YeuThichModel>> GetFavoriteProductsAsync(string customerId)
        {
            return await repository.Favorites
                .Where(yt => yt.Id_KhachHang == customerId)
                .Include(yt => yt.SanPham)
                .ToListAsync();
        }

        // Order History Methods
        public async Task<HistoryViewModel> GetOrderHistoryAsync(string customerId)
        {
            var donHangVanChuyenModel = await repository.ShippingOrders
                .Where(ct => ct.DonHang.Id_KhachHang == customerId)
                .Include(p => p.TrangThaiVanChuyen)
                .Include(p => p.DonHang)
                .Include(p => p.PhuongThucThanhToan)
                .OrderByDescending(hd => hd.DonHang.NgayDat)
                .ToListAsync();

            var accountModel = await repository.Customers.FirstOrDefaultAsync(k => k.Id_KhachHang == customerId);

            var chiTietDonHangModel = await repository.OrderDetails
                .Include(ct => ct.DungCu)
                .Where(ct => donHangVanChuyenModel.Select(dh => dh.DonHang.Id_DonHang).Contains(ct.Id_DonHang))
                .ToListAsync();

            var result = new HistoryViewModel
            {
                khachHangModel = accountModel,
                donHangModel = donHangVanChuyenModel.Select(dh => dh.DonHang).ToList(),
                chiTietDonHangModel = chiTietDonHangModel,
                donHangVanChuyenModels = donHangVanChuyenModel
            };

            return result;
        }

        public async Task<OrderDetailViewModel?> GetOrderDetailAsync(string orderId)
        {
            var donHang = await repository.Orders.FirstOrDefaultAsync(dh => dh.Id_DonHang == orderId);
            
            if (donHang == null)
            {
                return null;
            }

            var chiTietDonHang = await repository.OrderDetails
                .Where(ct => ct.Id_DonHang == orderId)
                .Include(p => p.DungCu)
                .Include(p => p.DungCu.LoaiDungCu)
                .ToListAsync();

            var donHangVanChuyen = await repository.ShippingOrders
                .Where(ct => ct.Id_DonHang == orderId)
                .Include(p => p.TrangThaiVanChuyen)
                .Include(p => p.PhuongThucThanhToan)
                .FirstOrDefaultAsync();

            var result = new OrderDetailViewModel
            {
                donHangModel = donHang,
                chiTietDonHangModel = chiTietDonHang,
                donHangVanChuyenModel = donHangVanChuyen
            };

            return result;
        }

        // Helper Methods
        public string HandleFirebaseException(Exception ex)
        {
            if (ex.Message.Contains("INVALID"))
            {
                return "Thông tin đăng nhập không chính xác.";
            }
            if (ex.Message.Contains("WEAK"))
            {
                return "Mật khẩu quá ngắn, mật khẩu phải tối thiểu 6 ký tự.";
            }
            if (ex.Message.Contains("TOO_MANY"))
            {
                return "Đăng nhập quá nhiều lần, vui lòng thử lại sau.";
            }
            if (ex.Message.Contains("EMAIL_NOT_FOUND"))
            {
                return "Không tìm thấy email này.";
            }
            if (ex.Message.Contains("EXIST"))
            {
                return "Không tìm thấy email này.";
            }
            return "Đã xảy ra lỗi từ phía chúng tôi.";
        }
    }
}
