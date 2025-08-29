abstract class RegisterRepo {
  Future<void> register({
    required String email,
    required String password,
    required String name,
  });
}
