import 'package:flutter/material.dart';

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  bool _isSearchBarVisible = false; // Untuk mengontrol visibilitas search bar
  List<bool> _selectedItems = [false, false];
  List<int> _quantities = [1, 1];
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
                  setState(() {});
                },
              )
            : Text(
                "My Cart",
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
            child: ListView(
              children: [
                if (_searchController.text.isEmpty ||
                    'Jaket Polos'
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase()))
                  _buildCartItem(
                    index: 0,
                    shopName: 'cvpshop',
                    imageUrl: 'assets/images/gambar1.jpg',
                    productName: 'Jaket Polos',
                    variation: '-',
                    price: 'Rp150.000',
                  ),
                if (_searchController.text.isEmpty ||
                    'Jam Tangan'
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase()))
                  _buildCartItem(
                    index: 1,
                    shopName: 'Official Shop',
                    imageUrl: 'assets/images/gambar2.jpg',
                    productName: 'Jam Tangan',
                    variation: '-',
                    price: 'Rp49.000',
                  ),
              ],
            ),
          ),
          Divider(height: 1, color: const Color.fromARGB(255, 56, 55, 55)),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required int index,
    required String shopName,
    required String imageUrl,
    required String productName,
    required String variation,
    required String price,
    String? originalPrice,
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
                  Icon(Icons.store, color: Colors.red, size: 20),
                  SizedBox(width: 4),
                  Text(shopName, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              TextButton(onPressed: () {}, child: Text('Ubah')),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _selectedItems[index],
                onChanged: (value) {
                  setState(() {
                    _selectedItems[index] = value!;
                  });
                },
              ),
              Image.asset(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(price,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            if (originalPrice != null)
                              Text(originalPrice,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  )),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_quantities[index] > 1) {
                                    _quantities[index]--;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove_circle_outline),
                              color: Colors.grey,
                            ),
                            Text('${_quantities[index]}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _quantities[index]++;
                                });
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
    int totalPrice = 0;
    for (int i = 0; i < _selectedItems.length; i++) {
      if (_selectedItems[i]) {
        totalPrice += _quantities[i] * (i == 0 ? 150000 : 49000);
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: _selectedItems.every((item) => item),
                onChanged: (value) {
                  setState(() {
                    _selectedItems = List.filled(_selectedItems.length, value!);
                  });
                },
              ),
              Text('Semua'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Total', style: TextStyle(color: Colors.grey)),
              Text('Rp${totalPrice.toString()}',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onPressed: totalPrice > 0 ? () {} : null,
            child: Text('Checkout (${_selectedItems.where((item) => item).length})',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}