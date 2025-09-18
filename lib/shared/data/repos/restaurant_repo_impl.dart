import 'package:food_delivery/shared/data/models/restaurant_model.dart';
import 'package:food_delivery/shared/domain/repos/restaurant_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/restaurant_entity.dart';

@LazySingleton(as: RestaurantRepo)
class RestaurantRepositoryImpl implements RestaurantRepo {
  final supabase = Supabase.instance.client;

  // @override
  // Future<List<RestaurantEntity>> getRestaurants({
  //   String? category,
  //   int? limit,
  // }) async {
  //   dynamic data = supabase.from('restaurants').select();

  //   if (category != null && category.isNotEmpty) {
  //     // 1. Filter the query to check if the 'category' array column contains the specified string.
  //     data = data.filter('categories', 'cs', '{"${category.toLowerCase()}"}');
  //   }

  //   if (limit != null) {
  //     // 2. Apply the limit if it exists.
  //     data = data.limit(limit);
  //   }

  //   final response = await data;

  //   // 3. Map the response to a list of RestaurantEntity objects.
  //   return (response as List)
  //       .map((json) => RestaurantModel.fromJson(json).toEntity())
  //       .toList();
  // }

  @override
  Future<List<RestaurantEntity>> getRestaurants({
    String? category,
    int? limit,
  }) async {
    // Start with the base query.
    dynamic data = supabase.from('restaurants').select();

    // 1. Process the input category string.
    if (category != null && category.isNotEmpty) {
      // Trim whitespace and split the string by spaces to get a list of keywords.
      List<String> tokens = category
          .trim()
          .toLowerCase()
          .split(RegExp(r'\s+'))
          .where((t) => t.isNotEmpty)
          .toList();

      // 2. Build the dynamic OR filter.
      if (tokens.isNotEmpty) {
        // Create a list of filter clauses, one for each keyword.
        // We use the `cs` (contains) operator to check if the `category` array
        // includes the specific token.
        String orFilter = tokens
            .map((token) => 'categories.cs.{"$token"}')
            .join(',');

        // Apply the combined OR filter to the query.
        data = data.or(orFilter);
      }
    }

    // 3. Apply the limit if it exists.
    if (limit != null) {
      data = data.limit(limit);
    }

    // Execute the query.
    final response = await data;

    // 4. Map the response to a list of RestaurantEntity objects.
    return (response as List)
        .map((json) => RestaurantModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<RestaurantEntity> getRestaurantById(String id) async {
    final response = await supabase
        .from('restaurants')
        .select()
        .eq('id', id)
        .single();
    return RestaurantModel.fromJson(response).toEntity();
  }
}
