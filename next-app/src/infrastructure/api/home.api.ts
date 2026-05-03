import { fetchApi } from "./client";
import type { HomeDataResponse, BannerModel } from "@/domain/entities";

export const homeApi = {
  getData: () => fetchApi<HomeDataResponse>("/api/HomeData"),
  getBanners: () => fetchApi<{ success: boolean; data: BannerModel[] }>("/api/HomeData/Banners"),
};
