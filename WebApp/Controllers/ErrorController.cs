using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Components;

namespace WebDungCuLamBanh.Controllers
{
    [ProfileStatusFilter]
    public class ErrorController : Controller
    {
        [Route("/Error")]
        public IActionResult Error404()
        {
            return View();
        }

    }
}
