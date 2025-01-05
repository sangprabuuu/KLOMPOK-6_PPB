import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Jika menggunakan Firebase Authentication

Future<void> logout(BuildContext context) async {
  try {
    // Jika menggunakan Firebase Authentication
    await FirebaseAuth.instance.signOut();

    // Navigasi ke halaman login (atau sesuai kebutuhan)
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);

    // Tampilkan pesan berhasil logout
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Berhasil logout!")),
    );
  } catch (e) {
    // Tampilkan pesan error jika gagal logout
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Gagal logout: $e")),
    );
  }
}
