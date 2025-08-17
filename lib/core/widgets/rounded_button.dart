import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Widget? icon;
  final bool isLeft;
  final VoidCallback onPressed;
  const RoundedButton({
    super.key,
    this.isLeft = false,
    required this.title,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).cardColor,
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isLeft
              ? [
                  icon != null ? icon! : SizedBox(),
                  SizedBox(width: 5),
                  Text(title, style: TextStyle(fontSize: 20)),
                ]
              : [
                  Text(title, style: TextStyle(fontSize: 20)),
                  SizedBox(width: 5),
                  icon != null ? icon! : SizedBox(),
                ],
        ),
      ),
    );
  }
}
