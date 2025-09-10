import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:animated_digit/animated_digit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_cubit.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/restaurant_details_screen_args.dart';
import 'package:food_delivery/core/routes/args/search_result_screen_args.dart';
import 'package:food_delivery/features/home/cubit/home_cubit.dart';
import 'package:food_delivery/core/models/restaurant_imodel.dart';
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

  void _showOfferDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      useSafeArea: false,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      builder: (BuildContext dialogContext) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.black38,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),

          child: Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 400.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFA500), Color(0xFFE76F00)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(35.r),
              ),
              padding: const EdgeInsets.all(20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        AppStrings.hurryOffers,
                        style: GoogleFonts.sen(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        "#1243CD2",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sen(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        AppStrings.offerDescription,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sen(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(parentContext).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 60.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          side: const BorderSide(color: Colors.white),
                        ),
                        child: Text(
                          AppStrings.gotIt.toUpperCase(),
                          style: GoogleFonts.sen(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    top: -40,
                    right: -25,
                    child: IconButton.filled(
                      icon: Icon(
                        Icons.close,
                        color: Color(0xFFEF761A),
                        size: 20.h,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xFFFFE194),
                        ),
                        shape: WidgetStateProperty.all(const CircleBorder()),
                        minimumSize: WidgetStateProperty.all(Size(45.w, 45.h)),
                      ),
                      onPressed: () {
                        Navigator.of(parentContext).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(hours: 1), () {
      if (context.mounted) {
        _showOfferDialog(context);
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

class CategoriesPart extends StatelessWidget {
  final Function(FoodModel) onTap;
  const CategoriesPart({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: FoodModel.foodCategoriesList.length,
        clipBehavior: Clip.none,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final foodItem = FoodModel.foodCategoriesList[index];
          return _buildCategoryItem(foodItem);
        },
      ),
    );
  }

  Widget _buildCategoryItem(FoodModel foodItem) {
    return GestureDetector(
      onTap: () => onTap(foodItem),
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: SizedBox(
          width: 160.w,
          height: 170.h,
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.45), // 45%
                        Text(
                          foodItem.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sen(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text(
                              AppStrings.starting,
                              style: GoogleFonts.sen(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF646982),
                              ),
                            ),
                            const Spacer(),
                            AnimatedDigitWidget(
                              value: foodItem.price,
                              prefix: '\$',
                              textStyle: GoogleFonts.sen(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBlue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -35.h,
                  child: Image.asset(
                    foodItem.image,
                    width: constraints.maxWidth * 0.6,
                    height: constraints.maxHeight * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SeeAllBarPart extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const SeeAllBarPart({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
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
}

class SearchBarPart extends StatelessWidget {
  const SearchBarPart({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppPaths.search),
      child: Container(
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
      ),
    );
  }
}

class GreetingPart extends StatelessWidget {
  final String fisrtName;
  const GreetingPart({super.key, required this.fisrtName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
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
                text: state is UserGreeting ? state.greeting : "",
                style: GoogleFonts.sen(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1D1D),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppBarPart extends StatelessWidget {
  final String fullName;
  const AppBarPart({super.key, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          backgroundColor: Color(0xFFECF0F4),
          size: 60.h,
          icon: Icon(FontAwesomeIcons.barsStaggered, color: AppColors.darkBlue),
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
                    color: AppColors.darkBlue,
                    size: 27.h,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        BlocSelector<CartCubit, List<FoodModel>, int>(
          selector: (state) {
            return state.length;
          },
          builder: (context, length) {
            return length == 0
                ? CustomCircleButton(
                    backgroundColor: AppColors.darkBlue,
                    onPressed: () => context.push(AppPaths.cart),
                    size: 60.h,
                    icon: Icon(
                      FontAwesomeIcons.basketShopping,
                      color: AppColors.white,
                    ),
                  )
                : Badge(
                    backgroundColor: AppColors.secondary,
                    offset: Offset(-5.w, -2.h),
                    label: Text(
                      length.toString(),
                      style: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColors.white,
                      ),
                    ),
                    child: CustomCircleButton(
                      backgroundColor: AppColors.darkBlue,
                      size: 60.h,
                      onPressed: () => context.push(AppPaths.cart),
                      icon: Icon(
                        FontAwesomeIcons.basketShopping,
                        color: AppColors.white,
                      ),
                    ),
                  );
          },
        ),
      ],
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
              SizedBox(height: 50.h),
              CategoriesPart(
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
