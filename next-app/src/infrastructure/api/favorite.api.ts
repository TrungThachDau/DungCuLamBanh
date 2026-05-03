import { fetchApi } from "./client";
import type { YeuThichModel } from "@/domain/entities";

export const favoriteApi = {
  getAll: (token: string) =>
    fetchApi<{ success: boolean; data: YeuThichModel[] }>("/api/Favorite", { token }),
  add: (token: string, productId: number) =>
    fetchApi<{ success: boolean }>(`/api/Favorite/${productId}`, { method: "POST", token }),
  remove: (token: string, productId: number) =>
    fetchApi<{ success: boolean }>(`/api/Favorite/${productId}`, { method: "DELETE", token }),
  check: (token: string, productId: number) =>
    fetchApi<{ success: boolean; isFavorite: boolean }>(`/api/Favorite/check/${productId}`, { token }),
};
