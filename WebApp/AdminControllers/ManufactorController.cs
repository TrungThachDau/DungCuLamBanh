using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.AdminControllers
{
    public class ManufactorController(AppDbContext context) : Controller
    {
        // GET: Manufactor
        public async Task<IActionResult> Index()
        {
            return View(await context.NhaSanXuats.ToListAsync());
        }

        // GET: Manufactor/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var nhaSanXuatModel = await context.NhaSanXuats
                .FirstOrDefaultAsync(m => m.Id_NhaSanXuat == id);
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
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id_NhaSanXuat,TenNSX,DiaChi,Email")] NhaSanXuatModel nhaSanXuatModel)
        {
            if (ModelState.IsValid)
            {
                context.Add(nhaSanXuatModel);
                await context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
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

            var nhaSanXuatModel = await context.NhaSanXuats.FindAsync(id);
            if (nhaSanXuatModel == null)
            {
                return NotFound();
            }
            return View(nhaSanXuatModel);
        }

        // POST: Manufactor/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
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
                try
                {
                    context.Update(nhaSanXuatModel);
                    await context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!NhaSanXuatModelExists(nhaSanXuatModel.Id_NhaSanXuat))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
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

            var nhaSanXuatModel = await context.NhaSanXuats
                .FirstOrDefaultAsync(m => m.Id_NhaSanXuat == id);
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
            var nhaSanXuatModel = await context.NhaSanXuats.FindAsync(id);
            if (nhaSanXuatModel != null)
            {
                context.NhaSanXuats.Remove(nhaSanXuatModel);
            }

            await context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool NhaSanXuatModelExists(int id)
        {
            return context.NhaSanXuats.Any(e => e.Id_NhaSanXuat == id);
        }
    }
}
