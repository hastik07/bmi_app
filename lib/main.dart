import 'package:flutter/cupertino.dart';
import 'package:ibmi_app/pages/main_page.dart';
import 'dart:developer' as developer;

  void main() {
    developer.log("\x1B[37mIBMI App Starting\x1B[0m");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'IBMI',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (BuildContext context) => const MainPage(),
      },
      initialRoute: '/',
    );
  }
}
