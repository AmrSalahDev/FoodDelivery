import 'package:animated_digit/animated_digit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/app/cubits/food_cubit.dart';
import 'package:food_delivery/app/cubits/food_state.dart';
import 'package:food_delivery/app/widgets/custom_circle_button.dart';
import 'package:food_delivery/app/widgets/custom_readmore.dart';
import 'package:food_delivery/app/widgets/custom_select_food_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/app/models/food_model.dart';
import 'package:food_delivery/app/models/restaurant_imodel.dart';
import 'package:food_delivery/core/di/di.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/buttons/add_to_cart_button.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final RestaurantModel restaurantModel;
  const RestaurantDetailsScreen({super.key, required this.restaurantModel});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  late final CarouselSliderController _carouselController;
  late final List<String> foundFoods;
  int _currentIndex = 0;
  late final FoodCubit foodCubit;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
    foundFoods = ['Burger', 'Pizza', 'Sandwich', 'Pasta'];
    foodCubit = getIt<FoodCubit>();
    //foodCubit.loadBurger();
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
                    itemCount: widget.restaurantModel.images.length,
                    itemBuilder: (context, itemIndex, pageViewIndex) =>
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.restaurantModel.images[itemIndex],
                            height: 350.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Stack(
                              alignment: Alignment.center,
                              children: [
                                Skeletonizer(
                                  enabled: true,
                                  effect: ShimmerEffect(
                                    baseColor: Colors.grey.shade200,
                                    highlightColor: Colors.grey.shade100,
                                  ),
                                  child: Container(
                                    height: 350.h,
                                    width: double.infinity,
                                    color: AppColors.lightGray,
                                  ),
                                ),

                                Assets.lottie.handLoading.lottie(),
                              ],
                            ),
                            errorWidget: (context, url, error) =>
                                Center(child: Assets.lottie.error.lottie()),
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
                          count: widget.restaurantModel.images.length,
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
                      onPressed: () => _showFliterDialog(),
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
                    RestaurantInfoSection(
                      restaurantModel: widget.restaurantModel,
                    ),
                    SizedBox(height: 10.h),
                    CustomReadMore(text: widget.restaurantModel.description),
                    SizedBox(height: 30.h),
                    CustomSelectFoodButton(
                      foods: foundFoods,
                      selectedBackgroundColor: Color(0xFFF58D1D),
                      unselectedBackgroundColor: AppColors.white,
                      borderColor: Color(0xFFEDEDED),
                      onSelected: (index, name) {
                        // if (index == 0) {
                        //   foodCubit.loadBurger();
                        // } else if (index == 1) {
                        //   foodCubit.loadPizza();
                        // } else if (index == 2) {
                        //   foodCubit.loadSandwich();
                        // } else if (index == 3) {
                        //   foodCubit.loadPasta();
                        // }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              // BlocBuilder<FoodCubit, FoodState>(
              //   bloc: foodCubit,
              //   builder: (context, state) {
              //     if (state is FoodLoading) {
              //       return const Center(
              //         child: CircularProgressIndicator(
              //           color: AppColors.secondary,
              //         ),
              //       );
              //     }
              //     if (state is FoodLoaded) {
              //       return GenerateFoodItems(
              //         onTap: (foodModel) {
              //           context.push(
              //             AppPaths.foodDetails,
              //             extra: FoodDetailsScreenArgs(foodModel: foodModel),
              //           );
              //         },
              //         showCartButton: true,
              //         foodList: state.foods,
              //       );
              //     }

              //     return Container();
              //   },
              // ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showFliterDialog() {
    final List<String> offers = [
      'Delivery',
      'Pick Up',
      'Offer',
      'Online payment available',
    ];
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Filter your search",
                    style: GoogleFonts.sen(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const Spacer(),
                  CustomCircleButton(
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: AppColors.lightGray,
                    size: 55.h,
                    icon: Icon(
                      Icons.close,
                      color: AppColors.darkBlue,
                      size: 20.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                "Offers",
                style: GoogleFonts.sen(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.darkBlue,
                ),
              ),
              SizedBox(height: 20.h),
              // CustomSelectFoodButton(
              //   foods: offers,
              //   isWrap: true,
              //   selectedBackgroundColor: Color(0xFFF58D1D),
              //   unselectedBackgroundColor: AppColors.white,
              //   borderColor: Color(0xFFEDEDED),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantInfoSection extends StatelessWidget {
  final RestaurantModel restaurantModel;
  const RestaurantInfoSection({super.key, required this.restaurantModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Row(
          children: [
            Icon(FontAwesomeIcons.star, color: AppColors.secondary, size: 20.h),
            SizedBox(width: 10.w),
            Text(
              restaurantModel.rate.toString(),
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
              restaurantModel.deliveryCost,
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
              restaurantModel.deliveryTime,
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
          restaurantModel.name,
          style: GoogleFonts.sen(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}
