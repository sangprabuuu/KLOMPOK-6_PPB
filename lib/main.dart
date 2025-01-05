import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopee/landing/landing_page.dart';
import 'package:shopee/login/login_page.dart';
import 'pages/home/home_page.dart';
import 'pages/register/register_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          if (args == null) {
            return const Scaffold(
              body: Center(
                child: Text('Error: userId is missing'),
              ),
            );
          }
          return HomePage(userId: args);
        },
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text(
              'Halaman tidak ditemukan!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
