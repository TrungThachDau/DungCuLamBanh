"use client";

import { useAuth } from "@/lib/auth-context";
import Image from "next/image";
import { cartApi } from "@/lib/api";
import { formatCurrency, getImageUrl } from "@/lib/utils";
import { useEffect, useState } from "react";
import { CartResponse } from "@/lib/types";
import Link from "next/link";

export default function CartPage() {
  const { token, isAnonymous, isLoading: authLoading } = useAuth();
  const [cart, setCart] = useState<CartResponse | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (authLoading) return;
    if (!token) {
      // No token = empty cart (never added anything)
      setLoading(false);
      return;
    }
    loadCart();
  }, [token, authLoading]);

  const loadCart = async () => {
    if (!token) return;
    try {
      const data = await cartApi.getCart(token);
      setCart(data);
    } catch {
      setCart(null);
    } finally {
      setLoading(false);
    }
  };

  const handleUpdateQuantity = async (orderDetailId: number, quantity: number) => {
    if (!token || quantity < 1 || quantity > 10) return;
    try {
      await cartApi.updateQuantity(token, orderDetailId, quantity);
      loadCart();
    } catch (err) {
      alert(err instanceof Error ? err.message : "Lỗi cập nhật số lượng");
    }
  };

  const handleRemoveItem = async (orderDetailId: number) => {
    if (!token) return;
    try {
      await cartApi.removeItem(token, orderDetailId);
      loadCart();
      window.dispatchEvent(new Event("cart-updated"));
    } catch {
      alert("Không thể xóa sản phẩm");
    }
  };

  if (loading || authLoading) {
    return (
      <div className="p-3 sm:p-4 lg:p-8 text-center text-gray-500">Đang tải...</div>
    );
  }

  const isEmpty = !cart?.data || cart.items.length === 0;

  return (
    <div className="p-3 sm:p-4 lg:p-8">
      {/* Progress Steps */}
      <div className="flex items-center justify-center gap-2 mb-6 text-sm">
        <span className="bg-[#f8d9d6] px-4 py-1.5 rounded-[20px] font-bold">1. Chọn sản phẩm</span>
        <span className="text-gray-300">→</span>
        <span className="text-gray-400 px-4 py-1.5">2. Thông tin</span>
        <span className="text-gray-300">→</span>
        <span className="text-gray-400 px-4 py-1.5">3. Thanh toán</span>
        <span className="text-gray-300">→</span>
        <span className="text-gray-400 px-4 py-1.5">4. Thành công</span>
      </div>

      {isEmpty ? (
        <div className="bg-white rounded-[20px] p-12 text-center">
          <p className="text-gray-500 mb-4">Giỏ hàng trống</p>
          <Link href="/products" className="text-black hover:underline font-bold">
            Tiếp tục mua sắm →
          </Link>
        </div>
      ) : (
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Cart Items */}
          <div className="lg:col-span-2 space-y-4">
            {cart!.items.map((item) => (
              <div key={item.id_ChiTietDonHang} className="bg-white rounded-[20px] p-4 flex gap-4">
                <Image
                  src={getImageUrl(item.dungCu?.hinhAnh)}
                  alt={item.dungCu?.tenDungCu || ""}
                  width={96}
                  height={96}
                  quality={15}
                  className="w-24 h-24 object-cover rounded-[20px] flex-shrink-0"
                />
                <div className="flex-1 min-w-0">
                  <Link href={`/products/${item.id_DungCu}`} className="font-bold text-black hover:underline line-clamp-2">
                    {item.dungCu?.tenDungCu}
                  </Link>
                  <p className="text-sm text-red-600 font-bold mt-1">
                    {formatCurrency(item.donGia)}
                  </p>
                  <div className="flex items-center gap-3 mt-2">
                    <div className="flex items-center border rounded-[20px] overflow-hidden">
                      <button
                        onClick={() => handleUpdateQuantity(item.id_ChiTietDonHang, item.soLuong - 1)}
                        className="px-3 py-1 text-black hover:bg-gray-100 font-bold"
                      >-</button>
                      <span className="px-3 py-1 text-sm border-x">{item.soLuong}</span>
                      <button
                        onClick={() => handleUpdateQuantity(item.id_ChiTietDonHang, item.soLuong + 1)}
                        className="px-3 py-1 text-black hover:bg-gray-100 font-bold"
                      >+</button>
                    </div>
                    <button
                      onClick={() => handleRemoveItem(item.id_ChiTietDonHang)}
                      className="text-red-500 text-sm hover:underline"
                    >Xóa</button>
                  </div>
                </div>
              </div>
            ))}
          </div>

          {/* Order Summary */}
          <div className="bg-[#ffd28d] rounded-[20px] p-5 h-fit sticky top-20">
            <h3 className="font-bold text-black mb-4">Tổng đơn hàng</h3>
            <div className="space-y-2 text-sm">
              <div className="flex justify-between">
                <span>Tiền hàng:</span>
                <span className="font-bold">{formatCurrency(cart!.data!.tamTinh)}</span>
              </div>
              <div className="flex justify-between">
                <span>Phí vận chuyển:</span>
                <span className="text-gray-600">Chưa tính</span>
              </div>
              <div className="flex justify-between">
                <span>Thuế VAT (8%):</span>
                <span className="font-bold">{formatCurrency(cart!.data!.vat)}</span>
              </div>
              <hr className="border-gray-500" />
              <div className="flex justify-between text-base font-bold">
                <span>Tổng cộng:</span>
                <span>{formatCurrency(cart!.data!.tongTien)}</span>
              </div>
            </div>
            <Link
              href="/checkout"
              className="block w-full text-center bg-[#212631] text-white py-2.5 rounded-[20px] mt-4 font-bold hover:bg-[#343a46] transition-colors"
            >
              Thanh toán
            </Link>
          </div>
        </div>
      )}
    </div>
  );
}
