import 'package:animated_digit/animated_digit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/app/widgets/custom_circle_button.dart';
import 'package:food_delivery/app/widgets/custom_select_food_button.dart';
import 'package:food_delivery/app/widgets/select_size_buttons.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/features/home/data/models/popular_fast_food_model.dart';
import 'package:food_delivery/features/home/data/models/popular_food_model.dart';
import 'package:food_delivery/features/home/data/models/restaurant_items_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/buttons/add_to_cart_button.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final RestaurantItemsModel restaurantItemsModel;
  const RestaurantDetailsScreen({
    super.key,
    required this.restaurantItemsModel,
  });

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  late final CarouselSliderController _carouselController;
  final List<String> foundFoods = ['Burger', 'Pizza', 'Sandwich', 'Pasta'];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SystemUIWrapper(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      navigationBarColor: AppColors.white,
      navigationBarIconBrightness: Brightness.dark,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: widget.restaurantItemsModel.images.length,
                    itemBuilder:
                        (
                          BuildContext context,
                          int itemIndex,
                          int pageViewIndex,
                        ) => ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                widget.restaurantItemsModel.images[itemIndex],
                            height: 350.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Skeletonizer(
                              enabled: true,
                              child: Container(
                                height: 350.h,
                                width: double.infinity,
                                color: AppColors.lightGray,
                              ),
                            ),
                          ),
                        ),
                    options: CarouselOptions(
                      height: 350.h,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      viewportFraction: 1.0,
                      pageSnapping: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        SmoothPageIndicator(
                          controller: PageController(
                            initialPage: _currentIndex,
                          ),
                          count: widget.restaurantItemsModel.images.length,
                          effect: WormEffect(
                            dotHeight: 12,
                            dotWidth: 12,
                            spacing: 8,
                            dotColor: AppColors.white.withAlpha(100),
                            activeDotColor: AppColors.white,
                            type: WormType.thin,
                          ),
                          onDotClicked: (index) {
                            _carouselController.animateToPage(index);
                          },
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50.h,
                    left: 20.w,
                    child: CustomCircleButton(
                      backgroundColor: AppColors.white,
                      size: 55.h,
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.darkBlue,
                        size: 20.h,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50.h,
                    right: 20.w,
                    child: CustomCircleButton(
                      backgroundColor: AppColors.white,
                      size: 55.h,
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        color: AppColors.darkBlue,
                        size: 20.h,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildFoodInfo(),
                    SizedBox(height: 30.h),
                    CustomSelectFoodButton(
                      foods: foundFoods,
                      selectedBackgroundColor: Color(0xFFF58D1D),
                      unselectedBackgroundColor: AppColors.white,
                      borderColor: Color(0xFFEDEDED),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              _buildPopularFood(),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularFood() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Burger (${PopularFastFoodModel.popularFastFoodList.length})",
            style: GoogleFonts.sen(
              fontSize: 24.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(height: 30.h),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 45.h,
              mainAxisExtent: 190.h,
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
    return GestureDetector(
      onTap: () => context.push(
        AppPaths.foodDetails,
        extra: FoodDetailsScreenArgs(popularFoodModel: popularFood),
      ),
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
                    popularFood.subtitle,
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
              top: -35.h,
              child: Image.asset(
                popularFood.image,
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

  Widget _buildReadMore() {
    return ReadMoreText(
      "${widget.restaurantItemsModel.description} ",
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
    );
  }

  Widget _buildFoodInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Row(
          children: [
            Icon(FontAwesomeIcons.star, color: AppColors.secondary, size: 20.h),
            SizedBox(width: 10.w),
            Text(
              widget.restaurantItemsModel.rate.toString(),
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
              widget.restaurantItemsModel.deliveryCost,
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
              widget.restaurantItemsModel.deliveryTime,
              style: GoogleFonts.sen(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF181C2E),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Text(
          widget.restaurantItemsModel.name,
          style: GoogleFonts.sen(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(height: 10.h),
        _buildReadMore(),
      ],
    );
  }
}
