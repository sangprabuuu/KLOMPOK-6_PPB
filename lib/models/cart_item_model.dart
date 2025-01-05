class CartItemModel {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  // Factory untuk membuat CartItemModel dari Firebase snapshot
  factory CartItemModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CartItemModel(
      id: documentId,
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      quantity: data['quantity'] ?? 1,
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  // Konversi CartItemModel ke Map untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
