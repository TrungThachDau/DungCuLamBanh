using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services;

public class CheckTabService(ICheckTabRepository repository) : ICheckTabService
{
    public async Task<IEnumerable<CheckTab>> GetAllAsync()
    {
        return await repository.GetAllAsync();
    }

    public async Task<CheckTab?> GetByIdAsync(int? id)
    {
        if (id == null) return null;
        return await repository.GetByIdAsync(id.Value);
    }

    public async Task<OperationResult<CheckTab>> CreateAsync(CheckTab model)
    {
        try
        {
            await repository.AddAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult<CheckTab>.SuccessResult(model);
        }
        catch (Exception ex)
        {
            return OperationResult<CheckTab>.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> UpdateAsync(CheckTab model)
    {
        try
        {
            if (!await ExistsAsync(model.Id))
            {
                return OperationResult.FailureResult("Không tìm thấy CheckTab.");
            }

            await repository.UpdateAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult.SuccessResult();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!await ExistsAsync(model.Id))
            {
                return OperationResult.FailureResult("Không tìm thấy CheckTab.");
            }
            throw;
        }
        catch (Exception ex)
        {
            return OperationResult.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> DeleteAsync(int? id)
    {
        if (id == null) return OperationResult.FailureResult("ID không hợp lệ.");

        try
        {
            var model = await repository.GetByIdAsync(id.Value);
            if (model == null)
            {
                return OperationResult.FailureResult("Không tìm thấy CheckTab.");
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

    public async Task<bool> ExistsAsync(int? id)
    {
        if (id == null) return false;
        return await repository.ExistsAsync(e => e.Id == id.Value);
    }
}
