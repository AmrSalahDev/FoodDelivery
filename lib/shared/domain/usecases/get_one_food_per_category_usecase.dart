import 'package:food_delivery/shared/domain/entities/food_entity.dart';
import 'package:food_delivery/shared/domain/repos/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOneFoodPerCategoryUsecase {
  final FoodRepo foodRepo;
  GetOneFoodPerCategoryUsecase({required this.foodRepo});
  Future<List<FoodEntity>> call() => foodRepo.getOneFoodPerCategory();
}
