import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/app/widgets/custom_circle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';

import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/features/home/data/models/popular_fast_food_model.dart';
import 'package:food_delivery/features/home/data/models/popular_food_model.dart';
import 'package:food_delivery/features/home/data/models/restaurant_items_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/buttons/add_to_cart_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchResultScreen extends StatefulWidget {
  final String? query;
  const SearchResultScreen({super.key, this.query});

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
                child: Column(children: [_buildAppBar(context)]),
              ),
              SizedBox(height: 30.h),
              _buildPopularFood(),
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildRestaurants(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.openRestaurants,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(height: 20.h),
        ListView.builder(
          itemCount: RestaurantItemsModel.restaurantItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return RestaurantItem(index: index);
          },
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
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
        Chip(
          label: Text(widget.query!),
          backgroundColor: AppColors.white,
          onDeleted: () {},
          deleteIcon: Icon(Icons.arrow_drop_down, size: 24.h),
          deleteIconColor: AppColors.secondary,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          shape: StadiumBorder(side: BorderSide(color: Color(0xFFECF0F4))),
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

  Widget _buildPopularFood() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 30,
              //childAspectRatio: 0.8,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PopularFastFoodModel.popularFastFoodList.length,
            itemBuilder: (context, index) =>
                _buildPopularFoodItem(index: index),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularFoodItem({required int index}) {
    final popularFood = PopularFoodModel.popularFoodList[index];
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 153.w,
          height: 175.h,
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
              SizedBox(height: 70.h),
              Text(
                popularFood.title,
                style: GoogleFonts.sen(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              Text(
                popularFood.subtitle,
                style: GoogleFonts.sen(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF646982),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      "\$${popularFood.price.toString()}",
                      style: GoogleFonts.sen(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const Spacer(),
                    AddToCartButton(
                      onIncrement: (value) {},
                      onDecrement: (value) {},
                      maxQuantity: 100,
                      width: 75.w,
                      height: 40.h,
                      backgroundColor: AppColors.secondary,
                      iconColor: AppColors.white,
                      initialSize: 40.h,
                      countColor: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -25,
          child: Image.asset(
            popularFood.image,
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class RestaurantItem extends StatefulWidget {
  final int index;
  const RestaurantItem({super.key, required this.index});

  @override
  State<RestaurantItem> createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final restaurant = RestaurantItemsModel.restaurantItems[widget.index];

    return Skeletonizer(
      enabled: _isLoading,
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

              placeholder: (context, url) => Container(
                height: 200.h,
                width: double.infinity,
                color: AppColors.lightGray,
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
                  Center(child: Icon(Icons.error, color: Colors.red)),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            restaurant.name,
            style: GoogleFonts.sen(
              fontSize: 20.sp,
              fontWeight: FontWeight.normal,
              color: Color(0xFF181C2E),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: restaurant.foodTypes
                .map(
                  (foodType) => Text(
                    foodType == restaurant.foodTypes.last
                        ? foodType
                        : "$foodType - ",
                    style: GoogleFonts.sen(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFA0A5BA),
                    ),
                  ),
                )
                .toList(),
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
                restaurant.rate,
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
                restaurant.deliveryCost,
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
                restaurant.deliveryTime,
                style: GoogleFonts.sen(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF181C2E),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
