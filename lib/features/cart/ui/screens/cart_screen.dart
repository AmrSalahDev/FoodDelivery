import 'package:animated_digit/animated_digit.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/shared/data/models/food_model.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/payment_screen_args.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_cubit.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_edit_address_cubit.dart';
import 'package:food_delivery/features/cart/ui/cubits/cart_edit_items_cubit.dart';
import 'package:food_delivery/shared/widgets/add_to_cart_button_v2.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SystemUIWrapper(
      statusBarColor: Color(0xFF121223),
      statusBarIconBrightness: Brightness.light,
      navigationBarColor: AppColors.white,
      navigationBarIconBrightness: Brightness.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFF121223),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeaderSection(),
                  SizedBox(height: 30.h),
                  BodySection(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<CartCubit, List<FoodModel>>(
          builder: (context, state) {
            return state.isEmpty
                ? const SizedBox.shrink()
                : AnimatedPadding(
                    duration: const Duration(milliseconds: 200),
                    // padding = keyboard height
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SafeArea(top: false, child: FooterSection()),
                  );
          },
        ),
      ),
    );
  }
}

class AppBarPart extends StatefulWidget {
  const AppBarPart({super.key});

  @override
  State<AppBarPart> createState() => _AppBarPartState();
}

class _AppBarPartState extends State<AppBarPart> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          backgroundColor: Color(0xFf32343E),
          size: 55.h,
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
            size: 20.h,
          ),
        ),
        SizedBox(width: 15.w),
        Text(
          AppStrings.cart,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.white,
          ),
        ),
        const Spacer(),
        BlocBuilder<CartCubit, List<FoodModel>>(
          builder: (context, state) {
            return state.isEmpty
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () => context.read<CartEditItemsCubit>().toggle(),
                    child: BlocBuilder<CartEditItemsCubit, bool>(
                      builder: (context, state) {
                        return Text(
                          state
                              ? AppStrings.done.toUpperCase()
                              : AppStrings.editItems.toUpperCase(),
                          style: GoogleFonts.sen(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            color: state
                                ? Color(0xFF059C6A)
                                : AppColors.secondary,
                            decoration: TextDecoration.underline,
                            decorationColor: state
                                ? Color(0xFF059C6A)
                                : AppColors.secondary,
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ],
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [AppBarPart()]);
  }
}

class CartPart extends StatefulWidget {
  const CartPart({super.key});

  @override
  State<CartPart> createState() => _CartPartState();
}

class _CartPartState extends State<CartPart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<FoodModel>>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.length,
          shrinkWrap: true,
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final foodItem = state[index];

            final addToCartController = AddToCartController(
              initialQuantity: foodItem.quantity,
            );
            return _buildCartItem(
              foodItem: foodItem,
              addToCartController: addToCartController,
            );
          },
        );
      },
    );
  }

  Widget _buildCartItem({
    required FoodModel foodItem,
    required AddToCartController addToCartController,
  }) {
    return Row(
      children: [
        Image.asset(foodItem.image, width: 136.w, height: 117.h),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    foodItem.title,
                    style: GoogleFonts.sen(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.white,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<CartEditItemsCubit, bool>(
                    builder: (context, state) {
                      return state
                          ? IconButton.filled(
                              iconSize: 24.h,
                              onPressed: () {
                                context.read<CartCubit>().removeFromCart(
                                  foodItem,
                                );
                              },
                              icon: Icon(Icons.close),
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(CircleBorder()),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  Color(0xFFE04444),
                                ),
                              ),
                              visualDensity: VisualDensity.compact,
                            )
                          : SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Text(
                '\$${foodItem.price}',
                style: GoogleFonts.sen(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  // BlocBuilder<CartCubit, List<FoodModel>>(
                  //   builder: (context, state) {
                  //     final cartItem = context
                  //         .read<CartCubit>()
                  //         .getFoodFromCart(foodItem);
                  //     return Text(
                  //       cartItem.size,
                  //       style: GoogleFonts.sen(
                  //         color: Color(0xFF32343E),
                  //         fontSize: 18.sp,
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  //     );
                  //   },
                  // ),
                  const Spacer(),
                  AddToCartButtonV2(
                    controller: addToCartController,
                    onIncrement: (value) {
                      context.read<CartCubit>().incrementQuantity(foodItem);
                    },
                    onDecrement: (value) {
                      if (value == 0) {
                        context.read<CartCubit>().removeFromCart(foodItem);
                        return;
                      }
                      context.read<CartCubit>().decrementQuantity(foodItem);
                    },
                    width: 110.w,
                    height: 55.h,

                    backgroundColor: addToCartController.quantity > 0
                        ? Colors.transparent
                        : Color(0xFF32343E),
                    borderColor: Colors.transparent,
                    iconColor: AppColors.white,
                    iconSize: 24.h,
                    initialSize: 40.h,
                    iconBackgroundColor: Color(0xFF32343E),
                    countColor: AppColors.white,
                  ),
                ],
              ),
            ],
          ),
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
        CartPart(),
        SizedBox(height: 50.h),
      ],
    );
  }
}

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  late final TextEditingController addressController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
    formKey = GlobalKey<FormState>();
    addressController.text = faker.faker.address.streetAddress();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _AddressHeader(formKey: formKey),
            SizedBox(height: 30.h),
            _AddressField(
              formKey: formKey,
              addressController: addressController,
            ),
            SizedBox(height: 40.h),
            _SummaryPart(),
            SizedBox(height: 30.h),
            _PlaceOrderButton(),
          ],
        ),
      ),
    );
  }
}

