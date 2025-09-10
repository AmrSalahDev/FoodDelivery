import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectedCardCubit extends Cubit<int> {
  SelectedCardCubit() : super(0);

  void onCardSelected(int index) {
    emit(index);
  }
}
