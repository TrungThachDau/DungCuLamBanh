using Firebase.Auth;
using Firebase.Auth.Providers;
using MailKit.Security;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using MimeKit;
using System.Text.RegularExpressions;
using WebDungCuLamBanh.Components;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Helpers;
namespace WebDungCuLamBanh.Controllers
{
    [ProfileStatusFilter]
    public class CartController(AppDbContext context, ILogger<AccountController> logger) : Controller
    {
        private readonly ILogger<AccountController> _logger = logger;
        private static readonly FirebaseAuthConfig config = new FirebaseAuthConfig()
        {

            ApiKey = "AIzaSyDByy95_HvWxluru48av1inYpYKWMMhVuI",
            AuthDomain = "qldclb-770f5.firebaseapp.com",
            Providers = new FirebaseAuthProvider[]
            {
                new EmailProvider()
            }
        };

        public async Task<IActionResult> Index(object MyData)
        {
            string maTK = GetSession("uid");
            if (MyData == null)
            {
                ViewData["hoadon"] = null;
                return View();
            }

            var hoadon = await GetUnpaidOrder(maTK);

            if (hoadon == null)
            {
                ViewData["hoadon"] = null;
                return View();
            }

            ViewBag.tongtien = HtmlHelpers.FormatCurrency((decimal)hoadon.TongTien);
            ViewBag.tamtinh = HtmlHelpers.FormatCurrency((decimal)(await context.ChiTietDonHangs
                    .Where(ct => ct.Id_DonHang == hoadon.Id_DonHang)
                    .SumAsync(ct => ct.DonGia)));
            ViewBag.vat = HtmlHelpers.FormatCurrency((decimal)hoadon.VAT);
            ViewBag.dem = await GetCartItemCount(hoadon.Id_DonHang);

            var cthd = await GetOrderDetails(hoadon.Id_DonHang);
            //HttpContext.Session.SetString("dem", ViewBag.dem.ToString());

            return View(cthd);
        }

        private async Task<DonHangModel> GetUnpaidOrder(string maTK)
        {
            return await context.DonHangs
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == maTK && hd.TrangThai == "Chưa thanh toán");
        }

        private async Task<int> GetCartItemCount(string maHD)
        {
            return await context.ChiTietDonHangs
                .Where(p => string.IsNullOrEmpty(maHD) || p.Id_DonHang == maHD)
                .CountAsync();
        }

        private async Task<List<ChiTietDonHangModel>> GetOrderDetails(string maHD)
        {
            return await context.ChiTietDonHangs
                .Include(p => p.DungCu)
                .Include(p => p.DungCu.LoaiDungCu)
                .Where(p => string.IsNullOrEmpty(maHD) ? false : p.Id_DonHang == maHD)
                .ToListAsync();
        }
        [HttpPost]
        public async Task<IActionResult> AddToCart(int? productId, int? quantity)
        {
            string maTK = GetSession("uid");
            string email = GetSession("email");

            if (maTK == null)
            {
                return RedirectToAction("SignIn", "Account");
            }
            if (productId == null || quantity == null)
            {
                return RedirectToAction("Index", "Home");
            }
            var product = await context.DungCus.FirstOrDefaultAsync(p => p.Id_DungCu == productId);

            if (product == null || product.SoLuong == null)
            {
                return RedirectToAction("Detail", "Product", new { id = productId, MyData = "Sản phẩm đã hết hàng" });
            }

            decimal? Giasaukm = product.GiaKhuyenMai != 0 ? product.GiaKhuyenMai : product.Gia;

            var donHang = await GetUnpaidOrder(maTK);

            if (donHang == null)
            {
                donHang = await CreateNewOrder(maTK);
            }

            await AddOrderDetail((int)productId, (int)quantity, (decimal)Giasaukm, donHang);

            // Trả về phản hồi JSON để xác nhận rằng sản phẩm đã được thêm vào giỏ hàng thành công
            return Json(new { success = true });
        }


