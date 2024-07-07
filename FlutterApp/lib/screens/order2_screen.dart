import 'package:flutter/material.dart';
import 'package:whiskflourish/screens/order_detail_screen.dart';
import 'package:whiskflourish/services/order_service.dart';

class Order2Screen extends StatefulWidget {
  const Order2Screen({super.key});

  @override
  State<Order2Screen> createState() => _Order2ScreenState();
}

class _Order2ScreenState extends State<Order2Screen> {
  final OrderService orderService = OrderService();
  late Future<List<Order>> futureOrder;
  @override
    void initState() {
      super.initState();

      futureOrder = orderService.getOrderList();

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar.large(
            title: Text('Đơn hàng của bạn'),
            backgroundColor: Color(0xfff8d9d6),
          ),
          FutureBuilder<List<Order>>(
            future: futureOrder, builder:(context, snapshot){
               return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (snapshot.hasData) {
                      final order = snapshot.data![index];
                      return Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.local_shipping),
                            title: Text('Đơn hàng ${order.idOrder.substring(order.idOrder.length - 10)}'), // Thay thế 'Đơn hàng $index' bằng dữ liệu thực tế
                            subtitle: Text('${order.OrderDate.day}/${order.OrderDate.month}/${order.OrderDate.year} ${order.OrderDate.hour}:${order.OrderDate.minute}\n${order.Status}'),
                            
                            trailing: Text('${order.Total.round()}₫'
                            ),
                            onTap: () {
                              //Mở webview
                              //Mở trang
                              //Mở screen About
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                    order: order.idOrder,
                                  ),
                                ),
                              );
                              // Xử lý khi người dùng nhấn vào một đơn hàng
                            },

                            isThreeLine: true, // Thay thế 'Chi tiết đơn hàng $index' bằng dữ liệu thực tế
                          ),
                          const Divider(
                            height: 0,
                          ),
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  childCount: snapshot.hasData ? snapshot.data!.length : 0,
                ),
            
          );
            })
        ],
      ),
         
        
      
    );
  }
}