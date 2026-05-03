import { fetchApi } from "./client";
import type { OrderHistoryResponse, OrderDetailResponse, DonHangModel, DonHangVanChuyenModel } from "@/domain/entities";

export const orderApi = {
  getHistory: (token: string) =>
    fetchApi<OrderHistoryResponse>("/api/CustomerOrder/History", { token }),
  getDetail: (token: string, orderId: string) =>
    fetchApi<OrderDetailResponse>(`/api/CustomerOrder/Detail/${encodeURIComponent(orderId)}`, { token }),
  lookup: (orderId: string) =>
    fetchApi<DonHangModel>(`/api/Order/OrderDetail/${encodeURIComponent(orderId)}`),
  getByUid: (uid: string) =>
    fetchApi<DonHangVanChuyenModel[]>(`/api/Order/${encodeURIComponent(uid)}`),
};
