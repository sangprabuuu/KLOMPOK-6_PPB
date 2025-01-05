import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fungsi untuk login pengguna
  Future<String?> login(String phone, String password) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('user')
          .where('phone', isEqualTo: phone)
          .where('password', isEqualTo: password)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id; // Mengembalikan userId
      } else {
        return null; // Data tidak ditemukan
      }
    } catch (e) {
      print('Error login: $e');
      rethrow; // Lempar kembali error untuk debugging
    }
  }

  // Fungsi untuk mendaftarkan pengguna baru
  Future<void> register(String phone, String password) async {
    try {
      await _firestore.collection('user').add({
        'phone': phone,
        'password': password,
      });
    } catch (e) {
      print('Error register: $e');
      rethrow;
    }
  }
}
