using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services;

public class ManufacturerService(IManufacturerRepository repository) : IManufacturerService
{
    public async Task<IEnumerable<NhaSanXuatModel>> GetAllAsync()
    {
        return await repository.GetAllAsync();
    }

    public async Task<NhaSanXuatModel?> GetByIdAsync(int id)
    {
        return await repository.GetByIdAsync(id);
    }

    public async Task<OperationResult<NhaSanXuatModel>> CreateAsync(NhaSanXuatModel model)
    {
        try
        {
            await repository.AddAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult<NhaSanXuatModel>.SuccessResult(model);
        }
        catch (Exception ex)
        {
            return OperationResult<NhaSanXuatModel>.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> UpdateAsync(NhaSanXuatModel model)
    {
        try
        {
            if (!await ExistsAsync(model.Id_NhaSanXuat))
            {
                return OperationResult.FailureResult("Không tìm thấy nhà sản xuất.");
            }

            await repository.UpdateAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult.SuccessResult();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!await ExistsAsync(model.Id_NhaSanXuat))
            {
                return OperationResult.FailureResult("Không tìm thấy nhà sản xuất.");
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
                return OperationResult.FailureResult("Không tìm thấy nhà sản xuất.");
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
        return await repository.ExistsAsync(e => e.Id_NhaSanXuat == id);
    }
}
