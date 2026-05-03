using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.APIControllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class CustomerCartController : ControllerBase
    {
        private readonly ICartService _cartService;

        public CustomerCartController(ICartService cartService)
        {
            _cartService = cartService;
        }

        private string? GetUid() =>
            User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value
            ?? User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        // GET: api/CustomerCart
        [HttpGet]
        public async Task<IActionResult> GetCart()
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var order = await _cartService.GetUnpaidOrderAsync(uid);

            if (order == null)
                return Ok(new { success = true, data = (object?)null, items = Array.Empty<object>(), itemCount = 0 });

            var orderDetails = await _cartService.GetOrderDetailsAsync(order.Id_DonHang);
            var itemCount = await _cartService.GetCartItemCountAsync(order.Id_DonHang);
            var tamTinh = orderDetails.Sum(ct => ct.DonGia);

            return Ok(new
            {
                success = true,
                data = new
                {
                    orderId = order.Id_DonHang,
                    tongTien = order.TongTien,
                    vat = order.VAT,
                    tienGiamGia = order.TienGiamGia,
                    tamTinh
                },
                items = orderDetails,
                itemCount
            });
        }

        // POST: api/CustomerCart/AddItem
        [HttpPost("AddItem")]
        public async Task<IActionResult> AddItem([FromBody] AddToCartRequest request)
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var result = await _cartService.AddToCartAsync(request.ProductId, request.Quantity, uid);

            return result
                ? Ok(new { success = true, message = "Đã thêm vào giỏ hàng." })
                : BadRequest(new { success = false, message = "Sản phẩm đã hết hàng." });
        }

        // PUT: api/CustomerCart/UpdateQuantity
        [HttpPut("UpdateQuantity")]
        public async Task<IActionResult> UpdateQuantity([FromBody] UpdateQuantityRequest request)
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var result = await _cartService.UpdateQuantityAsync(request.OrderDetailId, request.Quantity, uid);

            if (!result)
                return BadRequest(new { success = false, message = "Số lượng yêu cầu vượt quá số lượng có trong kho." });

            var order = await _cartService.GetUnpaidOrderAsync(uid);
            var orderDetails = await _cartService.GetOrderDetailsAsync(order?.Id_DonHang);
            var updatedDetail = orderDetails.FirstOrDefault(ct => ct.Id_ChiTietDonHang == request.OrderDetailId);

            return Ok(new { success = true, donGia = updatedDetail?.DonGia, tongTien = order?.TongTien });
        }

        // DELETE: api/CustomerCart/RemoveItem/5
        [HttpDelete("RemoveItem/{orderDetailId}")]
        public async Task<IActionResult> RemoveItem(int orderDetailId)
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var result = await _cartService.RemoveFromCartAsync(orderDetailId, uid);

            return result
                ? Ok(new { success = true, message = "Đã xóa sản phẩm khỏi giỏ hàng." })
                : BadRequest(new { success = false, message = "Không thể xóa sản phẩm." });
        }

        // GET: api/CustomerCart/ItemCount
        [HttpGet("ItemCount")]
        public async Task<IActionResult> GetItemCount()
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Ok(new { success = true, count = 0 });

            var order = await _cartService.GetUnpaidOrderAsync(uid);

            if (order == null)
                return Ok(new { success = true, count = 0 });

            var count = await _cartService.GetCartItemCountAsync(order.Id_DonHang);
            return Ok(new { success = true, count });
        }

        // POST: api/CustomerCart/ApplyVoucher
        [HttpPost("ApplyVoucher")]
        public async Task<IActionResult> ApplyVoucher([FromBody] ApplyVoucherRequest request)
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var result = await _cartService.ApplyVoucherAsync(request.VoucherCode, uid);

            if (!result)
                return BadRequest(new { success = false, message = "Không tìm thấy mã giảm giá." });

            var order = await _cartService.GetUnpaidOrderAsync(uid);
            var orderDetails = await _cartService.GetOrderDetailsAsync(order?.Id_DonHang);
            var tamTinh = orderDetails.Sum(ct => ct.DonGia);

            return Ok(new
            {
                success = true,
                message = "Áp dụng mã giảm giá thành công.",
                vat = order?.VAT,
                tienGiamGia = order?.TienGiamGia,
                tamTinh
            });
        }

        // GET: api/CustomerCart/ShippingRate?district=xxx
        [HttpGet("ShippingRate")]
        [AllowAnonymous]
        public async Task<IActionResult> GetShippingRate([FromQuery] string district)
        {
            var rate = await _cartService.GetShippingRateAsync(district);

            return rate != null
                ? Ok(new { success = true, shippingRate = rate })
                : NotFound(new { success = false, message = "Không tìm thấy giá vận chuyển cho khu vực này." });
        }

        // GET: api/CustomerCart/Checkout
        [HttpGet("Checkout")]
        public async Task<IActionResult> GetCheckoutData()
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var (paymentMethods, customer, order) = await _cartService.GetCheckoutDataAsync(uid);

            if (order == null)
                return Ok(new { success = true, data = (object?)null });

            var orderDetails = await _cartService.GetOrderDetailsAsync(order.Id_DonHang);
            var tamTinh = orderDetails.Sum(ct => ct.DonGia);
            var itemCount = await _cartService.GetCartItemCountAsync(order.Id_DonHang);

            return Ok(new
            {
                success = true,
                customer = customer != null ? new
                {
                    email = customer.Email,
                    diaChi = customer.DiaChi,
                    soDienThoai = customer.SoDienThoai,
                    tenKhachHang = customer.TenKhachHang,
                    diemThuong = customer.DiemThuong
                } : null,
                order = new
                {
                    tongTien = order.TongTien,
                    vat = order.VAT,
                    tienGiamGia = order.TienGiamGia,
                    tamTinh,
                    itemCount
                },
                items = orderDetails,
                paymentMethods = paymentMethods.Select(p => new { value = p.Value, text = p.Text })
            });
        }

        // POST: api/CustomerCart/CODPayment
        [HttpPost("CODPayment")]
        public async Task<IActionResult> ProcessCODPayment([FromBody] CODPaymentRequest request)
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            if (string.IsNullOrEmpty(request.Ten) || string.IsNullOrEmpty(request.SoDienThoai) ||
                string.IsNullOrEmpty(request.Email) || string.IsNullOrEmpty(request.DiaChi))
            {
                return BadRequest(new { success = false, message = "Vui lòng nhập đầy đủ thông tin." });
            }

            var result = await _cartService.ProcessCODPaymentAsync(
                uid, request.Ten.Trim(), request.SoDienThoai.Trim(), request.Email.Trim(),
                request.DiaChi.Trim(), request.PhiVanChuyen, request.DiemThuong);

            if (result == null)
                return BadRequest(new { success = false, message = "Đã xảy ra sự cố ngoài ý muốn." });

            await _cartService.SendOrderEmailAsync(result, request.Email);

            return Ok(new
            {
                success = true,
                message = "Đặt hàng thành công.",
                orderId = result.donHangVanChuyenModel?.Id_DonHang
            });
        }

        // GET: api/CustomerCart/OrderHistory
        [HttpGet("OrderHistory")]
        public async Task<IActionResult> GetOrderHistory()
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var history = await _cartService.GetCustomerAsync(uid);
            return Ok(new { success = true, data = history });
        }
    }

    // Request DTOs
    public class AddToCartRequest
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; } = 1;
    }

    public class UpdateQuantityRequest
    {
        public int OrderDetailId { get; set; }
        public int Quantity { get; set; }
    }

    public class ApplyVoucherRequest
    {
        public string VoucherCode { get; set; } = string.Empty;
    }

    public class CODPaymentRequest
    {
        public string Ten { get; set; } = string.Empty;
        public string SoDienThoai { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string DiaChi { get; set; } = string.Empty;
        public decimal PhiVanChuyen { get; set; }
        public decimal DiemThuong { get; set; }
    }
}
