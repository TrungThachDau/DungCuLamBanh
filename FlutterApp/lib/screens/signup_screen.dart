import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whiskflourish/config/app_env.dart';


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
        AppEnv.account('/Account/SignUp/'),
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
