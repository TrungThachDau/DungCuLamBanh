using MailKit.Security;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using MimeKit;
using WebDungCuLamBanh.Models;
using WebDungCuLamBanh.Repositories;

namespace WebDungCuLamBanh.Services
{
    public class CartService(ICartRepository repository, ILogger<CartService> logger) : ICartService
    {
        // Cart Operations
        public async Task<DonHangModel?> GetUnpaidOrderAsync(string customerId)
        {
            return await repository.Orders
                .FirstOrDefaultAsync(hd => hd.Id_KhachHang == customerId && hd.TrangThai == "Chưa thanh toán");
        }

        public async Task<int> GetCartItemCountAsync(string orderId)
        {
            return await repository.OrderDetails
                .Where(p => string.IsNullOrEmpty(orderId) || p.Id_DonHang == orderId)
                .CountAsync();
        }

        public async Task<List<ChiTietDonHangModel>> GetOrderDetailsAsync(string orderId)
        {
            return await repository.OrderDetails
                .Include(p => p.DungCu)
                .Include(p => p.DungCu!.LoaiDungCu)
                .Where(p => string.IsNullOrEmpty(orderId) ? false : p.Id_DonHang == orderId)
                .ToListAsync();
        }

        public async Task<bool> AddToCartAsync(int productId, int quantity, string customerId)
        {
            try
            {
                var product = await repository.Products.FirstOrDefaultAsync(p => p.Id_DungCu == productId);

                if (product == null || product.SoLuong == null || product.SoLuong <= 0)
                {
                    return false;
                }

                decimal? priceAfterDiscount = product.GiaKhuyenMai != 0 ? product.GiaKhuyenMai : product.Gia;

                var order = await GetUnpaidOrderAsync(customerId);

                if (order == null)
                {
                    order = await CreateNewOrderAsync(customerId);
                }

                await AddOrderDetailAsync(productId, quantity, priceAfterDiscount, order);

                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error adding to cart");
                return false;
            }
        }

        private async Task<DonHangModel> CreateNewOrderAsync(string customerId)
        {
            var newOrder = new DonHangModel()
            {
                Id_DonHang = $"{customerId}{DateTime.Now:ddMMyyyyHHmmss}",
                Id_KhachHang = customerId,
                NgayDat = DateTime.Now,
                NgayGiao = DateTime.Now.AddDays(3),
                TrangThai = "Chưa thanh toán",
                TongTien = 0,
                Id_PhuongThucThanhToan = null,
                Id_MaGiamGia = null,
                PhiVanChuyen = 0,
                VAT = 0,
                TienGiamGia = 0,
                TienDiemThuong = 0
            };

            await repository.AddAsync(newOrder);
            await repository.SaveChangesAsync();

            return newOrder;
        }

        private async Task AddOrderDetailAsync(int productId, int quantity, decimal? priceAfterDiscount, DonHangModel order)
        {
            var orderDetail = await repository.OrderDetails
                .FirstOrDefaultAsync(ct => ct.Id_DonHang == order.Id_DonHang && ct.Id_DungCu == productId);

            if (orderDetail != null)
            {
                orderDetail.SoLuong += quantity;
                orderDetail.DonGia = priceAfterDiscount * orderDetail.SoLuong;
                await repository.UpdateAsync(orderDetail);
            }
            else
            {
                var newOrderDetail = new ChiTietDonHangModel()
                {
                    Id_DonHang = order.Id_DonHang,
                    Id_DungCu = productId,
                    SoLuong = quantity,
                    DonGia = priceAfterDiscount * quantity,
                };
                await repository.AddAsync(newOrderDetail);
            }

            await repository.SaveChangesAsync();

            // Update order total
            decimal? totalBeforeTax = await repository.OrderDetails
                .Where(ct => ct.Id_DonHang == order.Id_DonHang)
                .SumAsync(ct => ct.DonGia);

            order.TongTien = totalBeforeTax * 1.08m;
            order.VAT = totalBeforeTax * 0.08m;
            await repository.UpdateAsync(order);
            await repository.SaveChangesAsync();
        }

