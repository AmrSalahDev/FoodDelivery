import 'package:animated_digit/animated_digit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/shared/cubits/food_cubit.dart';
import 'package:food_delivery/shared/widgets/add_to_cart_button_v2.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';

import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:food_delivery/core/models/restaurant_imodel.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    HeaderSection(query: widget.query),
                    SizedBox(height: 30.h),
                    BodySection(query: widget.query),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantsPart extends StatefulWidget {
  final Function(RestaurantModel) onTap;
  const RestaurantsPart({super.key, required this.onTap});

  @override
  State<RestaurantsPart> createState() => _RestaurantsPartState();
}

class _RestaurantsPartState extends State<RestaurantsPart> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.openRestaurants,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 20.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: RestaurantModel.restaurantItems.length,

          itemBuilder: (context, index) {
            final restaurant = RestaurantModel.restaurantItems[index];
            return _buildRestaurantItem(restaurant);
          },
        ),
      ],
    );
  }

  Widget _buildRestaurantItem(RestaurantModel restaurant) {
    return GestureDetector(
      onTap: () => widget.onTap(restaurant),
      child: Skeletonizer(
        enabled: _isLoading,
        ignorePointers: _isLoading,
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: CachedNetworkImage(
                imageUrl: restaurant.image,
                fit: BoxFit.fill,
                height: 200.h,
                width: double.infinity,

                placeholder: (context, url) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),

                    Assets.lottie.handLoading.lottie(),
                  ],
                ),
                imageBuilder: (context, imageProvider) {
                  // Use addPostFrameCallback to avoid calling setState during build
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && _isLoading) {
                      setState(() => _isLoading = false);
                    }
                  });
                  return Image(
                    image: imageProvider,
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  );
                },
                errorWidget: (context, url, error) =>
                    Center(child: Assets.lottie.error.lottie()),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              restaurant.name,
              style: GoogleFonts.sen(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.darkBlue,
              ),
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Icon(
                  FontAwesomeIcons.star,
                  color: AppColors.secondary,
                  size: 20.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  restaurant.rate,
                  style: GoogleFonts.sen(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
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
                  restaurant.deliveryCost,
                  style: GoogleFonts.sen(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
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
                  restaurant.deliveryTime,
                  style: GoogleFonts.sen(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

class PopularFoodPart extends StatefulWidget {
  final String query;
  final Function(FoodModel foodd) onTap;
  const PopularFoodPart({super.key, required this.query, required this.onTap});

  @override
  State<PopularFoodPart> createState() => _PopularFoodPartState();
}

class _PopularFoodPartState extends State<PopularFoodPart> {
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
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            final popularFood = foodList[index];
            return _buildPopularFoodItem(popularFood);
          },
        ),
      ],
    );
  }

  Widget _buildPopularFoodItem(FoodModel popularFood) {
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
                          controller: AddToCartController(),
                          onIncrement: (value) {
                            context.read<FoodCubit>().incrementQuantity(
                              popularFood.id,
                            );
                          },
                          onDecrement: (value) {
                            context.read<FoodCubit>().decrementQuantity(
                              popularFood.id,
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

class AppBarPart extends StatelessWidget {
  final String? query;
  const AppBarPart({super.key, required this.query});

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

class HeaderSection extends StatelessWidget {
  final String query;
  const HeaderSection({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(children: [AppBarPart(query: query)]);
  }
}

class BodySection extends StatelessWidget {
  final String query;
  const BodySection({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PopularFoodPart(
          query: query,
          onTap: (food) {
            context.push(
              AppPaths.foodDetails,
              extra: FoodDetailsScreenArgs(foodModel: food),
            );
          },
        ),
        SizedBox(height: 40.h),
        RestaurantsPart(
          onTap: (restaurant) {
            context.push(
              AppPaths.restaurantDetails,
              extra: RestaurantDetailsScreenArgs(restaurant),
            );
          },
        ),
      ],
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
