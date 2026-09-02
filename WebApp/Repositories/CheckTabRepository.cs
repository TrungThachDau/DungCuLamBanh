using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class CheckTabRepository(AppDbContext context) : Repository<CheckTab>(context), ICheckTabRepository
{
}
