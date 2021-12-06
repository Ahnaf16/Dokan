// ignore_for_file: prefer_const_constructors
import 'package:dokan/Screen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      // themeMode: ThemeMode.system,
      // darkTheme: Mytheme.dark,
      // theme: Mytheme.light,
      home: SplashScreen(),
    );
  }
}
