import 'package:flutter/material.dart';
import 'profile.dart'; // Impor halaman profil
import 'kategori.dart'; // Impor halaman kategori

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Daftar halaman untuk navigasi
  final List<Widget> _pages = [
    HomePageContent(), // Konten Home
    KategoriPage(), // Halaman kategori
    ProfileScreen(), // Halaman profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEE4D2D), // Mail Red
        elevation: 0,
        title: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // Lebar 90% dari layar
            height: 36, // Tinggi lebih kecil
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari di Shopee',
                hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey[700], size: 20),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 5), // Padding atas dan bawah
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Radius lebih kecil
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
      body: _pages[_currentIndex], // Tampilkan halaman sesuai indeks
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
        selectedItemColor: Color(0xFFEE4D2D), // Mail Red
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Konten Halaman Utama
class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          // Banner
          Container(
            color: Color(0xFF113366), // Men Blue
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '7.7 PESTA DISKON SUPERMARKET',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'FLASH SALE',
                  style: TextStyle(
                    color: Color(0xFFEE4D2D), // Mail Red
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
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
                _buildFeatureItem(Icons.card_giftcard, 'Vouchers'),
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
                color: Colors.black,
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
                    'assets/gambar1.jpg', 'Jaket Polos', 'Rp150.000'),
                _buildFlashSaleItem(
                    'assets/gambar2.jpg', 'Jam Benten', 'Rp49.000'),
                _buildFlashSaleItem(
                    'assets/gambar1.jpg', 'Jaket Tidak Polos', 'Rp1.200.000'),
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
