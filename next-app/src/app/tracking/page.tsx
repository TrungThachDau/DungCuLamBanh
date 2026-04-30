"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";


export default function TrackingPage() {
  const router = useRouter();
  const [orderId, setOrderId] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const trimmed = orderId.trim();
    if (trimmed) {
      router.push(`/order/${encodeURIComponent(trimmed)}`);
    }
  };

  return (
    <div className="p-3 sm:p-4 lg:p-10" style={{ minHeight: 300 }}>
      <h4 className="font-bold text-lg mb-4">Tra cứu đơn hàng</h4>
      <div className="max-w-md">
        <form onSubmit={handleSubmit}>
          <input
            id="inputField"
            type="text"
            value={orderId}
            onChange={(e) => setOrderId(e.target.value)}
            className="w-full border border-gray-300 rounded-[20px] px-4 py-2 text-sm focus:outline-none focus:border-gray-500"
            placeholder="Nhập mã đơn hàng"
          />
          <br />
          <button
            type="submit"
            className="mt-3 bg-[#f8d9d6] text-[#49130e] rounded-[20px] px-6 py-2 text-sm font-bold hover:bg-[#f0c5c1] transition-colors"
          >
            Xác nhận
          </button>
        </form>
      </div>
    </div>
  );
}
