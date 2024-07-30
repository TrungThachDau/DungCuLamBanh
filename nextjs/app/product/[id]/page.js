import React from 'react';
import { getProductById } from "@/services/product";
import { notFound } from "next/navigation";
export const metadata = {
    title: "Ten San pham",
    description: "Product page",
}
export default async function Product({ params }) {
    const { id } = params;
    const product = await getProductById(id);
    if (!product) return notFound();
    //metadata
    metadata.title = product.tenSanPham;
    metadata.description = product.moTa;
    return (
        <div>
            <div className={"row justify-content-center py-3"}>
                <div className={"col-md-6"} style={{ marginBottom: "20px" }}>
                    <img src={product.hinhAnh} alt={"..."} className={"img img-fluid mb-sm-4 mb-md-0"} width={500} height={500} />
                </div>
                <div className={"col-md-6"}>
                    <h2>{product.tenSanPham}</h2>
                    <p>Số lượng: {product.soLuong}</p>
                    <p>Loại sản phẩm: {product.loaiSanPham.tenLoaiSanPham}</p>
                    <p>Price: {product.gia}</p>
                    <button className={"btn btn-primary"}>Add to Cart</button>
                </div>
            </div>
        </div>
    )
}