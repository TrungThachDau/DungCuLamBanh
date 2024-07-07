
import 'package:flutter/material.dart';
import 'package:whiskflourish/screens/main_screen.dart';
import 'package:whiskflourish/screens/notification_screen.dart';
import 'package:whiskflourish/screens/search_screen.dart'; // Assuming this import is needed
import 'package:whiskflourish/screens/all_product_screen.dart'; // Assuming this import is needed
// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final webViewController = WebViewController()
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/logodoc.png',
            height: 30,
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SearchBarApp(),
                    ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'Go to the next page',
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                // Handle next page navigation (optional)
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tổng quan'), // First tab
              Tab(text: 'Tất cả'), // Second tab
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            // WebViewWidget(
            //   controller: webViewController,
            // ),

            // Content for first tab
            MainScreenScreen(),
            AllProductScreen(), // Content for second tab
          ],
        ),
      ),
    );
  }
}
