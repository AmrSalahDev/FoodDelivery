import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_cubit.dart';
import 'package:food_delivery/shared/cubits/food_cubit.dart';
import 'package:food_delivery/shared/widgets/add_to_cart_button_v2.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:food_delivery/shared/widgets/custom_readmore.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/shared/widgets/favorite_button.dart';
import 'package:food_delivery/shared/widgets/select_size_buttons.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/di/di.dart';
import 'package:food_delivery/features/food_details/data/models/ingridents_model.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';

class FoodDetailsScreen extends StatefulWidget {
  final FoodModel foodModel;
  const FoodDetailsScreen({super.key, required this.foodModel});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AddToCartController _addToCartController;
  late final AnimationController _animationController;
  late final Animation<Offset> _foodSlideAnimation;
  late final Animation<Offset> _backBtnSlideAnimation;
  late final Animation<Offset> _favoriteBtnSlideAnimation;
  late final FoodCubit foodCubit;

  @override
  void initState() {
    super.initState();
    // cubits
    foodCubit = getIt<FoodCubit>();

    // controllers
    _addToCartController = AddToCartController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // animations
    _foodSlideAnimation = _buildSlideAnimation(const Offset(0, -1));

    _backBtnSlideAnimation = _buildSlideAnimation(const Offset(-2, 0));

    _favoriteBtnSlideAnimation = _buildSlideAnimation(const Offset(2, 0));

    // start animation
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _animationController.forward(),
    );
  }

  Animation<Offset> _buildSlideAnimation(Offset begin) {
    /// Builds an animation that slides an object from [begin] to [Offset.zero].
    ///
    /// The animation is driven by [_animationController] and has a curve of
    /// [Curves.easeOutBack]. This means the animation will start slow and then
    /// accelerate, ending with a slight overshoot and then returning to the
    /// final position.
    ///
    return Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _addToCartController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SystemUIWrapper(
      statusBarColor: Color(0xFFFFB872),
      statusBarIconBrightness: Brightness.light,
      navigationBarColor: Color(0xFFF0F5FA),
      navigationBarIconBrightness: Brightness.light,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSection(
                  backBtnSlideAnimation: _backBtnSlideAnimation,
                  favoriteBtnSlideAnimation: _favoriteBtnSlideAnimation,
                  foodSlideAnimation: _foodSlideAnimation,
                  foodModel: widget.foodModel,
                ),
                SizedBox(height: 30.h),
                BodySection(foodModel: widget.foodModel),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: FooterSection(
          foodModel: widget.foodModel,
          foodCubit: foodCubit,
          addToCartController: _addToCartController,
          animationController: _animationController,
        ),
      ),
    );
  }
}

