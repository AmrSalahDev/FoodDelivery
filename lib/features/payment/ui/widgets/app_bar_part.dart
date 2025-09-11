import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarPart extends StatelessWidget {
  const AppBarPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          backgroundColor: Color(0xFFECF0F4),
          size: 55.h,
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkBlue,
            size: 20.h,
          ),
        ),
        SizedBox(width: 15.w),
        Text(
          AppStrings.payment,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}
