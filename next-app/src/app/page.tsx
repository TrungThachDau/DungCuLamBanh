import { homeApi } from "@/infrastructure/api";
import ProductCard from "@/presentation/components/ProductCard";
import Link from "next/link";
import BannerCarousel from "@/presentation/components/BannerCarousel";

export default async function HomePage() {
  const data = await homeApi.getData();

  return (
    <div className="p-3 sm:p-4 lg:p-10 pt-0">
      {/* Banner Carousel - full width row */}
      <div className="row">
        <BannerCarousel banners={data.banners} />
      </div>

      {/* Sale Off Section */}
      {data.saleOffProducts.length > 0 && (
        <div className="bg-white rounded-[20px] mt-[30px] p-5">
          <div className="text-center">
            <h3 className="font-bold text-lg md:text-xl">GIẢM GIÁ DÀNH CHO BẠN</h3>
          </div>
          <div className="text-right">
            <Link href="/promotions" className="text-black text-sm no-underline hover:underline">
              Xem thêm
            </Link>
          </div>
          <div className="flex flex-wrap justify-center gap-[15px]">
            {data.saleOffProducts.slice(0, 10).map((product) => (
              <div key={product.id_DungCu} className="w-[110px] md:w-[240px] flex-shrink-0 flex-grow-0">
                <ProductCard product={product} />
              </div>
            ))}
          </div>
        </div>
      )}

      {/* New Products Section */}
      {data.newProducts.length > 0 && (
        <div className="bg-white rounded-[20px] mt-[30px] p-5">
          <div className="text-center">
            <h3 className="font-bold text-lg md:text-xl">SẢN PHẨM MỚI RA MẮT</h3>
          </div>
          <div className="flex flex-wrap justify-center gap-[15px] mt-3">
            {data.newProducts.map((product) => (
              <div key={product.id_DungCu} className="w-[110px] md:w-[240px] flex-shrink-0 flex-grow-0">
                <ProductCard product={product} />
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
