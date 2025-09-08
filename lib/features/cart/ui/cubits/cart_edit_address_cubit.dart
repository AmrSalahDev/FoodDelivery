import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartEditAddressCubit extends Cubit<bool> {
  CartEditAddressCubit() : super(false);

  void handelEditAddress(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      emit(state == false ? true : false);
    }
  }
}
