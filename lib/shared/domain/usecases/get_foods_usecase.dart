import 'package:food_delivery/shared/domain/entities/food_entity.dart';
import 'package:food_delivery/shared/domain/repos/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFoodsUsecase {
  final FoodRepo foodRepo;

  GetFoodsUsecase(this.foodRepo);

  Future<List<FoodEntity>> call({String? category, int? limit}) =>
      foodRepo.getFoods(category: category, limit: limit);
}
