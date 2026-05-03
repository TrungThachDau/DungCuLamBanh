import { fetchApi } from "./client";
import type { DungCuModel, ProductFilterResponse, FilterOptionsResponse } from "@/domain/entities";

export const productApi = {
  getAll: () => fetchApi<{ success: boolean; data: DungCuModel[] }>("/api/SanPham"),
  getById: (id: number) => fetchApi<DungCuModel>(`/api/SanPham/${id}`),
  getFiltered: (params: URLSearchParams) =>
    fetchApi<ProductFilterResponse>(`/api/SanPham/filter?${params}`),
  getFilterOptions: () => fetchApi<FilterOptionsResponse>("/api/SanPham/filters"),
};
