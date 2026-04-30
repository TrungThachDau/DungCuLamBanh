"use client";

import { useAuth } from "@/lib/auth-context";
import { cartApi } from "@/lib/api";
import { formatCurrency, getImageUrl } from "@/lib/utils";
import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { CheckoutResponse } from "@/lib/types";

export default function CheckoutPage() {
  const { token, isLoading: authLoading } = useAuth();
  const router = useRouter();
  const [checkout, setCheckout] = useState<CheckoutResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [voucher, setVoucher] = useState("");
  const [shippingFee, setShippingFee] = useState(0);
  const [useLoyaltyPoints, setUseLoyaltyPoints] = useState(false);

  const [form, setForm] = useState({
    ten: "",
    soDienThoai: "",
    email: "",
    diaChi: "",
  });

  useEffect(() => {
    if (authLoading) return;
    if (!token) {
      // No token means user hasn't added anything to cart yet
      setLoading(false);
      return;
    }
    loadCheckout();
  }, [token, authLoading]);

  const loadCheckout = async () => {
    if (!token) return;
    try {
      const data = await cartApi.getCheckout(token);
      setCheckout(data);
      if (data.customer) {
        setForm({
          ten: data.customer.tenKhachHang || "",
          soDienThoai: data.customer.soDienThoai || "",
          email: data.customer.email || "",
          diaChi: data.customer.diaChi || "",
        });
      }
    } catch {
      setCheckout(null);
    } finally {
      setLoading(false);
    }
  };

  const handleApplyVoucher = async () => {
    if (!token || !voucher) return;
    try {
      await cartApi.applyVoucher(token, voucher);
      loadCheckout();
    } catch {
      alert("Mã giảm giá không hợp lệ");
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!token || !form.ten || !form.soDienThoai || !form.email || !form.diaChi) {
      alert("Vui lòng nhập đầy đủ thông tin");
      return;
    }

    setSubmitting(true);
    try {
      const result = await cartApi.codPayment(token, {
        ten: form.ten,
        soDienThoai: form.soDienThoai,
        email: form.email,
        diaChi: form.diaChi,
        phiVanChuyen: shippingFee,
        diemThuong: useLoyaltyPoints ? (checkout?.customer?.diemThuong || 0) : 0,
      });

      if (result.success) {
        router.push("/order-success");
      }
    } catch (err) {
      alert(err instanceof Error ? err.message : "Đặt hàng thất bại");
    } finally {
      setSubmitting(false);
    }
  };

  if (loading || authLoading) {
    return <div className="max-w-7xl mx-auto px-4 py-12 text-center text-gray-500">Đang tải...</div>;
  }

  if (!checkout?.order) {
    return (
      <div className="p-3 sm:p-4 lg:p-8 text-center text-gray-500">
        Giỏ hàng trống. <a href="/products" className="text-black hover:underline font-bold">Mua sắm ngay</a>
      </div>
    );
  }

  return (
    <div className="p-3 sm:p-4 lg:p-8">
      {/* Progress Steps */}
      <div className="flex items-center justify-center gap-2 mb-8 text-sm">
        <span className="text-gray-400 px-4 py-1.5">1. Chọn sản phẩm</span>
        <span className="text-gray-300">→</span>
        <span className="text-gray-400 px-4 py-1.5">2. Thông tin</span>
        <span className="text-gray-300">→</span>
        <span className="bg-[#f8d9d6] px-4 py-1.5 rounded-[20px] font-bold">3. Thanh toán</span>
        <span className="text-gray-300">→</span>
        <span className="text-gray-400 px-4 py-1.5">4. Thành công</span>
      </div>

      <form onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 lg:grid-cols-5 gap-6">
          {/* Order Items */}
          <div className="lg:col-span-2 space-y-3">
            <h2 className="font-bold mb-3">Sản phẩm</h2>
            {checkout.items.map((item) => (
              <div key={item.id_ChiTietDonHang} className="bg-white rounded-[20px] p-3 flex gap-3">
                <img
                  src={getImageUrl(item.dungCu?.hinhAnh)}
                  alt={item.dungCu?.tenDungCu || ""}
                  className="w-16 h-16 object-cover rounded-[20px] flex-shrink-0"
                />
                <div className="flex-1 min-w-0">
                  <p className="text-sm line-clamp-1">{item.dungCu?.tenDungCu}</p>
                  <p className="text-xs text-gray-500">SL: {item.soLuong}</p>
                  <p className="text-sm text-red-600 font-bold">{formatCurrency(item.donGia)}</p>
                </div>
              </div>
            ))}
          </div>

          {/* Checkout Form */}
          <div className="lg:col-span-3 space-y-6">
            {/* Contact Info */}
            <div className="bg-white rounded-[20px] p-5 space-y-4">
              <h2 className="font-bold">Thông tin liên hệ</h2>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                  <label className="text-sm mb-1 block">Họ tên</label>
                  <input
                    type="text"
                    value={form.ten}
                    onChange={(e) => setForm({ ...form, ten: e.target.value })}
                    required
                    className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                  />
                </div>
                <div>
                  <label className="text-sm mb-1 block">Số điện thoại</label>
                  <input
                    type="tel"
                    value={form.soDienThoai}
                    onChange={(e) => setForm({ ...form, soDienThoai: e.target.value })}
                    required
                    className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                  />
                </div>
              </div>
              <div>
                <label className="text-sm mb-1 block">Email</label>
                <input
                  type="email"
                  value={form.email}
                  onChange={(e) => setForm({ ...form, email: e.target.value })}
                  required
                  className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                />
              </div>
              <div>
                <label className="text-sm mb-1 block">Địa chỉ giao hàng</label>
                <input
                  type="text"
                  value={form.diaChi}
                  onChange={(e) => setForm({ ...form, diaChi: e.target.value })}
                  required
                  className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                  placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/TP"
                />
              </div>
            </div>

            {/* Voucher */}
            <div className="bg-white rounded-[20px] p-5">
              <h3 className="font-bold mb-3">Mã giảm giá</h3>
              <div className="flex gap-2">
                <input
                  type="text"
                  value={voucher}
                  onChange={(e) => setVoucher(e.target.value)}
                  className="flex-1 border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none"
                  placeholder="Nhập mã giảm giá"
                />
                <button
                  type="button"
                  onClick={handleApplyVoucher}
                  className="bg-[#212631] text-white px-4 py-2.5 rounded-[20px] text-sm font-bold hover:bg-[#343a46]"
                >
                  Áp dụng
                </button>
              </div>
            </div>

            {/* Loyalty Points */}
            {checkout.customer && checkout.customer.diemThuong > 0 && (
              <div className="bg-white rounded-[20px] p-5">
                <label className="flex items-center gap-3 cursor-pointer">
                  <input
                    type="checkbox"
                    checked={useLoyaltyPoints}
                    onChange={(e) => setUseLoyaltyPoints(e.target.checked)}
                    className="w-4 h-4 rounded"
                  />
                  <span className="text-sm">
                    Sử dụng {checkout.customer.diemThuong} điểm thưởng (giảm {formatCurrency(checkout.customer.diemThuong)})
                  </span>
                </label>
              </div>
            )}

            {/* Totals */}
            <div className="bg-[#ffd28d] rounded-[20px] p-5">
              <div className="space-y-2 text-sm">
                <div className="flex justify-between">
                  <span>Tiền hàng:</span>
                  <span className="font-bold">{formatCurrency(checkout.order.tamTinh)}</span>
                </div>
                <div className="flex justify-between">
                  <span>Phí vận chuyển:</span>
                  <span className="font-bold">{shippingFee > 0 ? formatCurrency(shippingFee) : "Miễn phí"}</span>
                </div>
                {checkout.order.tienGiamGia > 0 && (
                  <div className="flex justify-between text-green-700">
                    <span>Giảm giá:</span>
                    <span>-{formatCurrency(checkout.order.tienGiamGia)}</span>
                  </div>
                )}
                <div className="flex justify-between">
                  <span>Thuế VAT (8%):</span>
                  <span className="font-bold">{formatCurrency(checkout.order.vat)}</span>
                </div>
                <hr className="border-gray-500" />
                <div className="flex justify-between text-base font-bold">
                  <span>Tổng cộng:</span>
                  <span>{formatCurrency(checkout.order.tongTien + shippingFee)}</span>
                </div>
              </div>

              <button
                type="submit"
                disabled={submitting}
                className="w-full bg-[#212631] text-white py-3 rounded-[20px] mt-4 font-bold hover:bg-[#343a46] transition-colors disabled:opacity-50"
              >
                {submitting ? "Đang xử lý..." : "Thanh toán (COD)"}
              </button>

              <p className="text-xs text-gray-600 mt-2 text-center">
                Bạn sẽ nhận được 10% điểm thưởng trên tổng đơn hàng
              </p>
            </div>
          </div>
        </div>
      </form>
    </div>
  );
}
