import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback? onPressed;
  final IconData icon;
  const FavButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: (Colors.red),
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: isLiked ? Colors.red : Colors.black),
      ),
    );
  }
}
