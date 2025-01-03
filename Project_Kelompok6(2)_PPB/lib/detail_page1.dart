import 'package:flutter/material.dart';
import 'package:tubes_ppb/cart_page.dart';
import 'package:tubes_ppb/detail_page3.dart';
import 'package:tubes_ppb/detail_page4.dart';
import 'detail_page2.dart'; // Import halaman detail_page2

class ProductPage1 extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _productImageKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _productDetailsKey = GlobalKey();
  final GlobalKey _recommendedKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFF4422)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Wear Threek',
            hintStyle: TextStyle(color: Color(0xFFFF4422)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 1),
            prefixIcon: Icon(Icons.search, color: Colors.red),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xFFFF4422),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xFFFF4422),
                width: 2.0,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Color(0xFFFF4422)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        _scrollToSection(_productImageKey);
                      },
                      child: Text('Overview',
                          style: TextStyle(color: Color(0xFFFF4422))),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: Colors.grey,
                    ),
                    TextButton(
                      onPressed: () {
                        _scrollToSection(_reviewsKey);
                      },
                      child: Text('Reviews',
                          style: TextStyle(color: Color(0xFFFF4422))),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: Colors.grey,
                    ),
                    TextButton(
                      onPressed: () {
                        _scrollToSection(_productDetailsKey);
                      },
                      child: Text('Product Details',
                          style: TextStyle(color: Color(0xFFFF4422))),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: Colors.grey,
                    ),
                    TextButton(
                      onPressed: () {
                        _scrollToSection(_recommendedKey);
                      },
                      child: Text('Recommended',
                          style: TextStyle(color: Color(0xFFFF4422))),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              key: _productImageKey,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/produk1.png',
                fit: BoxFit.cover,
              ),
            ),

            // Product Price & Sold
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp68.900',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF4422),
                        ),
                      ),
                      Text(
                        '47 Terjual',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Press O Nails Y2K Ribbon Star Shine - Kuku Palsu Y2K Ribbon Star Shine',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Divider(thickness: 5),
                ],
              ),
            ),

            // Store Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 25,
                        child: Text(
                          'CVR',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'cvpshop',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Kota Jakarta Barat',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(thickness: 5),
                ],
              ),
            ),

            // Reviews Section
            Padding(
              key: _reviewsKey,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '5⭐Penilaian Produk (19)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.png'),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'riniputrik',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('⭐⭐⭐⭐⭐'),
                            SizedBox(height: 5),
                            Text(
                                'Lucuuu walaupun po 3 hari tp gpp krna hasilnya bagus rapi banget.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildReview(
                    's*****a',
                    'Jujur cantik bangetttt, bener2 bagus dan rapi banget pokoknya.',
                    'assets/profile.png',
                  ),
                  SizedBox(height: 15),
                  Divider(thickness: 5),
                ],
              ),
            ),

            // Product Description
            Padding(
              key: _productDetailsKey,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spesifikasi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 2, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Press On Nails Y2K Ribbon Star Shine 🎀✨⭐Press On Nails bisa di pakai berulang Free Nail Kit Custom request bisa langsung chat ya kak. Pengiriman menggunakan kotak plastik, jika mau menggunakan acrylic bisa CO kotak acrylic juga. Note: sedikit perbedaan warna bisa saja terjadi 🙏. Tidak memberikan keterangan warna, ukuran, dan bentuk maka akan dikirim ukuran S-M.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 5),
                ],
              ),
            ),

            // Suggested Products
            Padding(
              key: _recommendedKey,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Kamu Mungkin Juga Suka',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildSuggestedProductsGrid(context),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    _showSnackbar(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child:
                      Icon(Icons.shopping_cart, color: Colors.white, size: 30),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi untuk tombol beli sekarang
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF4422),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Beli Sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 200),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: 8),
          Text(
            'Dimasukan Ke Keranjang',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildReview(String username, String comment, String imageUrl) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text('⭐⭐⭐⭐⭐'),
              SizedBox(height: 5),
              Text(comment),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestedProductsGrid(BuildContext context) {
    final products = [
      ProductCard(
        image: AssetImage('assets/produk2.png'),
        title: "Skechers Moonhiker Women's Sneaker - White",
        price: 'Rp1.179.000',
        rating: 5.0,
        sold: 36,
        hasDiscount: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage2()),
          );
        },
      ),
      ProductCard(
        image: AssetImage('assets/produk3.png'),
        title: "LABUBU ORIGINAL NEW BLIND BOX SEGEL",
        price: 'Rp556.800',
        rating: 5.0,
        sold: 222,
        hasDiscount: false,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage3()),
          );
        },
      ),
      ProductCard(
        image: AssetImage('assets/produk4.jpg'),
        title: "GOODETHICS - Celana Bahan Formal Pria Slimfit",
        price: 'Rp113.500',
        rating: 5.0,
        sold: 785,
        hasDiscount: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage4()),
          );
        },
      ),
      ProductCard(
        image: AssetImage('assets/produk5.jpg'),
        title:
            "Samsung Galaxy Buds Live Headset Bluetooth Super Clone 1: 1 OEM by AKG TWS Earphone Wireless",
        price: 'Rp332.547',
        rating: 5.0,
        sold: 494,
        hasDiscount: false,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage2()),
          );
        },
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return products[index];
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String price;
  final double rating;
  final int sold;
  final bool hasDiscount;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.sold,
    this.hasDiscount = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF4422),
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 14),
                      SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    '$sold Terjual',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
