import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductPage extends StatelessWidget {
  final String userId; // Tambahkan userId sebagai parameter
  final String productName;
  final int price;
  final String imageUrl;
  final String description;

  const ProductPage({
    Key? key,
    required this.userId, // Tambahkan userId sebagai parameter yang diperlukan
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  // Fungsi untuk menambahkan produk ke cart
  Future<void> addToCart(BuildContext context) async {
    try {
      // Simpan produk ke koleksi `cart` di Firestore
      await FirebaseFirestore.instance.collection('cart').add({
        'userId': userId, // Tambahkan userId ke dalam data keranjang
        'productName': productName,
        'price': price,
        'imageUrl': imageUrl,
        'quantity': 1, // Jumlah awal produk
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produk berhasil ditambahkan ke keranjang!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Tampilkan pesan error jika gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEE4D2D),
        title: Text(productName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk
              Center(
                child: Image.network(
                  imageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              // Nama Produk
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Harga Produk
              Text(
                'Rp${price.toString()}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Deskripsi Produk
              const Text(
                'Deskripsi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // Tombol Tambah ke Keranjang
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => addToCart(context),
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Tambah ke Keranjang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEE4D2D), // Shopee Red
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
