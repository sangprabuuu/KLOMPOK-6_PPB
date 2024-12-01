import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              // Tambahkan navigasi ke pengaturan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Profil
            Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kelompok 6',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '37 Pengikut  ·  90 Mengikuti',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                ],
              ),
            ),
            // Pesanan Saya Section
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
                  _buildMenuTile(Icons.account_balance_wallet, 'ShopeePay'),
                  const Divider(height: 1),
                  _buildMenuTile(Icons.card_giftcard, 'Voucher Saya'),
                  const Divider(height: 1),
                  _buildMenuTile(Icons.money, 'SPayLater'),
                  const Divider(height: 1),
                  _buildMenuTile(Icons.support, 'Asuransi'),
                ],
              ),
            ),
            // Aktivitas Saya
            _buildSection(
              title: 'Aktivitas Saya',
              child: Column(
                children: [
                  _buildMenuTile(Icons.favorite, 'Favorit Saya'),
                  const Divider(height: 1),
                  _buildMenuTile(Icons.store, 'Shopee Affiliate Program'),
                  const Divider(height: 1),
                  _buildMenuTile(Icons.live_tv, 'Live dan Video'),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildMenuTile(IconData icon, String title) {
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
      onTap: () {
        // Tambahkan navigasi ke halaman terkait
      },
    );
  }
}
