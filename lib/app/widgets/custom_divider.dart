import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  final Color? color;
  final double? thickness;
  final double? height;
  final double? indent;
  final double? endIndent;

  const CustomDivider({
    super.key,
    this.color,
    this.thickness,
    this.height,
    this.indent,
    this.endIndent,
    required this.title,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: color)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: textStyle ?? TextStyle(color: color, fontSize: 14),
              ),
            ),
            Expanded(child: Divider(color: color)),
          ],
        ),
      ],
    );
  }
}
