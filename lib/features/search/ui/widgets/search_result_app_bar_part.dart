import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';

class SearchResultAppBarPart extends StatelessWidget {
  final String? query;
  const SearchResultAppBarPart({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppColors.lightGray,
          size: 55.h,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.h,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: Color(0xFFECF0F4), width: 1),
            color: AppColors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SizedBox(width: 15.w),
              Text(query!),
              Icon(
                Icons.arrow_drop_down,
                size: 24.h,
                color: AppColors.secondary,
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
        const Spacer(),
        CustomCircleButton(
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppColors.darkBlue,
          size: 55.h,
          icon: Icon(Icons.search_rounded, size: 20.h, color: AppColors.white),
        ),
        SizedBox(width: 10.w),
        CustomCircleButton(
          onPressed: () {},
          backgroundColor: AppColors.lightGray,
          size: 55.h,
          icon: Assets.icons.icSortSettings.image(height: 20.h, width: 20.h),
        ),
      ],
    );
  }
}
