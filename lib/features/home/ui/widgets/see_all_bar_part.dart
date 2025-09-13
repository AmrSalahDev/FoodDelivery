import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeAllBarPart extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const SeeAllBarPart({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => onTap?.call(),
          child: Row(
            children: [
              Text(
                AppStrings.seeAll,
                style: GoogleFonts.sen(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF32343E),
                ),
              ),
              SizedBox(width: 5.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFFA0A5BA),
                size: 18.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
