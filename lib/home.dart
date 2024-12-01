import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'profile.dart'; // Impor halaman profil
import 'kategori.dart'; // Impor halaman kategori

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopee Clone',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(), // Konten Home
    KategoriPage(), // Halaman kategori
    ProfileScreen(), // Halaman profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEE4D2D), // Shopee Red
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
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun Saya',
          ),
        ],
        selectedItemColor: Color(0xFFEE4D2D),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final List<String> sliderImages = [
    'assets/images/slider1.jpeg',
    'assets/images/slider2.jpeg',
    'assets/images/slider3.jpeg',
  ];

@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        // Image Slider
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
            ),
            items: sliderImages.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
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
        // Fitur
        Padding(
          padding: EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildFeatureItem(Icons.live_tv, 'Shopee Live'),
              _buildFeatureItem(Icons.payment, 'ShopeePay'),
              _buildFeatureItem(Icons.card_giftcard, 'Voucher'),
              _buildFeatureItem(Icons.widgets, 'Lainnya'),
            ],
          ),
        ),
        // Flash Sale
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'FLASH SALE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 220,
          padding: EdgeInsets.only(left: 16),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFlashSaleItem(
                'assets/images/gambar1.jpg',
                'Jaket Polos',
                'Rp150.000',
              ),
              _buildFlashSaleItem(
                'assets/images/gambar2.jpg',
                'Jam Tangan',
                'Rp49.000',
              ),
              _buildFlashSaleItem(
                'assets/images/gambar1.jpg',
                'Kacamata',
                'Rp1.200.000',
              ),
            ],
          ),
        ),
        // Kategori
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            'Kategori',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              _buildCategoryItem('Fashion'),
              _buildCategoryItem('Elektronik'),
              _buildCategoryItem('Rumah Tangga'),
              _buildCategoryItem('Olahraga'),
              _buildCategoryItem('Hobi'),
              _buildCategoryItem('Makanan & Minuman'),
            ],
          ),
        ),
      ],
    ),
  );
}


  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFFFFE6E0), // Soft Mail Red
          child: Icon(icon, color: Color(0xFFD0011B)), // Dark Red
        ),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildFlashSaleItem(String imagePath, String produk, String price) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover, height: 120, width: 140),
          SizedBox(height: 8),
          Text(
            produk,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              color: Color(0xFFD0011B), // Dark Red
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String categoryName) {
    return Chip(
      label: Text(categoryName),
      backgroundColor: Color(0xFFFFE6E0), // Soft Mail Red
    );
  }
}