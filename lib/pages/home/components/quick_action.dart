import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final List<Map<String, dynamic>> quickActions = [
    {"icon": Icons.account_balance_wallet, "label": "Isi Saldo", "color": Colors.orange},
    {"icon": Icons.fastfood, "label": "ShopeeFood", "color": Colors.red},
    {"icon": Icons.add_circle_outline, "label": "ShopeePlus", "color": Colors.purple},
    {"icon": Icons.card_giftcard, "label": "Hadiah", "color": Colors.blue},
    {"icon": Icons.more_horiz, "label": "Lainnya", "color": Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: quickActions.map((action) {
          return Column(
            children: [
              CircleAvatar(
                backgroundColor: action["color"].withOpacity(0.2),
                radius: 25,
                child: Icon(
                  action["icon"],
                  color: action["color"],
                  size: 30,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                action["label"],
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