class IngridentsPart extends StatelessWidget {
  const IngridentsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.ingridents,
          style: GoogleFonts.sen(fontSize: 16.sp, color: AppColors.darkBlue),
        ),
        SizedBox(height: 20.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 20.h,
          children: IngridentsModel.ingridentsList
              .map(
                (ingridents) => Column(
                  children: [
                    CustomCircleButton(
                      onPressed: () {},
                      backgroundColor: Color(0xFFFFEBE4),
                      size: 60.h,
                      icon: SvgPicture.asset(
                        // placeholderBuilder: (context) {
                        //   return Container(
                        //     height: 60.h,
                        //     width: 60.h,
                        //     color: Color(0xFFFFEBE4),
                        //   );
                        // },
                        ingridents.image,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      ingridents.title,
                      style: GoogleFonts.sen(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF747783),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class SizeSelectorPart extends StatelessWidget {
  const SizeSelectorPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.size.toUpperCase(),
          style: GoogleFonts.sen(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA0A5BA),
          ),
        ),
        SizedBox(width: 10.w),
        SelectSizeButtons(
          sizes: ["10”", "14”", "16”"],
          selectedBackgroundColor: Color(0xFFF58D1D),
          unselectedBackgroundColor: AppColors.lightGray,
        ),
      ],
    );
  }
}

class FoodInfoPart extends StatelessWidget {
  final FoodModel foodModel;
  const FoodInfoPart({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          foodModel.title,
          style: GoogleFonts.sen(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          foodModel.restaurantName,
          style: GoogleFonts.sen(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(height: 30.h),
        Row(
          children: [
            Icon(FontAwesomeIcons.star, color: AppColors.secondary, size: 20.h),
            SizedBox(width: 10.w),
            Text(
              foodModel.rating.toString(),
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
              foodModel.deliveryCost,
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
              foodModel.deliveryTime,
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
}

class BodySection extends StatelessWidget {
  final FoodModel foodModel;
  const BodySection({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FoodInfoPart(foodModel: foodModel),
          SizedBox(height: 20.h),
          CustomReadMore(text: foodModel.description),
          SizedBox(height: 20.h),
          SizeSelectorPart(),
          SizedBox(height: 30.h),
          IngridentsPart(),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  final FoodModel foodModel;
  final FoodCubit foodCubit;
  final AddToCartController addToCartController;
  final AnimationController animationController;
  const FooterSection({
    super.key,
    required this.foodModel,
    required this.foodCubit,
    required this.addToCartController,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF0F5FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                AnimatedDigitWidget(
                  value: foodModel.price,
                  textStyle: GoogleFonts.sen(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.darkBlue,
                  ),
                  fractionDigits: 0,
                  //enableSeparator: true,
                  //separateSymbol: "·",
                  //separateLength: 2,
                  //decimalSeparator: ",",
                  prefix: "\$",
                  //suffix: "€",
                ),
                const Spacer(),
                BlocBuilder<CartCubit, List<FoodModel>>(
                  builder: (context, state) {
                    final cartItem = context.read<CartCubit>().isInCart(
                      foodModel,
                    );
                    addToCartController.setQuantity(cartItem.quantity);
                    return AddToCartButtonV2(
                      onIncrement: (value) {
                        context.read<CartCubit>().incrementQuantity(foodModel);
                      },
                      onDecrement: (value) {
                        context.read<CartCubit>().decrementQuantity(foodModel);
                      },
                      controller: addToCartController,
                      iconBackgroundColor: Colors.white.withAlpha(100),
                      backgroundColor: AppColors.secondary,
                      height: 55.h,
                      width: 130.w,
                      iconColor: AppColors.white,
                      countColor: AppColors.white,
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomRectangleButton(
              onPressed: () {
                animationController.reset();
                animationController.forward();
              },
              title: AppStrings.addToCart.toUpperCase(),
              height: 60.h,
              backgroundColor: AppColors.secondary,
              titleColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final Animation<Offset> backBtnSlideAnimation;
  final Animation<Offset> favoriteBtnSlideAnimation;
  final Animation<Offset> foodSlideAnimation;
  final FoodModel foodModel;

  const HeaderSection({
    super.key,
    required this.backBtnSlideAnimation,
    required this.favoriteBtnSlideAnimation,
    required this.foodSlideAnimation,
    required this.foodModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      width: double.infinity,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Color(0xFFFFB872),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                SlideTransition(
                  position: backBtnSlideAnimation,
                  child: CustomCircleButton(
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: AppColors.white,
                    size: 55.h,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20.h,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ),
                const Spacer(),
                SlideTransition(
                  position: favoriteBtnSlideAnimation,
                  child: CustomCircleButton(
                    backgroundColor: AppColors.white,
                    size: 55.h,
                    icon: FavoriteButton(
                      heartColor: Color(0xFFFF8400),
                      size: 24.h,
                      onFavorited: () {},
                      onUnfavorited: () {},
                    ),
                  ),
                ),
              ],
            ),
            SlideTransition(
              position: foodSlideAnimation,
              child: Image.asset(foodModel.image, width: 245.w, height: 245.h),
            ),
          ],
        ),
      ),
    );
  }
}
