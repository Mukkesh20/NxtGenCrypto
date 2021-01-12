import 'package:NextGenCrypto/screens/home_screen.dart';
import 'package:NextGenCrypto/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'screens/coinMarket_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomeScreen(),
    );
  }
}