        private async Task<DonHangModel> CreateNewOrder(string maTK)
        {
            var newOrder = new DonHangModel()
            {
                Id_DonHang = $"{maTK}{DateTime.Now.ToString("ddMMyyyyHHmmss")}",
                Id_KhachHang = maTK,
                NgayDat = DateTime.Now,
                NgayGiao = DateTime.Now.AddDays(3),
                TrangThai = "Chưa thanh toán",
                TongTien = 0,
                Id_PhuongThucThanhToan = null,
                Id_MaGiamGia = null,
                PhiVanChuyen = 0,
                VAT = 0,
                TienGiamGia = 0,
                TienDiemThuong = 0
            };

            context.Add(newOrder);
            await context.SaveChangesAsync();

            return newOrder;
        }

        private async Task AddOrderDetail(int? productId, int? quantity, decimal? Giasaukm, DonHangModel? donHang)
        {
            var orderDetail = new ChiTietDonHangModel()
            {
                Id_DonHang = donHang.Id_DonHang,
                Id_DungCu = productId,
                SoLuong = quantity,
                DonGia = Giasaukm * quantity,
            };
            //kiểm tra nếu sản phẩm đã tồn tại trong giỏ hàng thì cộng thêm số lượng
            var check = await context.ChiTietDonHangs.FirstOrDefaultAsync(ct => ct.Id_DonHang == donHang.Id_DonHang && ct.Id_DungCu == productId);
            if (check != null)
            {
                check.SoLuong += quantity;
                check.DonGia = Giasaukm * check.SoLuong;
                context.Update(check);
                await context.SaveChangesAsync();
            }
            else
            {
                context.ChiTietDonHangs.Add(orderDetail);
                await context.SaveChangesAsync();
            }


            decimal? tongtien = await context.ChiTietDonHangs.Where(ct => ct.Id_DonHang == donHang.Id_DonHang).SumAsync(ct => ct.DonGia);
            donHang.TongTien = tongtien*(decimal)1.08;
            donHang.VAT = tongtien * (decimal)0.08;
            context.Update(donHang);
            await context.SaveChangesAsync();
        }

        public async Task<IActionResult> CheckOut()
        {

            string? maTK = GetSession("uid");

            if (maTK == null)
            {
                return RedirectToAction("SignIn", "Account");
            }
            //Kiểm tra giỏ hàng có sản phẩm không
            //var dem = await _context.ChiTietDonHangs
            //    .Where(ct => ct.Id_DonHang == maTK)
            //    .CountAsync();
            //if (dem == 0)
            //{
            //    return RedirectToAction("Index", "Cart");
            //}    

            var khachHang = await context.KhachHangs.FirstOrDefaultAsync(kh => kh.Id_KhachHang == maTK);
            if (khachHang != null)
            {

                ViewBag.Email = khachHang.Email;
                ViewBag.DiaChi = khachHang.DiaChi;
                ViewBag.SDT = khachHang.SoDienThoai;
                ViewBag.Ten = khachHang.TenKhachHang;
                ViewBag.DiemThuong = khachHang.DiemThuong;
            }
            var hoadon = await context.DonHangs
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == maTK && hd.TrangThai == "Chưa thanh toán");

