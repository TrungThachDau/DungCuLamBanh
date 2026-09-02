using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services;

public interface IStaffService
{
    Task<IEnumerable<AdminModel>> GetAllAsync();
    Task<AdminModel?> GetByUsernameAsync(string username);
    Task<OperationResult<AdminModel>> CreateAsync(AdminModel model);
    Task<OperationResult> UpdateAsync(AdminModel model);
    Task<OperationResult> DeleteAsync(string username);
    Task<bool> ExistsAsync(string username);
}
