import 'package:flutter/material.dart';
import 'package:whiskflourish/services/cart_service.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // This is just a sample data. Replace this with your actual cart data.
  final CartService cartService = CartService();
  late Future<List<CartItem>> futureCartItems;
  late Future<double> futureTotal;

  @override
  void initState() {
    super.initState();

    futureCartItems = cartService.getCartItems();
    futureTotal = cartService.getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar.large(
            title: Text('Giỏ hàng'),
            backgroundColor: Color(0xfff8d9d6),
          ),
          FutureBuilder<List<CartItem>>(
            future: futureCartItems,
            builder: (context, snapshot) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (snapshot.hasData) {
                      final cart = snapshot.data![index];
                      return Column(
                        children: [
                          ListTile(
                            leading: Image.network(cart.imageUrl),
                            title: Text(cart.name),
                            subtitle: Text('x${cart.quantity}'),
                            trailing: Text('${cart.price.round()}₫'),
                            isThreeLine: true,
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
            },
          ),
          SliverFillRemaining(
            child: BottomAppBar(
              child: Container(
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(
                    maxHeight: 100), // Tăng maxHeight để đủ chỗ cho các phần tử
                child: FutureBuilder<double>(
                  future: futureTotal,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Giỏ hàng trống');
                    } else {
                      var total = snapshot.data;
                      // Use total to build your UI
                      return Column(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // Đặt phần tử xuống cuối
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tổng cộng:',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                // ignore: unnecessary_brace_in_string_interps
                                '${total?.round()}₫',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height:
                                  10), // Khoảng cách giữa tổng cộng và nút thanh toán
                          ElevatedButton(
                            onPressed: () async {
                              const url = 'http://35.223.233.219/Cart/CheckOut';
                              // ignore: deprecated_member_use
                              if (await canLaunch(url)) {
                                // ignore: deprecated_member_use
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                              // Handle the payment process here
                            },
                            child: const Text('Thanh toán'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
