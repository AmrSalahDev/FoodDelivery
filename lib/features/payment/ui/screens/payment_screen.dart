import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/features/payment/ui/cubits/selected_card_cubit.dart';
import 'package:food_delivery/features/payment/ui/widgets/add_new_card_part.dart';
import 'package:food_delivery/features/payment/ui/widgets/card_status_part.dart';
import 'package:food_delivery/features/payment/ui/widgets/cards_part.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/app_bar_part.dart';

class PaymentScreen extends StatefulWidget {
  final double totalPrice;
  const PaymentScreen({super.key, required this.totalPrice});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
      bottomNavigationBar: FooterSection(totalPrice: widget.totalPrice),
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

class BodySection extends StatelessWidget {
  const BodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardsPart(
          onCardSelected: (index) {
            context.read<SelectedCardCubit>().onCardSelected(index);
          },
        ),
        SizedBox(height: 30.h),
        CardStatusPart(),
        SizedBox(height: 30.h),
        BlocBuilder<SelectedCardCubit, int>(
          builder: (context, state) {
            if (state == 0) {
              return SizedBox.shrink();
            }
            return AddNewCardPart();
          },
        ),
      ],
    );
  }
}

class FooterSection extends StatelessWidget {
  final double totalPrice;
  const FooterSection({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                value: totalPrice,
                prefix: '\$',
                textStyle: GoogleFonts.sen(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.darkBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          CustomRectangleButton(
            backgroundColor: AppColors.secondary,
            title: AppStrings.payAndConfirm.toUpperCase(),
            onPressed: () {
              context.push(AppPaths.paymentSuccess);
            },
            textStyle: GoogleFonts.sen(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
