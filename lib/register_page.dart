import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk input form
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Fungsi untuk menyimpan data ke Firestore
  Future<void> registerUser() async {
    // Periksa apakah form valid
    if (_formKey.currentState!.validate()) {
      // Debugging: Validasi berhasil
      print("Validasi form berhasil.");

      try {
        // Ambil nilai dari input form
        final String phone = _phoneController.text.trim();
        final String username = _usernameController.text.trim();
        final String password = _passwordController.text.trim();
        final String email = _emailController.text.trim();

        // Debugging: Cetak nilai field
        print("Phone: $phone");
        print("Username: $username");
        print("Password: $password");
        print("Email: $email");

        // Data yang akan disimpan di Firestore
        final Map<String, dynamic> data = {
          'phone': phone,
          'username': username,
          'password': password, // Untuk keamanan, hash password di tahap produksi
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        };

        // Debugging: Cetak data yang akan dikirim
        print("Data yang dikirim: $data");

        // Simpan data ke Firestore
        await FirebaseFirestore.instance.collection('user').add(data);

        // Debugging: Konfirmasi data berhasil disimpan
        print("Data berhasil disimpan ke Firestore!");

        // Tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registrasi berhasil!')),
        );

        // Navigasi ke halaman login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        // Debugging: Tampilkan error jika gagal
        print("Error saat menyimpan data ke Firestore: $e");

        // Tampilkan pesan error di aplikasi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } else {
      // Debugging: Validasi form gagal
      print("Validasi form gagal.");
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
                          hintText: 'Nomor Telepon',
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
                      // Input Username
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username tidak boleh kosong';
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
                      // Input Email
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Masukkan email yang valid';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Tombol Registrasi
                      ElevatedButton(
                        onPressed: registerUser,
                        child: Text('Daftar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEE4D2D),
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Link ke Login
                      RichText(
                        text: TextSpan(
                          text: 'Sudah punya akun? ',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
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
