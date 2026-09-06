using Microsoft.AspNetCore.Mvc;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Services;

namespace WebDungCuLamBanh.Areas.Admin.Controllers;

[Area("Admin")]
public class SupplierController(ISupplierService supplierService) : Controller
{
    // GET: Supplier
    public async Task<IActionResult> Index()
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }
        return View(await supplierService.GetAllAsync());
    }

    // GET: Supplier/Details/5
    public async Task<IActionResult> Details(int? id)
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }
        if (id == null)
        {
            return NotFound();
        }

        var nhaCungCapModel = await supplierService.GetByIdAsync(id.Value);
        if (nhaCungCapModel == null)
        {
            return NotFound();
        }

        return View(nhaCungCapModel);
    }

    // GET: Supplier/Create
    public IActionResult Create()
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }
        return View();
    }

    // POST: Supplier/Create
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create([Bind("Id_NhaCungCap,TenNhaCungCap,DiaChi,SoDienThoai,Email")] NhaCungCapModel nhaCungCapModel)
    {
        if (ModelState.IsValid)
        {
            var result = await supplierService.CreateAsync(nhaCungCapModel);
            if (result.Success)
            {
                return RedirectToAction(nameof(Index));
            }
        }
        return View(nhaCungCapModel);
    }

    // GET: Supplier/Edit/5
    public async Task<IActionResult> Edit(int? id)
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }
        if (id == null)
        {
            return NotFound();
        }

        var nhaCungCapModel = await supplierService.GetByIdAsync(id.Value);
        if (nhaCungCapModel == null)
        {
            return NotFound();
        }
        return View(nhaCungCapModel);
    }

    // POST: Supplier/Edit/5
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(int id, [Bind("Id_NhaCungCap,TenNhaCungCap,DiaChi,SoDienThoai,Email")] NhaCungCapModel nhaCungCapModel)
    {
        if (id != nhaCungCapModel.Id_NhaCungCap)
        {
            return NotFound();
        }

        if (ModelState.IsValid)
        {
            var result = await supplierService.UpdateAsync(nhaCungCapModel);
            if (result.Success)
            {
                return RedirectToAction(nameof(Index));
            }
            return NotFound();
        }
        return View(nhaCungCapModel);
    }

    // GET: Supplier/Delete/5
    public async Task<IActionResult> Delete(int? id)
    {
        if (HttpContext.Session.GetString("admin") == null)
        {
            return RedirectToAction("Index");
        }
        if (id == null)
        {
            return NotFound();
        }

        var nhaCungCapModel = await supplierService.GetByIdAsync(id.Value);
        if (nhaCungCapModel == null)
        {
            return NotFound();
        }

        return View(nhaCungCapModel);
    }

    // POST: Supplier/Delete/5
    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(int id)
    {
        await supplierService.DeleteAsync(id);
        return RedirectToAction(nameof(Index));
    }
}
