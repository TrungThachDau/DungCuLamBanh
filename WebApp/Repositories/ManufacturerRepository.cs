using WebDungCuLamBanh.Data;
using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Repositories;

public class ManufacturerRepository(AppDbContext context) : Repository<NhaSanXuatModel>(context), IManufacturerRepository
{
}
