import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class Order{
  final String idOrder;
  final DateTime OrderDate;
  final double Total;
  final String Status;
  Order({required this.idOrder, required this.OrderDate, required this.Total, required this.Status});
  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      idOrder: json['id_DonHang'],
      OrderDate: DateTime.parse(json['donHang']['ngayDat']),
      Total: json['donHang']['tongTien'].toDouble(),
      Status: json['trangThaiVanChuyen']['tenTrangThai'],
    );
  }


}
class OrderService {
  Future<List<Order>> getOrderList() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final response =
        await http.get(Uri.parse('http://34.150.89.227/api/Order/$uid'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      return throw Exception('Đã có lỗi xảy ra đi tải danh sách đơn hàng.');
    }
  }
}