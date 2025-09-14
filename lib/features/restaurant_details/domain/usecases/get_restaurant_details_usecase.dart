import 'package:food_delivery/features/restaurant_details/domain/entities/restaurant_entity.dart';
import 'package:food_delivery/features/restaurant_details/domain/repo/restaurant_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRestaurantDetailsUseCase {
  final RestaurantRepo repository;

  GetRestaurantDetailsUseCase(this.repository);

  Future<RestaurantEntity> call(String id) async {
    return await repository.getRestaurantById(id);
  }
}
