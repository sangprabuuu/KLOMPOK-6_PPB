class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  // Factory untuk membuat UserModel dari Firebase snapshot
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
    );
  }

  // Konversi UserModel ke Map untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}
