import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';  // Import đúng gói intl
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whiskflourish/screens/order_detail_screen.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  User? _currentUser;
  List<Map<String, dynamic>> _notifications = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _databaseURL = "https://qldclb-770f5-default-rtdb.asia-southeast1.firebasedatabase.app/";

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    
  }

  void _getCurrentUser() {
    User? user = _auth.currentUser;

    if (user != null) {
      setState(() {
        _currentUser = user;
      });

      // Sử dụng `uid` để lấy thông báo
      _loadNotifications(user.uid);
    }
    
  }

  void _loadNotifications(String userId) {
    // Sử dụng URL bạn đã cung cấp để tham chiếu đến Realtime Database
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: _databaseURL);

    DatabaseReference notificationRef = rtdb.ref().child('notification');

    notificationRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?; // Có thể trả về null
      final List<Map<String, dynamic>> notifications = [];

      if (data != null) {
        // Lọc dữ liệu theo userId và sắp xếp từ dưới lên
        final filteredKeys = data.keys.where((key) => data[key]['uid'] == userId).toList();
        filteredKeys.sort((a, b) => b.compareTo(a)); // Sắp xếp từ mới đến cũ

        for (var key in filteredKeys) {
          final notification = data[key];
          notifications.add({
            'timestamp': key,
            'message': notification['message'],
            'link': notification['link'],
            'time': notification['time'],
          });
        }
        if (_notifications.length < notifications.length) {
          _showToast();
        }

        setState(() {
          _notifications = notifications;
        });
      
      }

      setState(() {
        _notifications = notifications;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _currentUser == null
          ? const Center(child: Text('No user logged in'))
          : _notifications.isEmpty
              ? const Center(child: Text("Không có thông báo"))
              : CustomScrollView(
                  slivers: <Widget>[
                    const SliverAppBar.large(
                      title: Text('Thông báo'),
                      backgroundColor: Color(0xfff8d9d6),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final notification = _notifications[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(notification['message']),
                                subtitle: Text(
                                  _formatTime(notification['time']), // Hiển thị thời gian định dạng
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                onTap: () {
                                  //Mở webview
                                  //Mở trang
                                  //Mở screen About
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderDetailScreen(
                                        order: notification['link'],
                                      ),
                                    ),
                                  );
                                  // Xử lý khi người dùng nhấn vào một đơn hàng
                                },
                                 // Hiển thị thời gian
                              ),
                              const Divider(
                            height: 0,
                          ),
                            ],
                          );
                        },
                        childCount: _notifications.length,
                      ),
                    ),
                  ],
                ),
                
    );
    
  }

  String _formatTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedTime = DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
    return formattedTime;
  }
   void _showToast() {
    Fluttertoast.showToast(
      msg: 'Dữ liệu đã được cập nhật thành công!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1, // Thời gian hiển thị trên iOS và Web
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}
