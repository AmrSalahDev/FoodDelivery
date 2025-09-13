import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/features/home/ui/cubit/home_category_cubit.dart';
import 'package:food_delivery/features/home/ui/widgets/all_categories_part.dart';
import 'package:food_delivery/features/home/ui/widgets/app_bar_part.dart';
import 'package:food_delivery/features/home/ui/widgets/greeting_part.dart';
import 'package:food_delivery/features/home/ui/widgets/search_bar_part.dart';
import 'package:food_delivery/features/home/ui/widgets/see_all_bar_part.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/search_result_screen_args.dart';
import 'package:food_delivery/features/home/ui/cubit/home_cubit.dart';
import 'package:food_delivery/core/models/restaurant_imodel.dart';
import 'package:food_delivery/features/home/ui/widgets/show_offer_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  final String userLocation;
  const HomeScreen({super.key, required this.userLocation});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  late String fullName;
  late String fisrtName;

  @override
  void initState() {
    super.initState();
    fullName = faker.faker.person.name();
    fisrtName = fullName.split(" ")[0];
    context.read<HomeCubit>().startGreeting();
    context.read<HomeCategoryCubit>().fetchCategories();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSecton(fisrtName: fisrtName, fullName: fullName),
              SizedBox(height: 30.h),
              BodySection(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(hours: 1), () {
      if (context.mounted) {
        ShowOfferDialog.showOfferDialog(context);
      }
    });
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
    return ListView.builder(
      itemCount: RestaurantModel.restaurantItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final restaurant = RestaurantModel.restaurantItems[index];
        return _buildRestaurantItem(restaurant);
      },
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

class BodySection extends StatelessWidget {
  const BodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SeeAllBarPart(title: AppStrings.allCategories),
              SizedBox(height: 30.h),
              AllCategoriesPart(
                onTap: (food) {
                  context.push(
                    AppPaths.searchResult,
                    extra: SearchResultScreenArgs(query: food.title),
                  );
                },
              ),
              SizedBox(height: 50.h),
              SeeAllBarPart(title: AppStrings.openRestaurants),
              SizedBox(height: 30.h),
              RestaurantsPart(
                onTap: (restaurant) {
                  context.push(
                    AppPaths.restaurantDetails,
                    extra: RestaurantDetailsScreenArgs(restaurant),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}

class HeaderSecton extends StatelessWidget {
  final String fullName;
  final String fisrtName;

  const HeaderSecton({
    super.key,
    required this.fullName,
    required this.fisrtName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          AppBarPart(fullName: fullName),
          SizedBox(height: 30.h),
          GreetingPart(fisrtName: fisrtName),
          SizedBox(height: 30.h),
          SearchBarPart(),
        ],
      ),
    );
  }
}
