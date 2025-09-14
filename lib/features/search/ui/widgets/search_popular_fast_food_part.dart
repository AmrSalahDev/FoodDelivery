import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPopularFastFoodPart extends StatefulWidget {
  final Function(FoodModel food) onTap;
  final TextEditingController searchController;
  const SearchPopularFastFoodPart({
    super.key,
    required this.onTap,
    required this.searchController,
  });

  @override
  State<SearchPopularFastFoodPart> createState() =>
      _SearchPopularFastFoodPartState();
}

class _SearchPopularFastFoodPartState extends State<SearchPopularFastFoodPart> {
  late List<FoodModel> foodList;
  @override
  Widget build(BuildContext context) {
    final search = widget.searchController.text.toLowerCase();

    final Map<String, List<FoodModel>> foodMap = {
      'pizza': FoodModel.pizzaList,
      'burger': FoodModel.burgerList,
      'pasta': FoodModel.pastaList,
      'sandwich': FoodModel.sandwichList,
    };

    foodList = foodMap[search] ?? FoodModel.foodList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.popularFastFood,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 45.h),

        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.w,
            mainAxisSpacing: 40.h,
            mainAxisExtent: 150.h,
          ),
          clipBehavior: Clip.none,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            final foodItem = foodList[index];
            return _buildPopularFastFoodItem(foodItem: foodItem);
          },
        ),
      ],
    );
  }

  Widget _buildPopularFastFoodItem({required FoodModel foodItem}) {
    return GestureDetector(
      onTap: () => widget.onTap(foodItem),
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
                  SizedBox(height: constraints.maxHeight * 0.5), // 50%
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
                ],
              ),
            ),

            Positioned(
              top: -35.h,
              child: Image.asset(
                foodItem.image,
                width: constraints.maxWidth * 0.7,
                height: constraints.maxHeight * 0.7,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
