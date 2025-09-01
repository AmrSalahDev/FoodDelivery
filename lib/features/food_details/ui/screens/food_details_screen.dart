import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/app/widgets/custom_circle_button.dart';
import 'package:food_delivery/app/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/app/widgets/favorite_button.dart';
import 'package:food_delivery/app/widgets/select_size_buttons.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/features/food_details/data/models/ingridents_model.dart';
import 'package:food_delivery/features/home/data/models/popular_food_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/buttons/add_to_cart_button.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:readmore/readmore.dart';

class FoodDetailsScreen extends StatefulWidget {
  final PopularFoodModel popularFoodModel;
  const FoodDetailsScreen({super.key, required this.popularFoodModel});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SystemUIWrapper(
      statusBarColor: Color(0xFFFFB872),
      statusBarIconBrightness: Brightness.light,
      navigationBarColor: Color(0xFFF0F5FA),
      navigationBarIconBrightness: Brightness.light,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 350.h,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFB872),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        _buildAppBar(context),
                        Image.asset(
                          widget.popularFoodModel.image,
                          width: 245.w,
                          height: 245.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.popularFoodModel.title,
                        style: GoogleFonts.sen(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        widget.popularFoodModel.subtitle,
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.star,
                            color: AppColors.secondary,
                            size: 20.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            widget.popularFoodModel.rating.toString(),
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF181C2E),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          Icon(
                            FontAwesomeIcons.truck,
                            color: AppColors.secondary,
                            size: 20.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            widget.popularFoodModel.deliveryCost,
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF181C2E),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          Icon(
                            FontAwesomeIcons.clock,
                            color: AppColors.secondary,
                            size: 20.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            widget.popularFoodModel.deliveryTime,
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF181C2E),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      ReadMoreText(
                        "${widget.popularFoodModel.description} ",
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
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Size:",
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFA0A5BA),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          SelectSizeButtons(
                            sizes: ["10”", "14”", "16”"],
                            selectedBackgroundColor: Color(0xFFF58D1D),
                            unselectedBackgroundColor: AppColors.lightGray,
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        "Ingridents",
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GridView.builder(
                        itemBuilder: (context, index) => Column(
                          children: [
                            CustomCircleButton(
                              onPressed: () {},
                              backgroundColor: Color(0xFFFFEBE4),
                              size: 60.h,
                              icon: SvgPicture.asset(
                                IngridentsModel.ingridentsList[index].image,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              IngridentsModel.ingridentsList[index].title,
                              style: GoogleFonts.sen(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF747783),
                              ),
                            ),
                          ],
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.6,
                            ),
                        itemCount: IngridentsModel.ingridentsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 185.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF0F5FA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    AnimatedDigitWidget(
                      value: widget.popularFoodModel.price,
                      textStyle: GoogleFonts.sen(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF181C2E),
                      ),
                      fractionDigits: 0,
                      //enableSeparator: true,
                      //separateSymbol: "·",
                      //separateLength: 2,
                      //decimalSeparator: ",",
                      prefix: "\$",
                      //suffix: "€",
                    ),
                    const Spacer(),
                    AddToCartButton(
                      onIncrement: (value) {},
                      onDecrement: (value) {},
                      maxQuantity: 100,
                      iconBackgroundColor: Colors.white.withAlpha(100),
                      backgroundColor: AppColors.secondary,
                      height: 50,
                      width: 130,
                      iconColor: AppColors.white,
                      countColor: AppColors.white,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomRectangleButton(
                  onPressed: () {},
                  title: "Add to cart",
                  height: 60.h,
                  backgroundColor: AppColors.secondary,
                  titleColor: AppColors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildAppBar(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppColors.white,
          size: 55.h,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.h,
            color: AppColors.darkBlue,
          ),
        ),
        const Spacer(),
        CustomCircleButton(
          backgroundColor: AppColors.white,
          size: 55.h,
          icon: FavoriteButton(
            heartColor: Color(0xFFFF8400),
            size: 24.h,
            onFavorited: () {},
            onUnfavorited: () {},
          ),
        ),
      ],
    );
  }
}