            ViewData["PTTT"] = context.PTTTs.Where(predicate: pttt => pttt.TinhTrang == 1)
                .Select(pttt => new SelectListItem
                {
                    Value = pttt.Id_PTTT.ToString(),
                    Text = $"{pttt.TenPTTT}"
                })
                .ToList();
            if (hoadon == null)
            {
                return View();
            }
            else
            {

                string? maHD = hoadon.Id_DonHang;
                ViewBag.tamtinh = HtmlHelpers.FormatCurrency((decimal)await context.ChiTietDonHangs
                    .Where(ct => ct.Id_DonHang == maHD)
                    .SumAsync(ct => ct.DonGia));
                ViewBag.giamgia = HtmlHelpers.FormatCurrency((decimal)hoadon.TienGiamGia);
                ViewBag.tongtien = HtmlHelpers.FormatCurrency((decimal)hoadon.TongTien);
                ViewBag.vat  = HtmlHelpers.FormatCurrency((decimal)hoadon.VAT);
                int dem = 0;
                //Lấy danh sách sản phẩm trong giỏ hàng
                if (context.ChiTietDonHangs != null)
                {

                    var cthd = await context.ChiTietDonHangs
                        .Include(p => p.DungCu)
                        .Include(p => p.DungCu.LoaiDungCu)
                        .Where(string.IsNullOrEmpty(maHD) ? p => p.Id_DonHang == maHD : p => p.Id_DonHang == maHD)
                        .ToListAsync();
                    dem = await context.ChiTietDonHangs
                    .Where(p => string.IsNullOrEmpty(maHD) || p.Id_DonHang == maHD)
                    .CountAsync();
                    ViewBag.dem = dem;
                    SetSession("dem", dem.ToString());
                    return View(cthd);
                }
                ViewBag.TongTien = hoadon.TongTien;
                return View();
            }
        }
        [HttpPost]
        public async Task<IActionResult> CheckOut(string ten, string sdt, string email, string diachi, int pttt, int dvvc, decimal phivanchuyen, decimal diemthuong)
        {
            // Kiểm tra tính hợp lệ của dữ liệu đầu vào
            if (string.IsNullOrEmpty(ten) || string.IsNullOrEmpty(sdt) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(diachi))
            {
                return Json(new { success = false, error = "Vui lòng nhập đầy đủ thông tin." });
            }
            if (Regex.IsMatch(ten, "[\\d\\W]+\r\n"))
            {
                return Json(new { success = false, error = "Tên không hợp lệ." });
            }
            string maTK = GetSession("uid");


            // Lấy đơn hàng chưa thanh toán của khách hàng
            var hoadon = await context.DonHangs
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == maTK && hd.TrangThai == "Chưa thanh toán");

            if (hoadon == null)
            {
                return Json(new { success = false });
            }
            if (pttt == 1)
            {
                return RedirectToAction("COD_Payment", "Cart", new { phivanchuyen, diachi, ten, email, sdt, diemthuong });
            }
            if (pttt == 3)
            {
                return Json(new { success = true, type = "MoMo" });
            }
            // Tạo đối tượng DonHangVanChuyenModel

            return Json(new { success = false });
        }
        public async Task<IActionResult> COD_Payment(decimal phivanchuyen, string diachi, string ten, string email, string sdt, decimal diemthuong)
        {
            string maTK = GetSession("uid");
            var hoadon = await context.DonHangs
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == maTK && hd.TrangThai == "Chưa thanh toán");
            if (hoadon == null)
            {
                return RedirectToAction("Index", "Cart");
            }
            var donHangVanChuyenModel = new DonHangVanChuyenModel()
            {
                Id_DonHang = hoadon.Id_DonHang,
                ID_PhuongThucThanhToan = 1,
                PhiVanChuyen = phivanchuyen,
                DiaChiVanChuyen = diachi,
                TenKhachHang = ten,
                Email = email,
                SoDienThoai = sdt,
                TinhTrang = 0
            };
            try
            {
                // Thêm đối tượng DonHangVanChuyenModel vào cơ sở dữ liệu
                context.Add(donHangVanChuyenModel);

                // Cập nhật thông tin đơn hàng
                hoadon.TrangThai = "Thanh toán khi nhận hàng";
                hoadon.NgayDat = DateTime.Now;
                hoadon.PhiVanChuyen = phivanchuyen;
                hoadon.Id_PhuongThucThanhToan = 1;
                hoadon.TienDiemThuong = diemthuong;
                hoadon.NgayGiao = DateTime.Now.AddDays(3);
              
                decimal? TienHang =hoadon.TongTien + phivanchuyen - diemthuong;


                decimal? Tongiensauvat = TienHang;
                if (Tongiensauvat<0)
                {
                    return Json(new { success = false, error = "Đã xảy ra sự cố ngoài ý muốn." });
                }
                else
                {
                    hoadon.TongTien=Tongiensauvat;
                }    
                // Tính tổng tiền của đơn hàng
                context.Update(hoadon);

                // Cập nhật thông tin khách hàng về điểm thưởng
                var khachhang = await context.KhachHangs.FirstOrDefaultAsync(kh => kh.Id_KhachHang == maTK);
                if (khachhang != null)
                {
                    khachhang.DiemThuong += (hoadon.TongTien) * (decimal)0.1;
                    context.Update(khachhang);
                }
                //Cập nhật số lượng sản phẩm
                var cthd = await context.ChiTietDonHangs
                    .Where(ct => ct.Id_DonHang == hoadon.Id_DonHang)
                    .ToListAsync();
                foreach (var item in cthd)
                {

                    var dungcu = await context.DungCus.FirstOrDefaultAsync(dc => dc.Id_DungCu == item.Id_DungCu);
                    if (dungcu != null)
                    {
                        dungcu.SoLuong -= item.SoLuong;
                        context.Update(dungcu);
                    }

                }
                //Cập nhật lại số lượng mã giảm có trong kho
                if (hoadon.Id_MaGiamGia != null)
                {
                    var magiamgia = await context.MaGiamGias.FirstOrDefaultAsync(mgg => mgg.Id_MaGiamGia == hoadon.Id_MaGiamGia);
                    if (magiamgia != null)
                    {
                        magiamgia.LuotSuDung -= 1;
                        context.Update(magiamgia);
                    }
                }

                await context.SaveChangesAsync();
                HttpContext.Session.Set("donhang", System.Text.Encoding.UTF8.GetBytes(donHangVanChuyenModel.Id_DonHang));
                var result = new OrderDetailViewModel()
                {
                    chiTietDonHangModel = new List<ChiTietDonHangModel>(),
                    donHangVanChuyenModel = new DonHangVanChuyenModel(),
                    donHangModel = new DonHangModel()
                };

                var ChiTietHoaDonModel = await context.ChiTietDonHangs
                    .Where(ct => ct.Id_DonHang == hoadon.Id_DonHang)
                    .Include(p => p.DungCu)
                    .ToListAsync();

                result.chiTietDonHangModel.AddRange(ChiTietHoaDonModel);
                result.donHangModel = hoadon;
                result.donHangVanChuyenModel = donHangVanChuyenModel;


                SendEmail(result, donHangVanChuyenModel.Email);
                return Json(new { success = true, type = "COD" });
            }
            catch (Exception e)
            {
                // Trả về thông báo lỗi nếu có lỗi xảy ra trong quá trình xử lý
                return Json(new { success = false, error = e.Message });
            }
        }
        private async void SendEmail(OrderDetailViewModel result, string emailTo)
        {
            var email = new MimeMessage();
            email.Sender = new MailboxAddress("Whisk & Flourish", "whiskandflourish@gmail.com");
            email.From.Add(new MailboxAddress("Whisk & Flourish", "whiskandflourish@gmail.com"));
            email.To.Add(MailboxAddress.Parse(emailTo));
            email.Subject = "Thanh toán thành công!";
            var builder = new BodyBuilder();
            builder.HtmlBody = string.Format("<img src=\"https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/logodai.png?alt=media&token=9b3c82aa-1cc1-4d9d-b642-108ef39da3bd\" height=\"40\" />\r\n<p>Chào " + result.donHangVanChuyenModel.TenKhachHang + "!</p>\r\n<p>Cảm ơn bạn đã tin dùng sản phẩm của Whisk & Flourish.</p>\r\n<p>Sau đây là thông tin đơn hàng của bạn.</p>\r\n<hr />");
            builder.HtmlBody += "<table style=\"width:100%\">";
            builder.HtmlBody += "<tbody>";
            builder.HtmlBody += "<tr>\r\n                <td style=\"text-align:left\">Mã đơn hàng:</td>\r\n                <td style=\"text-align:right\">"+result.donHangModel.Id_DonHang+"</td>\r\n            </tr>";
            builder.HtmlBody += "<tr>\r\n                <td style=\"text-align:left\">Ngày đặt hàng:</td>\r\n                <td style=\"text-align:right\">" + result.donHangModel.NgayDat + "</td>\r\n            </tr>";
            builder.HtmlBody += "<tr>\r\n                <td style=\"text-align:left\">Địa chỉ giao:</td>\r\n                <td style=\"text-align:right\">" + result.donHangVanChuyenModel.DiaChiVanChuyen + "</td>\r\n            </tr>";
            builder.HtmlBody += "<tr>\r\n                <td style=\"text-align:left\">Số điện thoại:</td>\r\n                <td style=\"text-align:right\">" + result.donHangVanChuyenModel.SoDienThoai + "</td>\r\n            </tr>";
            builder.HtmlBody += "</tbody>";
            builder.HtmlBody += "</table>";
            builder.HtmlBody += "<hr/>";
            builder.HtmlBody += "<p><b>Thông tin về đơn hàng của bạn</b></p>";
            builder.HtmlBody += "<table style=\"width:100%; border-collapse: collapse;\">";
            builder.HtmlBody += "<thead>";
            builder.HtmlBody += "<tr>";
            builder.HtmlBody += "<th style=\"border: 1px solid black;text-align:center\">Tên sản phẩm</th>";
            builder.HtmlBody += "<th style=\"border: 1px solid black;text-align:center\">Đơn giá</th>";
            builder.HtmlBody += "<th style=\"border: 1px solid black;text-align:center\">Số lượng</th>";
            builder.HtmlBody += "<th style=\"border: 1px solid black;text-align:center\">Giá tiền</th>";
            builder.HtmlBody += "</tr>";
            builder.HtmlBody += "</thead>";
            builder.HtmlBody += "<tbody>";
            foreach (var item in result.chiTietDonHangModel)
            {
                builder.HtmlBody += "<tr>";
                builder.HtmlBody += "<td style=\"border: 1px solid black;text-align:center\">" + item.DungCu.TenDungCu + "</td>";
                builder.HtmlBody += "<td style=\"border: 1px solid black;text-align:center\">" + item.DungCu.Gia + "₫</td>";
                builder.HtmlBody += "<td style=\"border: 1px solid black;text-align:center\">" + item.SoLuong + "</td>";
                builder.HtmlBody += "<td style=\"border: 1px solid black;text-align:center\">" + item.DonGia + "₫</td>";
                builder.HtmlBody += "</tr>";
            }
            builder.HtmlBody += "</tbody>";
            builder.HtmlBody += "</table>";
            builder.HtmlBody += "<hr/>";
            builder.HtmlBody += "<table style=\"width:100%\">\r\n    <tbody>\r\n        <tr>\r\n            <td>Thuế: </td>\r\n            <td style=\"text-align:right\">"+result.donHangModel.VAT+"₫</td>\r\n        </tr>\r\n        <tr>\r\n            <td>Phí vận chuyển: </td>\r\n            <td style=\"text-align:right\">"+result.donHangModel.PhiVanChuyen+ "₫</td>\r\n        </tr>\r\n        <tr>\r\n            <td>Giảm giá bởi mã giảm giá: </td>\r\n            <td style=\"text-align:right\">"+result.donHangModel.GiamGia+ "₫</td>\r\n        </tr>\r\n        <tr>\r\n            <td>Giảm giá bởi điểm thưởng: </td>\r\n            <td style=\"text-align:right\">"+result.donHangModel.TienDiemThuong+ "₫</td>\r\n        </tr>\r\n        <tr>\r\n            <td><b>Thành tiền: </b></td>\r\n            <td style=\"text-align:right\"><b>"+result.donHangModel.TongTien+"₫</b></td>\r\n        </tr>\r\n    </tbody>\r\n</table>";

            builder.HtmlBody += "<p>Mọi chi tiết liên hệ:</p>\r\n<p>Email: contact@whiskandflourish.vn</p>\r\n<p>SĐT: +84 36 213 5435</p>\r\n<p>© 2024 Whisk & Flourish.</p>";
            email.Body = builder.ToMessageBody();
            // dùng SmtpClient của MailKit
            using var smtp = new MailKit.Net.Smtp.SmtpClient();
            try
            {
                smtp.Connect("smtp.gmail.com", 587, SecureSocketOptions.StartTls);
                smtp.Authenticate("whiskandflourish@gmail.com", "zggy nngt azcw dmqc");
                await smtp.SendAsync(email);
            }
            catch (Exception ex)
            {
                // Gửi mail thất bại, nội dung email sẽ lưu vào thư mục mailssave
                System.IO.Directory.CreateDirectory("mailssave");
                var emailsavefile = string.Format(@"mailssave/{0}.eml", Guid.NewGuid());
                await email.WriteToAsync(emailsavefile);
            }
            smtp.Disconnect(true);
        }
        public IActionResult MoMo_Payment()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Delete(int id)
        {
            string maTK = GetSession("uid");

            // Lấy đơn hàng chưa thanh toán của khách hàng
            var hoadon = await context.DonHangs
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == maTK && hd.TrangThai == "Chưa thanh toán");

            if (hoadon == null)
            {
                return Json(new { success = false, error = "Không tìm thấy đơn hàng chưa thanh toán" });
            }

            // Lấy chi tiết đơn hàng cần xóa
            var ct = await context.ChiTietDonHangs
                .FirstOrDefaultAsync(ct => ct.Id_ChiTietDonHang == id);

            if (ct != null)
            {
                // Xóa chi tiết đơn hàng
                context.ChiTietDonHangs.Remove(ct);
                await context.SaveChangesAsync();

                // Cập nhật lại tổng tiền của đơn hàng
                decimal? tongTienTruocVAT = await context.ChiTietDonHangs
                    .Where(ct => ct.Id_DonHang == hoadon.Id_DonHang)
                    .SumAsync(ct => ct.DonGia) - hoadon.TienGiamGia;

                if (tongTienTruocVAT < 0)
                {
                    tongTienTruocVAT = 0;
                }

                // Tính VAT dựa trên tổng tiền trước VAT
                hoadon.VAT = tongTienTruocVAT * (decimal)0.08;

                // Cộng VAT vào tổng tiền để có tổng tiền sau VAT
                decimal? tongTienSauVAT = tongTienTruocVAT + hoadon.VAT;
                hoadon.TongTien = (decimal)tongTienSauVAT;

                // Cập nhật lại hóa đơn
                context.Update(hoadon);
                await context.SaveChangesAsync();
            }
            else
            {
                return Json(new { success = false, error = "Không tìm thấy chi tiết đơn hàng cần xóa" });
            }

            return RedirectToAction("Index", "Cart");
        }


        [HttpPost]
        public async Task<IActionResult> UpdateQuantity(int id, int quantity)
        {
            // Đảm bảo số lượng không nhỏ hơn 1
            if (quantity < 1)
            {
                quantity = 1;
            }

            string? maTK = HttpContext.Session.GetString("uid");

            // Lấy thông tin chi tiết đơn hàng
            var ct = await context.ChiTietDonHangs
                 .FirstOrDefaultAsync(ct => ct.Id_ChiTietDonHang == id);

            if (ct == null)
            {
                return Json(new { success = false, error = "Không tìm thấy chi tiết đơn hàng" });
            }

            // Lấy thông tin sản phẩm từ kho
            int slkho = (int)await context.DungCus
                .Where(sp => sp.Id_DungCu == ct.Id_DungCu)
                .Select(sp => sp.SoLuong)
                .FirstOrDefaultAsync();

            // Lấy thông tin đơn hàng chưa thanh toán của khách hàng
            var hoadon = await context.DonHangs
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == maTK && hd.TrangThai == "Chưa thanh toán");

            if (hoadon == null)
            {
                return Json(new { success = false, error = "Không tìm thấy đơn hàng chưa thanh toán" });
            }

            // Kiểm tra số lượng yêu cầu so với số lượng kho
            if (quantity > slkho)
            {
                quantity = slkho;
                return Json(new { success = false, error = "Số lượng yêu cầu vượt quá số lượng có trong kho" });
            }

            // Lấy giá sau khuyến mãi
            decimal? GiaKM = await context.DungCus
                .Where(sp => sp.Id_DungCu == ct.Id_DungCu)
                .Select(sp => sp.GiaKhuyenMai)
                .FirstOrDefaultAsync();

            decimal? Gia = (await context.DungCus.FirstOrDefaultAsync(sp => sp.Id_DungCu == ct.Id_DungCu)).Gia;

            decimal? Giasaukm = (GiaKM != null && GiaKM != 0) ? GiaKM : Gia;

            // Cập nhật số lượng và đơn giá trong chi tiết đơn hàng
            ct.SoLuong = quantity;
            ct.DonGia = (decimal)(Giasaukm * quantity);
            context.Update(ct);
            await context.SaveChangesAsync();

            // Cập nhật lại tổng tiền hóa đơn
            decimal? tongTienTruocVAT = await context.ChiTietDonHangs
                .Where(ct => ct.Id_DonHang == hoadon.Id_DonHang)
                .SumAsync(ct => ct.DonGia) - hoadon.TienGiamGia;

            if (tongTienTruocVAT < 0)
            {
                tongTienTruocVAT = 0;
            }

            // Tính VAT
            decimal? VAT = tongTienTruocVAT * (decimal)0.08;
            hoadon.VAT = VAT;

            // Cộng VAT vào tổng tiền
            decimal? tongTienSauVAT = tongTienTruocVAT + VAT;
            hoadon.TongTien = (decimal)tongTienSauVAT;

            // Cập nhật thông tin hóa đơn
            context.Update(hoadon);
            await context.SaveChangesAsync();

            return Json(new { success = true, donGia = ct.DonGia, tongTien = hoadon.TongTien });
        }


        [HttpPost]
        public async Task<IActionResult> AddVoucher(string voucher)
        {
            string maTK = GetSession("uid");

            // Lấy đơn hàng chưa thanh toán của khách hàng
            var hoadon = await context.DonHangs
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == maTK && hd.TrangThai == "Chưa thanh toán");

            if (hoadon == null)
            {
                return Json(new { success = false, error = "Không có đơn hàng nào chưa thanh toán" });
            }

            // Lấy thông tin mã giảm giá từ cơ sở dữ liệu
            var giamgia = await context.MaGiamGias
                .FirstOrDefaultAsync(gg => gg.Id_MaGiamGia == voucher&&gg.LuotSuDung>0);

            if (giamgia == null)
            {
                return Json(new { success = false, error = "Không tìm thấy mã" });
            }

            // Tính toán lại tổng tiền và giá trị giảm giá
            decimal? giaTriGiam = (decimal)giamgia.GiaTriGiam;
            decimal? tongTien = (await context.ChiTietDonHangs
                .Where(ct => ct.Id_DonHang == hoadon.Id_DonHang)
                .SumAsync(ct => ct.DonGia)) - giaTriGiam;

            // Tính VAT
            hoadon.VAT = tongTien * (decimal)0.08; // VAT dựa trên tổng tiền trước khi cộng VAT
            tongTien += hoadon.VAT;

            // Đảm bảo tổng tiền không âm
            if (tongTien < 0)
            {
                tongTien = 0;
            }

            // Cập nhật mã giảm giá vào đơn hàng
            hoadon.Id_MaGiamGia = voucher;
            hoadon.TienGiamGia = giaTriGiam;
            hoadon.TongTien = tongTien;
            var tamTinh = await context.ChiTietDonHangs.Where(ct => ct.Id_DonHang == hoadon.Id_DonHang).SumAsync(ct => ct.DonGia);
            var vat = hoadon.VAT;
            //hoadon.TongTien = Math.Round((decimal)tongTien, 0);

            // Lưu thay đổi vào cơ sở dữ liệu
            context.Update(hoadon);
            try
            {
                await context.SaveChangesAsync();
                return Json(new { success = true, vat = vat, giaTriGiam = giaTriGiam, tamTinh = tamTinh });
            }
            catch (Exception e)
            {
                return Json(new { success = false, error = e.Message });
            }
        }



        [HttpGet]
        public async Task<IActionResult> GetCartItemCount()
        {
            try
            {
                string maTK = GetSession("uid");

                // Kiểm tra xem Session 'uid' có rỗng hoặc null không
                if (string.IsNullOrEmpty(maTK))
                {
                    return Json(new { success = false, error = "Session 'uid' is null or empty." });
                }

                // Tìm đơn hàng chưa thanh toán của khách hàng
                var hoadon = await context.DonHangs.FirstOrDefaultAsync(hd => hd.Id_KhachHang == maTK && hd.TrangThai == "Chưa thanh toán");

                // Nếu không có đơn hàng chưa thanh toán, trả về 0
                if (hoadon == null)
                {
                    return Json(new { success = true, dem = 0 });
                }

                // Đếm số lượng sản phẩm trong giỏ hàng của khách hàng
                int dem = await context.ChiTietDonHangs.CountAsync(p => p.Id_DonHang == hoadon.Id_DonHang);

                return Json(new { success = true, dem = dem });
            }
            catch (Exception e)
            {
                return Json(new { success = false, error = e.Message });
            }
        }

        [HttpGet]
        public async Task<ActionResult> LayGiaVanChuyen(string quan)
        {
            try
            {
                // Tình cước vận chuyển dựa trên quận được cung cấp
                // Lấy giá vận chuyển từ cơ sở dữ liệu
                var giaVanChuyen = await context.CuocVanChuyens.FirstOrDefaultAsync(cvc => cvc.KhuVuc == quan);

                if (giaVanChuyen == null)
                {
                    // Nếu không tìm thấy giá vận chuyển cho quận được cung cấp, lấy giá vận chuyển của khu vực 'Khác'
                    giaVanChuyen = await context.CuocVanChuyens.FirstOrDefaultAsync(cvc => cvc.KhuVuc == "Khác");
                }

                if (giaVanChuyen != null)
                {
                    // Trả về giá vận chuyển nếu có
                    return Json(new { success = true, giaVanChuyen = giaVanChuyen.CuocVanChuyen });
                }
                else
                {
                    // Trả về thông báo lỗi nếu không tìm thấy giá vận chuyển cho khu vực được cung cấp
                    return Json(new { success = false, error = "Không tìm thấy giá vận chuyển cho khu vực này." });
                }
            }
            catch (Exception e)
            {
                // Xử lý ngoại lệ nếu có
                return Json(new { success = false, error = e.Message });
            }
        }

        private string GetSession(string key)
        {
            return HttpContext.Session.GetString(key);
        }
        private void SetSession(string key, string value)
        {
            HttpContext.Session.Set(key, System.Text.Encoding.UTF8.GetBytes(value));
        }
        
    }
}

