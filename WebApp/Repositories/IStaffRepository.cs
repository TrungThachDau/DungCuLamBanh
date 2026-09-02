using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public interface IStaffRepository : IRepository<AdminModel>
{
    Task<AdminModel?> GetByUsernameAsync(string username);
}
