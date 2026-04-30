const API_BASE = process.env.NEXT_PUBLIC_API_URL || "http://localhost:5000";

type FetchOptions = RequestInit & {
  token?: string;
};

async function fetchApi<T>(endpoint: string, options: FetchOptions = {}): Promise<T> {
  const { token, headers, ...rest } = options;

  const res = await fetch(`${API_BASE}${endpoint}`, {
    headers: {
      "Content-Type": "application/json",
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...headers,
    },
    ...rest,
  });

  if (!res.ok) {
    if (res.status === 401) {
      // Token expired or invalid — clear stored auth so ensureAuth will refresh
      localStorage.removeItem("token");
      localStorage.removeItem("user");
      throw new Error("Phiên đăng nhập đã hết hạn. Vui lòng thử lại.");
    }
    const error = await res.json().catch(() => ({ message: "Lỗi kết nối server" }));
    throw new Error(error.message || `HTTP ${res.status}`);
  }

  return res.json();
}

// ===== Public APIs (no auth) =====

export const homeApi = {
  getData: () => fetchApi<import("./types").HomeDataResponse>("/api/HomeData"),
  getBanners: () => fetchApi<{ success: boolean; data: import("./types").BannerModel[] }>("/api/HomeData/Banners"),
};

export const productApi = {
  getAll: () => fetchApi<{ success: boolean; data: import("./types").DungCuModel[] }>("/api/SanPham"),
  getById: (id: number) => fetchApi<import("./types").DungCuModel>(`/api/SanPham/${id}`),
  getFiltered: (params: URLSearchParams) =>
    fetchApi<import("./types").ProductFilterResponse>(`/api/SanPham/filter?${params}`),
  getFilterOptions: () => fetchApi<import("./types").FilterOptionsResponse>("/api/SanPham/filters"),
};

// ===== Auth APIs =====

export const authApi = {
  signIn: (email: string, password: string) =>
    fetchApi<import("./types").AuthResponse>("/api/Auth/SignIn", {
      method: "POST",
      body: JSON.stringify({ email, password }),
    }),
  signUp: (data: { email: string; password: string; tenKhachHang?: string; soDienThoai?: string; diaChi?: string }) =>
    fetchApi<import("./types").AuthResponse>("/api/Auth/SignUp", {
      method: "POST",
      body: JSON.stringify(data),
    }),
  getProfile: (token: string) =>
    fetchApi<{ success: boolean; data: import("./types").KhachHangModel }>("/api/Auth/Profile", { token }),
  resetPassword: (email: string) =>
    fetchApi<{ success: boolean; message: string }>("/api/Auth/ResetPassword", {
      method: "POST",
      body: JSON.stringify({ email }),
    }),
  signInAnonymously: () =>
    fetchApi<import("./types").AuthResponse>("/api/Auth/SignInAnonymously", {
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

// ===== Cart APIs (require auth) =====

export const cartApi = {
  getCart: (token: string) =>
    fetchApi<import("./types").CartResponse>("/api/CustomerCart", { token }),
  addItem: (token: string, productId: number, quantity: number) =>
    fetchApi<{ success: boolean; message: string }>("/api/CustomerCart/AddItem", {
      method: "POST",
      token,
      body: JSON.stringify({ productId, quantity }),
    }),
  updateQuantity: (token: string, orderDetailId: number, quantity: number) =>
    fetchApi<{ success: boolean; donGia: number; tongTien: number }>("/api/CustomerCart/UpdateQuantity", {
      method: "PUT",
      token,
      body: JSON.stringify({ orderDetailId, quantity }),
    }),
  removeItem: (token: string, orderDetailId: number) =>
    fetchApi<{ success: boolean }>(`/api/CustomerCart/RemoveItem/${orderDetailId}`, {
      method: "DELETE",
      token,
    }),
  getItemCount: (token: string) =>
    fetchApi<{ success: boolean; count: number }>("/api/CustomerCart/ItemCount", { token }),
  getCheckout: (token: string) =>
    fetchApi<import("./types").CheckoutResponse>("/api/CustomerCart/Checkout", { token }),
  applyVoucher: (token: string, voucherCode: string) =>
    fetchApi<{ success: boolean; message: string; vat: number; tienGiamGia: number; tamTinh: number }>(
      "/api/CustomerCart/ApplyVoucher",
      { method: "POST", token, body: JSON.stringify({ voucherCode }) }
    ),
  getShippingRate: (district: string) =>
    fetchApi<{ success: boolean; shippingRate: number }>(`/api/CustomerCart/ShippingRate?district=${encodeURIComponent(district)}`),
  codPayment: (token: string, data: { ten: string; soDienThoai: string; email: string; diaChi: string; phiVanChuyen: number; diemThuong: number }) =>
    fetchApi<{ success: boolean; message: string; orderId: string }>("/api/CustomerCart/CODPayment", {
      method: "POST",
      token,
      body: JSON.stringify(data),
    }),
};

// ===== Favorite APIs (require auth) =====

export const favoriteApi = {
  getAll: (token: string) =>
    fetchApi<{ success: boolean; data: import("./types").YeuThichModel[] }>("/api/Favorite", { token }),
  add: (token: string, productId: number) =>
    fetchApi<{ success: boolean }>(`/api/Favorite/${productId}`, { method: "POST", token }),
  remove: (token: string, productId: number) =>
    fetchApi<{ success: boolean }>(`/api/Favorite/${productId}`, { method: "DELETE", token }),
  check: (token: string, productId: number) =>
    fetchApi<{ success: boolean; isFavorite: boolean }>(`/api/Favorite/check/${productId}`, { token }),
};

// ===== Order APIs =====

export const orderApi = {
  // Authenticated: get order history for logged-in user
  getHistory: (token: string) =>
    fetchApi<import("./types").OrderHistoryResponse>("/api/CustomerOrder/History", { token }),
  // Authenticated: get order detail
  getDetail: (token: string, orderId: string) =>
    fetchApi<import("./types").OrderDetailResponse>(`/api/CustomerOrder/Detail/${encodeURIComponent(orderId)}`, { token }),
  // Public: lookup order by ID (legacy API, no auth)
  lookup: (orderId: string) =>
    fetchApi<import("./types").DonHangModel>(`/api/Order/OrderDetail/${encodeURIComponent(orderId)}`),
  // Public: get orders by customer UID (returns DonHangVanChuyen[])
  getByUid: (uid: string) =>
    fetchApi<import("./types").DonHangVanChuyenModel[]>(`/api/Order/${encodeURIComponent(uid)}`),
};
