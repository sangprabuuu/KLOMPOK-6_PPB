import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  Future<void> addProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Dapatkan referensi ke koleksi 'products'
        CollectionReference products = FirebaseFirestore.instance.collection('products');

        // Tambahkan produk ke Firestore
        await products.add({
          'productName': _nameController.text.trim(),
          'price': int.parse(_priceController.text.trim()),
          'stock': int.parse(_stockController.text.trim()),
          'imageUrl': _imageController.text.trim(),
          'description': _descriptionController.text.trim(),
          'category': _categoryController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produk berhasil ditambahkan!')),
        );

        // Reset form
        _formKey.currentState!.reset();
      } catch (e) {
        // Tampilkan pesan error jika ada
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Produk"),
        backgroundColor: Color(0xFFEE4D2D), // Shopee Red
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nama Produk"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Harga Produk"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: "Stok Produk"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Stok produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: "URL Gambar Produk"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "URL gambar tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Deskripsi Produk"),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: "Kategori Produk"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Kategori produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addProduct,
                child: Text("Tambahkan Produk"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEE4D2D), // Shopee Red
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
