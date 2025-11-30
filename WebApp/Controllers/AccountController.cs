using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using WebDungCuLamBanh.Components;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;
using WebDungCuLamBanh.Helpers;

namespace WebDungCuLamBanh.Controllers
{
    [ProfileStatusFilter]
    public class AccountController(ICustomerService customerService, ILogger<AccountController> logger) : Controller
    {
        // Sign In
        public IActionResult SignIn()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> SignIn(KhachHangModel model, string password)
        {
            try
            {
                var result = await customerService.SignInAsync(model.Email, password);
                
                if (result != null && result.User.Uid != null && model.Email != null)
                {
                    SetSession("uid", result.User.Uid);
                    SetSession("email", model.Email);
                    
                    var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.Name, model.Email),
                        new Claim(ClaimTypes.NameIdentifier, result.User.Uid)
                    };
                    
                    var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                    var claimsPrincipal = new ClaimsPrincipal(claimsIdentity);
                    
                    await HttpContext.SignInAsync("Firebase", claimsPrincipal, new AuthenticationProperties
                    {
                        IsPersistent = true,
                        ExpiresUtc = DateTime.UtcNow.AddMinutes(30)
                    });
                    
                    return RedirectToAction("Index", "Home");
                }
                
                return View();
            }
            catch (Exception ex)
            {
                ViewBag.Error = customerService.HandleFirebaseException(ex);
                return View(model);
            }
        }

        [HttpPost]
        [HttpGet]
        public async Task<IActionResult> SignInAnonymously()
        {
            try
            {
                var result = await customerService.SignInAnonymouslyAsync();
                
                if (result != null && result.User.Uid != null)
                {
                    SetSession("uid", result.User.Uid);
                    
                    await HttpContext.SignInAsync("Firebase", new ClaimsPrincipal(), new AuthenticationProperties
                    {
                        IsPersistent = true,
                        ExpiresUtc = DateTime.UtcNow.AddMinutes(30)
                    });
                    
                    return Json(new { success = true });
                }
                
                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return Json(new { success = false });
            }
        }

        // Sign Up
        public IActionResult SignUp()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> SignUp(KhachHangModel model, string password)
        {
            try
            {
                var result = await customerService.SignUpAsync(model, password);
                
                if (result != null && result.User.Uid != null && model.Email != null)
                {
                    SetSession("uid", result.User.Uid);
                    SetSession("email", model.Email);
                    return RedirectToAction("Index", "Home");
                }
                
                return View("SignIn");
            }
            catch (Exception ex)
            {
                ViewBag.Error = customerService.HandleFirebaseException(ex);
                logger.LogError(ex, "Lỗi khi đăng ký.");
                return View("SignIn");
            }
        }

        [HttpPost]
        public async Task<IActionResult> SignUp2(KhachHangModel model, string password)
        {
            try
            {
                var result = await customerService.SignUpAsync(model, password);
                
                if (result != null && result.User.Uid != null)
                {
                    return RedirectToAction("SignUpOk", "Account");
                }
                
                return View("SignUp");
            }
            catch (Exception ex)
            {
                ViewBag.Error = customerService.HandleFirebaseException(ex);
                logger.LogError(ex, "Lỗi khi đăng ký.");
                return View("SignUp");
            }
        }

        public IActionResult SignUpOk()
        {
            return View();
        }

        // Sign Out
        public async Task<IActionResult> SignOut()
        {
            HttpContext.Session.Clear();
            await HttpContext.SignOutAsync("Firebase");
            return RedirectToAction("SignIn");
        }

        // Change Password
        public IActionResult ChangePassword()
        {
            string uid = GetSession("uid");
            if (uid == null)
            {
                return RedirectToAction("SignIn", "Account");
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ChangePassword(string oldPassword, string newPassword)
        {
            string? email = HttpContext.Session.GetString("email");

            if (string.IsNullOrEmpty(email))
            {
                ViewBag.notice = "Không tìm thấy email trong phiên làm việc. Vui lòng đăng nhập lại.";
                return View();
            }

            var result = await customerService.ChangePasswordAsync(email, oldPassword, newPassword);
            
            if (result)
            {
                ViewBag.success = "Đổi mật khẩu thành công";
            }
            else
            {
                ViewBag.error = "Đổi mật khẩu không thành công. Vui lòng kiểm tra lại mật khẩu cũ.";
            }
            
            return View();
        }

        // Reset Password
        public IActionResult ResetPassword()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ResetPassword(string email)
        {
            if (string.IsNullOrEmpty(email))
            {
                ViewBag.Error = "Bạn chưa nhập email.";
                return View();
            }

            var result = await customerService.ResetPasswordAsync(email);
            
            if (result)
            {
                ViewBag.notice = "Vui lòng kiểm tra email để đổi mật khẩu.";
            }
            else
            {
                ViewBag.Error = "Có lỗi xảy ra khi gửi yêu cầu đặt lại mật khẩu. Vui lòng thử lại.";
            }
            
            return View();
        }

        // Edit Profile
        public async Task<IActionResult> Edit(object data)
        {
            string uid = GetSession("uid");
            if (uid == null)
            {
                return RedirectToAction("SignIn", "Account");
            }
            
            ViewBag.success = data;
            var accountModel = await customerService.GetCustomerAsync(uid);
            
            if (accountModel == null)
            {
                return NotFound();
            }
            
            return View(accountModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit([Bind("Id_KhachHang,TenKhachHang,Email,SoDienThoai,DiaChi")] KhachHangModel accountModel)
        {
            if (ModelState.IsValid)
            {
                var result = await customerService.UpdateCustomerAsync(accountModel);
                
                if (result)
                {
                    TempData["SuccessMessage"] = "Cập nhật thông tin thành công";
                }
                else
                {
                    TempData["ErrorMessage"] = "Cập nhật thông tin không thành công";
                }
                
                return RedirectToAction("Edit", "Account");
            }

            return View(accountModel);
        }

        // Order History
        public async Task<IActionResult> History()
        {
            var email = HttpContext.Session.GetString("email");
            var uid = HttpContext.Session.GetString("uid");

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(uid))
            {
                return RedirectToAction("SignIn", "Account");
            }

            var result = await customerService.GetOrderHistoryAsync(uid);
            return View(result);
        }

        // Order Detail
        public async Task<IActionResult> OrderDetail(string id)
        {
            var session = GetSession("email");
            ViewBag.email = session;

            var result = await customerService.GetOrderDetailAsync(id);
            
            if (result == null || result.donHangModel == null)
            {
                return View("Error", new ErrorViewModel { Message = "Không tìm thấy hóa đơn." });
            }

            if (result.chiTietDonHangModel == null || result.chiTietDonHangModel.Count == 0)
            {
                return NotFound("Không tìm thấy chi tiết hóa đơn.");
            }

            decimal? tongtien = result.donHangModel.TongTien;
            decimal? tamtinh = result.chiTietDonHangModel.Sum(ct => ct.DonGia);
            decimal vat = Math.Round((decimal)((tongtien * 8) / 108), 0);

            var magiamgia = result.donHangModel.Id_MaGiamGia;
            decimal giatrigiam = 0;
            
            if (!string.IsNullOrEmpty(magiamgia))
            {
                var voucher = await customerService.GetCustomerAsync(magiamgia);
                // Note: Need to add GetVoucher method to service if needed
            }

            ViewBag.tamtinh = HtmlHelpers.FormatCurrency((decimal)tamtinh);
            ViewBag.vat = vat;
            ViewBag.magiamgia = giatrigiam;
            ViewBag.tongtien = tongtien;
            ViewBag.phivanchuyen = result.donHangVanChuyenModel?.PhiVanChuyen;
            
            return View(result);
        }

        public async Task<IActionResult> OrderDetail2(string id)
        {
            var session = GetSession("email");
            ViewBag.email = session;

            var result = await customerService.GetOrderDetailAsync(id);
            
            if (result == null || result.donHangModel == null)
            {
                return View("Error", new ErrorViewModel { Message = "Không tìm thấy hóa đơn." });
            }

            if (result.chiTietDonHangModel == null || result.chiTietDonHangModel.Count == 0)
            {
                return NotFound("Không tìm thấy chi tiết hóa đơn.");
            }

            decimal? tongtien = result.donHangModel.TongTien;
            decimal? tamtinh = result.chiTietDonHangModel.Sum(ct => ct.DonGia);
            decimal vat = Math.Round((decimal)((tongtien * 8) / 108), 0);

            var magiamgia = result.donHangModel.Id_MaGiamGia;
            decimal giatrigiam = 0;

            ViewBag.tamtinh = HtmlHelpers.FormatCurrency((decimal)tamtinh);
            ViewBag.vat = vat;
            ViewBag.magiamgia = giatrigiam;
            ViewBag.tongtien = tongtien;
            ViewBag.phivanchuyen = result.donHangVanChuyenModel?.PhiVanChuyen;
            
            return View(result);
        }

        // Check Login Status
        [HttpGet]
        public IActionResult CheckLogin()
        {
            var session = GetSession("uid");
            ViewBag.uid = session;

            if (string.IsNullOrEmpty(session))
            {
                return Json(new { signedIn = false });
            }
            
            return Json(new { signedIn = true });
        }

        // New Sign In Page
        public IActionResult NewSignIn()
        {
            return View();
        }

        // Delete Account
        public async Task<IActionResult> DeleteAccount()
        {
            try
            {
                string? uid = HttpContext.Session.GetString("uid");
                
                if (uid != null)
                {
                    await customerService.DeleteAccountAsync(uid);
                    return RedirectToAction("SignOut");
                }
                
                return RedirectToAction("SignIn");
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }

        // Favorites
        [HttpPost]
        [Route("Account/AddToFavorite")]
        public async Task<ActionResult> AddToFavorite(int id)
        {
            var session = HttpContext.Session.GetString("email");
            var uid = HttpContext.Session.GetString("uid");
            
            if (session == null || uid == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập để thêm sản phẩm vào yêu thích." });
            }

            var result = await customerService.AddToFavoriteAsync(id, uid);
            
            if (!result)
            {
                return Json(new { success = false, message = "Sản phẩm đã có trong danh sách yêu thích." });
            }

            return Json(new { success = true, message = "Thêm sản phẩm vào yêu thích thành công." });
        }

        [HttpPost]
        [Route("Account/DeleteFavorite/{id}")]
        public async Task<ActionResult> DeleteFavorite(int id)
        {
            var sessionEmail = HttpContext.Session.GetString("email");
            var sessionUid = HttpContext.Session.GetString("uid");

            if (sessionEmail == null || sessionUid == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập để xóa sản phẩm khỏi yêu thích." });
            }

            var result = await customerService.RemoveFromFavoriteAsync(id, sessionUid);
            
            if (!result)
            {
                return Json(new { success = false, message = "Sản phẩm không có trong danh sách yêu thích." });
            }

            return Json(new { success = true, message = "Xóa sản phẩm khỏi yêu thích thành công." });
        }

        public async Task<IActionResult> FavoriteProduct()
        {
            var session = HttpContext.Session.GetString("email");
            if (session == null)
            {
                return RedirectToAction("SignIn", "Account");
            }
            
            var uid = HttpContext.Session.GetString("uid");
            if (uid == null)
            {
                return RedirectToAction("SignIn", "Account");
            }
            
            var favorite = await customerService.GetFavoriteProductsAsync(uid);
            return View(favorite);
        }

        // Notification
        public IActionResult Notification()
        {
            return View();
        }

        // Helper Methods
        private void SetSession(string key, string value)
        {
            HttpContext.Session.Set(key, System.Text.Encoding.UTF8.GetBytes(value));
        }

        private string GetSession(string key)
        {
            return HttpContext.Session.GetString(key);
        }
    }
}
