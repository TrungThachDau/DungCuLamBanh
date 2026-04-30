"use client";

import { useState } from "react";
import { useAuth } from "@/lib/auth-context";
import { authApi } from "@/lib/api";
import { useRouter } from "next/navigation";
import Link from "next/link";

export default function SignUpPage() {
  const { signIn } = useAuth();
  const router = useRouter();
  const [form, setForm] = useState({
    email: "",
    password: "",
    confirmPassword: "",
    tenKhachHang: "",
    soDienThoai: "",
  });
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    if (form.password !== form.confirmPassword) {
      setError("Mật khẩu xác nhận không khớp.");
      return;
    }

    if (form.password.length < 6) {
      setError("Mật khẩu phải có ít nhất 6 ký tự.");
      return;
    }

    setLoading(true);

    try {
      const result = await authApi.signUp({
        email: form.email,
        password: form.password,
        tenKhachHang: form.tenKhachHang,
        soDienThoai: form.soDienThoai,
      });

      if (result.success) {
        signIn(result.token, {
          uid: result.data.uid,
          email: result.data.email,
          tenKhachHang: result.data.tenKhachHang,
        });
        router.push("/");
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Đăng ký thất bại");
    } finally {
      setLoading(false);
    }
  };

  const updateForm = (field: string, value: string) => {
    setForm((prev) => ({ ...prev, [field]: value }));
  };

  return (
    <div className="max-w-md mx-auto px-4 py-12">
      <div className="bg-white rounded-[20px] p-8">
        <h1 className="text-2xl font-bold text-center mb-6">Đăng ký</h1>

        {error && (
          <div className="bg-red-50 text-red-700 text-sm px-4 py-3 rounded-[20px] mb-4">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="text-sm text-gray-600 mb-1 block">Họ tên</label>
            <input
              type="text"
              value={form.tenKhachHang}
              onChange={(e) => updateForm("tenKhachHang", e.target.value)}
              required
              className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
              placeholder="Nguyễn Văn A"
            />
          </div>

          <div>
            <label className="text-sm text-gray-600 mb-1 block">Email</label>
            <input
              type="email"
              value={form.email}
              onChange={(e) => updateForm("email", e.target.value)}
              required
              className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
              placeholder="email@example.com"
            />
          </div>

          <div>
            <label className="text-sm text-gray-600 mb-1 block">Số điện thoại</label>
            <input
              type="tel"
              value={form.soDienThoai}
              onChange={(e) => updateForm("soDienThoai", e.target.value)}
              className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
              placeholder="0369 132 321"
            />
          </div>

          <div>
            <label className="text-sm text-gray-600 mb-1 block">Mật khẩu</label>
            <input
              type="password"
              value={form.password}
              onChange={(e) => updateForm("password", e.target.value)}
              required
              className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
              placeholder="••••••••"
            />
          </div>

          <div>
            <label className="text-sm text-gray-600 mb-1 block">Xác nhận mật khẩu</label>
            <input
              type="password"
              value={form.confirmPassword}
              onChange={(e) => updateForm("confirmPassword", e.target.value)}
              required
              className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
              placeholder="••••••••"
            />
          </div>

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-[#f8d9d6] text-[#49130e] py-2.5 rounded-[20px] font-bold hover:bg-[#f0c8c4] transition-colors disabled:opacity-50"
          >
            {loading ? "Đang đăng ký..." : "Đăng ký"}
          </button>
        </form>

        <div className="mt-6 text-center text-sm text-gray-500">
          Đã có tài khoản?{" "}
          <Link href="/sign-in" className="hover:underline font-bold">
            Đăng nhập
          </Link>
        </div>
      </div>
    </div>
  );
}
