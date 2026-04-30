"use client";

import { useState, useEffect } from "react";
import { BannerModel } from "@/lib/types";
import { getImageUrl } from "@/lib/utils";

export default function BannerCarousel({ banners }: { banners: BannerModel[] }) {
  const [current, setCurrent] = useState(0);

  useEffect(() => {
    if (banners.length <= 1) return;
    const timer = setInterval(() => {
      setCurrent((prev) => (prev + 1) % banners.length);
    }, 5000);
    return () => clearInterval(timer);
  }, [banners.length]);

  if (banners.length === 0) return null;

  return (
    <div className="relative overflow-hidden">
      {banners.map((banner, i) => (
        <div
          key={banner.id_Banner}
          className={`transition-opacity duration-700 ${i === current ? "opacity-100 relative" : "opacity-0 absolute inset-0"}`}
        >
          {banner.lienKet ? (
            <a href={banner.lienKet}>
              <img src={getImageUrl(banner.duongDan)} alt={banner.tenBanner || ""} className="w-full block" />
            </a>
          ) : (
            <img src={getImageUrl(banner.duongDan)} alt={banner.tenBanner || ""} className="w-full block" />
          )}
        </div>
      ))}

      {/* Indicators */}
      {banners.length > 1 && (
        <div className="absolute bottom-4 left-1/2 -translate-x-1/2 flex gap-2">
          {banners.map((_, i) => (
            <button
              key={i}
              onClick={() => setCurrent(i)}
              className={`w-3 h-3 rounded-full border-2 border-white transition-colors ${i === current ? "bg-white" : "bg-white/40"}`}
            />
          ))}
        </div>
      )}

      {/* Nav Arrows */}
      {banners.length > 1 && (
        <>
          <button
            onClick={() => setCurrent((current - 1 + banners.length) % banners.length)}
            className="absolute left-4 top-1/2 -translate-y-1/2 bg-black/20 text-white rounded-full w-10 h-10 flex items-center justify-center hover:bg-black/40 text-xl"
          >
            ‹
          </button>
          <button
            onClick={() => setCurrent((current + 1) % banners.length)}
            className="absolute right-4 top-1/2 -translate-y-1/2 bg-black/20 text-white rounded-full w-10 h-10 flex items-center justify-center hover:bg-black/40 text-xl"
          >
            ›
          </button>
        </>
      )}
    </div>
  );
}
