import 'package:flutter/material.dart';
import 'package:shopee/pages/profile/services/user_service.dart';

import 'profile_header.dart' as header;
import 'profile_orders.dart' as orders;
import 'profile_menu.dart' as menu;

class ProfileScreen extends StatefulWidget {
  final String userId; // ID pengguna dari Firestore

  const ProfileScreen({super.key, required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variable untuk menyimpan data pengguna
  Map<String, dynamic>? userData;

  // Instance dari UserService
  final UserService _userService = UserService();

  // Fungsi untuk mengambil data dari Firestore
  Future<void> fetchUserData() async {
    final data = await _userService.fetchUserData(widget.userId);
    setState(() {
      userData = data;
    });
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
                  header.ProfileHeader(userData: userData),
                  _buildSection(
                    child: const orders.ProfileOrders(),
                  ),
                  _buildSection(
                    child: const menu.ProfileMenu(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSection({required Widget child}) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }
}
