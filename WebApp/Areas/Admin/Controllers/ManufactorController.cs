using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.Areas.Admin.Controllers;

[Area("Admin")]
public class ManufactorController(IManufacturerService manufacturerService) : Controller
{
    // GET: Manufactor
    public async Task<IActionResult> Index()
    {
        return View(await manufacturerService.GetAllAsync());
    }

    // GET: Manufactor/Details/5
    public async Task<IActionResult> Details(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var nhaSanXuatModel = await manufacturerService.GetByIdAsync(id.Value);
        if (nhaSanXuatModel == null)
        {
            return NotFound();
        }

        return View(nhaSanXuatModel);
    }

    // GET: Manufactor/Create
    public IActionResult Create()
    {
        return View();
    }

    // POST: Manufactor/Create
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create([Bind("Id_NhaSanXuat,TenNSX,DiaChi,Email")] NhaSanXuatModel nhaSanXuatModel)
    {
        if (ModelState.IsValid)
        {
            var result = await manufacturerService.CreateAsync(nhaSanXuatModel);
            if (result.Success)
            {
                return RedirectToAction(nameof(Index));
            }
        }
        return View(nhaSanXuatModel);
    }

    // GET: Manufactor/Edit/5
    public async Task<IActionResult> Edit(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var nhaSanXuatModel = await manufacturerService.GetByIdAsync(id.Value);
        if (nhaSanXuatModel == null)
        {
            return NotFound();
        }
        return View(nhaSanXuatModel);
    }

    // POST: Manufactor/Edit/5
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(int id, [Bind("Id_NhaSanXuat,TenNSX,DiaChi,Email")] NhaSanXuatModel nhaSanXuatModel)
    {
        if (id != nhaSanXuatModel.Id_NhaSanXuat)
        {
            return NotFound();
        }

        if (ModelState.IsValid)
        {
            var result = await manufacturerService.UpdateAsync(nhaSanXuatModel);
            if (result.Success)
            {
                return RedirectToAction(nameof(Index));
            }
            return NotFound();
        }
        return View(nhaSanXuatModel);
    }

    // GET: Manufactor/Delete/5
    public async Task<IActionResult> Delete(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var nhaSanXuatModel = await manufacturerService.GetByIdAsync(id.Value);
        if (nhaSanXuatModel == null)
        {
            return NotFound();
        }

        return View(nhaSanXuatModel);
    }

    // POST: Manufactor/Delete/5
    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(int id)
    {
        await manufacturerService.DeleteAsync(id);
        return RedirectToAction(nameof(Index));
    }
}
