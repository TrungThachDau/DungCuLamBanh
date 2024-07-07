import 'package:http/http.dart' as http;
import 'dart:convert';
class Customer{
  final String id;
  final String name;
  final String sdt;
  final String email;
  final String address;
  final int point;
  Customer({
    required this.id,
    required this.name,
    required this.sdt,
    required this.email,
    required this.address,
    required this.point,
  });
  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      id: json['id_KhachHang'],
      name: json['tenKhachHang'],
      sdt: json['soDienThoai'],
      email: json['email'],
      address: json['diaChi'],
      point: json['diemThuong'],
    );
  }
}
class ProfileService {

  Future<Customer> loadProfile(String id) async {
    try {
      final response = await http.get(Uri.parse('http://34.150.89.227/api/customer/$id'));
      if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Customer.fromJson(data);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}