import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_item.dart';

class CartList extends StatelessWidget {
  final String userId;
  final TextEditingController searchController;

  const CartList({Key? key, required this.userId, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('keranjang')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final cartItems = snapshot.data!.docs;

        if (cartItems.isEmpty) {
          return const Center(
            child: Text(
              "Keranjang Anda kosong.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = cartItems[index];
            final cartData = cartItem.data() as Map<String, dynamic>;

            // Filter pencarian
            if (searchController.text.isNotEmpty &&
                !cartData['productName']
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase())) {
              return Container();
            }

            return CartItem(
              cartId: cartItem.id,
              userId: userId,
              productName: cartData['productName'] ?? 'Produk Tidak Diketahui',
              imageUrl: cartData['imageUrl'] ?? '',
              price: cartData['price'] ?? 0,
              quantity: cartData['quantity'] ?? 1,
            );
          },
        );
      },
    );
  }
}
