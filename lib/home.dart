import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'profile.dart';
import 'mycart.dart';
import 'detail_produk.dart'; // Pastikan import DetailProduk

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePageContent(userId: widget.userId),
      ProfileScreen(userId: widget.userId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEE4D2D),
        title: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 36,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari di Shopee',
                hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCartPage(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun Saya',
          ),
        ],
        selectedItemColor: const Color(0xFFEE4D2D),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final String userId;

  HomePageContent({Key? key, required this.userId}) : super(key: key);

  final List<String> sliderImages = const [
    'assets/images/slider1.jpeg',
    'assets/images/slider2.jpeg',
    'assets/images/slider3.jpeg',
  ];

  final List<Map<String, dynamic>> quickActions = [
    {"icon": Icons.account_balance_wallet, "label": "Isi Saldo", "color": Colors.orange},
    {"icon": Icons.fastfood, "label": "ShopeeFood", "color": Colors.red},
    {"icon": Icons.add_circle_outline, "label": "ShopeePlus", "color": Colors.purple},
    {"icon": Icons.card_giftcard, "label": "Hadiah", "color": Colors.blue},
    {"icon": Icons.more_horiz, "label": "Lainnya", "color": Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Slider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
              items: sliderImages.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),

          // Quick Actions Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: quickActions.map((action) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: action["color"].withOpacity(0.2),
                      radius: 25,
                      child: Icon(
                        action["icon"],
                        color: action["color"],
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      action["label"],
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Semua Produk Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Semua Produk',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildAllProductsList(context),
        ],
      ),
    );
  }

  Widget _buildAllProductsList(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: http.get(Uri.parse('https://fakestoreapi.com/products')),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Gagal memuat produk.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final products = json.decode(snapshot.data!.body) as List;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductItem(
              context,
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
      },
    );
  }

  Widget _buildProductItem(
    BuildContext context, {
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
            builder: (context) => DetailProduk(
              userId: userId,
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
              height: 150,
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
