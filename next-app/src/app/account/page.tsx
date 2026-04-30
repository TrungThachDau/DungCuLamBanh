"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { useAuth } from "@/lib/auth-context";
import { authApi } from "@/lib/api";
import type { KhachHangModel } from "@/lib/types";
import AccountSidebar from "@/components/AccountSidebar";

export default function AccountPage() {
  const { user, token, isLoading } = useAuth();
  const router = useRouter();
  const [profile, setProfile] = useState<KhachHangModel | null>(null);
  const [form, setForm] = useState({ tenKhachHang: "", soDienThoai: "", diaChi: "" });
  const [success, setSuccess] = useState("");
  const [error, setError] = useState("");
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (!isLoading && !user) {
      router.push("/sign-in");
      return;
    }
    if (token) {
      authApi.getProfile(token).then((res) => {
        if (res.success && res.data) {
          setProfile(res.data);
          setForm({
            tenKhachHang: res.data.tenKhachHang || "",
            soDienThoai: res.data.soDienThoai || "",
            diaChi: res.data.diaChi || "",
          });
        }
      });
    }
  }, [user, token, isLoading, router]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!token) return;
    setSuccess("");
    setError("");
    setSaving(true);

    try {
      const res = await authApi.updateProfile(token, form);
      if (res.success) {
        setSuccess("Cập nhật thông tin thành công");
      } else {
        setError(res.message || "Cập nhật thất bại");
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Cập nhật thất bại");
    } finally {
      setSaving(false);
    }
  };

  if (isLoading || !profile) {
    return (
      <div className="p-3 sm:p-4 lg:p-8">
        <p>Đang tải...</p>
      </div>
    );
  }

  return (
    <div className="p-3 sm:p-4 lg:p-8 !pt-0">
      <nav className="pt-5 mb-4 text-sm text-gray-500">
        <Link href="/" className="text-gray-500 no-underline hover:underline">
          Trang chủ
        </Link>
        {" > "}
        <span>Tài khoản</span>
        {" > "}
        <span>Thông tin</span>
      </nav>

      <div className="grid grid-cols-1 md:grid-cols-12 gap-6">
        <div className="md:col-span-4">
          <AccountSidebar />
        </div>

        <div className="md:col-span-8 p-[30px]">
          {success && (
            <div className="bg-green-100 text-green-700 px-4 py-3 rounded mb-4">
              {success}
            </div>
          )}
          {error && (
            <div className="bg-red-100 text-red-700 px-4 py-3 rounded mb-4">
              {error}
            </div>
          )}

          <h3 className="text-xl font-bold mb-4">
            Xin chào, {profile.tenKhachHang}
          </h3>

          <h5 className="font-semibold mb-2">Tổng quan</h5>
          <div className="bg-white rounded-[20px] p-3 mb-6">
            <table className="w-full">
              <thead>
                <tr>
                  <td className="p-2 font-bold">Email</td>
                  <td className="p-2 font-bold">Điểm tích luỹ</td>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td className="p-2">{profile.email}</td>
                  <td className="p-2">{profile.diemThuong ?? 0} điểm</td>
                </tr>
              </tbody>
              <thead>
                <tr>
                  <td className="p-2 font-bold">Số điện thoại</td>
                  <td className="p-2 font-bold">Địa chỉ</td>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td className="p-2">{profile.soDienThoai || "—"}</td>
                  <td className="p-2">{profile.diaChi || "—"}</td>
                </tr>
              </tbody>
            </table>
          </div>

          <h5 className="font-semibold mb-4">Cập nhật thông tin</h5>
          <form onSubmit={handleSubmit}>
            <div className="mb-3 relative">
              <input
                type="text"
                value={form.tenKhachHang}
                onChange={(e) =>
                  setForm((f) => ({ ...f, tenKhachHang: e.target.value }))
                }
                className="w-full border border-gray-300 rounded-[20px] px-4 py-3 text-sm focus:outline-none focus:border-gray-500"
                placeholder="Tên của bạn"
              />
            </div>
            <div className="mb-3">
              <input
                type="text"
                value={form.soDienThoai}
                onChange={(e) =>
                  setForm((f) => ({ ...f, soDienThoai: e.target.value }))
                }
                className="w-full border border-gray-300 rounded-[20px] px-4 py-3 text-sm focus:outline-none focus:border-gray-500"
                placeholder="Số điện thoại"
              />
            </div>
            <div className="mb-3">
              <input
                type="text"
                value={form.diaChi}
                onChange={(e) =>
                  setForm((f) => ({ ...f, diaChi: e.target.value }))
                }
                className="w-full border border-gray-300 rounded-[20px] px-4 py-3 text-sm focus:outline-none focus:border-gray-500"
                placeholder="Địa chỉ"
              />
            </div>
            <button
              type="submit"
              disabled={saving}
              className="bg-[#f8d9d6] text-[#49130e] rounded-[20px] px-6 py-2.5 font-bold hover:bg-[#f0c8c4] transition-colors disabled:opacity-50"
            >
              {saving ? "Đang lưu..." : "Lưu thay đổi"}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
}
