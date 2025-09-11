import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/features/payment/data/models/cards_model.dart';
import 'package:google_fonts/google_fonts.dart';

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
