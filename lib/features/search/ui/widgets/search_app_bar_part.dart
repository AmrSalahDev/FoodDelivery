import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/shared/data/models/food_model.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_cubit.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchAppBarPart extends StatelessWidget {
  const SearchAppBarPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          onPressed: () => context.pop(),
          backgroundColor: AppColors.lightGray,
          size: 55.h,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkBlue,
            size: 20.h,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          AppStrings.search,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.darkBlue,
          ),
        ),
        const Spacer(),
        BlocSelector<CartCubit, List<FoodModel>, int>(
          selector: (state) {
            return state.length;
          },
          builder: (context, state) {
            return state == 0
                ? CustomCircleButton(
                    onPressed: () => context.push(AppPaths.cart),
                    backgroundColor: AppColors.darkBlue,
                    size: 55.h,
                    icon: Icon(
                      FontAwesomeIcons.basketShopping,
                      size: 24.h,
                      color: AppColors.white,
                    ),
                  )
                : Badge(
                    backgroundColor: AppColors.secondary,
                    offset: Offset(-5.w, 0),
                    label: AnimatedDigitWidget(
                      value: state,
                      textStyle: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.white,
                      ),
                    ),
                    child: CustomCircleButton(
                      onPressed: () => context.push(AppPaths.cart),
                      backgroundColor: AppColors.darkBlue,
                      size: 55.h,
                      icon: Icon(
                        FontAwesomeIcons.basketShopping,
                        size: 24.h,
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
