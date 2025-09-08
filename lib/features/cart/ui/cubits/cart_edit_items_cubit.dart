import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartEditItemsCubit extends Cubit<bool> {
  CartEditItemsCubit() : super(false);
  void toggle() => emit(!state);
}
