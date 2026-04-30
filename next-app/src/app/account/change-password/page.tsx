"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { useAuth } from "@/lib/auth-context";
import { authApi } from "@/lib/api";
import AccountSidebar from "@/components/AccountSidebar";

export default function ChangePasswordPage() {
  const { user, token, signOut, isLoading } = useAuth();
  const router = useRouter();
  const [oldPassword, setOldPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [success, setSuccess] = useState("");
  const [error, setError] = useState("");
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (!isLoading && !user) {
      router.push("/sign-in");
    }
  }, [user, isLoading, router]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSuccess("");
    setError("");

    if (newPassword !== confirmPassword) {
      setError("Mật khẩu mới không khớp.");
      return;
    }

    if (!token) return;
    setSaving(true);

    try {
      const res = await authApi.changePassword(token, oldPassword, newPassword);
      if (res.success) {
        setSuccess("Đổi mật khẩu thành công");
        setOldPassword("");
        setNewPassword("");
        setConfirmPassword("");
      } else {
        setError(res.message || "Đổi mật khẩu không thành công");
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Đổi mật khẩu không thành công");
    } finally {
      setSaving(false);
    }
  };

  const handleDeleteAccount = async () => {
    if (!token) return;
    if (!confirm("Bạn có chắc chắn muốn xoá tài khoản? Hành động này không thể hoàn tác.")) return;

    try {
      const res = await authApi.deleteAccount(token);
      if (res.success) {
        signOut();
        router.push("/");
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Xoá tài khoản thất bại");
    }
  };

  if (isLoading) {
    return (
      <div className="p-3 sm:p-4 lg:p-8">
        <p>Đang tải...</p>
      </div>
    );
  }

  return (
    <div className="p-3 sm:p-4 lg:p-8 pt-0!">
      <nav className="pt-5 mb-4 text-sm text-gray-500">
        <Link href="/" className="text-gray-500 no-underline hover:underline">
          Trang chủ
        </Link>
        {" > "}
        <Link href="/account" className="text-gray-500 no-underline hover:underline">
          Tài khoản
        </Link>
        {" > "}
        <span>Đổi mật khẩu</span>
      </nav>

      <div className="grid grid-cols-1 md:grid-cols-12 gap-6">
        <div className="md:col-span-4">
          <AccountSidebar />
        </div>

        <div className="md:col-span-8 p-[30px]">
          {error && (
            <div className="bg-red-100 text-red-700 px-4 py-3 rounded mb-4">
              {error}
            </div>
          )}
          {success && (
            <div className="bg-green-100 text-green-700 px-4 py-3 rounded mb-4">
              {success}
            </div>
          )}

          <h5 className="font-semibold mb-2">Mật khẩu</h5>
          <p className="text-gray-600 mb-4">
            Vì sự an toàn, Shop khuyến khích khách hàng sử dụng mật khẩu mạnh
          </p>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <form onSubmit={handleSubmit}>
              <div className="mb-4">
                <input
                  name="oldPassword"
                  type="password"
                  value={oldPassword}
                  onChange={(e) => setOldPassword(e.target.value)}
                  required
                  className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                  placeholder="Nhập mật khẩu cũ"
                />
              </div>
              <div className="mb-4">
                <input
                  name="newPassword"
                  type="password"
                  value={newPassword}
                  onChange={(e) => setNewPassword(e.target.value)}
                  required
                  className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                  placeholder="Nhập mật khẩu mới"
                />
              </div>
              <div className="mb-4">
                <input
                  name="confirmPassword"
                  type="password"
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  required
                  className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                  placeholder="Nhập lại mật khẩu mới"
                />
              </div>
              <button
                type="submit"
                disabled={saving}
                className="bg-[#f8d9d6] text-[#49130e] rounded-[20px] px-6 py-2.5 font-bold hover:bg-[#f0c8c4] transition-colors disabled:opacity-50 mb-3"
              >
                {saving ? "Đang lưu..." : "Lưu thay đổi"}
              </button>
            </form>

            <div>
              <p className="font-bold">Mật khẩu của bạn</p>
              <p className="text-sm text-gray-600">Phải 6 ký tự trở lên</p>
              <p className="text-sm text-gray-600">
                Nên có ít nhất 1 số hoặc 1 ký tự đặc biệt
              </p>
              <p className="text-sm text-gray-600">
                Không nên giống với mật khẩu được sử dụng gần đây
              </p>
            </div>
          </div>

          <div className="mt-4">
            <button
              type="button"
              onClick={handleDeleteAccount}
              className="bg-[#f8d9d6] text-[#49130e] rounded-[20px] px-6 py-2.5 font-bold hover:bg-[#f0c8c4] transition-colors"
            >
              Xoá tài khoản
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
