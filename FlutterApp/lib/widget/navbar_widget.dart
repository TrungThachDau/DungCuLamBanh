import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiskflourish/screens/cart_screen.dart';
import 'package:whiskflourish/screens/home_screen.dart';
import 'package:whiskflourish/screens/profile_screen.dart';
import 'package:whiskflourish/screens/signin_screen.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  final PageController _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: const Color(0xfff8d9d6),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.shop_rounded),
            label: 'Giỏ hàng',
          ),
          NavigationDestination(
            icon:
              
              Icon(Icons.person),
            
            label: 'Tôi',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
          if (index == 2) {
            checkLoginStatus();
          }
        },
      ),
    );
  }

// Lấy thông tin phiên đăng nhập
  Future<String?> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
  void checkLoginStatus() async {
    String? userId = await getSession();
    if (userId == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }
}
