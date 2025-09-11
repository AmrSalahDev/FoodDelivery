import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:food_delivery/core/routes/app_router.dart';
import 'package:food_delivery/core/routes/args/add_card_screen_args.dart';
import 'package:food_delivery/features/payment/enums/cards_supported.dart';
import 'package:food_delivery/features/payment/ui/cubits/selected_card_cubit.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewCardPart extends StatelessWidget {
  const AddNewCardPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCardCubit, int>(
      builder: (context, state) {
        CardsSupported cardType = CardsSupported.visaCard;
        return CustomRectangleButton(
          onPressed: () {
            switch (state) {
              case 1:
                cardType = CardsSupported.visaCard;
                break;
              case 2:
                cardType = CardsSupported.masterCard;
                break;
              case 3:
                cardType = CardsSupported.payPal;
                break;
            }
            context.push(
              AppPaths.addCard,
              extra: AddCardScreenArgs(cardType: cardType),
            );
          },
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
      },
    );
  }
}
