using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services;

public interface IManufacturerService
{
    Task<IEnumerable<NhaSanXuatModel>> GetAllAsync();
    Task<NhaSanXuatModel?> GetByIdAsync(int id);
    Task<OperationResult<NhaSanXuatModel>> CreateAsync(NhaSanXuatModel model);
    Task<OperationResult> UpdateAsync(NhaSanXuatModel model);
    Task<OperationResult> DeleteAsync(int id);
    Task<bool> ExistsAsync(int id);
}
