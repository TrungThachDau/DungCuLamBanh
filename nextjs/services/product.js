export async function getAllProduct(){
    const res = await fetch('http://localhost:5209/api/SanPham',{cache: "no-store"});
    if (!res.ok) {
        throw new Error('Failed to fetch products');
    }
    return await res.json();
}
export async function getProductById(id){
    const res = await fetch(`http://localhost:5209/api/SanPham/${id}`,{cache: "no-store"});
    if (!res.ok) {
        throw new Error('Failed to fetch product');
    }
    return await res.json();
}
export async function addProduct(formData) {
    const rawFormData = {
        tenSanPham: formData.get('tenSanPham'),
        gia: formData.get('gia'),
        soLuong: formData.get('soLuong'),
        id_LoaiSanPham: formData.get('id_LoaiSanPham'),
        hinhAnh: formData.get('hinhAnh')
    };
    const res = await fetch('http://localhost:5209/api/SanPham', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(rawFormData)
    });
    if (!res.ok) {
        throw new Error('Failed to add product');
    }
    return await res.json();
}
export async function updateProduct(id, formData) {
    const rawFormData = {
        tenSanPham: formData.get('tenSanPham'),
        gia: formData.get('gia'),
        soLuong: formData.get('soLuong'),
        id_LoaiSanPham: formData.get('id_LoaiSanPham'),
        hinhAnh: formData.get('hinhAnh')
    };
    const res = await fetch(`http://localhost:5209/api/SanPham/${id}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(rawFormData)
    });
    if (!res.ok) {
        throw new Error('Failed to update product');
    }
    return await res.json();
}
export async function deleteProduct(id) {
    const res = await fetch(`http://localhost:5209/api/SanPham/${id}`, {
        method: 'DELETE'
    });
    if (!res.ok) {
        throw new Error('Failed to delete product');
    }
    return await res.json();
}
export async function getAllLoaiSanPham(){
    const res = await fetch('http://localhost:5209/api/LoaiSanPham',{cache: "no-store"});
    if (!res.ok) {
        throw new Error('Failed to fetch categories');
    }
    return await res.json();
}
