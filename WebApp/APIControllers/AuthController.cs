using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.APIControllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly ICustomerService _customerService;
        private readonly IConfiguration _configuration;

        public AuthController(ICustomerService customerService, IConfiguration configuration)
        {
            _customerService = customerService;
            _configuration = configuration;
        }

        // POST: api/Auth/SignIn
        [HttpPost("SignIn")]
        public async Task<IActionResult> SignIn([FromBody] SignInRequest request)
        {
            try
            {
                var result = await _customerService.SignInAsync(request.Email, request.Password);

                if (result?.User?.Uid == null)
                {
                    return Unauthorized(new { success = false, message = "Email hoặc mật khẩu không đúng." });
                }

                var customer = await _customerService.GetCustomerAsync(result.User.Uid);
                var token = GenerateJwtToken(result.User.Uid, request.Email, "Customer");

                return Ok(new
                {
                    success = true,
                    token = token.Token,
                    expires = token.Expires,
                    data = new
                    {
                        uid = result.User.Uid,
                        email = request.Email,
                        tenKhachHang = customer?.TenKhachHang,
                        soDienThoai = customer?.SoDienThoai,
                        diaChi = customer?.DiaChi,
                        diemThuong = customer?.DiemThuong
                    }
                });
            }
            catch (Exception ex)
            {
                var message = _customerService.HandleFirebaseException(ex);
                return BadRequest(new { success = false, message });
            }
        }

        // POST: api/Auth/SignUp
        [HttpPost("SignUp")]
        public async Task<IActionResult> SignUp([FromBody] SignUpRequest request)
        {
            try
            {
                var model = new KhachHangModel
                {
                    TenKhachHang = request.TenKhachHang,
                    Email = request.Email,
                    SoDienThoai = request.SoDienThoai,
                    DiaChi = request.DiaChi
                };

                var result = await _customerService.SignUpAsync(model, request.Password);

                if (result?.User?.Uid == null)
                {
                    return BadRequest(new { success = false, message = "Đăng ký không thành công." });
                }

                var token = GenerateJwtToken(result.User.Uid, request.Email, "Customer");

                return Ok(new
                {
                    success = true,
                    token = token.Token,
                    expires = token.Expires,
                    data = new
                    {
                        uid = result.User.Uid,
                        email = request.Email,
                        tenKhachHang = request.TenKhachHang
                    }
                });
            }
            catch (Exception ex)
            {
                var message = _customerService.HandleFirebaseException(ex);
                return BadRequest(new { success = false, message });
            }
        }

        // POST: api/Auth/ChangePassword
        [HttpPost("ChangePassword")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
        {
            try
            {
                var email = User.FindFirst(JwtRegisteredClaimNames.Email)?.Value
                         ?? User.FindFirst(ClaimTypes.Email)?.Value;

                if (string.IsNullOrEmpty(email))
                {
                    return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });
                }

                var result = await _customerService.ChangePasswordAsync(email, request.OldPassword, request.NewPassword);

                return result
                    ? Ok(new { success = true, message = "Đổi mật khẩu thành công." })
                    : BadRequest(new { success = false, message = "Mật khẩu cũ không đúng." });
            }
            catch (Exception ex)
            {
                var message = _customerService.HandleFirebaseException(ex);
                return BadRequest(new { success = false, message });
            }
        }

        // POST: api/Auth/ResetPassword
        [HttpPost("ResetPassword")]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordRequest request)
        {
            try
            {
                var result = await _customerService.ResetPasswordAsync(request.Email);

                return result
                    ? Ok(new { success = true, message = "Email đặt lại mật khẩu đã được gửi." })
                    : BadRequest(new { success = false, message = "Không tìm thấy tài khoản." });
            }
            catch (Exception ex)
            {
                var message = _customerService.HandleFirebaseException(ex);
                return BadRequest(new { success = false, message });
            }
        }

        // GET: api/Auth/Profile
        [HttpGet("Profile")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        public async Task<IActionResult> GetProfile()
        {
            var uid = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value
                   ?? User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(uid))
            {
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });
            }

            var customer = await _customerService.GetCustomerAsync(uid);

            if (customer == null)
            {
                return NotFound(new { success = false, message = "Không tìm thấy khách hàng." });
            }

            return Ok(new { success = true, data = customer });
        }

        // PUT: api/Auth/Profile
        [HttpPut("Profile")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        public async Task<IActionResult> UpdateProfile([FromBody] KhachHangModel model)
        {
            var uid = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value
                   ?? User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(uid))
            {
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });
            }

            model.Id_KhachHang = uid;
            var result = await _customerService.UpdateCustomerAsync(model);

            return result
                ? Ok(new { success = true, message = "Cập nhật thông tin thành công." })
                : BadRequest(new { success = false, message = "Cập nhật thất bại." });
        }

        // DELETE: api/Auth/Account
        [HttpDelete("Account")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        public async Task<IActionResult> DeleteAccount()
        {
            var uid = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value
                   ?? User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (string.IsNullOrEmpty(uid))
            {
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });
            }

            await _customerService.DeleteAccountAsync(uid);
            return Ok(new { success = true, message = "Xóa tài khoản thành công." });
        }

        // POST: api/Auth/SignInAnonymously
        [HttpPost("SignInAnonymously")]
        public async Task<IActionResult> SignInAnonymously()
        {
            try
            {
                var result = await _customerService.SignInAnonymouslyAsync();

                if (result?.User?.Uid == null)
                {
                    return BadRequest(new { success = false, message = "Không thể tạo phiên ẩn danh." });
                }

                var token = GenerateJwtToken(result.User.Uid, string.Empty, "Anonymous");

                return Ok(new
                {
                    success = true,
                    token = token.Token,
                    expires = token.Expires,
                    data = new
                    {
                        uid = result.User.Uid,
                        email = (string?)null,
                        tenKhachHang = (string?)null,
                        isAnonymous = true
                    }
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new { success = false, message = ex.Message });
            }
        }

        private (string Token, DateTime Expires) GenerateJwtToken(string uid, string email, string role)
        {
            var jwtSection = _configuration.GetSection("Jwt");
            var key = jwtSection["Key"] ?? throw new InvalidOperationException("JWT signing key is missing.");
            var expires = DateTime.UtcNow.AddMinutes(double.TryParse(jwtSection["AccessTokenMinutes"], out var minutes) ? minutes : 120);

            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Sub, uid),
                new Claim(JwtRegisteredClaimNames.Email, email ?? string.Empty),
                new Claim(ClaimTypes.NameIdentifier, uid),
                new Claim(ClaimTypes.Email, email ?? string.Empty),
                new Claim(ClaimTypes.Role, role)
            };

            var signingKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(key));
            var credentials = new SigningCredentials(signingKey, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: jwtSection["Issuer"],
                audience: jwtSection["Audience"],
                claims: claims,
                expires: expires,
                signingCredentials: credentials);

            return (new JwtSecurityTokenHandler().WriteToken(token), expires);
        }
    }

    // Request DTOs
    public class SignInRequest
    {
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    public class SignUpRequest
    {
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string? TenKhachHang { get; set; }
        public string? SoDienThoai { get; set; }
        public string? DiaChi { get; set; }
    }

    public class ChangePasswordRequest
    {
        public string OldPassword { get; set; } = string.Empty;
        public string NewPassword { get; set; } = string.Empty;
    }

    public class ResetPasswordRequest
    {
        public string Email { get; set; } = string.Empty;
    }
}
