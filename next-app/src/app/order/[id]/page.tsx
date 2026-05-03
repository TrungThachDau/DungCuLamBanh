import { orderApi } from "@/infrastructure/api";
import { formatCurrency } from "@/presentation/utils";
import Link from "next/link";

export const metadata = {
  title: "Chi tiết đơn hàng",
};

export default async function OrderDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;

  let order = null;
  let error = null;

  try {
    order = await orderApi.lookup(id);
  } catch {
    error = "Không tìm thấy đơn hàng với mã này.";
  }

  if (error || !order) {
    return (
      <div className="p-3 sm:p-4 lg:p-10">
        <nav className="flex items-center gap-2 text-sm mb-4">
          <Link href="/" className="text-gray-500 hover:underline">Trang chủ</Link>
          <span className="text-gray-400">/</span>
          <Link href="/tracking" className="text-gray-500 hover:underline">Tra cứu</Link>
          <span className="text-gray-400">/</span>
          <span className="text-black font-bold">{id}</span>
        </nav>
        <div className="bg-white rounded-[20px] p-8 text-center">
          <p className="text-gray-500 mb-4">{error || "Không tìm thấy đơn hàng."}</p>
          <Link href="/tracking" className="text-black hover:underline font-bold">
            ← Tra cứu lại
          </Link>
        </div>
      </div>
    );
  }

  const statusColor = (status: string | null) => {
    switch (status) {
      case "Đã thanh toán": return "text-green-600";
      case "Chưa thanh toán": return "text-yellow-600";
      case "Đã hủy": return "text-red-600";
      default: return "text-gray-600";
    }
  };

  return (
    <div className="p-3 sm:p-4 lg:p-10">
      <nav className="flex items-center gap-2 text-sm mb-4">
        <Link href="/" className="text-gray-500 hover:underline">Trang chủ</Link>
        <span className="text-gray-400">/</span>
        <Link href="/tracking" className="text-gray-500 hover:underline">Tra cứu</Link>
        <span className="text-gray-400">/</span>
        <span className="text-black font-bold">{order.id_DonHang}</span>
      </nav>

      <div className="bg-white rounded-[20px] p-5">
        <h4 className="font-bold text-lg mb-4">Chi tiết đơn hàng</h4>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
          <div>
            <p><span className="text-gray-500">Mã đơn hàng:</span> <strong>{order.id_DonHang}</strong></p>
            <p><span className="text-gray-500">Ngày đặt:</span> {new Date(order.ngayDat).toLocaleDateString("vi-VN")}</p>
            {order.ngayGiao && (
              <p><span className="text-gray-500">Ngày giao:</span> {new Date(order.ngayGiao).toLocaleDateString("vi-VN")}</p>
            )}
            <p>
              <span className="text-gray-500">Trạng thái:</span>{" "}
              <span className={`font-bold ${statusColor(order.trangThai)}`}>{order.trangThai || "Không rõ"}</span>
            </p>
          </div>
          <div>
            <p><span className="text-gray-500">Tạm tính:</span> {formatCurrency(order.tongTien - order.vat + order.tienGiamGia + order.tienDiemThuong - order.phiVanChuyen)}</p>
            <p><span className="text-gray-500">VAT (8%):</span> {formatCurrency(order.vat)}</p>
            {order.tienGiamGia > 0 && (
              <p><span className="text-gray-500">Giảm giá:</span> -{formatCurrency(order.tienGiamGia)}</p>
            )}
            {order.tienDiemThuong > 0 && (
              <p><span className="text-gray-500">Điểm thưởng:</span> -{formatCurrency(order.tienDiemThuong)}</p>
            )}
            {order.phiVanChuyen > 0 && (
              <p><span className="text-gray-500">Phí vận chuyển:</span> {formatCurrency(order.phiVanChuyen)}</p>
            )}
            <p className="text-base font-bold mt-2">
              <span className="text-gray-500">Tổng cộng:</span> <span className="text-red-600">{formatCurrency(order.tongTien)}</span>
            </p>
          </div>
        </div>
      </div>

      <div className="mt-4 text-center">
        <Link href="/tracking" className="text-black hover:underline font-bold text-sm">
          ← Tra cứu đơn hàng khác
        </Link>
      </div>
    </div>
  );
}
