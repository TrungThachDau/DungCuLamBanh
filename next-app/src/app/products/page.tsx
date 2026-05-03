import { productApi } from "@/infrastructure/api";
import ProductCard from "@/presentation/components/ProductCard";
import ProductFilters from "@/presentation/components/ProductFilters";
import Link from "next/link";

interface Props {
  searchParams: Promise<{
    search?: string;
    sortColumn?: string;
    min?: string;
    max?: string;
    page?: string;
    type?: string;
    manufacturer?: string;
  }>;
}

export default async function ProductListingPage({ searchParams }: Props) {
  const params = await searchParams;
  const urlParams = new URLSearchParams();
  if (params.search) urlParams.set("search", params.search);
  if (params.sortColumn) urlParams.set("sortColumn", params.sortColumn);
  if (params.min) urlParams.set("min", params.min);
  if (params.max) urlParams.set("max", params.max);
  if (params.page) urlParams.set("page", params.page);
  if (params.type) urlParams.set("type", params.type);
  if (params.manufacturer) urlParams.set("manufacturer", params.manufacturer);

  const [productsData, filterOptions] = await Promise.all([
    productApi.getFiltered(urlParams),
    productApi.getFilterOptions(),
  ]);

  const currentPage = productsData.currentPage || 1;
  const totalPages = productsData.totalPages || 1;

  return (
    <div className="p-3 sm:p-4 lg:p-8">
      {/* Breadcrumb */}
      <nav className="mb-4 text-sm text-gray-500">
        <Link href="/" className="text-gray-500 hover:underline">Trang chủ</Link>
        <span className="mx-1">&gt;</span>
        <span>Sản phẩm</span>
      </nav>

      <div className="bg-white rounded-[20px] p-5 pt-10 flex flex-col md:flex-row gap-5">
        {/* Sidebar Filters */}
        <aside className="w-full md:w-[250px] flex-shrink-0">
          <ProductFilters
            categories={filterOptions.categories}
            manufacturers={filterOptions.manufacturers}
            currentFilters={params}
          />
        </aside>

        {/* Product Grid */}
        <div className="flex-1">
          {productsData.data.length === 0 ? (
            <div className="bg-red-50 rounded-[20px] p-6 text-center text-gray-600">
              Không tìm thấy sản phẩm phù hợp.
            </div>
          ) : (
            <>
              <div className="flex flex-wrap justify-center gap-4">
                {productsData.data.map((product) => (
                  <div key={product.id_DungCu} className="w-[120px] md:w-[240px]">
                    <ProductCard product={product} />
                  </div>
                ))}
              </div>

              {/* Pagination */}
              {totalPages > 1 && (
                <div className="text-center mt-6">
                  <p className="text-sm text-gray-600 mb-3">Trang {currentPage} của {totalPages}</p>
                  <div className="flex justify-center flex-wrap gap-1">
                    {/* First */}
                    <PaginationLink href={buildPageUrl(urlParams, 1)} disabled={currentPage === 1}>
                      Đầu
                    </PaginationLink>
                    {/* Previous */}
                    <PaginationLink href={buildPageUrl(urlParams, currentPage - 1)} disabled={currentPage === 1}>
                      Trước
                    </PaginationLink>
                    {/* Page numbers */}
                    {Array.from({ length: totalPages }, (_, i) => i + 1)
                      .filter((p) => p === currentPage || (p >= currentPage - 2 && p <= currentPage + 2))
                      .map((p) => (
                        <PaginationLink key={p} href={buildPageUrl(urlParams, p)} active={p === currentPage}>
                          {p}
                        </PaginationLink>
                      ))}
                    {/* Next */}
                    <PaginationLink href={buildPageUrl(urlParams, currentPage + 1)} disabled={currentPage === totalPages}>
                      Kế
                    </PaginationLink>
                    {/* Last */}
                    <PaginationLink href={buildPageUrl(urlParams, totalPages)} disabled={currentPage === totalPages}>
                      Cuối
                    </PaginationLink>
                  </div>
                </div>
              )}
            </>
          )}
        </div>
      </div>
    </div>
  );
}

function buildPageUrl(params: URLSearchParams, page: number): string {
  const newParams = new URLSearchParams(params);
  newParams.set("page", page.toString());
  return `/products?${newParams}`;
}

function PaginationLink({
  href,
  children,
  active,
  disabled,
}: {
  href: string;
  children: React.ReactNode;
  active?: boolean;
  disabled?: boolean;
}) {
  if (disabled) {
    return (
      <span className="px-3 py-1.5 rounded-[20px] text-sm text-gray-400 bg-gray-100 border border-gray-200 cursor-not-allowed">
        {children}
      </span>
    );
  }
  return (
    <a
      href={href}
      className={`px-3 py-1.5 rounded-[20px] text-sm border transition-colors ${active
        ? "bg-blue-600 text-white border-blue-600"
        : "text-black border-gray-200 hover:bg-gray-100"
        }`}
    >
      {children}
    </a>
  );
}
