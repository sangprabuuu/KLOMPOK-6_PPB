import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopee/pages/home/components/image_slider.dart';
import 'package:shopee/pages/home/components/product_grid.dart';
import 'package:shopee/pages/home/components/quick_action.dart';


class HomePageContent extends StatelessWidget {
  final String userId;

  const HomePageContent({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageSlider(),
          const SizedBox(height: 16),
          QuickActions(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Semua Produk',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          FutureBuilder<http.Response>(
            future: http.get(Uri.parse('https://fakestoreapi.com/products')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Gagal memuat produk.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              final products = json.decode(snapshot.data!.body) as List;
              return ProductGrid(userId: userId, products: products);
            },
          ),
        ],
      ),
    );
  }
}
