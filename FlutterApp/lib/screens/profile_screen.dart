import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whiskflourish/screens/about_screen.dart';
import 'package:whiskflourish/screens/order2_screen.dart';
import 'package:whiskflourish/screens/signin_screen.dart';
import 'package:whiskflourish/services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<Customer> _customer;
  
  @override
  void initState() {
    super.initState();
    _loadCustomerProfile();
  }

  void _loadCustomerProfile() {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      String userId = currentUser.uid;
      setState(() {
        _customer = ProfileService().loadProfile(userId);
      });
    }
  }

  Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
        actions: [
          PopupMenuButton(
            onSelected: (value) async => {
              if (value == 'about')
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  ),
                }
              else if (value == 'sign_out')
                {
                  // Đăng xuất
                  await FirebaseAuth.instance.signOut(),
                  // Xóa thông tin phiên đăng nhập

                  // Gọi hàm clearSession
                  await clearSession(),

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  ),
                }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'about',
                  child: Text('Giới thiệu'),
                ),
                const PopupMenuItem(
                  value: 'sign_out',
                  child: Text('Đăng xuất'),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<Customer>(
        future: _customer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final userProfile = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Xin chào, ${userProfile.name}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${userProfile.email}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Số điện thoại: ${userProfile.sdt}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Địa chỉ: ${userProfile.address}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Điểm thưởng: ${userProfile.point} điểm',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Divider(),
                  SizedBox(
                    width: double.infinity, // Chiều rộng 100%
                    child: ElevatedButton(
                      onPressed: () async {
                        const url = 'http://34.150.89.227/Account/Edit';
                        // ignore: deprecated_member_use
                        if (await canLaunch(url)) {
                          // ignore: deprecated_member_use
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Text('Cập nhật thông tin'),
                    ),
                  ),
                  
                  const Divider(),
                  SizedBox(
                    width:double.infinity,
                    child: ElevatedButton(
                    onPressed: () async {
                     //Mở màn hình Order
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Order2Screen(),
                      ),
                    );
                    },
                    child: const Text('Đơn hàng của bạn'),
                  ),
                ),
                  
                  const SizedBox(height: 10),
                  const Divider(),

                ],
                
              ),
            );
          } else {
            return const Center(child: Text('Không có dữ liệu người dùng.'));
          }
        },
      ),
    
    );
  }
}
