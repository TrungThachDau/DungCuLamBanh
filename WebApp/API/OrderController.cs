using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.API
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly AppDbContext _context;

        public OrderController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/Order
        [HttpGet("{uid}")]
        public async Task<ActionResult<IEnumerable<DonHangModel>>> GetDonHangs(string uid)
        {
            var donHangs = await _context.DonHangVanChuyens
                .Where(donHangs => donHangs.DonHang.Id_KhachHang == uid)
                .Include(donHangs => donHangs.DonHang)
                .Include(donHangs => donHangs.DonHang.KhachHang)
                .Include(trangThais => trangThais.TrangThaiVanChuyen)
                .OrderByDescending(p=>p.DonHang.NgayDat)
                .ToListAsync();
            // Lấy sản phẩm từ chi tiết đơn hàng
            if(donHangs==null)
            {
                   return NotFound();
            }    

            return Ok(donHangs);
        }

        // GET: api/Order/5
        [HttpGet("OrderDetail/{id}")]
        public async Task<ActionResult<DonHangModel>> GetDonHangModel(string id)
        {
            var donHangModel = await _context.DonHangs.FindAsync(id);

            if (donHangModel == null)
            {
                return NotFound();
            }

            return donHangModel;
        }
        private bool DonHangModelExists(string id)
        {
            return _context.DonHangs.Any(e => e.Id_DonHang == id);
        }
    }
}
