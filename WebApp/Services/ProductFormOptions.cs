using WebDungCuLamBanh.Models;

namespace WebDungCuLamBanh.Services
{
    public class ProductFormOptions
    {
        public List<LoaiDungCuModel> Categories { get; set; } = [];
        public List<NhaCungCapModel> Suppliers { get; set; } = [];
        public List<NhaSanXuatModel> Manufacturers { get; set; } = [];
    }
}
