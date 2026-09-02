using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class SupplierRepository(AppDbContext context) : Repository<NhaCungCapModel>(context), ISupplierRepository
{
}
