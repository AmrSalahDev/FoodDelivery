import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/app/widgets/custom_circle_button.dart';
import 'package:food_delivery/app/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/app/widgets/favorite_button.dart';
import 'package:food_delivery/app/widgets/select_size_buttons.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/features/food_details/data/models/ingridents_model.dart';
import 'package:food_delivery/features/home/data/models/popular_food_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:readmore/readmore.dart';

class FoodDetailsScreen extends StatefulWidget {
  final PopularFoodModel popularFoodModel;
  const FoodDetailsScreen({super.key, required this.popularFoodModel});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AddToCartController _addToCartController;
  late AnimationController _animationController;
  late Animation<Offset> _foodSlideAnimation;
  late Animation<Offset> _backBtnSlideAnimation;
  late Animation<Offset> _favoriteBtnSlideAnimation;

  @override
  void initState() {
    super.initState();
    _addToCartController = AddToCartController(initialQuantity: 2);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _foodSlideAnimation = _buildSlideAnimation(const Offset(0, -1));

    _backBtnSlideAnimation = _buildSlideAnimation(const Offset(-2, 0));

    _favoriteBtnSlideAnimation = _buildSlideAnimation(const Offset(2, 0));

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _animationController.forward(),
    );
  }

  Animation<Offset> _buildSlideAnimation(Offset begin) {
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
                _buildHeader(context),
                SizedBox(height: 30.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFoodInfo(),
                      SizedBox(height: 20.h),
                      _buildReadMore(),
                      SizedBox(height: 20.h),
                      _buildSize(),
                      SizedBox(height: 30.h),
                      _buildIngridents(),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildNavBar(),
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
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
            _buildAppBar(context),
            SlideTransition(
              position: _foodSlideAnimation,
              child: Image.asset(
                widget.popularFoodModel.image,
                width: 245.w,
                height: 245.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.popularFoodModel.title,
          style: GoogleFonts.sen(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          widget.popularFoodModel.subtitle,
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
              widget.popularFoodModel.rating.toString(),
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
              widget.popularFoodModel.deliveryCost,
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
              widget.popularFoodModel.deliveryTime,
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

  Widget _buildReadMore() {
    return ReadMoreText(
      "${widget.popularFoodModel.description} ",
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

  Widget _buildSize() {
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

  Widget _buildIngridents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.ingridents,
          style: GoogleFonts.sen(fontSize: 16.sp, color: AppColors.darkBlue),
        ),
        SizedBox(height: 20.h),
        GridView.builder(
          itemBuilder: (context, index) => Column(
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
                  IngridentsModel.ingridentsList[index].image,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                IngridentsModel.ingridentsList[index].title,
                style: GoogleFonts.sen(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF747783),
                ),
              ),
            ],
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
            childAspectRatio: 0.6,
          ),
          itemCount: IngridentsModel.ingridentsList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }

  Widget _buildNavBar() {
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
                  value: widget.popularFoodModel.price,
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
                AddToCartButtonV2(
                  onIncrement: (value) {},
                  onDecrement: (value) {},
                  controller: _addToCartController,
                  iconBackgroundColor: Colors.white.withAlpha(100),
                  backgroundColor: AppColors.secondary,
                  height: 55.h,
                  width: 130.w,
                  iconColor: AppColors.white,
                  countColor: AppColors.white,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomRectangleButton(
              onPressed: () {
                _animationController.toggle();
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

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        SlideTransition(
          position: _backBtnSlideAnimation,
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
          position: _favoriteBtnSlideAnimation,
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
    );
  }
}

class AddToCartController extends ChangeNotifier {
  int _quantity;
  final int minQuantity;
  final int maxQuantity;

  AddToCartController({
    int initialQuantity = 0,
    this.minQuantity = 0,
    this.maxQuantity = 99,
  }) : _quantity = initialQuantity;

  int get quantity => _quantity;

  void setQuantity(int value) {
    if (value >= minQuantity && value <= maxQuantity) {
      _quantity = value;
      notifyListeners();
    }
  }

  void increment() {
    if (_quantity < maxQuantity) {
      _quantity++;
      notifyListeners();
    }
  }

  void decrement() {
    if (_quantity > minQuantity) {
      _quantity--;
      notifyListeners();
    }
  }
}

class AddToCartButtonV2 extends StatefulWidget {
  final AddToCartController controller;
  final Function(int value) onIncrement;
  final Function(int value) onDecrement;
  final Color backgroundColor;
  final Color countColor;
  final Color borderColor;
  final Color iconColor;
  final Color? iconBackgroundColor;
  final TextStyle? countTextStyle;
  final double borderWidth;
  final double borderRadius;
  final double height;
  final double width;
  final double initialSize;
  final BoxShape initialShape;
  final Duration animationDuration;

  const AddToCartButtonV2({
    super.key,
    required this.controller,
    required this.onIncrement,
    required this.onDecrement,
    this.iconBackgroundColor,
    this.backgroundColor = Colors.white,
    this.countColor = Colors.black,
    this.borderColor = Colors.white,
    this.iconColor = Colors.black,
    this.borderWidth = 1.0,
    this.borderRadius = 10.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.height = 40.0,
    this.width = 100.0,
    this.initialSize = 40.0,
    this.initialShape = BoxShape.circle,
    this.countTextStyle,
  });

  @override
  State<AddToCartButtonV2> createState() => _AddToCartButtonV2State();
}

class _AddToCartButtonV2State extends State<AddToCartButtonV2> {
  late AddToCartController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final quantity = controller.quantity;
    final bool isAdded = quantity > controller.minQuantity;

    return AnimatedContainer(
      duration: widget.animationDuration,
      width: isAdded ? widget.width : widget.initialSize,
      height: isAdded ? widget.height : widget.initialSize,
      padding: EdgeInsets.symmetric(
        horizontal: isAdded ? 10 : 0,
        vertical: isAdded ? 10 : 0,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(
          widget.initialShape == BoxShape.circle
              ? widget.height / 2
              : widget.borderRadius,
        ),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: widget.animationDuration,
            opacity: isAdded ? 1 : 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.decrement();
                      widget.onDecrement.call(controller.quantity);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            widget.iconBackgroundColor ?? Colors.grey.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: widget.iconColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: AnimatedDigitWidget(
                      value: controller.quantity,
                      textStyle:
                          widget.countTextStyle ??
                          TextStyle(
                            color: widget.countColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.increment();
                      widget.onIncrement.call(controller.quantity);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            widget.iconBackgroundColor ?? Colors.grey.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, size: 18, color: widget.iconColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IgnorePointer(
            ignoring: isAdded,
            child: AnimatedOpacity(
              duration: widget.animationDuration,
              opacity: isAdded ? 0 : 1,
              child: GestureDetector(
                onTap: () {
                  controller.increment();
                  widget.onIncrement.call(controller.quantity);
                },
                child: Center(child: Icon(Icons.add, color: widget.iconColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
