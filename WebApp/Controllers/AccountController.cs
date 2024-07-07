using Firebase.Auth;
using Firebase.Auth.Providers;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using WebDungCuLamBanh.Components;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Helpers;
using Org.BouncyCastle.Bcpg.OpenPgp;
namespace WebDungCuLamBanh.Controllers
{

    [ProfileStatusFilter]
    public class AccountController(AppDbContext context, ILogger<AccountController> logger) : Controller
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

        public IActionResult SignIn()
        {

            return View();
        }
        [HttpPost]
        public async Task<IActionResult> SignIn(KhachHangModel model, string password)
        {
            var client = new FirebaseAuthClient(config);
            try
            {

                var result = await client.SignInWithEmailAndPasswordAsync(model.Email, password);
                if (result != null)
                {
                    if (result.User.Uid != null && model.Email != null)
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
                        await HttpContext.SignInAsync("Firebase", claimsPrincipal, new Microsoft.AspNetCore.Authentication.AuthenticationProperties
                        {
                            IsPersistent = true,
                            ExpiresUtc = DateTime.UtcNow.AddMinutes(30)
                        });
                        return RedirectToAction("Index", "Home");
                    }
                    return RedirectToAction("Index", "Home");
                }
                return View();
            }
            catch (Exception ex)
            {
                ViewBag.Error = HandleFirebaseException(ex);
                return View(model);
            }
        }
        [HttpPost]
        [HttpGet]
        public async Task<IActionResult> SignInAnonymously()
        {
            var client = new FirebaseAuthClient(config);
            try
            {
                var result = await client.SignInAnonymouslyAsync();
                if (result != null)
                {
                    if (result.User.Uid != null)
                    {
                        SetSession("uid", result.User.Uid);
                  
                        await HttpContext.SignInAsync("Firebase", new System.Security.Claims.ClaimsPrincipal(), new Microsoft.AspNetCore.Authentication.AuthenticationProperties
                        {
                            IsPersistent = true,
                            ExpiresUtc = DateTime.UtcNow.AddMinutes(30)
                        });
                        return Json(new { success = true });
                    }
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
        public IActionResult SignUp()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> SignUp(KhachHangModel model, string password)
        {
            var client = new FirebaseAuthClient(config);
            try
            {
                // Thực hiện đăng ký tài khoản trên Firebase Auth
                var result = await client.CreateUserWithEmailAndPasswordAsync(model.Email, password);
                var auth = await client.SignInWithEmailAndPasswordAsync(model.Email, password);
                if (result != null)
                {
                    // Thực hiện insert vào bảng Account
                    var user = new KhachHangModel()
                    {
                        TenKhachHang = model.TenKhachHang,
                        Email = model.Email,
                        Id_KhachHang = result.User.Uid,
                        DiaChi = "",
                        SoDienThoai = "",
                        DiemThuong = 0,

                    };
                    try
                    {
                        // Thực hiện insert vào bảng Account
                        context.KhachHangs.Add(user);
                        await context.SaveChangesAsync();
                    }
                    catch (Exception ex)
                    {

                        ViewBag.Error = HandleFirebaseException(ex);
                        logger.LogError(ex, "Lỗi khi đăng nhập.");
                        return View("SignIn");
                    }
                    // Thực hiện insert chỉ vào các cột Email, Uid và FullName
                    if (result.User.Uid != null && model.Email != null)
                    {
                        SetSession("uid", result.User.Uid);
                        SetSession("email", model.Email);
                        return RedirectToAction("Index", "Home");
                    }
                }
                return View("SignIn");
            }
            catch (Exception ex)
            {
                ViewBag.Error = HandleFirebaseException(ex);
                logger.LogError(ex, "Lỗi khi đăng nhập.");
                return View("SignIn");
            }
        }
        [HttpPost]
        public async Task<IActionResult> SignUp2(KhachHangModel model, string password)
        {
            var client = new FirebaseAuthClient(config);
            try
            {
                // Thực hiện đăng ký tài khoản trên Firebase Auth
                var result = await client.CreateUserWithEmailAndPasswordAsync(model.Email, password);
                var auth = await client.SignInWithEmailAndPasswordAsync(model.Email, password);
                if (result != null)
                {
                    // Thực hiện insert vào bảng Account
                    var user = new KhachHangModel()
                    {
                        TenKhachHang = model.TenKhachHang,
                        Email = model.Email,
                        Id_KhachHang = result.User.Uid,
                        DiaChi = "",
                        SoDienThoai = "",
                        DiemThuong = 0,

                    };
                    try
                    {
                        // Thực hiện insert vào bảng Account
                        context.KhachHangs.Add(user);
                        await context.SaveChangesAsync();
                    }
                    catch (Exception ex)
                    {

                        ViewBag.Error = HandleFirebaseException(ex);
                        logger.LogError(ex, "Lỗi khi đăng nhập.");
                        return View("SignUp");
                    }
                    // Thực hiện insert chỉ vào các cột Email, Uid và FullName
                    if (result.User.Uid != null && model.Email != null)
                    {
                        return RedirectToAction("SignUpOk", "Account");
                    }
                }
                return View("SignUp");
            }
            catch (Exception ex)
            {
                ViewBag.Error = HandleFirebaseException(ex);
                logger.LogError(ex, "Lỗi khi đăng nhập.");
                return View("SignUp");
            }
        }
        public IActionResult SignUpOk()
        {
            return View();
        }
        public async Task<IActionResult> SignOut()
        {
            var client = new FirebaseAuthClient(config);
            client.SignOut();
            HttpContext.Session.Clear();
            await HttpContext.SignOutAsync("Firebase");
            return RedirectToAction("SignIn");
        }
        public IActionResult ChangePassword()
        {
            string uid = GetSession("uid");
            if (uid == null)
            {
                return RedirectToAction("SignIn", "Account");
            }
            return View();
        }
        //public async Task<IActionResult> ChangePassword()
        //{
        //    string uid = GetSession("uid");
        //    ViewBag.giohang = GetSession("dem");
        //    string? session = GetSession("email");
        //    @ViewBag.email = session;
        //    if (GetSession("dem") == null || _context.KhachHangs == null)
        //    {
        //        return RedirectToAction("SignIn", "Account");
        //    }
        //    var accountModel = await _context.KhachHangs.FindAsync(uid);
        //    if (accountModel == null)
        //    {
        //        return NotFound();
        //    }
        //    return View(accountModel);
        //}
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

            var client = new FirebaseAuthClient(config);
            try
            {
                var result = await client.SignInWithEmailAndPasswordAsync(email, oldPassword);

                if (result != null)
                {
                    await result.User.ChangePasswordAsync(newPassword);
                    ViewBag.success = "Đổi mật khẩu thành công";
                    return View();
                }

                ViewBag.error = "Đổi mật khẩu không thành công. Vui lòng kiểm tra lại mật khẩu cũ.";
                return View();
            }
            catch (Exception ex)
            {
                // Log the exception (ex) for further analysis
                ViewBag.error = "Có lỗi xảy ra khi đổi mật khẩu. Vui lòng thử lại.";
                return View();
            }
        }

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

            var client = new FirebaseAuthClient(config);
            try
            {
                await client.ResetEmailPasswordAsync(email);
                ViewBag.notice = "Vui lòng kiểm tra email để đổi mật khẩu.";
                return View();
            }
            catch (Exception ex)
            {
                // Log the exception for further analysis (you can use a logging framework)
                ViewBag.Error = "Có lỗi xảy ra khi gửi yêu cầu đặt lại mật khẩu. Vui lòng thử lại.";
                // Optionally log the exact error message to the logs
                // _logger.LogError(ex, "Error during password reset");
                return View();
            }
        }

        public async Task<IActionResult> Edit(object data)
        {
            string uid = GetSession("uid");
            if (uid == null)
            {
                return RedirectToAction("SignIn", "Account");
            }
            ViewBag.success = data;
            // Xuất nội dung trong Account
            var accountModel = await context.KhachHangs.FindAsync(uid);
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
                try
                {
                    context.Update(accountModel);
                    await context.SaveChangesAsync();
                    TempData["SuccessMessage"] = "Cập nhật thông tin thành công";
                }
                catch (Exception ex)
                {
                    TempData["ErrorMessage"] = "Cập nhật thông tin không thành công";
                    return RedirectToAction("Edit", "Account");
                }
                return RedirectToAction("Edit", "Account");
            }

            return View(accountModel);
        }


        //private bool KhachHangModelExists(string id)
        //{
        //    return _context.KhachHangs.Any(e => e.Id_KhachHang == id);
        //}
        public async Task<IActionResult> History()
        {
            // Kiểm tra Session và lấy thông tin
            var email = HttpContext.Session.GetString("email");
            var uid = HttpContext.Session.GetString("uid");

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(uid))
            {
                // Nếu session không có dữ liệu, điều hướng đến trang đăng nhập hoặc thông báo lỗi
                return RedirectToAction("SignIn", "Account");
            }

            // Lấy danh sách đơn hàng vận chuyển
            var donHangVanChuyenModel = await context.DonHangVanChuyens
                .Where(ct => ct.DonHang.Id_KhachHang == uid)
                .Include(p => p.TrangThaiVanChuyen)
                .Include(p => p.DonHang)
                .Include(p => p.PhuongThucThanhToan)
                .OrderByDescending(hd => hd.DonHang.NgayDat) // Sắp xếp theo ngày đặt
                .ToListAsync();

            // Lấy thông tin khách hàng
            var accountModel = await context.KhachHangs.FindAsync(uid);

            // Kiểm tra xem có dữ liệu khách hàng hay không
            if (accountModel == null)
            {
                // Không tìm thấy khách hàng, điều hướng hoặc thông báo lỗi
                return RedirectToAction("Login", "Account");
            }

            // Lấy chi tiết đơn hàng liên quan
            var chiTietDonHangModel = await context.ChiTietDonHangs
                .Include(ct => ct.DungCu) // Bao gồm các thông tin về dụng cụ liên quan
                .Where(ct => donHangVanChuyenModel.Select(dh => dh.DonHang.Id_DonHang).Contains(ct.Id_DonHang))
                .ToListAsync();

            // Tạo đối tượng ViewModel để truyền dữ liệu đến View
            var result = new HistoryViewModel
            {
                khachHangModel = accountModel,
                donHangModel = donHangVanChuyenModel.Select(dh => dh.DonHang).ToList(),
                chiTietDonHangModel = chiTietDonHangModel,
                donHangVanChuyenModels = donHangVanChuyenModel
            };

            // Trả về View với ViewModel
            return View(result);
        }


        [HttpGet]
        public async Task<IActionResult> CheckLogin()
        {

            var session = GetSession("uid");
            ViewBag.uid = session;

            if (string.IsNullOrEmpty(session))
            {
                return Json(new { signedIn = false });
            }
            return Json(new { signedIn = true });
        }
        public async Task<IActionResult> OrderDetail(string id)
        {
            var session = GetSession("email");
            ViewBag.email = session;

            //if (string.IsNullOrEmpty(session) || HttpContext.Session.GetString("uid") == null)
            //{
            //    return RedirectToAction("SignIn", "Account");
            //}

            var donHang = await context.DonHangs.FindAsync(id);
            if (donHang == null)
            {
                //Trả về View error
                return View("Error", new ErrorViewModel { Message = "Không tìm thấy hóa đơn." });
            }

            var chiTietDonHang = await context.ChiTietDonHangs
                .Where(ct => ct.Id_DonHang == id)
                .Include(p => p.DungCu)
                .ToListAsync();
            if (chiTietDonHang == null || chiTietDonHang.Count == 0)
            {
                return NotFound("Không tìm thấy chi tiết hóa đơn.");
            }
            var donHangVanChuyen = await context.DonHangVanChuyens
                .Where(ct => ct.Id_DonHang == id)
                .Include(p => p.TrangThaiVanChuyen)
                .Include(p => p.PhuongThucThanhToan)
                .FirstOrDefaultAsync();



            var result = new OrderDetailViewModel
            {
                donHangModel = donHang,
                chiTietDonHangModel = chiTietDonHang,
                donHangVanChuyenModel = donHangVanChuyen
            };
            decimal? tongtien = donHang.TongTien;
            decimal? tamtinh = await context.ChiTietDonHangs.Where(ct => ct.Id_DonHang == id).SumAsync(ct => ct.DonGia);
            decimal vat = Math.Round((decimal)((tongtien * 8) / 108), 0);

            //Lấy giá trị giảm
            var magiamgia = donHang.Id_MaGiamGia;
            decimal giatrigiam = 0;
            if (magiamgia != null)
            {
                giatrigiam = (decimal)await context.MaGiamGias.Where(gg => gg.Id_MaGiamGia == magiamgia).Select(gg => gg.GiaTriGiam).FirstOrDefaultAsync();
            }

            ViewBag.tamtinh = HtmlHelpers.FormatCurrency((decimal)tamtinh);
            ViewBag.vat = vat;
            ViewBag.magiamgia = giatrigiam;
            ViewBag.tongtien = tongtien;
            ViewBag.phivanchuyen = donHangVanChuyen?.PhiVanChuyen;
            return View(result);
        }
        public async Task<IActionResult> OrderDetail2(string id)
        {
            var session = GetSession("email");
            ViewBag.email = session;

            //if (string.IsNullOrEmpty(session) || HttpContext.Session.GetString("uid") == null)
            //{
            //    return RedirectToAction("SignIn", "Account");
            //}

            var donHang = await context.DonHangs.FindAsync(id);
            if (donHang == null)
            {
                //Trả về View error
                return View("Error", new ErrorViewModel { Message = "Không tìm thấy hóa đơn." });
            }

            var chiTietDonHang = await context.ChiTietDonHangs
                .Where(ct => ct.Id_DonHang == id)
                .Include(p => p.DungCu)
                .Include(p=>p.DungCu.LoaiDungCu)
                .ToListAsync();
            if (chiTietDonHang == null || chiTietDonHang.Count == 0)
            {
                return NotFound("Không tìm thấy chi tiết hóa đơn.");
            }
            var donHangVanChuyen = await context.DonHangVanChuyens
                .Where(ct => ct.Id_DonHang == id)
                .Include(p => p.TrangThaiVanChuyen)
                .Include(p => p.PhuongThucThanhToan)
                .FirstOrDefaultAsync();



            var result = new OrderDetailViewModel
            {
                donHangModel = donHang,
                chiTietDonHangModel = chiTietDonHang,
                donHangVanChuyenModel = donHangVanChuyen
            };
            decimal? tongtien = donHang.TongTien;
            decimal? tamtinh = await context.ChiTietDonHangs.Where(ct => ct.Id_DonHang == id).SumAsync(ct => ct.DonGia);
            decimal vat = Math.Round((decimal)((tongtien * 8) / 108), 0);

            //Lấy giá trị giảm
            var magiamgia = donHang.Id_MaGiamGia;
            decimal giatrigiam = 0;
            if (magiamgia != null)
            {
                giatrigiam = (decimal)await context.MaGiamGias.Where(gg => gg.Id_MaGiamGia == magiamgia).Select(gg => gg.GiaTriGiam).FirstOrDefaultAsync();
            }

            ViewBag.tamtinh = HtmlHelpers.FormatCurrency((decimal)tamtinh);
            ViewBag.vat = vat;
            ViewBag.magiamgia = giatrigiam;
            ViewBag.tongtien = tongtien;
            ViewBag.phivanchuyen = donHangVanChuyen?.PhiVanChuyen;
            return View(result);
        }
        public IActionResult NewSignIn()
        {
            return View();
        }
        public async Task<IActionResult> DeleteAccount()
        {
            var client = new FirebaseAuthClient(config);
            try
            {
                string? result = HttpContext.Session.GetString("uid");
                if (result != null)
                {
                    var id = HttpContext.Session.GetString("uid");
                    var accountModel = await context.KhachHangs.FindAsync(id);
                    if (accountModel == null)
                    {
                        return NotFound();
                    }
                    context.KhachHangs.Remove(accountModel);
                    await context.SaveChangesAsync();
                    await client.User.DeleteAsync();
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
        private string HandleFirebaseException(Exception ex)
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
            return ("Đã xảy ra lỗi từ phía chúng tôi.");
        }
        private void SetSession(string key, string value)
        {
            HttpContext.Session.Set(key, System.Text.Encoding.UTF8.GetBytes(value));
        }
        private string GetSession(string key)
        {

            return HttpContext.Session.GetString(key);
        }
        [HttpPost]
        [Route("Account/AddToFavorite")]
        public async Task<ActionResult> AddToFavorite(int id)
        {
            // Kiểm tra session để đảm bảo người dùng đã đăng nhập
            var session = HttpContext.Session.GetString("email");
            var uid = HttpContext.Session.GetString("uid");
            if (session == null || uid == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập để thêm sản phẩm vào yêu thích." });
            }

            // Kiểm tra xem sản phẩm đã có trong danh sách yêu thích chưa
            var favorite = await context.YeuThichs
                                         .Where(yt => yt.Id_SanPham == id && yt.Id_KhachHang == uid)
                                         .FirstOrDefaultAsync();
            if (favorite != null)
            {
                return Json(new { success = false, message = "Sản phẩm đã có trong danh sách yêu thích." });
            }

            // Thêm sản phẩm vào danh sách yêu thích
            var yeuthich = new YeuThichModel()
            {
                Id_SanPham = id,
                Id_KhachHang = uid
            };
            context.YeuThichs.Add(yeuthich);
            await context.SaveChangesAsync();

            return Json(new { success = true, message = "Thêm sản phẩm vào yêu thích thành công." });
        }

        [HttpPost]
        [Route("Account/DeleteFavorite/{id}")]
        public async Task<ActionResult> DeleteFavorite(int id)
        {
            // Kiểm tra xem người dùng đã đăng nhập chưa
            var sessionEmail = HttpContext.Session.GetString("email");
            var sessionUid = HttpContext.Session.GetString("uid");

            if (sessionEmail == null || sessionUid == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập để xóa sản phẩm khỏi yêu thích." });
            }

            // Tìm sản phẩm yêu thích trong cơ sở dữ liệu
            var favorite = await context.YeuThichs
                .Where(yt => yt.Id_SanPham == id && yt.Id_KhachHang == sessionUid)
                .FirstOrDefaultAsync();

            if (favorite == null)
            {
                return Json(new { success = false, message = "Sản phẩm không có trong danh sách yêu thích." });
            }

            try
            {
                // Xóa sản phẩm yêu thích khỏi cơ sở dữ liệu
                context.YeuThichs.Remove(favorite);
                await context.SaveChangesAsync();
                return Json(new { success = true, message = "Xóa sản phẩm khỏi yêu thích thành công." });
            }
            catch (Exception ex)
            {
                // Trả về thông báo lỗi chi tiết hơn
                return Json(new { success = false, message = "Đã xảy ra lỗi khi xóa sản phẩm khỏi yêu thích: " + ex.Message });
            }
        }
        public IActionResult FavoriteProduct()
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
            var favorite = context.YeuThichs.Where(yt => yt.Id_KhachHang == uid).Include(yt => yt.SanPham).ToList();
            return View(favorite);
        }
        public IActionResult Notification()
        {
            return View();
        }
    }
}
