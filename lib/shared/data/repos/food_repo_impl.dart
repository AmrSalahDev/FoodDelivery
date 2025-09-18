import 'package:food_delivery/shared/data/models/food_model.dart';
import 'package:food_delivery/shared/domain/entities/food_entity.dart';
import 'package:food_delivery/shared/domain/repos/food_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: FoodRepo)
class FoodRepoImpl implements FoodRepo {
  final supabase = Supabase.instance.client;

  // @override
  // Future<List<FoodEntity>> getFoods({String? category, int? limit}) async {
  //   try {
  //     final trimmed = category?.trim() ?? '';
  //     print('trimmed: $trimmed');
  //     final pattern = '%$trimmed%';

  //     dynamic builder = supabase.from('foods').select();

  //     // if (trimmed.isNotEmpty) {
  //     //   builder = builder.ilike('category', '%$trimmed%');
  //     // }

  //     if (trimmed.isNotEmpty) {
  //       builder = builder.or(
  //         'category.ilike.$pattern,title.ilike.$pattern,description.ilike.$pattern',
  //       );
  //     }

  //     if (limit != null) {
  //       builder = builder.limit(limit);
  //     }

  //     final data = await builder;

  //     return (data as List)
  //         .map((json) => FoodModel.fromJson(json).toEntity())
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Failed to fetch foods: $e');
  //   }
  // }

  @override
  Future<List<FoodEntity>> getFoods({String? category, int? limit}) async {
    try {
      final trimmed = (category ?? '').trim();

      final tokens = trimmed
          .toLowerCase()
          .split(RegExp(r'\s+'))
          .where((t) => t.isNotEmpty)
          .toList();

      dynamic builder = supabase.from('foods').select();

      if (tokens.isNotEmpty) {
        final conditions = <String>[];
        for (final t in tokens) {
          final p = '%$t%';
          // check all columns you want to search
          conditions.add('category.ilike.$p');
          conditions.add('title.ilike.$p');
          conditions.add('description.ilike.$p');
          conditions.add('restaurant_name.ilike.$p'); // optional
          // add more columns if needed, e.g. tags, size_text, etc.
        }
        final orString = conditions.join(',');
        builder = builder.or(orString);
      }

      if (limit != null) builder = builder.limit(limit);

      final data = await builder;

      if (data == null) return [];

      // If supabase returned an error payload (Map with message), handle it
      if (data is Map && data.containsKey('message')) {
        return [];
      }

      final all = (data as List)
          .map((json) => FoodModel.fromJson(json).toEntity())
          .toList();

      return all;
    } catch (e) {
      throw Exception('Failed to fetch foods: $e');
    }
  }

  @override
  Future<List<FoodEntity>> getOneFoodPerCategory() async {
    try {
      final data = await supabase.from('foods').select();

      final foods = (data as List)
          .map((json) => FoodModel.fromJson(json).toEntity())
          .toList();

      // Map to hold first food per category
      final Map<String, FoodEntity> categoryMap = {};

      for (final food in foods) {
        if (!categoryMap.containsKey(food.category)) {
          categoryMap[food.category] = food;
        }
      }

      return categoryMap.values.toList();
    } catch (e) {
      throw Exception('Failed to fetch foods: $e');
    }
  }
}
