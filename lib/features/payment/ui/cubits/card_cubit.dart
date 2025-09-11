import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/payment/data/models/card_info_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CardCubit extends Cubit<List<CardInfoModel>> {
  CardCubit() : super([]);

  void saveCard(CardInfoModel card) {
    emit([...state, card]);
  }

  void clearCards() {
    emit([]);
  }
}
