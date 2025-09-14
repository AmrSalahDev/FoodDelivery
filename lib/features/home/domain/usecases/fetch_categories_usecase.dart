import 'package:food_delivery/features/home/domain/entities/category_entity.dart';
import 'package:food_delivery/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchCategoriesUsecase {
  final HomeRepo homeRepo;

  FetchCategoriesUsecase({required this.homeRepo});

  Future<List<CategoryEntity>> call() => homeRepo.fetchCategories();
}