        public async Task<bool> UpdateQuantityAsync(int orderDetailId, int quantity, string customerId)
        {
            try
            {
                if (quantity < 1)
                {
                    quantity = 1;
                }

                var orderDetail = await repository.OrderDetails
                    .FirstOrDefaultAsync(ct => ct.Id_ChiTietDonHang == orderDetailId);

                if (orderDetail == null)
                {
                    return false;
                }

                var stockQuantity = await repository.Products
                    .Where(sp => sp.Id_DungCu == orderDetail.Id_DungCu)
                    .Select(sp => sp.SoLuong)
                    .FirstOrDefaultAsync();

                var order = await GetUnpaidOrderAsync(customerId);

                if (order == null)
                {
                    return false;
                }

                if (quantity > stockQuantity)
                {
                    return false;
                }

                var discountPrice = await repository.Products
                    .Where(sp => sp.Id_DungCu == orderDetail.Id_DungCu)
                    .Select(sp => sp.GiaKhuyenMai)
                    .FirstOrDefaultAsync();

                var regularPrice = (await repository.Products
                    .FirstOrDefaultAsync(sp => sp.Id_DungCu == orderDetail.Id_DungCu))?.Gia;

                decimal? priceAfterDiscount = (discountPrice != null && discountPrice != 0) ? discountPrice : regularPrice;

                orderDetail.SoLuong = quantity;
                orderDetail.DonGia = priceAfterDiscount * quantity;
                await repository.UpdateAsync(orderDetail);
                await repository.SaveChangesAsync();

                // Update order total
                await UpdateOrderTotalAsync(order);

                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error updating quantity");
                return false;
            }
        }

