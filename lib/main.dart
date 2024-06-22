import 'package:flutter/material.dart';
import 'CRUD/AddingScreen.dart';
import 'LoginPage/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      home: InputForm(),
    );
  }
}




