import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_cubit.dart';
import 'package:food_delivery/shared/widgets/add_to_cart_button_v2.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchResultPopularFoodPart extends StatefulWidget {
  final String query;
  final Function(FoodModel foodd) onTap;
  const SearchResultPopularFoodPart({
    super.key,
    required this.query,
    required this.onTap,
  });

  @override
  State<SearchResultPopularFoodPart> createState() =>
      _SearchResultPopularFoodPartState();
}

class _SearchResultPopularFoodPartState
    extends State<SearchResultPopularFoodPart> {
  late List<FoodModel> foodList;
  @override
  Widget build(BuildContext context) {
    final Map<String, List<FoodModel>> foodMap = {
      'pizza': FoodModel.pizzaList,
      'burger': FoodModel.burgerList,
      'pasta': FoodModel.pastaList,
      'sandwich': FoodModel.sandwichList,
    };

    foodList = foodMap[widget.query.toLowerCase()] ?? FoodModel.foodList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular ${widget.query}",

          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 50.h),
        BlocBuilder<CartCubit, List<FoodModel>>(
          builder: (context, state) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 45.h,
                mainAxisExtent: 190.h,
              ),
              clipBehavior: Clip.none,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                final popularFood = foodList[index];

                // Check if the food item is in the cart
                final cartItem = context.read<CartCubit>().getFoodFromCart(
                  popularFood,
                );

                final addToCartController = AddToCartController(
                  initialQuantity: cartItem.quantity,
                );
                return _buildPopularFoodItem(
                  popularFood: popularFood,
                  addToCartController: addToCartController,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularFoodItem({
    required FoodModel popularFood,
    required AddToCartController addToCartController,
  }) {
    return GestureDetector(
      onTap: () => widget.onTap(popularFood),
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
                    popularFood.title,
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
                    popularFood.restaurantName,
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
                          value: popularFood.price,
                          prefix: '\$',
                          textStyle: GoogleFonts.sen(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const Spacer(),
                        AddToCartButtonV2(
                          controller: addToCartController,
                          onIncrement: (value) {
                            context.read<CartCubit>().incrementQuantity(
                              popularFood,
                            );
                          },
                          onDecrement: (value) {
                            context.read<CartCubit>().decrementQuantity(
                              popularFood,
                            );
                          },

                          width: 90.w,
                          height: 45.h,
                          backgroundColor: AppColors.secondary,
                          iconColor: AppColors.white,
                          initialSize: 40.h,
                          iconBackgroundColor: Colors.white.withAlpha(100),
                          countColor: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: -45.h,
              child: Image.asset(
                popularFood.image,
                width: constraints.maxWidth * 0.65,
                height: constraints.maxHeight * 0.65,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
