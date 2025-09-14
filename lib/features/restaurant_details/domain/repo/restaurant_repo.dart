import 'package:food_delivery/features/restaurant_details/domain/entities/restaurant_entity.dart';

abstract class RestaurantRepo {
  Future<List<RestaurantEntity>> getRestaurants({int? limit});
  Future<RestaurantEntity> getRestaurantById(String id);
}
