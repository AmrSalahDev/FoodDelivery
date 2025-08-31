import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double size;
  final Widget icon;

  const CustomCircleButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.size,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,

        shape: const CircleBorder(),
        minimumSize: Size(size, size),
      ),
      icon: icon,
    );
  }
}
