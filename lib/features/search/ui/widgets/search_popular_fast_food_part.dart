import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/shared/cubits/food_cubit.dart';
import 'package:food_delivery/shared/cubits/food_state.dart';
import 'package:food_delivery/shared/domain/entities/food_entity.dart';
import 'package:food_delivery/shared/widgets/shimmer_box.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPopularFastFoodPart extends StatefulWidget {
  final Function(FoodEntity food) onTap;
  const SearchPopularFastFoodPart({super.key, required this.onTap});

  @override
  State<SearchPopularFastFoodPart> createState() =>
      _SearchPopularFastFoodPartState();
}

class _SearchPopularFastFoodPartState extends State<SearchPopularFastFoodPart> {
  @override
  void initState() {
    super.initState();
    context.read<FoodCubit>().getOneFoodPerCategory();
  }

  @override
  Widget build(BuildContext context) {
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
        BlocBuilder<FoodCubit, FoodState>(
          builder: (context, state) {
            if (state is FoodLoading) {
              return _ShimmerItems();
            }
            if (state is FoodLoaded) {
              return _FoodItems(widget: widget, foods: state.foods);
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _FoodItems extends StatelessWidget {
  final List<FoodEntity> foods;
  const _FoodItems({required this.widget, required this.foods});

  final SearchPopularFastFoodPart widget;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 45.h,
        mainAxisExtent: 150.h,
      ),
      clipBehavior: Clip.none,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final foodItem = foods[index];
        return PopularFastFoodItem(
          isLoading: false,
          foodItem: foodItem,
          onTap: widget.onTap,
        );
      },
    );
  }
}

class _ShimmerItems extends StatelessWidget {
  const _ShimmerItems();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 45.h,
        mainAxisExtent: 150.h,
      ),
      clipBehavior: Clip.none,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return PopularFastFoodItem(isLoading: true);
      },
    );
  }
}

class PopularFastFoodItem extends StatelessWidget {
  final FoodEntity? foodItem;
  final Function(FoodEntity food)? onTap;
  final bool isLoading;

  const PopularFastFoodItem({
    super.key,
    this.foodItem,
    this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: foodItem != null && !isLoading
          ? () => onTap?.call(foodItem!)
          : null,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.5), // 50%
                    foodItem != null && !isLoading
                        ? Text(
                            foodItem!.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sen(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBlue,
                            ),
                          )
                        : ShimmerBox(
                            height: 15.h,
                            width: 120.w,
                            margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
                          ),
                    foodItem != null && !isLoading
                        ? Text(
                            foodItem!.restaurantName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sen(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF646982),
                            ),
                          )
                        : ShimmerBox(height: 15.h, width: 100.w),
                  ],
                ),
              ),
            ),

            Positioned(
              top: -30.h,
              child: foodItem != null && !isLoading
                  ? CachedNetworkImage(
                      imageUrl: foodItem!.image,
                      width: constraints.maxWidth * 0.7,
                      height: constraints.maxHeight * 0.7,
                      fit: BoxFit.contain,
                    )
                  : ShimmerBox(
                      height: constraints.maxHeight * 0.7,
                      width: constraints.maxWidth * 0.7,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
