using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services;

public interface ISupplierService
{
    Task<IEnumerable<NhaCungCapModel>> GetAllAsync();
    Task<NhaCungCapModel?> GetByIdAsync(int id);
    Task<OperationResult<NhaCungCapModel>> CreateAsync(NhaCungCapModel model);
    Task<OperationResult> UpdateAsync(NhaCungCapModel model);
    Task<OperationResult> DeleteAsync(int id);
    Task<bool> ExistsAsync(int id);
}
