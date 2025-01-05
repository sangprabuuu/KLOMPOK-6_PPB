import 'package:flutter/material.dart';

class DetailReviews extends StatelessWidget {
  const DetailReviews({Key? key}) : super(key: key);

  // Dummy data untuk review
  final List<Map<String, dynamic>> reviews = const [
    {
      "username": "riniputrik",
      "rating": 5,
      "review":
          "Lucu banget! Walaupun harus menunggu 3 hari, hasilnya sangat memuaskan. Detail rapi, recommended banget!",
      "profileImage": null, // Null akan menggunakan default avatar
    },
    {
      "username": "s*****a",
      "rating": 4,
      "review":
          "Kualitas sesuai dengan harga. Pengemasan rapi dan produk tiba dengan aman. Terima kasih!",
      "profileImage": null,
    },
    {
      "username": "john_doe",
      "rating": 5,
      "review":
          "Perfect for what I needed! Super high quality and fast delivery. Will definitely buy again.",
      "profileImage": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: review["profileImage"] != null
                          ? NetworkImage(review["profileImage"])
                          : null,
                      child: review["profileImage"] == null
                          ? Icon(Icons.person, size: 20, color: Colors.grey)
                          : null,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review["username"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: List.generate(
                              review["rating"],
                              (index) => Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            review["review"],
                            style: TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
