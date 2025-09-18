import 'package:animated_digit/animated_digit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/features/search/ui/cubit/drop_down_cubit.dart';
import 'package:food_delivery/shared/cubits/food_cubit.dart';
import 'package:food_delivery/shared/cubits/food_state.dart';
import 'package:food_delivery/shared/domain/entities/food_entity.dart';
import 'package:food_delivery/shared/widgets/add_to_cart_button_v2.dart';
import 'package:food_delivery/shared/widgets/shimmer_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SearchResultPopularFoodPart extends StatefulWidget {
  final Function(FoodEntity food) onTap;
  final String query;

  const SearchResultPopularFoodPart({
    super.key,
    required this.onTap,
    required this.query,
  });

  @override
  State<SearchResultPopularFoodPart> createState() =>
      _SearchResultPopularFoodPartState();
}

class _SearchResultPopularFoodPartState
    extends State<SearchResultPopularFoodPart> {
  @override
  void initState() {
    super.initState();
    context.read<FoodCubit>().fetchFoods(category: widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodState>(
      builder: (context, state) {
        if (state is FoodLoading) {
          return _ShimmerItems(widget.query);
        }
        if (state is FoodLoaded) {
          if (state.foods.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.lottie.empty.lottie(),
                  SizedBox(height: 20.h),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade600,
                    highlightColor: Colors.grey.shade100,
                    child: Text(
                      AppStrings.noResultsFound,
                      style: GoogleFonts.sen(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF32343E),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return _FoodItems(widget: widget, foods: state.foods);
        }
        return SizedBox.shrink();
      },
    );
  }
}

class _ShimmerItems extends StatelessWidget {
  final String query;
  const _ShimmerItems(this.query);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocSelector<DropDownCubit, DropDownState, String>(
          selector: (state) {
            return state is DropDownSelected ? state.value : query;
          },
          builder: (context, state) {
            return Text(
              "${AppStrings.popular} ${state.capitalizeFirstLetter()}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.sen(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
                color: Color(0xFF32343E),
              ),
            );
          },
        ),
        SizedBox(height: 40.h),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.w,
            mainAxisSpacing: 45.h,
            mainAxisExtent: 190.h,
          ),
          clipBehavior: Clip.none,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) {
            return _PopularFoodItem(isLoading: true);
          },
        ),
      ],
    );
  }
}

class _FoodItems extends StatelessWidget {
  final List<FoodEntity> foods;
  const _FoodItems({required this.widget, required this.foods});

  final SearchResultPopularFoodPart widget;

  @override
  Widget build(BuildContext context) {
    return foods.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocSelector<DropDownCubit, DropDownState, String>(
                selector: (state) {
                  return state is DropDownSelected ? state.value : widget.query;
                },
                builder: (context, state) {
                  return Text(
                    "${AppStrings.popular} ${state.capitalizeFirstLetter()}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.sen(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF32343E),
                    ),
                  );
                },
              ),
              SizedBox(height: 40.h),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 45.h,
                  mainAxisExtent: 180.h,
                ),
                clipBehavior: Clip.none,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final popularFood = foods[index];
                  return _PopularFoodItem(
                    popularFood: popularFood,
                    addToCartController: AddToCartController(),
                    onTap: widget.onTap,
                    isLoading: false,
                  );
                },
              ),
            ],
          );
  }
}

class _PopularFoodItem extends StatelessWidget {
  final FoodEntity? popularFood;
  final AddToCartController? addToCartController;
  final Function(FoodEntity food)? onTap;
  final bool isLoading;

  const _PopularFoodItem({
    this.popularFood,
    this.addToCartController,
    this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: popularFood != null && !isLoading
          ? () => onTap?.call(popularFood!)
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
                    SizedBox(height: constraints.maxHeight * 0.42),
                    popularFood != null && !isLoading
                        ? Text(
                            popularFood!.title,
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
                            width: 120.w,
                            height: 15.h,
                            margin: EdgeInsets.only(bottom: 10.h),
                          ),
                    popularFood != null && !isLoading
                        ? Text(
                            popularFood!.restaurantName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sen(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF646982),
                            ),
                          )
                        : ShimmerBox(width: 100.w, height: 15.h),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        right: 10.w,
                        bottom: 7.h,
                      ),
                      child: Row(
                        children: [
                          popularFood != null && !isLoading
                              ? AnimatedDigitWidget(
                                  value: popularFood!.price,
                                  prefix: '\$',
                                  textStyle: GoogleFonts.sen(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkBlue,
                                  ),
                                )
                              : ShimmerBox(width: 50.w, height: 20.h),
                          const Spacer(),
                          addToCartController != null &&
                                  popularFood != null &&
                                  !isLoading
                              ? _AddToCart(
                                  addToCartController: addToCartController,
                                )
                              : ShimmerBox(
                                  width: 40.w,
                                  height: 40.h,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: -30.h,
              child: popularFood != null && !isLoading
                  ? CachedNetworkImage(
                      imageUrl: popularFood!.image,
                      width: constraints.maxWidth * 0.65,
                      height: constraints.maxHeight * 0.55,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => ShimmerBox(
                        width: constraints.maxWidth * 0.65,
                        height: constraints.maxHeight * 0.55,
                      ),
                    )
                  : ShimmerBox(
                      width: constraints.maxWidth * 0.65,
                      height: constraints.maxHeight * 0.55,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddToCart extends StatelessWidget {
  const _AddToCart({required this.addToCartController});

  final AddToCartController? addToCartController;

  @override
  Widget build(BuildContext context) {
    return AddToCartButtonV2(
      controller: addToCartController!,
      onIncrement: (value) {},
      onDecrement: (value) {},
      width: 90.w,
      height: 45.h,
      backgroundColor: AppColors.secondary,
      iconColor: AppColors.white,
      initialSize: 40.h,
      iconBackgroundColor: Colors.white.withAlpha(100),
      countColor: AppColors.white,
    );
  }
}
