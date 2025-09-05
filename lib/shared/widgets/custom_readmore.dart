import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class CustomReadMore extends StatelessWidget {
  final String text;
  const CustomReadMore({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      "$text ",
      trimMode: TrimMode.Line,
      trimLines: 3,
      style: GoogleFonts.sen(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Color(0xFFA0A5BA),
      ),
      colorClickableText: AppColors.secondary,
      trimCollapsedText: AppStrings.showMore,
      trimExpandedText: AppStrings.showLess,
      moreStyle: GoogleFonts.sen(
        fontSize: 16.sp,
        color: AppColors.secondary,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
