using Microsoft.EntityFrameworkCore;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services;

public class StaffService(IStaffRepository repository) : IStaffService
{
    public async Task<IEnumerable<AdminModel>> GetAllAsync()
    {
        return await repository.GetAllAsync();
    }

    public async Task<AdminModel?> GetByUsernameAsync(string username)
    {
        return await repository.GetByUsernameAsync(username);
    }

    public async Task<OperationResult<AdminModel>> CreateAsync(AdminModel model)
    {
        try
        {
            if (await ExistsAsync(model.TenNguoiDung))
            {
                return OperationResult<AdminModel>.FailureResult("Tên người dùng đã tồn tại.");
            }

            await repository.AddAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult<AdminModel>.SuccessResult(model);
        }
        catch (Exception ex)
        {
            return OperationResult<AdminModel>.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> UpdateAsync(AdminModel model)
    {
        try
        {
            if (!await ExistsAsync(model.TenNguoiDung))
            {
                return OperationResult.FailureResult("Không tìm thấy nhân viên.");
            }

            await repository.UpdateAsync(model);
            await repository.SaveChangesAsync();
            return OperationResult.SuccessResult();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!await ExistsAsync(model.TenNguoiDung))
            {
                return OperationResult.FailureResult("Không tìm thấy nhân viên.");
            }
            throw;
        }
        catch (Exception ex)
        {
            return OperationResult.FailureResult(ex.Message);
        }
    }

    public async Task<OperationResult> DeleteAsync(string username)
    {
        try
        {
            var model = await repository.GetByUsernameAsync(username);
            if (model == null)
            {
                return OperationResult.FailureResult("Không tìm thấy nhân viên.");
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

    public async Task<bool> ExistsAsync(string username)
    {
        return await repository.ExistsAsync(e => e.TenNguoiDung == username);
    }
}
