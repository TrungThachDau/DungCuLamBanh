import Link from "next/link";
import Image from "next/image";
import { DungCuModel } from "@/lib/types";
import { formatCurrency, getImageUrl, calcDiscountPercent } from "@/lib/utils";

interface ProductCardProps {
  product: DungCuModel;
}

export default function ProductCard({ product }: ProductCardProps) {
  const hasDiscount = product.giaKhuyenMai && product.giaKhuyenMai > 0;
  const discountPercent = calcDiscountPercent(product.gia, product.giaKhuyenMai);

  return (
    <Link
      href={`/products/${product.id_DungCu}`}
      className="group bg-[#fbf1f1] rounded-[20px] hover:shadow-[0_4px_8px_rgba(0,0,0,0.2)] transition-shadow w-full"
    >
      <div className="relative w-full aspect-square">
        <Image
          src={getImageUrl(product.hinhAnh)}
          alt={product.tenDungCu}
          fill
          sizes="(max-width: 768px) 50vw, 25vw"
          quality={15}
          className="object-cover rounded-[20px]"
        />
      </div>
      <div className="p-2 md:p-3">
        <p className="text-[13px] md:text-[20px] font-bold text-black line-clamp-2 mb-1">
          {product.tenDungCu}
        </p>
      </div>
      <div className="px-2 md:px-3 pb-3">
        {hasDiscount ? (
          <div className="flex flex-wrap items-center gap-1">
            <span className="text-red-600 font-bold text-[13px] md:text-base">
              {formatCurrency(product.giaKhuyenMai!)}
            </span>
            <del className="text-gray-500 text-[12px] md:text-sm">
              {formatCurrency(product.gia)}
            </del>
            <span className="bg-[#f8d9d6] text-red-600 text-[12px] md:text-[15px] px-1.5 py-0.5 rounded-sm font-medium">
              -{discountPercent}%
            </span>
          </div>
        ) : (
          <span className="text-red-600 font-bold text-[13px] md:text-base">
            {formatCurrency(product.gia)}
          </span>
        )}
      </div>
    </Link>
  );
}
