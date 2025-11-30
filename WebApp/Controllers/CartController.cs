using Microsoft.AspNetCore.Mvc;
using System.Text.RegularExpressions;
using WebDungCuLamBanh.Components;
using WebDungCuLamBanh.Services;
using WebDungCuLamBanh.Helpers;

namespace WebDungCuLamBanh.Controllers
{
    [ProfileStatusFilter]
    public class CartController(ICartService cartService, ILogger<CartController> logger) : Controller
    {
        // Cart Index
        public async Task<IActionResult> Index(object MyData)
        {
            string maTK = GetSession("uid");
            
            if (MyData == null)
            {
                ViewData["hoadon"] = null;
                return View();
            }

            var hoadon = await cartService.GetUnpaidOrderAsync(maTK);

            if (hoadon == null)
            {
                ViewData["hoadon"] = null;
                return View();
            }

            ViewBag.tongtien = HtmlHelpers.FormatCurrency((decimal)hoadon.TongTien);
            
            var orderDetails = await cartService.GetOrderDetailsAsync(hoadon.Id_DonHang);
            var tamtinh = orderDetails.Sum(ct => ct.DonGia);
            
            ViewBag.tamtinh = HtmlHelpers.FormatCurrency((decimal)tamtinh);
            ViewBag.vat = HtmlHelpers.FormatCurrency((decimal)hoadon.VAT);
            ViewBag.dem = await cartService.GetCartItemCountAsync(hoadon.Id_DonHang);

            return View(orderDetails);
        }

        // Add to Cart
        [HttpPost]
        public async Task<IActionResult> AddToCart(int? productId, int? quantity)
        {
            string maTK = GetSession("uid");

            if (maTK == null)
            {
                return RedirectToAction("SignIn", "Account");
            }
            
            if (productId == null || quantity == null)
            {
                return RedirectToAction("Index", "Home");
            }

            var result = await cartService.AddToCartAsync((int)productId, (int)quantity, maTK);

            if (!result)
            {
                return RedirectToAction("Detail", "Product", new { id = productId, MyData = "Sản phẩm đã hết hàng" });
            }

            return Json(new { success = true });
        }

        // Checkout
        public async Task<IActionResult> CheckOut()
        {
            string? maTK = GetSession("uid");

            if (maTK == null)
            {
                return RedirectToAction("SignIn", "Account");
            }

            var (paymentMethods, customer, order) = await cartService.GetCheckoutDataAsync(maTK);

            if (customer != null)
            {
                ViewBag.Email = customer.Email;
                ViewBag.DiaChi = customer.DiaChi;
                ViewBag.SDT = customer.SoDienThoai;
                ViewBag.Ten = customer.TenKhachHang;
                ViewBag.DiemThuong = customer.DiemThuong;
            }

            ViewData["PTTT"] = paymentMethods;

            if (order == null)
            {
                return View();
            }

            string? maHD = order.Id_DonHang;
            var orderDetails = await cartService.GetOrderDetailsAsync(maHD);
            var tamtinh = orderDetails.Sum(ct => ct.DonGia);

            ViewBag.tamtinh = HtmlHelpers.FormatCurrency((decimal)tamtinh);
            ViewBag.giamgia = HtmlHelpers.FormatCurrency((decimal)order.TienGiamGia);
            ViewBag.tongtien = HtmlHelpers.FormatCurrency((decimal)order.TongTien);
            ViewBag.vat = HtmlHelpers.FormatCurrency((decimal)order.VAT);
            ViewBag.dem = await cartService.GetCartItemCountAsync(maHD);
            ViewBag.TongTien = order.TongTien;

            SetSession("dem", ViewBag.dem.ToString());

            return View(orderDetails);
        }

        [HttpPost]
        public async Task<IActionResult> CheckOut(string ten, string sdt, string email, string diachi, int pttt, int dvvc, decimal phivanchuyen, decimal diemthuong)
        {
            if (string.IsNullOrEmpty(ten) || string.IsNullOrEmpty(sdt) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(diachi))
            {
                return Json(new { success = false, error = "Vui lòng nhập đầy đủ thông tin." });
            }
            
            if (Regex.IsMatch(ten, "[\\d\\W]+\r\n"))
            {
                return Json(new { success = false, error = "Tên không hợp lệ." });
            }

            string maTK = GetSession("uid");

            if (pttt == 1)
            {
                return RedirectToAction("COD_Payment", "Cart", new { phivanchuyen, diachi, ten, email, sdt, diemthuong });
            }
            
            if (pttt == 3)
            {
                return Json(new { success = true, type = "MoMo" });
            }

            return Json(new { success = false });
        }

