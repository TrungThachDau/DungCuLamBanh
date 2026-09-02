using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class StaffRepository(AppDbContext context) : Repository<AdminModel>(context), IStaffRepository
{
    public async Task<AdminModel?> GetByUsernameAsync(string username) =>
        await Context.Admins.FirstOrDefaultAsync(a => a.TenNguoiDung == username);
}
