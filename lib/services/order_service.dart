import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fungsi untuk membuat pesanan baru
  Future<void> createOrder(String userId, List<Map<String, dynamic>> items) async {
    try {
      await _firestore.collection('orders').add({
        'userId': userId,
        'items': items,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error creating order: $e');
      rethrow;
    }
  }

  // Fungsi untuk mendapatkan pesanan pengguna
  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error fetching user orders: $e');
      rethrow;
    }
  }
}
