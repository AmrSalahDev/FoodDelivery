import 'package:food_delivery/features/register/domain/repo/register_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: RegisterRepo)
class RegisterRepoImpl implements RegisterRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
  }
}
