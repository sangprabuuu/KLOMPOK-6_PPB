import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopee/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopee',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: LandingPage(), // Pastikan ini adalah halaman awal aplikasi
    );
  }
}
