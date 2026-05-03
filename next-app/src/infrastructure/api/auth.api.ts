import { fetchApi } from "./client";
import type { AuthResponse, KhachHangModel } from "@/domain/entities";

export const authApi = {
  signIn: (email: string, password: string) =>
    fetchApi<AuthResponse>("/api/Auth/SignIn", {
      method: "POST",
      body: JSON.stringify({ email, password }),
    }),
  signUp: (data: { email: string; password: string; tenKhachHang?: string; soDienThoai?: string; diaChi?: string }) =>
    fetchApi<AuthResponse>("/api/Auth/SignUp", {
      method: "POST",
      body: JSON.stringify(data),
    }),
  getProfile: (token: string) =>
    fetchApi<{ success: boolean; data: KhachHangModel }>("/api/Auth/Profile", { token }),
  resetPassword: (email: string) =>
    fetchApi<{ success: boolean; message: string }>("/api/Auth/ResetPassword", {
      method: "POST",
      body: JSON.stringify({ email }),
    }),
  signInAnonymously: () =>
    fetchApi<AuthResponse>("/api/Auth/SignInAnonymously", {
      method: "POST",
    }),
  updateProfile: (token: string, data: { tenKhachHang?: string; soDienThoai?: string; diaChi?: string }) =>
    fetchApi<{ success: boolean; message: string }>("/api/Auth/Profile", {
      method: "PUT",
      token,
      body: JSON.stringify(data),
    }),
  changePassword: (token: string, oldPassword: string, newPassword: string) =>
    fetchApi<{ success: boolean; message: string }>("/api/Auth/ChangePassword", {
      method: "POST",
      token,
      body: JSON.stringify({ oldPassword, newPassword }),
    }),
  deleteAccount: (token: string) =>
    fetchApi<{ success: boolean; message: string }>("/api/Auth/Account", {
      method: "DELETE",
      token,
    }),
};
