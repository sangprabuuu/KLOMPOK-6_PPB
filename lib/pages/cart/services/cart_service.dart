import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final String userId;

  CartService({required this.userId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Menambahkan produk ke keranjang
  Future<void> addToCart({
    required String productId,
    required String productName,
    required double price,
    required String imageUrl,
    int quantity = 1,
  }) async {
    try {
      final cartRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('keranjang'); // Koleksi keranjang untuk user

      // Mengecek apakah produk sudah ada di keranjang
      final querySnapshot = await cartRef
          .where('productId', isEqualTo: productId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Jika produk sudah ada, tambahkan jumlahnya
        final docId = querySnapshot.docs.first.id;
        final currentQuantity = querySnapshot.docs.first['quantity'];
        await cartRef.doc(docId).update({'quantity': currentQuantity + quantity});
      } else {
        // Jika produk belum ada, tambahkan sebagai item baru
        await cartRef.add({
          'productId': productId,
          'productName': productName,
          'price': price,
          'imageUrl': imageUrl,
          'quantity': quantity,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Gagal menambahkan produk ke keranjang: $e');
    }
  }

  /// Menghapus item dari keranjang
  Future<void> removeItem(String cartId) async {
    try {
      final cartRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('keranjang')
          .doc(cartId);

      await cartRef.delete();
    } catch (e) {
      throw Exception('Gagal menghapus item dari keranjang: $e');
    }
  }

  /// Memperbarui jumlah item di keranjang
  Future<void> updateQuantity(String cartId, int newQuantity) async {
    if (newQuantity < 1) {
      throw Exception('Jumlah tidak boleh kurang dari 1');
    }

    try {
      final cartRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('keranjang')
          .doc(cartId);

      await cartRef.update({'quantity': newQuantity});
    } catch (e) {
      throw Exception('Gagal memperbarui jumlah item di keranjang: $e');
    }
  }

  /// Mendapatkan semua item di keranjang
  Stream<QuerySnapshot> getCartItems() {
    try {
      return _firestore
          .collection('users')
          .doc(userId)
          .collection('keranjang')
          .orderBy('timestamp', descending: true)
          .snapshots();
    } catch (e) {
      throw Exception('Gagal mendapatkan data keranjang: $e');
    }
  }
}
