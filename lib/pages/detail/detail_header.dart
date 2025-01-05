import 'package:flutter/material.dart';
import 'package:shopee/pages/cart/cart_page.dart';

class DetailHeader extends StatelessWidget implements PreferredSizeWidget {
  final String productName;
  final String userId;
  final GlobalKey overviewKey;
  final GlobalKey reviewsKey;
  final GlobalKey productDetailsKey;
  final GlobalKey recommendedKey;

  const DetailHeader({
    Key? key,
    required this.productName,
    required this.userId,
    required this.overviewKey, // Key untuk bagian Overview
    required this.reviewsKey, // Key untuk bagian Reviews
    required this.productDetailsKey, // Key untuk bagian Product Details
    required this.recommendedKey, required void Function(dynamic key) onScrollToSection, // Key untuk bagian Recommended
  }) : super(key: key);

  void _scrollToSection(GlobalKey key, BuildContext context) {
    final contextSection = key.currentContext;
    if (contextSection != null) {
      Scrollable.ensureVisible(
        contextSection,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.red),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        productName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Color(0xFFFF4422)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyCartPage(userId: userId)),
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  _scrollToSection(overviewKey, context);
                },
                child: const Text(
                  'Overview',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  _scrollToSection(reviewsKey, context);
                },
                child: const Text(
                  'Reviews',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  _scrollToSection(productDetailsKey, context);
                },
                child: const Text(
                  'Product Details',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  _scrollToSection(recommendedKey, context);
                },
                child: const Text(
                  'Recommended',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
