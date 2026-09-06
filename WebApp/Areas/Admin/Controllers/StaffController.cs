using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.Areas.Admin.Controllers;

[Area("Admin")]
public class StaffController(IStaffService staffService) : Controller
{
    // GET: Staff
    public async Task<IActionResult> Index()
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }
        return View(await staffService.GetAllAsync());
    }

    // GET: Staff/Details/5
    public async Task<IActionResult> Details(string id)
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }
        if (string.IsNullOrEmpty(id))
        {
            return NotFound();
        }

        var adminModel = await staffService.GetByUsernameAsync(id);
        if (adminModel == null)
        {
            return NotFound();
        }

        return View(adminModel);
    }

    // GET: Staff/Create
    public IActionResult Create()
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }
        return View();
    }

    // POST: Staff/Create
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create([Bind("TenNguoiDung,MatKhau,Quyen,Ten,Email,DiaChi,SoDienThoai")] AdminModel adminModel)
    {
        if (ModelState.IsValid)
        {
            var result = await staffService.CreateAsync(adminModel);
            if (result.Success)
            {
                return RedirectToAction(nameof(Index));
            }
        }
        return View(adminModel);
    }

    // GET: Staff/Edit/5
    public async Task<IActionResult> Edit(string id)
    {
        if (string.IsNullOrEmpty(id))
        {
            return NotFound();
        }

        var adminModel = await staffService.GetByUsernameAsync(id);
        if (adminModel == null)
        {
            return NotFound();
        }
        return View(adminModel);
    }

    // POST: Staff/Edit/5
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(string id, [Bind("TenNguoiDung,MatKhau,Quyen,Ten,Email,DiaChi,SoDienThoai")] AdminModel adminModel)
    {
        if (id != adminModel.TenNguoiDung)
        {
            return NotFound();
        }

        if (ModelState.IsValid)
        {
            var result = await staffService.UpdateAsync(adminModel);
            if (result.Success)
            {
                return RedirectToAction(nameof(Index));
            }
            return NotFound();
        }
        return View(adminModel);
    }

    // GET: Staff/Delete/5
    public async Task<IActionResult> Delete(string id)
    {
        if (string.IsNullOrEmpty(id))
        {
            return NotFound();
        }

        var adminModel = await staffService.GetByUsernameAsync(id);
        if (adminModel == null)
        {
            return NotFound();
        }

        return View(adminModel);
    }

    // POST: Staff/Delete/5
    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(string id)
    {
        await staffService.DeleteAsync(id);
        return RedirectToAction(nameof(Index));
    }
}
