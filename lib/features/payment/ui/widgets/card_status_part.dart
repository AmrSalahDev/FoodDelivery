import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/payment/data/models/card_info_model.dart';
import 'package:food_delivery/features/payment/ui/cubits/card_cubit.dart';
import 'package:food_delivery/features/payment/ui/cubits/selected_card_cubit.dart';
import 'package:food_delivery/features/payment/ui/widgets/added_card_part.dart';
import 'package:food_delivery/features/payment/ui/widgets/no_card_part.dart';

class CardStatusPart extends StatelessWidget {
  const CardStatusPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCardCubit, int>(
      builder: (context, state) {
        return BlocBuilder<CardCubit, List<CardInfoModel>>(
          builder: (context, cards) {
            if (cards.isEmpty) {
              return NoCardPart();
            }
            return AddedCardPart(cards: cards);
          },
        );
      },
    );
  }
}
