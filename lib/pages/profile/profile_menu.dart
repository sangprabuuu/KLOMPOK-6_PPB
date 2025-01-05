import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
