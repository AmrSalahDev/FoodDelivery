import 'package:food_delivery/features/login/domain/repo/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepo loginRepo;
  LoginUseCase({required this.loginRepo});

  Future<void> call({required String email, required String password}) async {
    await loginRepo.login(email: email, password: password);
  }
}
