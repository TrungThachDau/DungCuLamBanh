using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services;

public class SupplierService(ISupplierRepository repository) : ISupplierService
{
    public async Task<IEnumerable<NhaCungCapModel>> GetAllAsync()
    {
        return await repository.GetAllAsync();
    }

    public async Task<NhaCungCapModel?> GetByIdAsync(int id)
    {
        return await repository.GetByIdAsync(id);
    }

    public async Task<OperationResult<NhaCungCapModel>> CreateAsync(NhaCungCapModel model)
    {
        try
        {
            await repository.AddAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult<NhaCungCapModel>.SuccessResult(model);
        }
        catch (Exception ex)
        {
            return OperationResult<NhaCungCapModel>.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> UpdateAsync(NhaCungCapModel model)
    {
        try
        {
            if (!await ExistsAsync(model.Id_NhaCungCap))
            {
                return OperationResult.FailureResult("Không tìm thấy nhà cung cấp.");
            }

            await repository.UpdateAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult.SuccessResult();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!await ExistsAsync(model.Id_NhaCungCap))
            {
                return OperationResult.FailureResult("Không tìm thấy nhà cung cấp.");
            }
            throw;
        }
        catch (Exception ex)
        {
            return OperationResult.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> DeleteAsync(int id)
    {
        try
        {
            var model = await repository.GetByIdAsync(id);
            if (model == null)
            {
                return OperationResult.FailureResult("Không tìm thấy nhà cung cấp.");
            }

            await repository.DeleteAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult.SuccessResult();
        }
        catch (Exception ex)
        {
            return OperationResult.FailureResult(ex.Message);
        }
    }

    public async Task<bool> ExistsAsync(int id)
    {
        return await repository.ExistsAsync(e => e.Id_NhaCungCap == id);
    }
}