        public async Task<bool> RemoveFromCartAsync(int orderDetailId, string customerId)
        {
            try
            {
                var order = await GetUnpaidOrderAsync(customerId);

                if (order == null)
                {
                    return false;
                }

                var orderDetail = await repository.OrderDetails
                    .FirstOrDefaultAsync(ct => ct.Id_ChiTietDonHang == orderDetailId);

                if (orderDetail != null)
                {
                    await repository.RemoveAsync(orderDetail);
                    await repository.SaveChangesAsync();

                    await UpdateOrderTotalAsync(order);
                }
                else
                {
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error removing from cart");
                return false;
            }
        }

        private async Task UpdateOrderTotalAsync(DonHangModel order)
        {
            decimal? totalBeforeTax = await repository.OrderDetails
                .Where(ct => ct.Id_DonHang == order.Id_DonHang)
                .SumAsync(ct => ct.DonGia) - order.TienGiamGia;

            if (totalBeforeTax < 0)
            {
                totalBeforeTax = 0;
            }

            order.VAT = totalBeforeTax * 0.08m;
            decimal? totalAfterTax = totalBeforeTax + order.VAT;
            order.TongTien = totalAfterTax ?? 0;

            await repository.UpdateAsync(order);
            await repository.SaveChangesAsync();
        }

        // Checkout
        public async Task<(List<SelectListItem> paymentMethods, KhachHangModel? customer, DonHangModel? order)> GetCheckoutDataAsync(string customerId)
        {
            var customer = await repository.Customers.FirstOrDefaultAsync(kh => kh.Id_KhachHang == customerId);
            var order = await GetUnpaidOrderAsync(customerId);

            var paymentMethods = await repository.PaymentMethods
                .Where(pttt => pttt.TinhTrang == 1)
                .Select(pttt => new SelectListItem
                {
                    Value = pttt.Id_PTTT.ToString(),
                    Text = pttt.TenPTTT
                })
                .ToListAsync();

            return (paymentMethods, customer, order);
        }

        public async Task<decimal?> GetShippingRateAsync(string district)
        {
            var shippingRate = await repository.ShippingRates.FirstOrDefaultAsync(cvc => cvc.KhuVuc == district);

            if (shippingRate == null)
            {
                shippingRate = await repository.ShippingRates.FirstOrDefaultAsync(cvc => cvc.KhuVuc == "Khác");
            }

            return shippingRate?.CuocVanChuyen;
        }

        // Voucher
        public async Task<bool> ApplyVoucherAsync(string voucherCode, string customerId)
        {
            try
            {
                var order = await GetUnpaidOrderAsync(customerId);

                if (order == null)
                {
                    return false;
                }

                var voucher = await repository.Vouchers
                    .FirstOrDefaultAsync(gg => gg.Id_MaGiamGia == voucherCode && gg.LuotSuDung > 0);

                if (voucher == null)
                {
                    return false;
                }

                decimal? discountValue = voucher.GiaTriGiam;
                decimal? totalBeforeTax = await repository.OrderDetails
                    .Where(ct => ct.Id_DonHang == order.Id_DonHang)
                    .SumAsync(ct => ct.DonGia) - discountValue;

                order.VAT = totalBeforeTax * 0.08m;
                totalBeforeTax += order.VAT;

                if (totalBeforeTax < 0)
                {
                    totalBeforeTax = 0;
                }

                order.Id_MaGiamGia = voucherCode;
                order.TienGiamGia = discountValue;
                order.TongTien = totalBeforeTax;

                await repository.UpdateAsync(order);
                await repository.SaveChangesAsync();

                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error applying voucher");
                return false;
            }
        }

        // Payment
        public async Task<OrderDetailViewModel?> ProcessCODPaymentAsync(string customerId, string name, string phone, string email, string address, decimal shippingFee, decimal loyaltyPoints)
        {
            try
            {
                var order = await GetUnpaidOrderAsync(customerId);

                if (order == null)
                {
                    return null;
                }

                var shippingOrder = new DonHangVanChuyenModel()
                {
                    Id_DonHang = order.Id_DonHang,
                    ID_PhuongThucThanhToan = 1,
                    PhiVanChuyen = shippingFee,
                    DiaChiVanChuyen = address,
                    TenKhachHang = name,
                    Email = email,
                    SoDienThoai = phone,
                    TinhTrang = 0
                };

                await repository.AddAsync(shippingOrder);

                order.TrangThai = "Thanh toán khi nhận hàng";
                order.NgayDat = DateTime.Now;
                order.PhiVanChuyen = shippingFee;
                order.Id_PhuongThucThanhToan = 1;
                order.TienDiemThuong = loyaltyPoints;
                order.NgayGiao = DateTime.Now.AddDays(3);

                decimal? totalAmount = order.TongTien + shippingFee - loyaltyPoints;

                if (totalAmount < 0)
                {
                    return null;
                }

                order.TongTien = totalAmount;
                await repository.UpdateAsync(order);

                // Update customer loyalty points
                var customer = await repository.Customers.FirstOrDefaultAsync(kh => kh.Id_KhachHang == customerId);
                if (customer != null)
                {
                    customer.DiemThuong += order.TongTien * 0.1m;
                    await repository.UpdateAsync(customer);
                }

                // Update product stock
                var orderDetails = await repository.OrderDetails
                    .Where(ct => ct.Id_DonHang == order.Id_DonHang)
                    .ToListAsync();

                foreach (var item in orderDetails)
                {
                    var product = await repository.Products.FirstOrDefaultAsync(dc => dc.Id_DungCu == item.Id_DungCu);
                    if (product != null)
                    {
                        product.SoLuong -= item.SoLuong;
                        await repository.UpdateAsync(product);
                    }
                }

                // Update voucher usage
                if (order.Id_MaGiamGia != null)
                {
                    var voucher = await repository.Vouchers.FirstOrDefaultAsync(mgg => mgg.Id_MaGiamGia == order.Id_MaGiamGia);
                    if (voucher != null)
                    {
                        voucher.LuotSuDung -= 1;
                        await repository.UpdateAsync(voucher);
                    }
                }

                await repository.SaveChangesAsync();

                // Prepare order detail view model
                var orderDetailViewModel = new OrderDetailViewModel()
                {
                    chiTietDonHangModel = await repository.OrderDetails
                        .Where(ct => ct.Id_DonHang == order.Id_DonHang)
                        .Include(p => p.DungCu)
                        .ToListAsync(),
                    donHangModel = order,
                    donHangVanChuyenModel = shippingOrder
                };

                return orderDetailViewModel;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error processing COD payment");
                return null;
            }
        }

        // Email
        public async Task SendOrderEmailAsync(OrderDetailViewModel result, string emailTo)
        {
            var email = new MimeMessage();
            email.Sender = new MailboxAddress("Whisk & Flourish", "whiskandflourish@gmail.com");
            email.From.Add(new MailboxAddress("Whisk & Flourish", "whiskandflourish@gmail.com"));
            email.To.Add(MailboxAddress.Parse(emailTo));
            email.Subject = "Thanh toán thành công!";
            
            var builder = new BodyBuilder();
            builder.HtmlBody = BuildEmailBody(result);
            email.Body = builder.ToMessageBody();

            using var smtp = new MailKit.Net.Smtp.SmtpClient();
            try
            {
                smtp.Connect("smtp.gmail.com", 587, SecureSocketOptions.StartTls);
                smtp.Authenticate("whiskandflourish@gmail.com", "zggy nngt azcw dmqc");
                await smtp.SendAsync(email);
            }
            catch (Exception ex)
            {
                System.IO.Directory.CreateDirectory("mailssave");
                var emailsavefile = $"mailssave/{Guid.NewGuid()}.eml";
                await email.WriteToAsync(emailsavefile);
                logger.LogError(ex, "Error sending email");
            }
            smtp.Disconnect(true);
        }

        private string BuildEmailBody(OrderDetailViewModel result)
        {
            var body = "<img src=\"https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/logodai.png?alt=media&token=9b3c82aa-1cc1-4d9d-b642-108ef39da3bd\" height=\"40\" />\r\n";
            body += $"<p>Chào {result.donHangVanChuyenModel.TenKhachHang}!</p>\r\n";
            body += "<p>Cảm ơn bạn đã tin dùng sản phẩm của Whisk & Flourish.</p>\r\n";
            body += "<p>Sau đây là thông tin đơn hàng của bạn.</p>\r\n<hr />";
            
            body += "<table style=\"width:100%\"><tbody>";
            body += $"<tr><td style=\"text-align:left\">Mã đơn hàng:</td><td style=\"text-align:right\">{result.donHangModel.Id_DonHang}</td></tr>";
            body += $"<tr><td style=\"text-align:left\">Ngày đặt hàng:</td><td style=\"text-align:right\">{result.donHangModel.NgayDat}</td></tr>";
            body += $"<tr><td style=\"text-align:left\">Địa chỉ giao:</td><td style=\"text-align:right\">{result.donHangVanChuyenModel.DiaChiVanChuyen}</td></tr>";
            body += $"<tr><td style=\"text-align:left\">Số điện thoại:</td><td style=\"text-align:right\">{result.donHangVanChuyenModel.SoDienThoai}</td></tr>";
            body += "</tbody></table><hr/>";
            
            body += "<p><b>Thông tin về đơn hàng của bạn</b></p>";
            body += "<table style=\"width:100%; border-collapse: collapse;\"><thead><tr>";
            body += "<th style=\"border: 1px solid black;text-align:center\">Tên sản phẩm</th>";
            body += "<th style=\"border: 1px solid black;text-align:center\">Đơn giá</th>";
            body += "<th style=\"border: 1px solid black;text-align:center\">Số lượng</th>";
            body += "<th style=\"border: 1px solid black;text-align:center\">Giá tiền</th>";
            body += "</tr></thead><tbody>";
            
            foreach (var item in result.chiTietDonHangModel)
            {
                body += "<tr>";
                body += $"<td style=\"border: 1px solid black;text-align:center\">{item.DungCu?.TenDungCu}</td>";
                body += $"<td style=\"border: 1px solid black;text-align:center\">{item.DungCu?.Gia}₫</td>";
                body += $"<td style=\"border: 1px solid black;text-align:center\">{item.SoLuong}</td>";
                body += $"<td style=\"border: 1px solid black;text-align:center\">{item.DonGia}₫</td>";
                body += "</tr>";
            }
            
            body += "</tbody></table><hr/>";
            body += "<table style=\"width:100%\"><tbody>";
            body += $"<tr><td>Thuế: </td><td style=\"text-align:right\">{result.donHangModel.VAT}₫</td></tr>";
            body += $"<tr><td>Phí vận chuyển: </td><td style=\"text-align:right\">{result.donHangModel.PhiVanChuyen}₫</td></tr>";
            body += $"<tr><td>Giảm giá bởi mã giảm giá: </td><td style=\"text-align:right\">{result.donHangModel.GiamGia}₫</td></tr>";
            body += $"<tr><td>Giảm giá bởi điểm thưởng: </td><td style=\"text-align:right\">{result.donHangModel.TienDiemThuong}₫</td></tr>";
            body += $"<tr><td><b>Thành tiền: </b></td><td style=\"text-align:right\"><b>{result.donHangModel.TongTien}₫</b></td></tr>";
            body += "</tbody></table>";
            
            body += "<p>Mọi chi tiết liên hệ:</p>";
            body += "<p>Email: contact@whiskandflourish.vn</p>";
            body += "<p>SĐT: +84 36 213 5435</p>";
            body += "<p>© 2024 Whisk & Flourish.</p>";
            
            return body;
        }

        // Helper
        public async Task<KhachHangModel?> GetCustomerAsync(string customerId)
        {
            return await repository.Customers.FirstOrDefaultAsync(k => k.Id_KhachHang == customerId);
        }
    }
}
