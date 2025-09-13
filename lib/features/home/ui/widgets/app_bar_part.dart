import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_cubit.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarPart extends StatelessWidget {
  final String fullName;
  const AppBarPart({super.key, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          backgroundColor: Color(0xFFECF0F4),
          size: 60.h,
          icon: Icon(FontAwesomeIcons.barsStaggered, color: AppColors.darkBlue),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.deliverTo.toUpperCase(),
              style: GoogleFonts.sen(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
            SizedBox(
              width: 150.w,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF676767),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.darkBlue,
                    size: 27.h,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        BlocSelector<CartCubit, List<FoodModel>, int>(
          selector: (state) {
            return state.length;
          },
          builder: (context, length) {
            return length == 0
                ? CustomCircleButton(
                    backgroundColor: AppColors.darkBlue,
                    onPressed: () => context.push(AppPaths.cart),
                    size: 60.h,
                    icon: Icon(
                      FontAwesomeIcons.basketShopping,
                      color: AppColors.white,
                    ),
                  )
                : Badge(
                    backgroundColor: AppColors.secondary,
                    offset: Offset(-5.w, -2.h),
                    label: Text(
                      length.toString(),
                      style: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.white,
                      ),
                    ),
                    child: CustomCircleButton(
                      backgroundColor: AppColors.darkBlue,
                      size: 60.h,
                      onPressed: () => context.push(AppPaths.cart),
                      icon: Icon(
                        FontAwesomeIcons.basketShopping,
                        color: AppColors.white,
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
