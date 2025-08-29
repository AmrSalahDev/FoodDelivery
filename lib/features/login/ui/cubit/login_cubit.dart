import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/login/domain/usecases/login_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await loginUseCase(email: email, password: password);
      emit(LoginSuccess());
    } on AuthApiException catch (e) {
      emit(LoginFailure(message: e.message));
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }
}
