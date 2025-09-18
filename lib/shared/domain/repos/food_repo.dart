import 'package:food_delivery/shared/domain/entities/food_entity.dart';

abstract class FoodRepo {
  Future<List<FoodEntity>> getFoods({String? category, int? limit});
  Future<List<FoodEntity>> getOneFoodPerCategory();
}
