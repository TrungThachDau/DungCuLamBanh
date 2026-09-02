using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services;

public interface ICheckTabService
{
    Task<IEnumerable<CheckTab>> GetAllAsync();
    Task<CheckTab?> GetByIdAsync(int? id);
    Task<OperationResult<CheckTab>> CreateAsync(CheckTab model);
    Task<OperationResult> UpdateAsync(CheckTab model);
    Task<OperationResult> DeleteAsync(int? id);
    Task<bool> ExistsAsync(int? id);
}
