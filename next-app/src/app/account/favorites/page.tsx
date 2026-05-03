"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import Image from "next/image";
import { useAuth } from "@/lib/auth-context";
import { favoriteApi } from "@/lib/api";
import type { YeuThichModel } from "@/lib/types";
import { formatCurrency } from "@/lib/utils";
import AccountSidebar from "@/components/AccountSidebar";

export default function FavoritesPage() {
  const { user, token, isLoading } = useAuth();
  const router = useRouter();
  const [favorites, setFavorites] = useState<YeuThichModel[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!isLoading && !user) {
      router.push("/sign-in");
      return;
    }
    if (token) {
      favoriteApi
        .getAll(token)
        .then((res) => {
          if (res.success) {
            setFavorites(res.data);
          }
        })
        .finally(() => setLoading(false));
    }
  }, [user, token, isLoading, router]);

  if (isLoading || loading) {
    return (
      <div className="p-3 sm:p-4 lg:p-8">
        <p>Đang tải...</p>
      </div>
    );
  }

  return (
    <div className="p-3 sm:p-4 lg:p-8 !pt-0">
      <nav className="pt-5 mb-4 text-sm text-gray-500">
        <Link href="/" className="text-gray-500 no-underline hover:underline">
          Trang chủ
        </Link>
        {" > "}
        <Link href="/account" className="text-gray-500 no-underline hover:underline">
          Tài khoản
        </Link>
        {" > "}
        <span>Sản phẩm yêu thích</span>
      </nav>

      <div className="grid grid-cols-1 md:grid-cols-12 gap-6">
        <div className="md:col-span-4">
          <AccountSidebar />
        </div>

        <div className="md:col-span-8">
          <h5 className="font-semibold mb-2">Sản phẩm yêu thích</h5>
          <p className="text-gray-600 mb-4">
            Hiển thị các sản phẩm bạn đã yêu thích.
          </p>

          {favorites.length === 0 ? (
            <p>Hiện chưa có sản phẩm yêu thích.</p>
          ) : (
            <div className="flex flex-wrap gap-2">
              {favorites.map((item) => {
                const product = item.sanPham;
                const hasDiscount =
                  product.giaKhuyenMai != null && product.giaKhuyenMai > 0;
                const discountPercent = hasDiscount
                  ? 100 - Math.round((product.giaKhuyenMai! / product.gia) * 100)
                  : 0;

                return (
                  <Link
                    key={item.id_YeuThich}
                    href={`/products/${product.id_DungCu}`}
                    className="no-underline text-inherit w-[110px] md:w-[220px] bg-[#fbf1f1] rounded-[20px] hover:shadow-lg transition-shadow"
                  >
                    <div className="relative w-full aspect-square">
                      <Image
                        src={product.hinhAnh || ""}
                        alt={product.tenDungCu}
                        fill
                        sizes="(max-width: 768px) 110px, 220px"
                        quality={15}
                        className="rounded-[20px] object-cover"
                      />
                    </div>
                    <div className="p-2">
                      <p className="text-xs md:text-base font-bold line-clamp-2">
                        {product.tenDungCu}
                      </p>
                    </div>
                    <div className="p-2 pt-0">
                      {hasDiscount ? (
                        <>
                          <span className="text-red-600 font-bold text-xs md:text-base">
                            {formatCurrency(product.giaKhuyenMai!)}
                          </span>{" "}
                          <span className="text-gray-500 line-through text-xs md:text-sm">
                            {formatCurrency(product.gia)}
                          </span>{" "}
                          <span className="bg-[#f8d9d6] text-red-600 text-xs px-1.5 py-0.5 rounded">
                            -{discountPercent}%
                          </span>
                        </>
                      ) : (
                        <span className="text-red-600 font-bold text-xs md:text-base">
                          {formatCurrency(product.gia)}
                        </span>
                      )}
                    </div>
                  </Link>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
