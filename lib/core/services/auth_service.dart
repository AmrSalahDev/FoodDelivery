import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class AuthService {
  bool isUserLoggedIn() {
    final user = Supabase.instance.client.auth.currentUser;
    return user != null;
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }
}
