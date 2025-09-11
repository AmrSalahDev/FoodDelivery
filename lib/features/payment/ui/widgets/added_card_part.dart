import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/utils/credit_card_utils.dart';
import 'package:food_delivery/features/payment/data/models/card_info_model.dart';
import 'package:google_fonts/google_fonts.dart';

class AddedCardPart extends StatelessWidget {
  final List<CardInfoModel> cards;
  const AddedCardPart({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      shrinkWrap: true,
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final card = cards[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: CardAddedItem(
            cardType: card.cardType,
            cardLogo: card.cardLogo,
            card: card,
          ),
        );
      },
    );
  }
}

class CardAddedItem extends StatelessWidget {
  const CardAddedItem({
    super.key,
    required this.cardType,
    required this.cardLogo,
    required this.card,
  });

  final String cardType;
  final String cardLogo;
  final CardInfoModel card;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.h,
      width: double.infinity,
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: const Color(0xFFF4F5F7),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardType,
                style: GoogleFonts.sen(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF32343E),
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  SizedBox(
                    width: 30.h,
                    height: 20.h,
                    child: SvgPicture.asset(cardLogo),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    CreditCardUtils.maskCardNumber(card.cardNumber),
                    style: GoogleFonts.sen(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF32343E),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_drop_down,
              size: 25.h,
              color: AppColors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
