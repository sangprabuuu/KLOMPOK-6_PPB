import 'package:flutter/material.dart';
import 'package:shopee/utils/logout.dart'; // Import file logout.dart

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
        const Divider(height: 1),
        _buildMenuTile(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () async {
            final result = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return _buildLogoutConfirmationDialog(context);
              },
            );

            if (result == true) {
              await logout(context); // Panggil fungsi logout dari file logout.dart
            }
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


  Widget _buildLogoutConfirmationDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Column(
        children: [
          Icon(Icons.warning_amber_rounded, size: 48, color: Colors.orange),
          const SizedBox(height: 10),
          const Text(
            "Konfirmasi Logout",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: const Text(
        "Apakah Anda yakin ingin logout? Semua perubahan yang belum disimpan akan hilang.",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Logout"),
        ),
      ],
    );
  }
}
