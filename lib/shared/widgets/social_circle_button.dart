import 'package:flutter/material.dart';

class SocialCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final double? width;
  final double? height;
  final Widget icon;

  const SocialCircleButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.width,
    this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        alignment: Alignment.center,
        width: width ?? 56,
        height: height ?? 56,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(60),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: icon,
      ),
    );
  }
}
