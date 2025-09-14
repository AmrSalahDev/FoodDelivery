import 'package:food_delivery/features/restaurant_details/domain/entities/restaurant_entity.dart';
import 'package:food_delivery/features/restaurant_details/domain/repo/restaurant_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRestaurantsUsecase {
  final RestaurantRepo repository;

  GetRestaurantsUsecase(this.repository);

  Future<List<RestaurantEntity>> call({int? limit}) async {
    return await repository.getRestaurants(limit: limit);
  }
}
