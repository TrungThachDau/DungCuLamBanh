"use client";
import React from "react";
import { addProduct } from "@/services/product";
const AddProduct = () => {
    const handleAddProduct = async (formData) => {
        try {
            await addProduct(formData);
            window.location.href = "/";
        } catch (error) {
            console.error(error);
        }
    };
    return (
        <div>
            <h1>Thêm sản phẩm mới</h1>
            <form action={handleAddProduct}>
                <div className="form-group">
                    <label htmlFor="name">Tên sản phẩm</label>
                    <input type="text" className="form-control" name="tenSanPham"  placeholder="Nhập tên sản phẩm" />
                </div>
                <div className="form-group">
                    <label htmlFor="price">Giá</label>
                    <input type="number" className="form-control" name="gia" placeholder="Nhập giá" />
                </div>
                <div className="form-group">
                    <label htmlFor="quantity">Số lượng</label>
                    <input type="number" className="form-control" name="soLuong" placeholder="Nhập số lượng" />
                </div>
                <div className="form-group">
                    <label htmlFor="type">Loại sản phẩm</label>
                    <input type="text" className="form-control" name="id_LoaiSanPham" placeholder="Nhập loại sản phẩm" />
                </div>
                <div className="form-group">
                    <label htmlFor="image">Hình ảnh</label>
                    <input type="text" className="form-control" name="hinhAnh" placeholder="Nhập URL hình ảnh" />
                </div>
                <button type="submit" className="btn btn-primary">Thêm sản phẩm</button>
            </form>
        </div>
    );
}
export default AddProduct;