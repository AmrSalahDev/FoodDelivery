import 'package:animated_digit/animated_digit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/food_details_screen_args.dart';
import 'package:food_delivery/features/restaurant_details/domain/entities/restaurant_entity.dart';
import 'package:food_delivery/shared/cubits/food_cubit.dart';
import 'package:food_delivery/shared/widgets/add_to_cart_button_v2.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:food_delivery/shared/widgets/custom_readmore.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/shared/widgets/custom_select_food_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final RestaurantEntity restaurantEntity;
  const RestaurantDetailsScreen({super.key, required this.restaurantEntity});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  late final List<String> foundFoods;

  @override
  void initState() {
    super.initState();
    foundFoods = ['Burger', 'Pizza', 'Sandwich', 'Pasta'];
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
              HeaderSection(restaurantEntity: widget.restaurantEntity),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    BodySection(restaurantEntity: widget.restaurantEntity),
                    SizedBox(height: 30.h),
                    FooterSection(foundFoods: foundFoods),
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

class RestaurantInfoPart extends StatelessWidget {
  final RestaurantEntity restaurantEntity;
  const RestaurantInfoPart({super.key, required this.restaurantEntity});

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
              restaurantEntity.rate.toString(),
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
              restaurantEntity.deliveryCost,
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
              restaurantEntity.deliveryTime,
              style: GoogleFonts.sen(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Text(
          restaurantEntity.name,
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

class HeaderSection extends StatefulWidget {
  final RestaurantEntity restaurantEntity;
  const HeaderSection({super.key, required this.restaurantEntity});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  late final CarouselSliderController _carouselController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            width: double.infinity,
            height: context.screenHeight * 0.91,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterDialogHeader(),
                  OfferFilterPart(options: groupButtonRoundedOptions()),
                  DeliveryTimeFilterPart(
                    options: groupButtonRoundedOptions(horizontal: 15),
                  ),
                  PriceFilterPart(options: groupButtonCircleOptions),
                  RateFilterPart(),
                  SizedBox(height: 30.h),
                  CustomRectangleButton(
                    title: AppStrings.filter.toUpperCase(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColors.secondary,
                    textStyle: GoogleFonts.sen(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
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

  GroupButtonOptions groupButtonRoundedOptions({double horizontal = 20}) {
    return GroupButtonOptions(
      selectedColor: Color(0xFFF58D1D),
      unselectedColor: AppColors.white,
      unselectedTextStyle: GoogleFonts.sen(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Color(0xFF464E57),
      ),
      selectedTextStyle: GoogleFonts.sen(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.white,
      ),
      unselectedBorderColor: Color(0xFFEDEDED),
      borderRadius: BorderRadius.all(Radius.circular(33.r)),
      selectedBorderColor: Color(0xFFF58D1D),
      elevation: 0,
      buttonHeight: 50.h,
      textPadding: EdgeInsets.symmetric(horizontal: horizontal),
      selectedShadow: const [],
      unselectedShadow: const [],
      mainGroupAlignment: MainGroupAlignment.start,
    );
  }

  GroupButtonOptions get groupButtonCircleOptions => GroupButtonOptions(
    selectedColor: Color(0xFFF58D1D),
    unselectedColor: AppColors.white,
    unselectedTextStyle: GoogleFonts.sen(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: Color(0xFF464E57),
    ),
    selectedTextStyle: GoogleFonts.sen(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.white,
    ),
    unselectedBorderColor: Color(0xFFEDEDED),
    borderRadius: BorderRadius.all(Radius.circular(100)),
    selectedBorderColor: Color(0xFFF58D1D),
    elevation: 0,
    buttonHeight: 55.h,
    buttonWidth: 55.h,

    selectedShadow: const [],
    unselectedShadow: const [],
    mainGroupAlignment: MainGroupAlignment.start,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: widget.restaurantEntity.images.length,
          itemBuilder: (context, itemIndex, pageViewIndex) => ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.restaurantEntity.images[itemIndex],
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
                      color: Colors.grey.shade200,
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
                controller: PageController(initialPage: _currentIndex),
                count: widget.restaurantEntity.images.length,
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
            onPressed: () => Navigator.pop(context),
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
            onPressed: () => _showFilterDialog(),
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
    );
  }
}

class FilterDialogHeader extends StatelessWidget {
  const FilterDialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.filterYourSearch,
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
          icon: Icon(Icons.close, color: AppColors.darkBlue, size: 20.h),
        ),
      ],
    );
  }
}

class OfferFilterPart extends StatelessWidget {
  final GroupButtonOptions options;
  OfferFilterPart({super.key, required this.options});

  final List<String> offers = [
    'Delivery',
    'Pick Up',
    'Offer',
    'Online payment available',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text(
          AppStrings.offers.toUpperCase(),
          style: GoogleFonts.sen(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 20.h),
        GroupButton(
          isRadio: true,
          //onSelected: (index, isSelected) => print('$index button is selected'),
          buttons: offers,
          options: options,
        ),
      ],
    );
  }
}

class DeliveryTimeFilterPart extends StatelessWidget {
  final GroupButtonOptions options;
  DeliveryTimeFilterPart({super.key, required this.options});

  final List<String> deliveryTimes = ['10-15 min', '20 min', '30 min'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Text(
          AppStrings.deliverTime.toUpperCase(),
          style: GoogleFonts.sen(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 20.h),
        GroupButton(
          isRadio: true,
          //onSelected: (index, isSelected) => print('$index button is selected'),
          buttons: deliveryTimes,
          options: options,
        ),
      ],
    );
  }
}

