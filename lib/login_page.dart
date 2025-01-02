import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Secure Storage untuk menyimpan data login
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Fungsi untuk login pengguna
  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Ambil nilai input pengguna
        String phone = _phoneController.text.trim();
        String password = _passwordController.text.trim();

        // Query Firestore untuk mencocokkan data pengguna
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('phone', isEqualTo: phone)
            .where('password', isEqualTo: password)
            .get();

        if (snapshot.docs.isNotEmpty) {
          // Dapatkan userId dari dokumen
          String userId = snapshot.docs.first.id;

          print("Login berhasil! User ID: $userId");

          // Simpan userId ke Secure Storage
          await _storage.write(key: 'userId', value: userId);

          // Navigasi ke halaman HomePage dengan userId
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(userId: userId), // Kirim userId ke HomePage
            ),
          );
        } else {
          // Jika data tidak ditemukan
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Nomor telepon atau password salah!')),
          );
        }
      } catch (e) {
        // Tampilkan pesan error jika ada masalah
        print("Error saat login: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      // Logo Shopee
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logo_shoope_polos.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Input Nomor Telepon
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: '(+62) 821-*****-***',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor telepon tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Input Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Password',
                          suffixIcon: Icon(Icons.visibility),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          } else if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Tombol Login
                      ElevatedButton(
                        onPressed: loginUser,
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEE4D2D),
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Link ke Halaman Registrasi
                      RichText(
                        text: TextSpan(
                          text: 'Belum punya akun? ',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Daftar',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
