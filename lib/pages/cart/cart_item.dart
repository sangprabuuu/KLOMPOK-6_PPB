import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem extends StatelessWidget {
  final String cartId;
  final String userId;
  final String productName;
  final String imageUrl;
  final double price;
  final int quantity;

  const CartItem({
    Key? key,
    required this.cartId,
    required this.userId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Gambar produk
          Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
              );
            },
          ),
          const SizedBox(width: 8),
          // Detail produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: quantity > 1
                          ? () {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userId)
                                  .collection('keranjang')
                                  .doc(cartId)
                                  .update({'quantity': quantity - 1});
                            }
                          : null,
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('keranjang')
                            .doc(cartId)
                            .update({'quantity': quantity + 1});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tombol hapus
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .collection('keranjang')
                  .doc(cartId)
                  .delete();
            },
          ),
        ],
      ),
    );
  }
}
