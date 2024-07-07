import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetail{
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String moreInfo;
  final String category;
  final String supplier;
  final int quantity;
  ProductDetail({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.moreInfo,
    required this.category,
    required this.supplier,
    required this.quantity,
  });
  factory ProductDetail.fromJson(Map<String, dynamic> json){
    return ProductDetail(
      id: json['id_DungCu'],
      name: json['tenDungCu'],
      price: json['gia'].toDouble(),
      imageUrl: json['hinhAnh'] ?? 'https://royalarcadenorwich.co.uk/wp-content/uploads/2017/07/150x150.png',
      description: json['moTa'],
      moreInfo: json['thongTin'],
      category: json['loaiDungCu']['tenLoaiDungCu'],
      supplier: json['nhaCungCap']['tenNhaCungCap'],
      quantity: json['soLuong'],
    );
}


}
class DetailProductService{
  Future<ProductDetail> getProductDetail(int id) async {
    final response = await http.get(Uri.parse('http://34.150.89.227/api/sanpham/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ProductDetail.fromJson(data);
    } else {
      throw Exception('Lỗi khi tải danh sách sản phẩm');
    }
  }
}