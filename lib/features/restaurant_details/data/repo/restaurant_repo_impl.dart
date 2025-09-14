import 'package:food_delivery/features/restaurant_details/data/models/restaurant_model.dart';
import 'package:food_delivery/features/restaurant_details/domain/repo/restaurant_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/restaurant_entity.dart';

@LazySingleton(as: RestaurantRepo)
class RestaurantRepositoryImpl implements RestaurantRepo {
  final client = Supabase.instance.client;

  RestaurantRepositoryImpl();

  @override
  Future<List<RestaurantEntity>> getRestaurants({int? limit}) async {
    PostgrestTransformBuilder<PostgrestList> query = client
        .from('restaurants')
        .select();

    if (limit != null) {
      query = query.limit(limit);
    }

    final response = await query;
    return (response as List<dynamic>)
        .map((json) => RestaurantModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<RestaurantEntity> getRestaurantById(String id) async {
    final response = await client
        .from('restaurants')
        .select()
        .eq('id', id)
        .single();
    return RestaurantModel.fromJson(response).toEntity();
  }
}
