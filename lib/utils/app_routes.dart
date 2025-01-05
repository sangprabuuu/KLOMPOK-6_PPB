import 'package:flutter/material.dart';
import '../pages/home/home_page.dart';
import '../pages/cart/cart_page.dart';
import '../pages/detail/detail_page.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String cart = '/cart';
  static const String detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomePage(userId: settings.arguments as String),
        );
      case cart:
        return MaterialPageRoute(
          builder: (_) => MyCartPage(userId: settings.arguments as String),
        );
      case detail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => DetailPage(
            userId: args['userId'],
            productId: args['productId'],
            productName: args['productName'],
            price: args['price'],
            imageUrl: args['imageUrl'],
            description: args['description'],
            rating: args['rating'],
            ratingCount: args['ratingCount'],
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Halaman tidak ditemukan'),
            ),
          ),
        );
    }
  }
}
