import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/register/domain/usecases/register_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(RegisterLoading());
    try {
      await registerUseCase(email: email, password: password, name: name);
      emit(RegisterSuccess());
    } on AuthApiException catch (e) {
      emit(RegisterFailure(message: e.message));
    } catch (e) {
      emit(RegisterFailure(message: e.toString()));
    }
  }
}