        // COD Payment
        public async Task<IActionResult> COD_Payment(decimal phivanchuyen, string diachi, string ten, string email, string sdt, decimal diemthuong)
        {
            string maTK = GetSession("uid");
            
            var result = await cartService.ProcessCODPaymentAsync(maTK, ten, sdt, email, diachi, phivanchuyen, diemthuong);

            if (result == null)
            {
                return Json(new { success = false, error = "Đã xảy ra sự cố ngoài ý muốn." });
            }

            HttpContext.Session.Set("donhang", System.Text.Encoding.UTF8.GetBytes(result.donHangVanChuyenModel.Id_DonHang));

            await cartService.SendOrderEmailAsync(result, email);

            return Json(new { success = true, type = "COD" });
        }

        // MoMo Payment Page
        public IActionResult MoMo_Payment()
        {
            return View();
        }

        // Delete Item from Cart
        [HttpPost]
        public async Task<IActionResult> Delete(int id)
        {
            string maTK = GetSession("uid");
            var result = await cartService.RemoveFromCartAsync(id, maTK);

            if (!result)
            {
                return Json(new { success = false, error = "Không thể xóa sản phẩm" });
            }

            return RedirectToAction("Index", "Cart");
        }

        // Update Quantity
        [HttpPost]
        public async Task<IActionResult> UpdateQuantity(int id, int quantity)
        {
            string? maTK = HttpContext.Session.GetString("uid");

            var result = await cartService.UpdateQuantityAsync(id, quantity, maTK);

            if (!result)
            {
                return Json(new { success = false, error = "Số lượng yêu cầu vượt quá số lượng có trong kho" });
            }

            var order = await cartService.GetUnpaidOrderAsync(maTK);
            var orderDetail = await cartService.GetOrderDetailsAsync(order?.Id_DonHang);
            var updatedDetail = orderDetail.FirstOrDefault(ct => ct.Id_ChiTietDonHang == id);

            return Json(new { success = true, donGia = updatedDetail?.DonGia, tongTien = order?.TongTien });
        }

        // Add Voucher
        [HttpPost]
        public async Task<IActionResult> AddVoucher(string voucher)
        {
            string maTK = GetSession("uid");

            var result = await cartService.ApplyVoucherAsync(voucher, maTK);

            if (!result)
            {
                return Json(new { success = false, error = "Không tìm thấy mã" });
            }

            var order = await cartService.GetUnpaidOrderAsync(maTK);
            var orderDetails = await cartService.GetOrderDetailsAsync(order?.Id_DonHang);
            var tamTinh = orderDetails.Sum(ct => ct.DonGia);
            var vat = order?.VAT;
            var giaTriGiam = order?.TienGiamGia;

            return Json(new { success = true, vat = vat, giaTriGiam = giaTriGiam, tamTinh = tamTinh });
        }

        // Get Cart Item Count
        [HttpGet]
        public async Task<IActionResult> GetCartItemCount()
        {
            try
            {
                string maTK = GetSession("uid");

                if (string.IsNullOrEmpty(maTK))
                {
                    return Json(new { success = false, error = "Session 'uid' is null or empty." });
                }

                var order = await cartService.GetUnpaidOrderAsync(maTK);

                if (order == null)
                {
                    return Json(new { success = true, dem = 0 });
                }

                int dem = await cartService.GetCartItemCountAsync(order.Id_DonHang);

                return Json(new { success = true, dem = dem });
            }
            catch (Exception e)
            {
                return Json(new { success = false, error = e.Message });
            }
        }

        // Get Shipping Rate
        [HttpGet]
        public async Task<ActionResult> LayGiaVanChuyen(string quan)
        {
            try
            {
                var shippingRate = await cartService.GetShippingRateAsync(quan);

                if (shippingRate != null)
                {
                    return Json(new { success = true, giaVanChuyen = shippingRate });
                }
                else
                {
                    return Json(new { success = false, error = "Không tìm thấy giá vận chuyển cho khu vực này." });
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, error = e.Message });
            }
        }

        // Helper Methods
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
