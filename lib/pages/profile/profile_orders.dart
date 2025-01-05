import 'package:flutter/material.dart';

class ProfileOrders extends StatelessWidget {
  const ProfileOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Pesanan Saya',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Lihat Riwayat Pesanan',
              style: TextStyle(fontSize: 14, color: Color(0xFF113366)),
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
    );
  }

  static Widget _buildOrderOption(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFEE4D2D), size: 30),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
