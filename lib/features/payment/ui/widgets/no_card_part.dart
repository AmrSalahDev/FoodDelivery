import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/features/payment/data/models/cards_model.dart';
import 'package:food_delivery/features/payment/ui/cubits/selected_card_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class NoCardPart extends StatelessWidget {
  const NoCardPart({super.key});

  @override
  Widget build(BuildContext context) {
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
