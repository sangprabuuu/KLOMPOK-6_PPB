import 'package:flutter/material.dart';
import 'package:tubes_ppb/detail_page2.dart';
import 'package:tubes_ppb/detail_page3.dart';
import 'package:tubes_ppb/detail_page4.dart';
import 'package:tubes_ppb/detail_page5.dart';
import 'package:tubes_ppb/detail_page6.dart';
import 'dart:async'; // Untuk timer pada PageView
import 'profile_page.dart';
import 'cart_page.dart'; // Import halaman CartPage
import 'detail_page1.dart'; // Import halaman DetailPage

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _isTyping = false;
  int _currentIndex = 0;
  int _promoIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _isTyping = _searchController.text.isNotEmpty;
      });
    });

    // Timer untuk menggeser halaman promosi
    Timer.periodic(Duration(seconds: 10), (timer) {
      if (_pageController.hasClients) {
        _promoIndex = (_promoIndex + 1) % 3; // Update ke indeks berikutnya
        _pageController.animateToPage(
          _promoIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          color: Color(0xFFFF4422),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _searchController,
                            textAlignVertical: TextAlignVertical
                                .center, // Memastikan teks di tengah vertikal
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Wear Threek',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10), // Menyesuaikan padding
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                    child:
                        Icon(Icons.shopping_cart_outlined, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          // Bagian promosi
          Column(
            children: [
              Container(
                height: 180, // Mengatur tinggi promosi agar terlihat bagus
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _promoIndex = index;
                    });
                  },
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/promosi1.jpg',
                        fit: BoxFit
                            .fill, // Menyesuaikan ukuran gambar dengan kontainer
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/promosi2.jpg',
                        fit: BoxFit
                            .fill, // Menyesuaikan ukuran gambar dengan kontainer
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/promosi3.jpg',
                        fit: BoxFit
                            .fill, // Menyesuaikan ukuran gambar dengan kontainer
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _promoIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _promoIndex == index ? 12 : 8,
                      height: _promoIndex == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _promoIndex == index
                            ? Color(0xFFFF4422)
                            : Colors.grey,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 0.65,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductPage1()),
                  );
                },
                child: ProductCard(
                  image: AssetImage('assets/produk1.png'),
                  title:
                      'Press O Nails Y2K Ribbon Star Shine - Kuku Palsu Y2K Ribbon Star Shine',
                  price: 'Rp68.900',
                  rating: 5.0,
                  sold: 47,
                  isNew: true,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductPage2()),
                  );
                },
                child: ProductCard(
                  image: AssetImage('assets/produk2.png'),
                  title: "Skechers Moonhiker Women's Sneaker - White",
                  price: 'Rp1.179.000',
                  rating: 5.0,
                  sold: 36,
                  hasDiscount: true,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductPage3()),
                  );
                },
                child: ProductCard(
                  image: AssetImage('assets/produk3.png'),
                  title: 'LABUBU ORIGINAL NEW BLIND BOX SEGEL',
                  price: 'Rp556.800',
                  rating: 5.0,
                  sold: 222,
                  isNew: true,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductPage4()),
                  );
                },
                child: ProductCard(
                  image: AssetImage('assets/produk4.jpg'),
                  title: 'GOODETHICS - Celana Bahan Formal Pria Slimfit',
                  price: 'Rp113.500',
                  rating: 5.0,
                  sold: 785,
                  isNew: true,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductPage5()),
                  );
                },
                child: ProductCard(
                  image: AssetImage('assets/produk5.jpg'),
                  title:
                      'Samsung Galaxy Buds Live Headset Bluetooth Super Clone 1: 1 OEM by AKG TWS Earphone Wireless',
                  price: 'Rp332.547',
                  rating: 5.0,
                  sold: 494,
                  isNew: true,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductPage6()),
                  );
                },
                child: ProductCard(
                  image: AssetImage('assets/produk6.jpg'),
                  title:
                      'Insurgent Club - Heavyweight No Response Embroidery Hoodie Black 330gsm',
                  price: 'Rp313.875',
                  rating: 5.0,
                  sold: 75,
                  isNew: true,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        selectedItemColor: Color(0xFFFF4422),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Saya',
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final dynamic image;
  final String title;
  final String price;
  final double rating;
  final int sold;
  final bool isNew;
  final bool hasDiscount;

  const ProductCard({
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.sold,
    this.isNew = false,
    this.hasDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1, // Gambar dengan rasio 1:1
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: image is String
                  ? Image.network(
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image(
                      image: image as AssetImage,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    color: Color(0xFFFF4422),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 12, color: Colors.amber),
                          SizedBox(width: 2),
                          Text(
                            rating.toString(),
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      '$sold terjual',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
