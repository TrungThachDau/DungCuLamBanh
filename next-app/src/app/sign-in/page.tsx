"use client";

import { useState } from "react";
import { useAuth } from "@/lib/auth-context";
import { authApi } from "@/lib/api";
import { useRouter } from "next/navigation";
import Image from "next/image";
import Link from "next/link";

export default function SignInPage() {
  const { signIn } = useAuth();
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const [showSignUp, setShowSignUp] = useState(false);

  // Sign-up form state
  const [signUpForm, setSignUpForm] = useState({
    tenKhachHang: "",
    email: "",
    password: "",
  });
  const [signUpError, setSignUpError] = useState("");
  const [signUpLoading, setSignUpLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setLoading(true);

    try {
      const result = await authApi.signIn(email, password);

      if (result.success) {
        signIn(result.token, {
          uid: result.data.uid,
          email: result.data.email,
          tenKhachHang: result.data.tenKhachHang,
        });
        router.push("/");
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Đăng nhập thất bại");
    } finally {
      setLoading(false);
    }
  };

  const handleSignUp = async (e: React.FormEvent) => {
    e.preventDefault();
    setSignUpError("");
    setSignUpLoading(true);

    try {
      const result = await authApi.signUp({
        email: signUpForm.email,
        password: signUpForm.password,
        tenKhachHang: signUpForm.tenKhachHang,
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
      setSignUpError(err instanceof Error ? err.message : "Đăng ký thất bại");
    } finally {
      setSignUpLoading(false);
    }
  };

  return (
    <div
      className="min-h-screen bg-cover bg-center bg-no-repeat p-2.5"
      style={{ backgroundImage: "url('/bg-login.jpg')" }}
    >
      <div className="grid grid-cols-1 md:grid-cols-2 gap-0 p-[30px]">
        {/* Left: Welcome Section */}
        <div className="pt-[50px]">
          <h2 className="text-2xl font-bold">Chào mừng đến</h2>
          <Image
            src="/logodai.png"
            alt="Logo"
            width={280}
            height={70}
            className="rounded my-2"
          />
          <h6 className="text-sm text-gray-700">
            Đăng nhập ngay để nhận ưu đãi thành viên cực nóng hổi
          </h6>
        </div>

        {/* Right: Login Form */}
        <div className="bg-white/[0.97] p-[30px] rounded-[20px] shadow-[0_0_10px_rgba(0,0,0,0.1)]">
          {error && (
            <div className="bg-red-100 text-red-700 text-sm px-4 py-3 rounded mb-4">
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit}>
            <div className="mb-4">
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                placeholder="Email"
              />
            </div>

            <div className="mb-4">
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                placeholder="Mật khẩu"
              />
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full bg-[#f8d9d6] text-[#49130e] rounded-[20px] py-2.5 font-bold mb-4 hover:bg-[#f0c8c4] transition-colors disabled:opacity-50"
            >
              {loading ? "Đang đăng nhập..." : "Đăng nhập"}
            </button>

            <div className="flex justify-center">
              <Link
                href="/forgot-password"
                className="text-sm no-underline hover:underline"
              >
                Bạn quên mật khẩu?
              </Link>
            </div>

            <hr className="my-4" />

            <button
              type="button"
              onClick={() => setShowSignUp(true)}
              className="w-full bg-[#f8d9d6] text-[#49130e] rounded-[20px] py-2.5 font-bold mb-4 hover:bg-[#f0c8c4] transition-colors"
            >
              Tạo tài khoản mới
            </button>
          </form>
        </div>
      </div>

      {/* Sign Up Modal */}
      {showSignUp && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-[20px] w-full max-w-md mx-4">
            <div className="flex items-start justify-between p-4 border-b">
              <div>
                <h3 className="text-xl font-bold">Đăng ký</h3>
                <span className="text-gray-500 text-sm">
                  Nhanh chóng và dễ dàng.
                </span>
              </div>
              <button
                onClick={() => setShowSignUp(false)}
                className="text-gray-400 hover:text-gray-600 text-2xl leading-none"
              >
                &times;
              </button>
            </div>

            <div className="p-6">
              {signUpError && (
                <div className="bg-red-100 text-red-700 text-sm px-4 py-3 rounded mb-4">
                  {signUpError}
                </div>
              )}

              <form onSubmit={handleSignUp} className="space-y-3">
                <input
                  type="text"
                  value={signUpForm.tenKhachHang}
                  onChange={(e) =>
                    setSignUpForm((f) => ({
                      ...f,
                      tenKhachHang: e.target.value,
                    }))
                  }
                  className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                  placeholder="Tên của bạn"
                />

                <input
                  type="email"
                  value={signUpForm.email}
                  onChange={(e) =>
                    setSignUpForm((f) => ({ ...f, email: e.target.value }))
                  }
                  required
                  className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                  placeholder="Email"
                />

                <input
                  type="password"
                  value={signUpForm.password}
                  onChange={(e) =>
                    setSignUpForm((f) => ({ ...f, password: e.target.value }))
                  }
                  required
                  className="w-full border border-gray-300 rounded-[20px] px-4 py-2.5 text-sm focus:outline-none focus:border-gray-500"
                  placeholder="Mật khẩu"
                />

                <p className="text-sm text-gray-600">
                  Bằng cách nhấn vào đăng ký nghĩa là bạn đã đồng ý với{" "}
                  <Link href="/privacy" className="text-blue-600 hover:underline">
                    chính sách và điều khoản dịch vụ
                  </Link>{" "}
                  của chúng tôi.
                </p>

                <button
                  type="submit"
                  disabled={signUpLoading}
                  className="w-full bg-[#f8d9d6] text-[#49130e] rounded-[20px] py-2.5 font-bold hover:bg-[#f0c8c4] transition-colors disabled:opacity-50"
                >
                  {signUpLoading ? "Đang đăng ký..." : "Đăng ký"}
                </button>
              </form>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
