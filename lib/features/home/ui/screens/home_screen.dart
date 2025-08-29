import 'dart:async';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_images.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/features/home/data/models/food_items_model.dart';
import 'package:food_delivery/features/home/data/models/restaurant_items_model.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final String userLocation;
  const HomeScreen({super.key, required this.userLocation});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String fullName;
  late String fisrtName;
  late String greeting;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    fullName = faker.faker.person.name();
    fisrtName = fullName.split(" ")[0];
    greeting = _getGreeting();

    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        greeting = _getGreeting();
      });
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                SizedBox(height: 30.h),
                _buildGreeting(),
                SizedBox(height: 30.h),
                _buildSearchBar(),
                SizedBox(height: 30.h),
                _buildSeeAllBar(title: "All Categories"),
                SizedBox(height: 30.h),
                _buildCategories(),
                SizedBox(height: 40.h),
                _buildSeeAllBar(title: "Open Restaurants"),
                SizedBox(height: 30.h),
                _buildRestaurants(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurants() {
    return SizedBox(
      height: 350.h,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: RestaurantItemsModel.restaurantItems.length,
        itemBuilder: (context, index) {
          return _buildRestaurantItem(index);
        },
      ),
    );
  }

  Widget _buildRestaurantItem(int index) {
    final restaurant = RestaurantItemsModel.restaurantItems[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Image.asset(
            restaurant.image,
            fit: BoxFit.fill,
            height: 200.h,
            width: double.infinity,
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
            Icon(FontAwesomeIcons.star, color: AppColors.secondary, size: 20.h),
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
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 170.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: FoodItemsModel.foodItems.length,
        itemBuilder: (context, index) {
          return _buildCategoryItem(index);
        },
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          width: 130.w,
          height: 130.h,
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
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              FoodItemsModel.foodItems[index].image,
              width: 70.w,
              height: 70.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            FoodItemsModel.foodItems[index].title,
            style: GoogleFonts.sen(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF32343E),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeeAllBar({required String title, VoidCallback? onTap}) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => onTap?.call(),
          child: Row(
            children: [
              Text(
                AppStrings.seeAll,
                style: GoogleFonts.sen(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF32343E),
                ),
              ),
              SizedBox(width: 5.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFFA0A5BA),
                size: 20.h,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 65.h,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: Color(0xFFA0A5BA), size: 27.h),
          SizedBox(width: 10.w),
          Text(
            "Search dishes, restaurants",
            style: GoogleFonts.sen(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Color(0xFF676767),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Text.rich(
      TextSpan(
        text: "Hey $fisrtName, ",
        style: GoogleFonts.sen(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: Color(0xFF1E1D1D),
        ),
        children: [
          TextSpan(
            text: greeting,
            style: GoogleFonts.sen(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1D1D),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildAppBar() {
    return Row(
      children: [
        IconButton.filled(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECF0F4),

            shape: const CircleBorder(),
            minimumSize: Size(60.w, 60.h),
          ),
          icon: Icon(
            FontAwesomeIcons.barsStaggered,
            color: Color(0xFF181C2E),
            size: 24.h,
          ),
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
                    color: Color(0xFF181C2E),
                    size: 27.h,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Badge(
          backgroundColor: AppColors.secondary,
          offset: Offset(-10, 0),
          label: Text(
            faker.faker.randomGenerator.integer(100).toString(),
            style: GoogleFonts.sen(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          child: IconButton.filled(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: Color(0xFF181C2E),
              shape: const CircleBorder(),
              minimumSize: Size(60.w, 60.h),
            ),
            icon: Icon(
              FontAwesomeIcons.basketShopping,
              color: AppColors.white,
              size: 24.h,
            ),
          ),
        ),
      ],
    );
  }
}
