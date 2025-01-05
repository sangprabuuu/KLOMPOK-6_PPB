class ProductModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final double rating;
  final int ratingCount;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.ratingCount,
  });

  // Factory untuk membuat ProductModel dari API atau Firebase snapshot
  factory ProductModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ProductModel(
      id: documentId,
      name: data['title'] ?? '',
      price: (data['price'] as num).toDouble(),
      description: data['description'] ?? '',
      imageUrl: data['image'] ?? '',
      rating: (data['rating']['rate'] as num).toDouble(),
      ratingCount: data['rating']['count'] ?? 0,
    );
  }

  // Konversi ProductModel ke Map untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'image': imageUrl,
      'rating': rating,
      'ratingCount': ratingCount,
    };
  }
}
