import 'package:flutter/material.dart';
import 'login_page.dart'; // Pastikan file login_page.dart ada
import 'profile_page.dart'; // Pastikan file profile_page.dart ada

class ProfileDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4422),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Kembali ke halaman ProfilePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding:
                EdgeInsets.symmetric(vertical: 16), // Jarak atas dan bawah sama
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/profile.png'), // Gambar lokal
                ),
                SizedBox(height: 16),
              ],
            ),
          ),

          // Info
          Expanded(
            child: ListView(
              children: [
                buildInfoRow('Nama', 'Ka`'),
                buildInfoRow('Bio', 'Atur Sekarang', isEditable: true),
                buildInfoRow('Jenis Kelamin', 'Perempuan', isEditable: true),
                buildInfoRow('Tanggal Lahir', '**/10/20**'),
                buildInfoRow('No. Handphone', '*********79'),
                buildInfoRow('Email', 'Atur Sekarang', isEditable: true),
                SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigasi ke halaman LoginPage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String title, String value, {bool isEditable = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: isEditable ? Colors.blue : Colors.black54,
                ),
              ),
              if (isEditable)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
