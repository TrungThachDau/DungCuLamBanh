import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {
  Future<List<Product>> getProducts() async {
    final response =
        await http.get(Uri.parse('http://34.150.89.227/api/sanpham'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<List<Product>> getSaleOffProducts() async {
    final response =
        await http.get(Uri.parse('http://34.150.89.227/api/sanpham/khuyenmai'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<List<Product>> getNewProduct() async {
    final response =
        await http.get(Uri.parse('http://34.150.89.227/api/sanpham/newproduct'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final double pricesale;
  final String image;

  Product(
      {
        required this.id,
      required this.name,
      required this.price,
      required this.pricesale,
      this.image =
          'https://royalarcadenorwich.co.uk/wp-content/uploads/2017/07/150x150.png'});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id_DungCu'],
      name: json['tenDungCu'],
      price: json['gia'].toDouble(),
      pricesale: json['giaKhuyenMai'].toDouble(),
      image: json['hinhAnh'] ??
          'https://royalarcadenorwich.co.uk/wp-content/uploads/2017/07/150x150.png',
    );
  }
}
