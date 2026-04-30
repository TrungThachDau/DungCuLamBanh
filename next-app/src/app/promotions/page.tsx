import { homeApi } from "@/lib/api";
import ProductCard from "@/components/ProductCard";

export default async function SaleOffPage() {
  const data = await homeApi.getData();

  return (
    <div className="p-3 sm:p-4 lg:p-8">
      <div className="bg-white rounded-[20px] p-5">
        <div className="text-center mb-4">
          <h3 className="font-bold text-xl">GIẢM GIÁ DÀNH CHO BẠN</h3>
        </div>

        {data.saleOffProducts.length === 0 ? (
          <div className="text-center text-gray-500 py-12">
            Hiện tại chưa có sản phẩm khuyến mãi.
          </div>
        ) : (
          <div className="flex flex-wrap justify-center gap-4">
            {data.saleOffProducts.map((product) => (
              <div key={product.id_DungCu} className="w-[110px] md:w-[240px]">
                <ProductCard product={product} />
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
