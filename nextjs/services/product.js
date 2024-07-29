export async function getAllProduct(){
    const res = await fetch('http://localhost:5209/api/SanPham');
    if (!res.ok) {
        throw new Error('Failed to fetch products');
    }
    return await res.json();

}
export async function getProductById(id){
    const res = await fetch(`http://localhost:5209/api/SanPham/${id}`);
    if (!res.ok) {
        throw new Error('Failed to fetch product');
    }
    return await res.json();
}