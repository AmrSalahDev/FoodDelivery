import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  late final Timer timer;

  void startGreeting() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(UserGreeting(greeting: _getGreeting()));
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Future<void> close() {
    if (timer.isActive) timer.cancel();
    return super.close();
  }
}
