import 'package:flutter/material.dart';
import 'package:shopee/pages/register/register_page.dart';
import '../../services/auth_service.dart'; 
import 'login_form.dart'; 
import 'login_header.dart';


class LoginPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  LoginPage({Key? key}) : super(key: key);

  // Fungsi untuk login pengguna
  Future<void> _loginUser(BuildContext context, String phone, String password) async {
    try {
      String? userId = await _authService.login(phone, password);

      if (userId != null) {
        // Login berhasil
        Navigator.pushReplacementNamed(context, '/home', arguments: userId); // Pindah ke halaman Home
      } else {
        // Login gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nomor telepon atau password salah!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: const Color(0xFFEE4D2D),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40), // Spasi di atas header
          const LoginHeader(), // Tambahkan header
          const SizedBox(height: 40), // Spasi antara header dan form
          Expanded(
            child: LoginForm(
              onLogin: (phone, password) => _loginUser(context, phone, password),
            ),
          ),
          // Link ke halaman registrasi
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
                'Belum punya akun? Daftar',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
