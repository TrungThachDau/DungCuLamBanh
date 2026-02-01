import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:whiskflourish/config/app_env.dart';

class Order {
  final String idOrder;
  final DateTime orderDate;
  final double total;
  final String status;
  Order(
      {required this.idOrder,
      required this.orderDate,
      required this.total,
      required this.status});
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      idOrder: json['id_DonHang'],
      orderDate: DateTime.parse(json['donHang']['ngayDat']),
      total: json['donHang']['tongTien'].toDouble(),
      status: json['trangThaiVanChuyen']['tenTrangThai'],
    );
  }
}

class OrderService {
  Future<List<Order>> getOrderList() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final response = await http.get(AppEnv.api('/api/Order/$uid'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      return throw Exception('Đã có lỗi xảy ra đi tải danh sách đơn hàng.');
    }
  }
}