class PriceFilterPart extends StatelessWidget {
  final GroupButtonOptions options;
  PriceFilterPart({super.key, required this.options});

  final List<String> prices = ['\$', '\$\$', '\$\$\$'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Text(
          AppStrings.pricing.toUpperCase(),
          style: GoogleFonts.sen(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 20.h),
        GroupButton(
          isRadio: true,
          //onSelected: (index, isSelected) => print('$index button is selected'),
          buttons: prices,
          options: options,
        ),
      ],
    );
  }
}

class RateFilterPart extends StatelessWidget {
  RateFilterPart({super.key});

  final List<IconData> ratings = [
    Icons.star,
    Icons.star,
    Icons.star,
    Icons.star,
    Icons.star,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Text(
          AppStrings.rating.toUpperCase(),
          style: GoogleFonts.sen(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 20.h),
        GroupButton<IconData>(
          isRadio: false,
          //onSelected: (index, isSelected) => print('$index button is selected'),
          buttonBuilder: (selected, value, context) {
            return Container(
              //padding: const EdgeInsets.all(10),
              width: 55.h,
              height: 55.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFEDEDED)),
              ),
              child: Icon(
                value,
                size: 24.h,
                color: selected ? AppColors.secondary : Color(0xFFD9D9D9),
              ),
            );
          },
          buttons: ratings,
        ),
      ],
    );
  }
}

class BodySection extends StatelessWidget {
  final RestaurantEntity restaurantEntity;

  const BodySection({super.key, required this.restaurantEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RestaurantInfoPart(restaurantEntity: restaurantEntity),
        SizedBox(height: 10.h),
        CustomReadMore(text: restaurantEntity.description),
      ],
    );
  }
}

class FooterSection extends StatefulWidget {
  final List<String> foundFoods;
  const FooterSection({super.key, required this.foundFoods});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  String selectedType = 'Burger';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSelectFoodButton(
          foods: widget.foundFoods,
          selectedBackgroundColor: Color(0xFFF58D1D),
          unselectedBackgroundColor: AppColors.white,
          borderColor: Color(0xFFEDEDED),
          onSelected: (index, name) {
            setState(() {
              selectedType = name;
            });
          },
        ),
        SizedBox(height: 30.h),
        FoodPart(
          type: selectedType,
          onTap: (food) {
            context.push(
              AppPaths.foodDetails,
              extra: FoodDetailsScreenArgs(foodModel: food),
            );
          },
        ),
      ],
    );
  }
}

class FoodPart extends StatefulWidget {
  final String type;
  final Function(FoodModel foodd) onTap;
  const FoodPart({super.key, required this.type, required this.onTap});

  @override
  State<FoodPart> createState() => _FoodPartState();
}

class _FoodPartState extends State<FoodPart> {
  late List<FoodModel> foodList;
  @override
  Widget build(BuildContext context) {
    final Map<String, List<FoodModel>> foodMap = {
      'pizza': FoodModel.pizzaList,
      'burger': FoodModel.burgerList,
      'pasta': FoodModel.pastaList,
      'sandwich': FoodModel.sandwichList,
    };

    foodList = foodMap[widget.type.toLowerCase()] ?? FoodModel.foodList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.type} (${foodList.length})",

          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
        ),
        SizedBox(height: 20.h),
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
