using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.AdminAPIControllers
{
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    public class AdministratorController : ControllerBase
    {
        private readonly IAdministratorService _administratorService;
        private readonly IConfiguration _configuration;

        public AdministratorController(IAdministratorService administratorService, IConfiguration configuration)
        {
            _administratorService = administratorService;
            _configuration = configuration;
        }

        // POST: api/Administrator/Login
        [HttpPost("Login")]
        [AllowAnonymous]
        public async Task<IActionResult> Login(AdminModel adminModel)
        {
            try
            {
                var admin = await _administratorService.AuthenticateAsync(adminModel);
                if (admin != null && admin.Quyen == 1)
                {
                    var token = GenerateJwtToken(admin);

                    return Ok(new { 
                        success = true, 
                        message = "Đăng nhập thành công",
                        token = token.Token,
                        expires = token.Expires,
                        data = new {
                            tenNguoiDung = admin.TenNguoiDung,
                            ten = admin.Ten,
                            email = admin.Email,
                            quyen = admin.Quyen
                        }
                    });
                }

                return Unauthorized(new { success = false, message = "Đăng nhập không thành công!" });
            }
            catch (Exception ex)
            {
                return BadRequest(new { success = false, message = ex.Message });
            }
        }

        // GET: api/Administrator/Dashboard
        [HttpGet("Dashboard")]
        public async Task<IActionResult> GetDashboard([FromQuery] DateTime? fromDate, [FromQuery] DateTime? toDate)
        {
            var data = await _administratorService.GetDashboardAsync(fromDate ?? DateTime.MinValue, toDate ?? DateTime.MinValue);
            return Ok(data);
        }

        // GET: api/Administrator/Product
        [HttpGet("Product")]
        public async Task<ActionResult<IEnumerable<DungCuModel>>> GetProducts([FromQuery] string search = "")
        {
            var products = await _administratorService.GetProductsAsync(search);
            return Ok(products);
        }

        // POST: api/Administrator/Product
        [HttpPost("Product")]
        public async Task<IActionResult> CreateProduct([FromForm] DungCuModel dungCuModel, IFormFile? imageInput = null)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _administratorService.CreateProductAsync(dungCuModel, imageInput);
            if (!result.Success)
            {
                return BadRequest(new { message = result.ErrorMessage });
            }

            return Ok(new { success = true, message = "Tạo sản phẩm thành công" });
        }

        // PUT: api/Administrator/Product/5
        [HttpPut("Product/{id}")]
        public async Task<IActionResult> UpdateProduct(int id, [FromForm] DungCuModel dungCuModel, IFormFile? imageInput = null)
        {
            if (id != dungCuModel.Id_DungCu)
            {
                return BadRequest(new { message = "ID không khớp" });
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _administratorService.UpdateProductAsync(dungCuModel, imageInput);
            if (!result.Success)
            {
                return BadRequest(new { message = result.ErrorMessage });
            }

            return Ok(new { success = true, message = "Cập nhật sản phẩm thành công" });
        }

        // DELETE: api/Administrator/Product/5
        [HttpDelete("Product/{id}")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            var result = await _administratorService.SoftDeleteProductAsync(id);
            if (!result.Success)
            {
                return BadRequest(new { message = result.ErrorMessage });
            }

            return Ok(new { success = true, message = "Xóa sản phẩm thành công" });
        }

        // GET: api/Administrator/Category
        [HttpGet("Category")]
        public async Task<IActionResult> GetCategories()
        {
            var categories = await _administratorService.GetCategoriesAsync();
            return Ok(categories);
        }

        // POST: api/Administrator/Category
        [HttpPost("Category")]
        public async Task<IActionResult> CreateCategory([FromBody] string tenLoaiDungCu)
        {
            var result = await _administratorService.CreateCategoryAsync(tenLoaiDungCu);
            if (!result.Success)
            {
                return BadRequest(new { message = result.ErrorMessage });
            }

            return Ok(new { success = true, message = "Tạo danh mục thành công" });
        }

        // DELETE: api/Administrator/Category/5
        [HttpDelete("Category/{id}")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            var result = await _administratorService.DeleteCategoryAsync(id);
            if (!result.Success)
            {
                return BadRequest(new { message = result.ErrorMessage });
            }

            return Ok(new { success = true, message = "Xóa danh mục thành công" });
        }

        // GET: api/Administrator/SaleOff
        [HttpGet("SaleOff")]
        public async Task<IActionResult> GetSaleOffs()
        {
            await _administratorService.ApplySaleOffAsync();
            var saleOffs = await _administratorService.GetSaleOffsAsync();
            return Ok(saleOffs);
        }

        // POST: api/Administrator/SaleOff
        [HttpPost("SaleOff")]
        public async Task<IActionResult> CreateSaleOff(KhuyenMaiModel khuyenMai)
        {
            var result = await _administratorService.CreateSaleOffAsync(khuyenMai);
            if (!result.Success)
            {
                return BadRequest(new { message = result.ErrorMessage });
            }

            return Ok(new { success = true, message = "Tạo khuyến mãi thành công", id = khuyenMai.Id_KhuyenMai });
        }

        // DELETE: api/Administrator/SaleOff/5
        [HttpDelete("SaleOff/{id}")]
        public async Task<IActionResult> DeleteSaleOff(int id)
        {
            await _administratorService.DeleteSaleOffAsync(id);
            return Ok(new { success = true, message = "Xóa khuyến mãi thành công" });
        }

        // GET: api/Administrator/SaleOff/5/Products
        [HttpGet("SaleOff/{id}/Products")]
        public async Task<IActionResult> GetSaleOffDetails(int id)
        {
            var data = await _administratorService.GetSaleOffDetailAsync(id);
            return Ok(data);
        }

        // POST: api/Administrator/SaleOff/AddProduct
        [HttpPost("SaleOff/AddProduct")]
        public async Task<IActionResult> AddProductToSaleOff(ChiTietKhuyenMaiModel chiTietKhuyenMai)
        {
            var result = await _administratorService.AddProductToSaleOffAsync(chiTietKhuyenMai);
            if (!result.Success)
            {
                return BadRequest(new { success = false, message = result.ErrorMessage });
            }
            return Ok(new { success = true });
        }

        // DELETE: api/Administrator/SaleOff/5/Product/10
        [HttpDelete("SaleOff/{idKhuyenMai}/Product/{idCTKM}")]
        public async Task<IActionResult> DeleteProductSaleOff(int idKhuyenMai, int idCTKM)
        {
            await _administratorService.DeleteProductSaleOffAsync(idKhuyenMai, idCTKM);
            return Ok(new { success = true, message = "Xóa sản phẩm khỏi khuyến mãi thành công" });
        }

        // POST: api/Administrator/SaleOff/Apply
        [HttpPost("SaleOff/Apply")]
        public async Task<IActionResult> ApplySaleOff()
        {
            var result = await _administratorService.ApplySaleOffAsync();
            if (!result.Success)
            {
                return BadRequest(new { success = false, message = result.ErrorMessage });
            }

            return Ok(new { success = true });
        }

        // GET: api/Administrator/Voucher
        [HttpGet("Voucher")]
        public async Task<IActionResult> GetVouchers()
        {
            var vouchers = await _administratorService.GetVouchersAsync();
            return Ok(vouchers);
        }

        // POST: api/Administrator/Voucher
        [HttpPost("Voucher")]
        public async Task<IActionResult> CreateVoucher(MaGiamGiaModel maGiamGia)
        {
            var result = await _administratorService.CreateVoucherAsync(maGiamGia);
            if (!result.Success)
            {
                return BadRequest(new { message = result.ErrorMessage });
            }

            return Ok(new { success = true, message = "Tạo voucher thành công" });
        }

        // DELETE: api/Administrator/Voucher/CODE123
        [HttpDelete("Voucher/{id}")]
        public async Task<IActionResult> DeleteVoucher(string id)
        {
            await _administratorService.DeleteVoucherAsync(id);
            return Ok(new { success = true, message = "Xóa voucher thành công" });
        }

        // GET: api/Administrator/Orders
        [HttpGet("Orders")]
        public async Task<IActionResult> GetAllOrders()
        {
            var data = await _administratorService.GetAllOrdersAsync();
            return Ok(data);
        }

        // GET: api/Administrator/Orders/NotDelivered
        [HttpGet("Orders/NotDelivered")]
        public async Task<IActionResult> GetOrdersNotDelivered()
        {
            var data = await _administratorService.GetOrdersNotDeliveredAsync();
            return Ok(data);
        }

        // GET: api/Administrator/Orders/Delivered
        [HttpGet("Orders/Delivered")]
        public async Task<IActionResult> GetOrdersDelivered()
        {
            var data = await _administratorService.GetOrdersDeliveredAsync();
            return Ok(data);
        }

        // GET: api/Administrator/Orders/HD001
        [HttpGet("Orders/{id}")]
        public async Task<IActionResult> GetOrderDetail(string id)
        {
            var result = await _administratorService.GetOrderDetailAsync(id);
            if (!result.Success || result.Data?.ViewModel == null)
            {
                return NotFound(new { message = result.ErrorMessage ?? "Không tìm thấy hóa đơn." });
            }

            return Ok(result.Data);
        }

        // GET: api/Administrator/Banner
        [HttpGet("Banner")]
        public async Task<IActionResult> GetBanners()
        {
            var banners = await _administratorService.GetBannersAsync();
            return Ok(banners);
        }

        // POST: api/Administrator/Banner
        [HttpPost("Banner")]
        public async Task<IActionResult> CreateBanner([FromForm] BannerModel bannerModel, IFormFile? imageInput)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _administratorService.CreateBannerAsync(bannerModel, imageInput);
            if (!result.Success)
            {
                return BadRequest(new { message = result.ErrorMessage });
            }
            return Ok(new { success = true, message = "Tạo banner thành công" });
        }

        // PUT: api/Administrator/Banner/5
        [HttpPut("Banner/{id}")]
        public async Task<IActionResult> UpdateBanner(int id, [FromForm] BannerModel bannerModel, IFormFile? imageInput = null)
        {
            if (id != bannerModel.Id_Banner)
            {
                return BadRequest(new { message = "ID không khớp" });
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _administratorService.UpdateBannerAsync(bannerModel, imageInput);
            if (!result.Success)
            {
                return BadRequest(new { message = result.ErrorMessage });
            }

            return Ok(new { success = true, message = "Cập nhật banner thành công" });
        }

        // DELETE: api/Administrator/Banner/5
        [HttpDelete("Banner/{id}")]
        public async Task<IActionResult> DeleteBanner(int id)
        {
            await _administratorService.DeleteBannerAsync(id);
            return Ok(new { success = true, message = "Xóa banner thành công" });
        }

        // POST: api/Administrator/ChangeStatus
        [HttpPost("ChangeStatus")]
        public async Task<IActionResult> ChangeStatus([FromBody] ChangeStatusRequest request)
        {
            var result = await _administratorService.ChangeStatusAsync(request.Dhvc, request.Value);
            if (!result.Success)
            {
                return BadRequest(new { success = false, error = result.ErrorMessage });
            }

            return Ok(new { success = true });
        }

        // GET: api/Administrator/EarningThisMonth
        [HttpGet("EarningThisMonth")]
        public async Task<IActionResult> GetEarningThisMonth()
        {
            var earnings = await _administratorService.GetEarningThisMonthAsync();
            return Ok(earnings);
        }

        // GET: api/Administrator/ProductFormOptions
        [HttpGet("ProductFormOptions")]
        public async Task<IActionResult> GetProductFormOptions()
        {
            var options = await _administratorService.GetProductFormOptionsAsync();
            return Ok(options);
        }

        private (string Token, DateTime Expires) GenerateJwtToken(AdminModel admin)
        {
            var jwtSection = _configuration.GetSection("Jwt");
            var key = jwtSection["Key"] ?? throw new InvalidOperationException("JWT signing key is missing.");
            var expires = DateTime.UtcNow.AddMinutes(double.TryParse(jwtSection["AccessTokenMinutes"], out var minutes) ? minutes : 120);

            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Sub, admin.TenNguoiDung ?? string.Empty),
                new Claim(JwtRegisteredClaimNames.Email, admin.Email ?? string.Empty),
                new Claim(ClaimTypes.Name, admin.TenNguoiDung ?? string.Empty),
                new Claim(ClaimTypes.Role, "Admin"),
                new Claim("quyen", admin.Quyen.ToString())
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

    public class ChangeStatusRequest
    {
        public int Dhvc { get; set; }
        public int Value { get; set; }
    }
}
