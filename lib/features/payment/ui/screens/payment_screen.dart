import 'package:animated_digit/animated_digit.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/features/payment/data/models/cards_model.dart';
import 'package:food_delivery/features/payment/ui/cubits/selected_card_cubit.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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

class AppBarPart extends StatelessWidget {
  const AppBarPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          backgroundColor: Color(0xFFECF0F4),
          size: 55.h,
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkBlue,
            size: 20.h,
          ),
        ),
        SizedBox(width: 15.w),
        Text(
          AppStrings.payment,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}

class CardsPart extends StatefulWidget {
  final Function(int index) onCardSelected;
  const CardsPart({super.key, required this.onCardSelected});

  @override
  State<CardsPart> createState() => _CardsPartState();
}

class _CardsPartState extends State<CardsPart> {
  int selectedCard = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        itemCount: CardsModel.cards.length,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          final card = CardsModel.cards[index];
          final isSelectedCard = selectedCard == index;
          return _buildCardItem(
            card: card,
            index: index,
            isSelectedCard: isSelectedCard,
          );
        },
      ),
    );
  }

  Widget _buildCardItem({
    required CardsModel card,
    required int index,
    required bool isSelectedCard,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedCard = index);
        widget.onCardSelected(index);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.h),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFF0F5FA),
                  border: isSelectedCard
                      ? Border.all(color: AppColors.secondary, width: 1.5)
                      : null,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                height: 72.h,
                width: 85.w,
                child: SvgPicture.asset(card.logo, width: 20, height: 20),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  card.title,
                  style: GoogleFonts.sen(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF464E57),
                  ),
                ),
              ),
            ],
          ),
          isSelectedCard
              ? Positioned(
                  top: -5.h,
                  right: 7.w,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondary,
                    ),
                    child: Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 14.h,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class CardStatus extends StatelessWidget {
  const CardStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildNoCard();
  }

  Widget _buildNoCard() {
    return BlocBuilder<SelectedCardCubit, int>(
      builder: (context, state) {
        return Container(
          height: 257.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Color(0xFFF7F8F9),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Bounce(
                scaleFactor: 1.0,
                child: Container(
                  height: 120.h,
                  width: 190.w,
                  padding: EdgeInsets.all(30.r),
                  decoration: BoxDecoration(
                    color: CardsModel.cards[state].color,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: SvgPicture.asset(CardsModel.cards[state].logo),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                CardsModel.cards[state].desc,
                style: GoogleFonts.sen(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF32343E),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                CardsModel.cards[state].subDesc,
                textAlign: TextAlign.center,
                style: GoogleFonts.sen(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddNewCard extends StatelessWidget {
  const AddNewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRectangleButton(
      onPressed: () => context.push(AppPaths.addCard),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Color(0xFFF0F5FA)),
      ),
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: AppColors.secondary, size: 24.h),
          SizedBox(width: 2.w),
          Text(
            AppStrings.addNew.toUpperCase(),
            style: GoogleFonts.sen(
              color: AppColors.secondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
        CardStatus(),
        SizedBox(height: 30.h),
        AddNewCard(),
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
