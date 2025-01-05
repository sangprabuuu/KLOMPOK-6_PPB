import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String _baseUrl = 'https://fakestoreapi.com';

  // Fungsi untuk mengambil semua produk
  Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));

      if (response.statusCode == 200) {
        return json.decode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  // Fungsi untuk mengambil detail produk berdasarkan ID
  Future<Map<String, dynamic>> fetchProductDetail(String productId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/$productId'));

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch product detail');
      }
    } catch (e) {
      print('Error fetching product detail: $e');
      rethrow;
    }
  }
}
