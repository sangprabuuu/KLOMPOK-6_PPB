import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCartIcon;
  final VoidCallback? onCartPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showCartIcon = false,
    this.onCartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFEE4D2D),
      title: Text(title),
      actions: showCartIcon
          ? [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: onCartPressed,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
