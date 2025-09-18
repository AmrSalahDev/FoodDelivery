import 'package:food_delivery/shared/domain/entities/restaurant_entity.dart';

abstract class RestaurantRepo {
  Future<List<RestaurantEntity>> getRestaurants({String? category, int? limit});
  Future<RestaurantEntity> getRestaurantById(String id);
}
