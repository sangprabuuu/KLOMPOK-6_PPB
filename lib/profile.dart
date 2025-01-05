import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileScreen extends StatefulWidget {
  final String userId; // ID pengguna dari Firestore

  const ProfileScreen({super.key, required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variable untuk menyimpan data pengguna
  Map<String, dynamic>? userData;

  // Fungsi untuk mengambil data dari Firestore
  Future<void> fetchUserData() async {
    try {
      // Ambil dokumen pengguna berdasarkan userId
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user') // Nama koleksi "user"
          .doc(widget.userId)
          .get();

      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data() as Map<String, dynamic>;
        });
        print("Data pengguna: $userData");
      } else {
        print("Dokumen tidak ditemukan untuk userId: ${widget.userId}");
      }
    } catch (e) {
      print("Error saat mengambil data pengguna: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Ambil data pengguna saat widget diinisialisasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEE4D2D), // Shopee Orange
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Toko Saya',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Navigasi ke halaman pengaturan
            },
          ),
        ],
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator()) // Loading indikator
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Profil
                  _buildProfileHeader(),
                  // Pesanan Saya
                  _buildSection(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Pesanan Saya',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Lihat Riwayat Pesanan',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF113366), // Men Blue
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildOrderOption(Icons.payment, 'Belum Bayar'),
                            _buildOrderOption(Icons.inventory, 'Dikemas'),
                            _buildOrderOption(Icons.local_shipping, 'Dikirim'),
                            _buildOrderOption(Icons.reviews, 'Beri Penilaian'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Menu Lainnya
                  _buildSection(
                    child: Column(
                      children: [
                        _buildMenuTile(
                          icon: Icons.account_balance_wallet,
                          title: 'ShopeePay',
                          onTap: () {
                            // Tambahkan navigasi ke ShopeePay
                          },
                        ),
                        const Divider(height: 1),
                        _buildMenuTile(
                          icon: Icons.card_giftcard,
                          title: 'Voucher Saya',
                          onTap: () {
                            // Navigasi ke Voucher Saya
                          },
                        ),
                        const Divider(height: 1),
                        _buildMenuTile(
                          icon: Icons.money,
                          title: 'SPayLater',
                          onTap: () {
                            // Navigasi ke SPayLater
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: const Color(0xFFEE4D2D), // Shopee Orange
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: userData == null
                ? const Center(child: CircularProgressIndicator()) // Loading
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData?['username'] ?? 'Nama Tidak Ditemukan',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userData?['email'] ?? 'Email Tidak Ditemukan',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              // Tambahkan aksi untuk Edit Profil
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFEE4D2D), // Shopee Orange
            ),
            child: const Text('Edit Profil'),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({String? title, required Widget child}) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }

  Widget _buildOrderOption(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFEE4D2D), size: 30), // Shopee Orange
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFEE4D2D)), // Shopee Orange
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
