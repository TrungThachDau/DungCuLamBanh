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
    public class CheckTabsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CheckTabsController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/CheckTabs
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CheckTab>>> GetCheckTabs()
        {
            return await _context.CheckTabs.ToListAsync();
        }

        // GET: api/CheckTabs/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CheckTab>> GetCheckTab(int? id)
        {
            var checkTab = await _context.CheckTabs.FindAsync(id);

            if (checkTab == null)
            {
                return NotFound();
            }

            return checkTab;
        }

        // PUT: api/CheckTabs/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCheckTab(int? id, CheckTab checkTab)
        {
            if (id != checkTab.Id)
            {
                return BadRequest();
            }

            _context.Entry(checkTab).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CheckTabExists(id))
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

        // POST: api/CheckTabs
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        //[HttpPost]
        //public async Task<ActionResult<CheckTab>> PostCheckTab(string username, string command)
        //{
        //    var checkTab = new CheckTab
        //    {
        //        Username = username,
        //        Command = command
        //    };
        //    _context.CheckTabs.Add(checkTab);
        //    await _context.SaveChangesAsync();

        //    return CreatedAtAction("GetCheckTab", new { id = checkTab.Id }, checkTab);
        //}
        [HttpPost]
        public async Task<ActionResult<CheckTab>> PostCheckTab([FromBody] CheckTab model)
        {
            if (model == null)
            {
               
            }

            var checkTab = new CheckTab
            {
                Username = model.Username,
                Command = model.Command
            };

            _context.CheckTabs.Add(checkTab);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCheckTab", new { id = checkTab.Id }, checkTab);
        }
        // DELETE: api/CheckTabs/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCheckTab(int? id)
        {
            var checkTab = await _context.CheckTabs.FindAsync(id);
            if (checkTab == null)
            {
                return NotFound();
            }

            _context.CheckTabs.Remove(checkTab);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CheckTabExists(int? id)
        {
            return _context.CheckTabs.Any(e => e.Id == id);
        }
    }
}
