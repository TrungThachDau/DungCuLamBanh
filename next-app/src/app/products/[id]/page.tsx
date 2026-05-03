import { productApi } from "@/lib/api";
import Image from "next/image";
import { formatCurrency, getImageUrl, calcDiscountPercent } from "@/lib/utils";
import { notFound } from "next/navigation";
import AddToCartSection from "./AddToCartSection";
import Link from "next/link";

interface Props {
  params: Promise<{ id: string }>;
}

export default async function ProductDetailPage({ params }: Props) {
  const { id } = await params;
  const productId = parseInt(id);

  if (isNaN(productId)) notFound();

  let product;
  try {
    product = await productApi.getById(productId);
  } catch {
    notFound();
  }

  const hasDiscount = product.giaKhuyenMai && product.giaKhuyenMai > 0;
  const discountPercent = calcDiscountPercent(product.gia, product.giaKhuyenMai);
  const inStock = product.soLuong > 0;

  return (
    <div className="p-3 sm:p-4 lg:p-8">
      {/* Breadcrumb */}
      <nav className="mb-4 text-sm text-gray-500 pl-5">
        <Link href="/" className="text-gray-500 hover:underline">Trang chủ</Link>
        <span className="mx-1">&gt;</span>
        <Link href="/products" className="text-gray-500 hover:underline">Sản phẩm</Link>
        <span className="mx-1">&gt;</span>
        <span>{product.tenDungCu}</span>
      </nav>

      {/* Main content */}
      <div className="bg-white rounded-[20px] p-5 pt-8">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {/* Product Image */}
          <div className="mb-4 md:mb-0">
            <Image
              src={getImageUrl(product.hinhAnh)}
              alt={product.tenDungCu}
              width={500}
              height={500}
              quality={15}
              className="rounded-[20px] w-full max-w-[500px]"
              priority
            />
          </div>

          {/* Product Info */}
          <div>
            <h1 className="text-2xl md:text-3xl font-bold">{product.tenDungCu}</h1>

            {/* Price */}
            <div className="mt-3">
              {hasDiscount ? (
                <h3 className="flex flex-wrap items-center gap-2">
                  <span className="text-red-600 font-bold text-xl md:text-2xl">
                    {formatCurrency(product.giaKhuyenMai!)}
                  </span>
                  <del className="text-gray-500 text-lg">
                    {formatCurrency(product.gia)}
                  </del>
                  <span className="bg-[#f8d9d6] text-red-600 text-[15px] px-1.5 py-0.5">
                    -{discountPercent}%
                  </span>
                </h3>
              ) : (
                <h2>
                  <span className="text-red-600 font-bold text-xl md:text-2xl">
                    {formatCurrency(product.gia)}
                  </span>
                </h2>
              )}
            </div>

            {/* Category & Manufacturer */}
            <div className="mt-3 space-y-1 text-sm">
              {product.loaiDungCu && <p>{product.loaiDungCu.tenLoaiDungCu}</p>}
              {product.nhaSanXuat && <p>{product.nhaSanXuat.tenNSX}</p>}
            </div>

            {/* ThongTin (short info) */}
            {product.thongTin && (
              <div className="mt-3 whitespace-pre-line text-sm min-h-[100px]">
                {product.thongTin}
              </div>
            )}

            <hr className="my-4 border-[#5d5d5d]" />

            {/* Add to Cart */}
            <AddToCartSection productId={product.id_DungCu} inStock={inStock} />

            <hr className="my-4 border-[#5d5d5d]" />
          </div>
        </div>
      </div>

      {/* Product Description Section */}
      <div className="bg-white rounded-[20px] p-5 mt-5">
        <div className="text-center mb-4">
          <h4>Chi tiết sản phẩm</h4>
        </div>
        {product.moTa && (
          <div
            className="whitespace-pre-line text-sm"
            dangerouslySetInnerHTML={{ __html: product.moTa }}
          />
        )}
        <div className="mt-4 text-sm space-y-1">
          <p>Mã sản phẩm: {product.id_DungCu}</p>
          <p>Kho: {product.soLuong}</p>
          {product.nhaCungCap && (
            <>
              <p>Nhà cung cấp: {product.nhaCungCap.tenNhaCungCap}</p>
              <ul className="list-disc ml-8">
                {product.nhaCungCap.diaChi && <li>Địa chỉ: {product.nhaCungCap.diaChi}</li>}
                {product.nhaCungCap.soDienThoai && <li>Hotline: {product.nhaCungCap.soDienThoai}</li>}
                {product.nhaCungCap.email && <li>Email: {product.nhaCungCap.email}</li>}
              </ul>
            </>
          )}
          {product.nhaSanXuat && (
            <>
              <p>Thương hiệu: {product.nhaSanXuat.tenNSX}</p>
              <ul className="list-disc ml-8">
                {product.nhaSanXuat.diaChi && <li>Địa chỉ: {product.nhaSanXuat.diaChi}</li>}
                {product.nhaSanXuat.email && <li>Email: {product.nhaSanXuat.email}</li>}
              </ul>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
