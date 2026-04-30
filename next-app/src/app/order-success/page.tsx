import Link from "next/link";

export default function OrderSuccessPage() {
  return (
    <div className="max-w-md mx-auto px-4 py-16 text-center">
      <div className="bg-white rounded-[20px] p-8">
        <div className="text-5xl mb-4">✓</div>
        <h1 className="text-2xl font-bold mb-2">Đặt hàng thành công!</h1>
        <p className="text-gray-500 mb-6">
          Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đang được xử lý.
        </p>
        <div className="flex gap-3 justify-center">
          <Link
            href="/"
            className="bg-[#212631] text-white px-6 py-2.5 rounded-[20px] text-sm font-bold hover:bg-[#343a46]"
          >
            Trang chủ
          </Link>
          <Link
            href="/products"
            className="bg-gray-100 text-gray-700 px-6 py-2.5 rounded-[20px] text-sm font-bold hover:bg-gray-200"
          >
            Tiếp tục mua sắm
          </Link>
        </div>
      </div>
    </div>
  );
}
