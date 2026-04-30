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
    public class CustomerOrderController : ControllerBase
    {
        private readonly ICustomerService _customerService;

        public CustomerOrderController(ICustomerService customerService)
        {
            _customerService = customerService;
        }

        private string? GetUid() =>
            User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value
            ?? User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        // GET: api/CustomerOrder/History
        [HttpGet("History")]
        public async Task<IActionResult> GetOrderHistory()
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var history = await _customerService.GetOrderHistoryAsync(uid);

            return Ok(new
            {
                success = true,
                donHang = history.donHangModel,
                chiTietDonHang = history.chiTietDonHangModel,
                donHangVanChuyen = history.donHangVanChuyenModels
            });
        }

        // GET: api/CustomerOrder/Detail/ABC123
        [HttpGet("Detail/{orderId}")]
        public async Task<IActionResult> GetOrderDetail(string orderId)
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var detail = await _customerService.GetOrderDetailAsync(orderId);

            if (detail == null)
                return NotFound(new { success = false, message = "Không tìm thấy đơn hàng." });

            return Ok(new
            {
                success = true,
                chiTietDonHang = detail.chiTietDonHangModel,
                donHang = detail.donHangModel,
                donHangVanChuyen = detail.donHangVanChuyenModel
            });
        }
    }
}
