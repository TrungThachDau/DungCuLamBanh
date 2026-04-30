using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.APIControllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HomeDataController : ControllerBase
    {
        private readonly IHomeService _homeService;

        public HomeDataController(IHomeService homeService)
        {
            _homeService = homeService;
        }

        // GET: api/HomeData
        [HttpGet]
        public async Task<IActionResult> GetHomeData()
        {
            var banners = await _homeService.GetBannersAsync();
            var saleOffProducts = await _homeService.GetSaleOffProductsAsync();
            var newProducts = await _homeService.GetNewProductsAsync();
            var discountPercentages = await _homeService.GetDiscountPercentagesAsync();

            return Ok(new
            {
                success = true,
                banners,
                saleOffProducts,
                newProducts,
                discountPercentages
            });
        }

        // GET: api/HomeData/Banners
        [HttpGet("Banners")]
        public async Task<IActionResult> GetBanners()
        {
            var banners = await _homeService.GetBannersAsync();
            return Ok(new { success = true, data = banners });
        }

        // GET: api/HomeData/SaleOff
        [HttpGet("SaleOff")]
        public async Task<IActionResult> GetSaleOffProducts()
        {
            var products = await _homeService.GetSaleOffProductsAsync();
            var discounts = await _homeService.GetDiscountPercentagesAsync();

            return Ok(new { success = true, data = products, discountPercentages = discounts });
        }

        // GET: api/HomeData/NewProducts
        [HttpGet("NewProducts")]
        public async Task<IActionResult> GetNewProducts()
        {
            var products = await _homeService.GetNewProductsAsync();
            return Ok(new { success = true, data = products });
        }
    }
}
