import 'package:food_delivery/features/home/data/models/category_model.dart';
import 'package:food_delivery/features/home/domain/entities/category_entity.dart';
import 'package:food_delivery/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  @override
  Future<List<CategoryEntity>> fetchCategories() async {
    try {
      final response = await Supabase.instance.client
          .from('all_categories')
          .select();

      return (response as List)
          .map((e) => CategoryModel.fromJson(e).toEntity())
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}
