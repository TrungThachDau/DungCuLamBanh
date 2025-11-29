
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Components;
namespace WebDungCuLamBanh.Controllers
{
    [ProfileStatusFilter]
    public class HomeController(ILogger<HomeController> logger, AppDbContext context) : Controller
    {
        private readonly ILogger<HomeController> _logger = logger;


        //chuyen chuyen ve error404 khi khong co view

        public IActionResult Error404()
        {

            return View();
        }
        public async Task<IActionResult> Index()
        {
            ViewBag.uid = HttpContext.Session.GetString("uid");
            var appDbContext = context.BannerModel;
            ViewData["KhuyenMai"]= await context.DungCus.Where(x => x.GiaKhuyenMai > 0&&x.SoLuong>0).Take(4).ToListAsync();
            ViewData["Banner"] = await appDbContext.ToListAsync();
            ViewData["NewProduct"] = await context.DungCus.Where(x=>x.SoLuong>0).OrderByDescending(x => x.Id_DungCu).Take(4).ToListAsync();
            ViewData["PhanTramKM"] = await context.DungCus
                .Where(x => x.GiaKhuyenMai > 0)
                .Select(x => x.GiaKhuyenMai / x.Gia * 100)
                .ToListAsync();

            return View();
        }
        public async Task<IActionResult> SaleOff()
        {

            ViewData["KhuyenMai"] = await context.DungCus.Where(x => x.GiaKhuyenMai > 0&&x.SoLuong>0).ToListAsync();
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
            //Lay cac ViewBag trong payment
            //Lay Id_DonHang từ payment


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
