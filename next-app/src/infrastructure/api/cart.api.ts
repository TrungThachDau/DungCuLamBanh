import { fetchApi } from "./client";
import type { CartResponse, CheckoutResponse } from "@/domain/entities";

export const cartApi = {
  getCart: (token: string) =>
    fetchApi<CartResponse>("/api/CustomerCart", { token }),
  addItem: (token: string, productId: number, quantity: number) =>
    fetchApi<{ success: boolean; message: string }>("/api/CustomerCart/AddItem", {
      method: "POST",
      token,
      body: JSON.stringify({ productId, quantity }),
    }),
  updateQuantity: (token: string, orderDetailId: number, quantity: number) =>
    fetchApi<{ success: boolean; donGia: number; tongTien: number }>("/api/CustomerCart/UpdateQuantity", {
      method: "PUT",
      token,
      body: JSON.stringify({ orderDetailId, quantity }),
    }),
  removeItem: (token: string, orderDetailId: number) =>
    fetchApi<{ success: boolean }>(`/api/CustomerCart/RemoveItem/${orderDetailId}`, {
      method: "DELETE",
      token,
    }),
  getItemCount: (token: string) =>
    fetchApi<{ success: boolean; count: number }>("/api/CustomerCart/ItemCount", { token }),
  getCheckout: (token: string) =>
    fetchApi<CheckoutResponse>("/api/CustomerCart/Checkout", { token }),
  applyVoucher: (token: string, voucherCode: string) =>
    fetchApi<{ success: boolean; message: string; vat: number; tienGiamGia: number; tamTinh: number }>(
      "/api/CustomerCart/ApplyVoucher",
      { method: "POST", token, body: JSON.stringify({ voucherCode }) }
    ),
  getShippingRate: (district: string) =>
    fetchApi<{ success: boolean; shippingRate: number }>(`/api/CustomerCart/ShippingRate?district=${encodeURIComponent(district)}`),
  codPayment: (token: string, data: { ten: string; soDienThoai: string; email: string; diaChi: string; phiVanChuyen: number; diemThuong: number }) =>
    fetchApi<{ success: boolean; message: string; orderId: string }>("/api/CustomerCart/CODPayment", {
      method: "POST",
      token,
      body: JSON.stringify(data),
    }),
};
