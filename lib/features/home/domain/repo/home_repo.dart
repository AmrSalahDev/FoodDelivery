import 'package:food_delivery/features/home/domain/entities/category_entity.dart';

abstract class HomeRepo {
  Future<List<CategoryEntity>> fetchCategories();
}
