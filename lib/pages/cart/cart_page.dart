import 'package:flutter/material.dart';
import 'package:shopee/pages/cart/services/cart_service.dart';
import 'cart_item.dart';

class MyCartPage extends StatefulWidget {
  final String userId;

  const MyCartPage({Key? key, required this.userId}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = ""; // Variabel untuk menyimpan kata kunci pencarian
  late CartService _cartService;

  @override
  void initState() {
    super.initState();
    _cartService = CartService(userId: widget.userId); // Inisialisasi CartService
  }

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
                setState(() {
                  _searchQuery = value.trim().toLowerCase(); // Update kata kunci pencarian
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _cartService.getCartItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Terjadi kesalahan saat memuat data.",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }

                final cartItems = snapshot.data!.docs;

                // Filter berdasarkan kata kunci pencarian
                final filteredCartItems = cartItems.where((item) {
                  final productName = item['productName'].toString().toLowerCase();
                  return productName.contains(_searchQuery);
                }).toList();

                if (filteredCartItems.isEmpty) {
                  return const Center(
                    child: Text(
                      "Tidak ada produk yang sesuai dengan pencarian.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredCartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = filteredCartItems[index];
                    return CartItem(
                      cartId: cartItem.id,
                      userId: widget.userId,
                      productName: cartItem['productName'],
                      imageUrl: cartItem['imageUrl'],
                      price: cartItem['price'],
                      quantity: cartItem['quantity'],
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
}
