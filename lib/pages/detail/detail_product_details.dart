import 'package:flutter/material.dart';

class ProductDetailsSection extends StatelessWidget {
  final String description;

  const ProductDetailsSection({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 20),
          Divider(thickness: 2, color: Colors.grey[300]),
        ],
      ),
    );
  }
}
