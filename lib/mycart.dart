import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCartPage extends StatefulWidget {
  final String userId;

  const MyCartPage({Key? key, required this.userId}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Keranjang Saya",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Input pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari barang di keranjang',
                prefixIcon: Icon(Icons.search, color: Colors.red),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Memicu pembaruan UI saat pencarian
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.userId)
                  .collection('keranjang') // Pastikan nama koleksi sesuai
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
                    if (_searchController.text.isNotEmpty &&
                        !cartData['productName']
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase())) {
                      return Container();
                    }

                    return _buildCartItem(
                      cartId: cartItem.id,
                      productName: cartData['productName'] ?? 'Produk Tidak Diketahui',
                      imageUrl: cartData['imageUrl'] ?? '',
                      price: cartData['price'] ?? 0,
                      quantity: cartData['quantity'] ?? 1,
                      description: cartData['description'] ?? '',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required String cartId,
    required String productName,
    required String imageUrl,
    required double price,
    required int quantity,
    required String description,
  }) {
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
                                  .doc(widget.userId)
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
                            .doc(widget.userId)
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
                  .doc(widget.userId)
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