class _PlaceOrderButton extends StatelessWidget {
  const _PlaceOrderButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartEditItemsCubit, bool>(
      builder: (context, state) {
        return CustomRectangleButton(
          onPressed: state
              ? null
              : () => context.push(
                  AppPaths.payment,
                  extra: PaymentScreenArgs(
                    totalPrice: context.read<CartCubit>().getTotalPrice(),
                  ),
                ),
          title: AppStrings.placeOrder.toUpperCase(),
          backgroundColor: state
              ? AppColors.secondary.withAlpha(100)
              : AppColors.secondary,
          textStyle: GoogleFonts.sen(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        );
      },
    );
  }
}

class _SummaryPart extends StatelessWidget {
  const _SummaryPart();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Text(
              AppStrings.total.toUpperCase(),
              style: GoogleFonts.sen(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: Color(0xFFA0A5BA),
              ),
            ),
            AnimatedDigitWidget(
              value: context.read<CartCubit>().getTotalPrice(),
              prefix: '\$',
              textStyle: GoogleFonts.sen(
                fontSize: 30.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.darkBlue,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          AppStrings.breakdown,
          style: GoogleFonts.sen(
            fontSize: 16.sp,
            color: AppColors.secondary,
            fontWeight: FontWeight.normal,
          ),
        ),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.darkBlue,
          size: 16.h,
        ),
      ],
    );
  }
}

class _AddressField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController addressController;
  const _AddressField({required this.formKey, required this.addressController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartEditAddressCubit, bool>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Form(
          key: formKey,
          child: TextFormField(
            readOnly: !state,
            controller: addressController,
            validator: (value) =>
                value!.trim().isEmpty ? AppStrings.addressEmptyMessage : null,
            style: GoogleFonts.sen(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
              color: Color(0xFF32343E),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF0F5FA),
              contentPadding: EdgeInsets.symmetric(
                vertical: 23.h,
                horizontal: 20.w,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              hintText: AppStrings.enterYourAddress,
              hintStyle: GoogleFonts.sen(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: Color(0xFF32343E).withValues(alpha: 0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AddressHeader extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _AddressHeader({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.deliveryAddress.toUpperCase(),
          style: GoogleFonts.sen(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFFA0A5BA),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () =>
              context.read<CartEditAddressCubit>().handelEditAddress(formKey),
          child: BlocBuilder<CartEditAddressCubit, bool>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return Text(
                state
                    ? AppStrings.done.toUpperCase()
                    : AppStrings.edit.toUpperCase(),
                style: GoogleFonts.sen(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: state ? Color(0xFF059C6A) : AppColors.secondary,
                  decoration: TextDecoration.underline,
                  decorationColor: state
                      ? Color(0xFF059C6A)
                      : AppColors.secondary,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
