import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopee/pages/detail/detail_bottom_bar.dart';
import 'package:shopee/pages/detail/detail_header.dart';
import 'package:shopee/pages/detail/detail_overview.dart';
import 'package:shopee/pages/detail/detail_product_details.dart';
import 'package:shopee/pages/detail/detail_recommended.dart';
import 'package:shopee/pages/detail/detail_review.dart';

class DetailPage extends StatelessWidget {
  final String userId;
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;
  final int ratingCount;

  // GlobalKeys untuk navigasi antar bagian
  final GlobalKey overviewKey = GlobalKey();
  final GlobalKey reviewsKey = GlobalKey();
  final GlobalKey productDetailsKey = GlobalKey();
  final GlobalKey recommendedKey = GlobalKey();

  DetailPage({
    Key? key,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.ratingCount,
  }) : super(key: key);

  // Fungsi untuk scroll ke bagian tertentu
  void _scrollToSection(BuildContext context, GlobalKey key) {
    final contextKey = key.currentContext;
    if (contextKey != null) {
      Scrollable.ensureVisible(
        contextKey,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  // Fungsi untuk menambahkan produk ke keranjang
  Future<void> _addToCart(BuildContext context) async {
    try {
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('keranjang');

      await cartRef.add({
        'productId': productId,
        'productName': productName,
        'price': price,
        'imageUrl': imageUrl,
        'description': description,
        'rating': rating,
        'ratingCount': ratingCount,
        'quantity': 1,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk berhasil ditambahkan ke keranjang!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan ke keranjang: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailHeader(
        productName: productName,
        userId: userId,
        overviewKey: overviewKey,
        reviewsKey: reviewsKey,
        productDetailsKey: productDetailsKey,
        recommendedKey: recommendedKey,
        onScrollToSection: (key) => _scrollToSection(context, key),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailOverview(
              key: overviewKey,
              imageUrl: imageUrl,
              price: price,
              productName: productName,
              rating: rating,
              ratingCount: ratingCount,
            ),
            DetailReviews(key: reviewsKey),
            ProductDetailsSection(
              key: productDetailsKey,
              description: description,
            ),
            RecommendedSection(
              key: recommendedKey,
              userId: userId,
            ),
          ],
        ),
      ),
      bottomNavigationBar: DetailBottomBar(
        userId: userId,
        productId: productId,
        productName: productName,
        price: price,
        imageUrl: imageUrl,
        onAddToCart: () => _addToCart(context),
      ),
    );
  }
}
