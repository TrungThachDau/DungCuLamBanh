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
    public class FavoriteController : ControllerBase
    {
        private readonly ICustomerService _customerService;
        private readonly IProductService _productService;

        public FavoriteController(ICustomerService customerService, IProductService productService)
        {
            _customerService = customerService;
            _productService = productService;
        }

        private string? GetUid() =>
            User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value
            ?? User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        // GET: api/Favorite
        [HttpGet]
        public async Task<IActionResult> GetFavorites()
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var favorites = await _customerService.GetFavoriteProductsAsync(uid);

            return Ok(new { success = true, data = favorites });
        }

        // POST: api/Favorite/5
        [HttpPost("{productId}")]
        public async Task<IActionResult> AddToFavorite(int productId)
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var result = await _customerService.AddToFavoriteAsync(productId, uid);

            return result
                ? Ok(new { success = true, message = "Đã thêm vào yêu thích." })
                : BadRequest(new { success = false, message = "Không thể thêm vào yêu thích." });
        }

        // DELETE: api/Favorite/5
        [HttpDelete("{productId}")]
        public async Task<IActionResult> RemoveFromFavorite(int productId)
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Unauthorized(new { success = false, message = "Không xác định được tài khoản." });

            var result = await _customerService.RemoveFromFavoriteAsync(productId, uid);

            return result
                ? Ok(new { success = true, message = "Đã xóa khỏi yêu thích." })
                : BadRequest(new { success = false, message = "Không thể xóa khỏi yêu thích." });
        }

        // GET: api/Favorite/check/5
        [HttpGet("check/{productId}")]
        public async Task<IActionResult> CheckFavorite(int productId)
        {
            var uid = GetUid();
            if (string.IsNullOrEmpty(uid))
                return Ok(new { success = true, isFavorite = false });

            var isFavorite = await _productService.IsFavoriteAsync(productId, uid);

            return Ok(new { success = true, isFavorite });
        }
    }
}
