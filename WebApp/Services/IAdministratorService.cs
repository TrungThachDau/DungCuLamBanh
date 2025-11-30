using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Models.admin;

namespace WebDungCuLamBanh.Services
{
    public interface IAdministratorService
    {
        Task<AdminModel?> AuthenticateAsync(AdminModel adminModel);
        Task<DashboardData> GetDashboardAsync(DateTime fromDate, DateTime toDate);
        Task<List<DungCuModel>> GetProductsAsync(string search);
        Task<ProductFormOptions> GetProductFormOptionsAsync();
        Task<OperationResult<DungCuModel>> CreateProductAsync(DungCuModel dungCuModel, IFormFile? imageInput);
        Task<DungCuModel?> GetProductForEditAsync(int? id);
        Task<OperationResult<DungCuModel>> UpdateProductAsync(DungCuModel dungCuModel, IFormFile? imageInput);
        Task<OperationResult<bool>> SoftDeleteProductAsync(int id);
        Task<CategoryViewModel> GetCategoriesAsync();
        Task<OperationResult<bool>> CreateCategoryAsync(string tenLoaiDungCu);
        Task<OperationResult<bool>> DeleteCategoryAsync(int? id);
        Task<List<KhuyenMaiModel>> GetSaleOffsAsync();
        Task<OperationResult<KhuyenMaiModel>> CreateSaleOffAsync(KhuyenMaiModel khuyenMai);
        Task<OperationResult<bool>> DeleteSaleOffAsync(int? id);
        Task<SaleOffViewData> GetSaleOffDetailAsync(int id);
        Task<OperationResult<bool>> AddProductToSaleOffAsync(ChiTietKhuyenMaiModel chiTietKhuyenMai);
        Task<OperationResult<bool>> DeleteProductSaleOffAsync(int idKhuyenMai, int idCtkm);
        Task<OperationResult<bool>> ApplySaleOffAsync();
        Task<List<MaGiamGiaModel>> GetVouchersAsync();
        Task<OperationResult<bool>> CreateVoucherAsync(MaGiamGiaModel maGiamGia);
        Task<OperationResult<bool>> DeleteVoucherAsync(string? id);
        Task<OrderListData> GetAllOrdersAsync();
        Task<OrderListData> GetOrdersNotDeliveredAsync();
        Task<OrderListData> GetOrdersDeliveredAsync();
        Task<OperationResult<OrderDetailData>> GetOrderDetailAsync(string id);
        Task<List<BannerModel>> GetBannersAsync();
        Task<OperationResult<BannerModel>> CreateBannerAsync(BannerModel banner, IFormFile? imageInput);
        Task<OperationResult<BannerModel>> GetBannerAsync(int? id);
        Task<OperationResult<BannerModel>> UpdateBannerAsync(BannerModel banner, IFormFile? imageInput);
        Task<OperationResult<bool>> DeleteBannerAsync(int? id);
        Task<OperationResult<bool>> ChangeStatusAsync(int dhvc, int value);
        Task<List<decimal>> GetEarningThisMonthAsync();
    }
}
