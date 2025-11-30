using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.AdminAPIControllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ManufactorController(AppDbContext context) : ControllerBase
    {
        // GET: api/Manufactor
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NhaSanXuatModel>>> GetAll()
        {
            return await context.NhaSanXuats.ToListAsync();
        }

        // GET: api/Manufactor/5
        [HttpGet("{id}")]
        public async Task<ActionResult<NhaSanXuatModel>> GetById(int id)
        {
            var nhaSanXuatModel = await context.NhaSanXuats
                .FirstOrDefaultAsync(m => m.Id_NhaSanXuat == id);
            
            if (nhaSanXuatModel == null)
            {
                return NotFound(new { message = "Không tìm thấy nhà sản xuất" });
            }

            return nhaSanXuatModel;
        }

        // POST: api/Manufactor
        [HttpPost]
        public async Task<ActionResult<NhaSanXuatModel>> Create(NhaSanXuatModel nhaSanXuatModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            context.Add(nhaSanXuatModel);
            await context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new { id = nhaSanXuatModel.Id_NhaSanXuat }, nhaSanXuatModel);
        }

        // PUT: api/Manufactor/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, NhaSanXuatModel nhaSanXuatModel)
        {
            if (id != nhaSanXuatModel.Id_NhaSanXuat)
            {
                return BadRequest(new { message = "ID không khớp" });
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            context.Entry(nhaSanXuatModel).State = EntityState.Modified;

            try
            {
                await context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NhaSanXuatModelExists(id))
                {
                    return NotFound(new { message = "Không tìm thấy nhà sản xuất" });
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Manufactor/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var nhaSanXuatModel = await context.NhaSanXuats.FindAsync(id);
            if (nhaSanXuatModel == null)
            {
                return NotFound(new { message = "Không tìm thấy nhà sản xuất" });
            }

            context.NhaSanXuats.Remove(nhaSanXuatModel);
            await context.SaveChangesAsync();

            return Ok(new { message = "Xóa thành công" });
        }

        private bool NhaSanXuatModelExists(int id)
        {
            return context.NhaSanXuats.Any(e => e.Id_NhaSanXuat == id);
        }
    }
}
