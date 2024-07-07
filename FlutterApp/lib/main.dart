import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whiskflourish/widget/navbar_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Tệp cấu hình Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  // make flutter draw behind navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whisk & Flourish Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xfff8d9d6)),
        useMaterial3: true,
      ),
      // darkTheme: ThemeData(
      //   primaryColor: Colors.grey[800],
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4a4c4b))
      //       .copyWith(background: Colors.black),
      // ),
      themeMode: ThemeMode.system,
      home: const NavBarWidget(),
    );
  }
}
