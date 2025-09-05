import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRectangleButton extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;

  // Text params
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final Color? titleColor;
  final double? titleSize;

  // Loading params
  final bool isLoading;
  final double? loadingStrokeWidth;
  final Color? loadingColor;

  // Container params
  final Decoration? decoration;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? height;
  final double? width;

  // Action params
  final Function() onPressed;

  CustomRectangleButton({
    super.key,
    this.title,
    required this.onPressed,
    this.backgroundColor,
    this.textStyle,
    this.decoration,
    this.titleWidget,
    this.titleSize,
    this.height,
    this.width,
    this.borderRadius,
    this.titleColor,
    this.loadingStrokeWidth,
    this.isLoading = false,
    this.fontWeight,
    this.loadingColor,
  }) {
    // Text conflict check
    final textParams = [titleColor, titleSize, fontWeight];
    if (textStyle != null && textParams.any((p) => p != null)) {
      throw ArgumentError(
        '❌ In CustomRectangleButton: Either provide textStyle OR (titleColor, titleSize, fontWeight), not both!',
      );
    }

    // Decoration conflict check
    final decorationParams = [borderRadius, backgroundColor];
    if (decoration != null && decorationParams.any((p) => p != null)) {
      throw ArgumentError(
        '❌ In CustomRectangleButton: Either provide decoration OR (backgroundColor, borderRadius), not both!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 60.h,
        decoration:
            decoration ??
            BoxDecoration(
              color: backgroundColor ?? Colors.black,
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
            ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: loadingColor ?? Colors.white,
                  strokeWidth: loadingStrokeWidth ?? 3,
                )
              : titleWidget ??
                    Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      style:
                          textStyle ??
                          TextStyle(
                            color: titleColor ?? Colors.white,
                            fontSize: titleSize ?? 14,
                            fontWeight: fontWeight ?? FontWeight.bold,
                          ),
                    ),
        ),
      ),
    );
  }
}
