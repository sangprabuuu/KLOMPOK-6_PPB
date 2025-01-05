import 'package:flutter/material.dart';
import '../../detail/detail_page.dart';

class ProductGrid extends StatelessWidget {
  final String userId; // Tambahkan userId di sini
  final List<dynamic> products;

  const ProductGrid({
    Key? key,
    required this.userId,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.6, // Ubah aspek rasio untuk membuat lebih panjang
      ),
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductItem(
          context,
          userId: userId, // Teruskan userId ke tiap item
          productId: product['id'].toString(),
          productName: product['title'],
          price: product['price'].toDouble(),
          imageUrl: product['image'],
          description: product['description'],
          rating: product['rating']['rate'].toDouble(),
          ratingCount: product['rating']['count'],
        );
      },
    );
  }

  Widget _buildProductItem(
    BuildContext context, {
    required String userId,
    required String productId,
    required String productName,
    required double price,
    required String imageUrl,
    required String description,
    required double rating,
    required int ratingCount,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              userId: userId, // Kirim userId
              productId: productId,
              productName: productName,
              price: price,
              imageUrl: imageUrl,
              description: description,
              rating: rating,
              ratingCount: ratingCount,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            Container(
              height: 180, // Tambahkan tinggi agar gambar lebih besar
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFFD0011B),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '($ratingCount)',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
