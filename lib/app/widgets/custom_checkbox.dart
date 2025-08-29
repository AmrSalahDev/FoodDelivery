import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';

class CustomCheckbox extends StatefulWidget {
  final Function(bool) onChange;
  const CustomCheckbox({super.key, required this.onChange});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isRemmemberMe = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isRemmemberMe = !isRemmemberMe;
          widget.onChange(isRemmemberMe);
        });
      },
      child: Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: isRemmemberMe ? AppColors.secondary : Colors.transparent,
          border: Border.all(
            color: isRemmemberMe ? Colors.transparent : Color(0xFFE3EBF2),
            width: 2,
          ),
        ),
        child: isRemmemberMe
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : null,
      ),
    );
  }
}
