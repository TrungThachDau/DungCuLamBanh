"use client";

import { useState } from "react";
import { authApi } from "@/lib/api";
import Link from "next/link";

export default function ResetPasswordPage() {
  const [email, setEmail] = useState("");
  const [notice, setNotice] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setNotice("");
    setError("");

    if (!email) {
      setError("Vui lòng nhập email.");
      return;
    }

    setLoading(true);

    try {
      const res = await authApi.resetPassword(email);
      if (res.success) {
        setNotice("Vui lòng kiểm tra email để đổi mật khẩu.");
      } else {
        setError(res.message || "Có lỗi xảy ra.");
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Có lỗi xảy ra.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="p-3 sm:p-4 lg:p-8 pt-0!">
      <nav className="pt-5 mb-4 text-sm text-gray-500">
        <Link href="/" className="text-gray-500 no-underline hover:underline">
          Trang chủ
        </Link>
        {" > "}
        <Link href="/sign-in" className="text-gray-500 no-underline hover:underline">
          Đăng nhập
        </Link>
        {" > "}
        <span>Đặt lại mật khẩu</span>
      </nav>

      <h4 className="text-xl font-semibold mb-4">Đặt lại mật khẩu</h4>
      <div className="max-w-md">
        <form onSubmit={handleSubmit}>
          {notice && (
            <div className="bg-green-100 text-green-700 px-4 py-3 rounded mb-4">
              {notice}
            </div>
          )}
          {error && (
            <p className="text-red-600 mb-4">{error}</p>
          )}

          <div className="mb-4">
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
              placeholder="Nhập Email cần đặt lại mật khẩu"
            />
          </div>

          <button
            type="submit"
            disabled={loading}
            className="bg-[#f8d9d6] text-[#49130e] rounded-[20px] px-6 py-2.5 font-bold hover:bg-[#f0c8c4] transition-colors disabled:opacity-50"
          >
            {loading ? "Đang xử lý..." : "Xác nhận"}
          </button>
        </form>
      </div>
    </div>
  );
}
