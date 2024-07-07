import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class OrderDetailScreen extends StatefulWidget {
  final String order;

  const OrderDetailScreen({required this.order, super.key,});
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}
class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('http://34.150.89.227/Account/OrderDetail2/${widget.order}'),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Thông tin đơn hàng'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}