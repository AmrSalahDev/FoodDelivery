import 'package:food_delivery/shared/domain/entities/restaurant_entity.dart';
import 'package:food_delivery/shared/domain/repos/restaurant_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRestaurantsUsecase {
  final RestaurantRepo repository;

  GetRestaurantsUsecase(this.repository);

  Future<List<RestaurantEntity>> call({String? category, int? limit}) async {
    return await repository.getRestaurants(category: category, limit: limit);
  }
}
