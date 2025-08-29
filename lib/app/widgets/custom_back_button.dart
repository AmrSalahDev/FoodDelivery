import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: 45.h,
          width: 45.w,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 25.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF5E616F),
            size: 20.h,
          ),
        ),
      ),
    );
  }
}
