const API_BASE = process.env.NEXT_PUBLIC_API_URL || "http://localhost:5000";

type FetchOptions = RequestInit & {
  token?: string;
};

export async function fetchApi<T>(endpoint: string, options: FetchOptions = {}): Promise<T> {
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
      localStorage.removeItem("token");
      localStorage.removeItem("user");
      throw new Error("Phiên đăng nhập đã hết hạn. Vui lòng thử lại.");
    }
    const error = await res.json().catch(() => ({ message: "Lỗi kết nối server" }));
    throw new Error(error.message || `HTTP ${res.status}`);
  }

  return res.json();
}
