
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Components;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.Controllers
{
    [ProfileStatusFilter]
    public class HomeController(ILogger<HomeController> logger, IHomeService homeService) : Controller
    {
        public IActionResult Error404()
        {
            return View();
        }

        public async Task<IActionResult> Index()
        {
            ViewBag.uid = HttpContext.Session.GetString("uid");
            
            ViewData["KhuyenMai"] = await homeService.GetSaleOffProductsAsync();
            ViewData["Banner"] = await homeService.GetBannersAsync();
            ViewData["NewProduct"] = await homeService.GetNewProductsAsync();
            ViewData["PhanTramKM"] = await homeService.GetDiscountPercentagesAsync();

            return View();
        }

        public async Task<IActionResult> SaleOff()
        {
            ViewData["KhuyenMai"] = await homeService.GetSaleOffProductsAsync();
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public IActionResult PaymentSuccess()
        {
            ViewBag.donhang = HttpContext.Session.GetString("donhang");
            return View();
        }

        public IActionResult About()
        {
            return View();
        }

        public async Task<IActionResult> TrackingOrder()
        {
            return View();
        }

        public IActionResult DeliveryPolicy()
        {
            return View();
        }

        public IActionResult MembershipPolicy()
        {
            return View();
        }

        public IActionResult ExchangePolicy()
        {
            return View();
        }
    }
}
