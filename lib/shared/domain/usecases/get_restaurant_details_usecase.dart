import 'package:food_delivery/shared/domain/entities/restaurant_entity.dart';
import 'package:food_delivery/shared/domain/repos/restaurant_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRestaurantDetailsUseCase {
  final RestaurantRepo repository;

  GetRestaurantDetailsUseCase(this.repository);

  Future<RestaurantEntity> call(String id) async {
    return await repository.getRestaurantById(id);
  }
}
