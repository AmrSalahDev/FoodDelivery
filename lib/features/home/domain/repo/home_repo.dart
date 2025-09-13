import 'package:food_delivery/features/home/data/models/category_model.dart';

abstract class HomeRepo {
  Future<List<CategoryModel>> fetchCategories();
}
