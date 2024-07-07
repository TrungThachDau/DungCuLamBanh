using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.API
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private readonly AppDbContext _context;

        public SanPhamController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/SanPham
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DungCuModel>>> GetDungCus()
        {
            return await _context.DungCus.Where(p=>p.DaXoa==0).ToListAsync();
        }

        // GET: api/SanPham/5
        [HttpGet("{id}")]
        public async Task<ActionResult> GetDungCuModel(int id)
        {
            var dungcu = await _context.DungCus
                .Include(p => p.NhaCungCap)
                .Include(p => p.LoaiDungCu)
                .FirstOrDefaultAsync(p => p.Id_DungCu == id);
            if (dungcu == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(dungcu);
            }
        }

        // PUT: api/SanPham/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDungCuModel(int id, DungCuModel dungCuModel)
        {
            if (id != dungCuModel.Id_DungCu)
            {
                return BadRequest();
            }

            _context.Entry(dungCuModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DungCuModelExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/SanPham
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<DungCuModel>> PostDungCuModel(DungCuModel dungCuModel)
        {
            _context.DungCus.Add(dungCuModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetDungCuModel", new { id = dungCuModel.Id_DungCu }, dungCuModel);
        }

        // DELETE: api/SanPham/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDungCuModel(int id)
        {
            var dungCuModel = await _context.DungCus.FindAsync(id);
            if (dungCuModel == null)
            {
                return NotFound();
            }

            _context.DungCus.Remove(dungCuModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool DungCuModelExists(int id)
        {
            return _context.DungCus.Any(e => e.Id_DungCu == id);
            
        }
        [HttpGet("khuyenmai")]
        public async Task<ActionResult<IEnumerable<DungCuModel>>> GetKhuyenMai()
        {
            return await _context.DungCus.Where(p => p.GiaKhuyenMai > 0).ToListAsync();
        }
        [HttpGet("newproduct")]
        public async Task<ActionResult<IEnumerable<DungCuModel>>> GetNewProduct()
        {
            return await _context.DungCus.OrderByDescending(x => x.Id_DungCu).Take(4).ToListAsync();
        }
        [HttpPost("webhook")]
        public async Task<IActionResult> Webhook([FromBody] JObject request)
        {
            var queryResult = request["queryResult"];
            var intent = queryResult["intent"]["displayName"].ToString();

            if (intent == "FindProduct")
            {
                var productName = queryResult["parameters"]["product"].ToString();
                var responseText = await SearchProduct(productName);

                var response = new
                {
                    fulfillmentText = responseText
                };

                return Ok(response);
            }

            return BadRequest();
        }

        private async Task<string> SearchProduct(string productName)
        {
            var product = _context.DungCus.FirstOrDefault(p => p.TenDungCu.ToLower().Contains(productName.ToLower()));
            if (product != null)
            {
                return await Task.FromResult($"Sản phẩm {product.TenDungCu} có giá {product.Gia} VND.");
            }
            else
            {
                return await Task.FromResult($"Sản phẩm {productName} không tồn tại.");
            }
        }
    }
}
