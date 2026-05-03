"use client";

import { useAuth } from "@/presentation/contexts/auth-context";
import { orderApi } from "@/infrastructure/api";
import { formatCurrency } from "@/presentation/utils";
import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { OrderHistoryResponse, DonHangModel, DonHangVanChuyenModel } from "@/domain/entities";
import Link from "next/link";

export default function OrderHistoryPage() {
  const { token, isAnonymous, isLoading: authLoading } = useAuth();
  const router = useRouter();
  const [data, setData] = useState<OrderHistoryResponse | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (authLoading) return;
    if (!token || isAnonymous) {
      router.push("/sign-in");
      return;
    }
    loadHistory();
  }, [token, authLoading, isAnonymous, router]);

  const loadHistory = async () => {
    if (!token) return;
    try {
      const res = await orderApi.getHistory(token);
      setData(res);
    } catch {
      setData(null);
    } finally {
      setLoading(false);
    }
  };

  if (loading || authLoading) {
    return <div className="p-3 sm:p-4 lg:p-10 text-center text-gray-500">Đang tải...</div>;
  }

  const orders = data?.donHang || [];
  const shippingMap = new Map<string, DonHangVanChuyenModel>();
  (data?.donHangVanChuyen || []).forEach((s) => {
    if (s.id_DonHang) shippingMap.set(s.id_DonHang, s);
  });

  const statusColor = (status: string | null) => {
    switch (status) {
      case "Đã thanh toán": return "bg-green-100 text-green-700";
      case "Chưa thanh toán": return "bg-yellow-100 text-yellow-700";
      case "Đã hủy": return "bg-red-100 text-red-700";
      default: return "bg-gray-100 text-gray-600";
    }
  };

  const shippingStatusColor = (status: string | null | undefined) => {
    if (!status) return "text-gray-500";
    if (status.includes("Giao thành công")) return "text-green-600";
    if (status.includes("Đang giao")) return "text-blue-600";
    return "text-gray-600";
  };

  return (
    <div className="p-3 sm:p-4 lg:p-10">
      <nav className="flex items-center gap-2 text-sm mb-4">
        <Link href="/" className="text-gray-500 hover:underline">Trang chủ</Link>
        <span className="text-gray-400">/</span>
        <span className="text-black font-bold">Lịch sử đơn hàng</span>
      </nav>

      {orders.length === 0 ? (
        <div className="bg-white rounded-[20px] p-12 text-center">
          <p className="text-gray-500 mb-4">Bạn chưa có đơn hàng nào.</p>
          <Link href="/products" className="text-black hover:underline font-bold">
            Mua sắm ngay →
          </Link>
        </div>
      ) : (
        <div className="space-y-4">
          {orders.map((order) => {
            const shipping = shippingMap.get(order.id_DonHang);
            return (
              <Link
                key={order.id_DonHang}
                href={`/order/${encodeURIComponent(order.id_DonHang)}`}
                className="block bg-white rounded-[20px] p-5 hover:shadow-[0_4px_8px_rgba(0,0,0,0.1)] transition-shadow"
              >
                <div className="flex flex-wrap items-start justify-between gap-3">
                  <div className="space-y-1">
                    <p className="font-bold text-black">#{order.id_DonHang}</p>
                    <p className="text-sm text-gray-500">
                      {new Date(order.ngayDat).toLocaleDateString("vi-VN", { day: "2-digit", month: "2-digit", year: "numeric" })}
                    </p>
                    {shipping?.trangThaiVanChuyen && (
                      <p className={`text-sm font-medium ${shippingStatusColor(shipping.trangThaiVanChuyen.tenTrangThai)}`}>
                        {shipping.trangThaiVanChuyen.tenTrangThai}
                      </p>
                    )}
                  </div>
                  <div className="text-right space-y-1">
                    <span className={`inline-block text-xs px-3 py-1 rounded-full font-bold ${statusColor(order.trangThai)}`}>
                      {order.trangThai || "Không rõ"}
                    </span>
                    <p className="text-red-600 font-bold">{formatCurrency(order.tongTien)}</p>
                  </div>
                </div>
                {shipping && (
                  <div className="mt-3 pt-3 border-t border-gray-100 text-sm text-gray-500">
                    <span>{shipping.tenKhachHang}</span>
                    {shipping.soDienThoai && <span className="ml-3">• {shipping.soDienThoai}</span>}
                    {shipping.diaChiVanChuyen && <span className="ml-3">• {shipping.diaChiVanChuyen}</span>}
                  </div>
                )}
              </Link>
            );
          })}
        </div>
      )}
    </div>
  );
}
