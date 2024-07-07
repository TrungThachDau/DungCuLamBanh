import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key,});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('http://34.150.89.227/Account/SignUp/'),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Đăng ký'),
        backgroundColor: const Color(0xfff8d9d6),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}