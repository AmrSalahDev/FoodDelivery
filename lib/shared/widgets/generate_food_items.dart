import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/data/models/food_model.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/buttons/add_to_cart_button.dart';

class GenerateFoodItems extends StatelessWidget {
  final Function(FoodModel foodMdel) onTap;
  final String? label;
  final bool makeIthorizontal;
  final bool showCartButton;
  final List<FoodModel> foodList;

  const GenerateFoodItems({
    super.key,
    required this.onTap,
    this.label,
    this.makeIthorizontal = false,
    required this.showCartButton,
    required this.foodList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null && label!.isNotEmpty) ...[
            Text(
              label!,
              style: GoogleFonts.sen(
                fontSize: 24.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.darkBlue,
              ),
            ),
            SizedBox(height: 30.h),
          ],

          makeIthorizontal
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 15.w,
                    children: List.generate(
                      foodList.length,
                      (index) => SizedBox(
                        width: 160.w,
                        height: 180.h,
                        child: _buildFoodItem(foodItem: foodList[index]),
                      ),
                    ),
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 45.h,
                    mainAxisExtent: 190.h,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: foodList.length,
                  itemBuilder: (context, index) {
                    final foodItem = foodList[index];
                    return _buildFoodItem(foodItem: foodItem);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildFoodItem({required FoodModel foodItem}) {
    return GestureDetector(
      onTap: () => onTap(foodItem),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.4), // 40%
                  Text(
                    foodItem.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sen(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  Text(
                    foodItem.restaurantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sen(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF646982),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      bottom: 7.h,
                    ),
                    child: Row(
                      children: [
                        AnimatedDigitWidget(
                          value: foodItem.price,
                          prefix: '\$',
                          textStyle: GoogleFonts.sen(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const Spacer(),
                        showCartButton
                            ? AddToCartButton(
                                onIncrement: (value) {},
                                onDecrement: (value) {},
                                maxQuantity: 100,
                                width: 75.w,
                                height: 40.h,
                                backgroundColor: AppColors.secondary,
                                iconColor: AppColors.white,
                                initialSize: 40.h,
                                countColor: AppColors.white,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: -35.h,
              child: Image.asset(
                foodItem.image,
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.6,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
