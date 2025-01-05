import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const ProfileHeader({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
