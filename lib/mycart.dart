import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCartPage extends StatefulWidget {
  final String userId; // Tambahkan userId untuk mengidentifikasi pengguna

  const MyCartPage({Key? key, required this.userId}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  bool _isSearchBarVisible = false; // Untuk mengontrol visibilitas search bar
  TextEditingController _searchController = TextEditingController();
  Map<String, bool> _selectedItems =
      {}; // Menyimpan status pilihan setiap produk

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
        title: _isSearchBarVisible
            ? TextField(
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
                  setState(() {}); // Memicu pembaruan UI
                },
              )
            : Text(
                "Keranjang Saya",
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          if (!_isSearchBarVisible)
            IconButton(
              icon: Icon(Icons.search, color: Colors.red),
              onPressed: () {
                setState(() {
                  _isSearchBarVisible = true; // Menampilkan search bar
                });
              },
            ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .where('userId', isEqualTo: widget.userId)
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

                    // Pastikan status pilihan produk tersimpan
                    _selectedItems[cartItem.id] ??= false;

                    return _buildCartItem(
                      cartId: cartItem.id,
                      shopName: cartData['shopName'] ?? 'Toko Tidak Diketahui',
                      imageUrl: cartData['imageUrl'] ?? '',
                      productName:
                          cartData['productName'] ?? 'Produk Tidak Diketahui',
                      variation: cartData['variation'] ?? '-',
                      price: cartData['price'] ?? 0,
                      quantity: cartData['quantity'] ?? 1,
                    );
                  },
                );
              },
            ),
          ),
          Divider(height: 1, color: const Color.fromARGB(255, 56, 55, 55)),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required String cartId,
    required String shopName,
    required String imageUrl,
    required String productName,
    required String variation,
    required int price,
    required int quantity,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 75, 72, 72)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _selectedItems[cartId],
                    onChanged: (value) {
                      setState(() {
                        _selectedItems[cartId] = value!;
                      });
                    },
                  ),
                  Icon(Icons.store, color: Colors.red, size: 20),
                  SizedBox(width: 4),
                  Text(shopName, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              IconButton(
                onPressed: () {
                  // Hapus item dari cart
                  FirebaseFirestore.instance
                      .collection('cart')
                      .doc(cartId)
                      .delete();
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
          Row(
            children: [
              Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(variation, style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rp${price.toString()}',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Kurangi jumlah
                                if (quantity > 1) {
                                  FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(cartId)
                                      .update({'quantity': quantity - 1});
                                }
                              },
                              icon: Icon(Icons.remove_circle_outline),
                              color: Colors.grey,
                            ),
                            Text('$quantity',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () {
                                // Tambah jumlah
                                FirebaseFirestore.instance
                                    .collection('cart')
                                    .doc(cartId)
                                    .update({'quantity': quantity + 1});
                              },
                              icon: Icon(Icons.add_circle_outline),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onPressed: () => _checkoutSelectedItems(),
            child: Text(
              'Checkout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkoutSelectedItems() async {
    final selectedCartIds = _selectedItems.keys
        .where((cartId) => _selectedItems[cartId] == true)
        .toList();

    if (selectedCartIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pilih produk untuk di-checkout!")),
      );
      return;
    }

    List<Map<String, dynamic>> orderItems = [];

    for (String cartId in selectedCartIds) {
      final cartItem =
          await FirebaseFirestore.instance.collection('cart').doc(cartId).get();

      if (cartItem.exists && cartItem.data() != null) {
        // Jika dokumen ada dan memiliki data
        orderItems.add(cartItem.data()!);

        // Hapus item dari cart setelah checkout
        await cartItem.reference.delete();
      } else {
        // Log jika ada dokumen yang tidak ditemukan
        print("Cart item dengan ID $cartId tidak ditemukan atau kosong.");
      }
    }

    if (orderItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tidak ada item yang valid untuk di-checkout!")),
      );
      return;
    }

    // Simpan order ke Firestore
    await FirebaseFirestore.instance.collection('orders').add({
      'userId': widget.userId,
      'items': orderItems,
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Checkout berhasil!")),
    );
  }
}
