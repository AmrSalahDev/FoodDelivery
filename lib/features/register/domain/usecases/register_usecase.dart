import 'package:food_delivery/features/register/domain/repo/register_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final RegisterRepo registerRepo;
  RegisterUseCase({required this.registerRepo});

  Future<void> call({
    required String email,
    required String password,
    required String name,
  }) => registerRepo.register(email: email, password: password, name: name);
}
