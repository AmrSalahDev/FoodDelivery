import 'package:food_delivery/features/login/domain/repo/login_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> login({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }
}
