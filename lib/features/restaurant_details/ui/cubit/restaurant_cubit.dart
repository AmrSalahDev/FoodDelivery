import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery/features/restaurant_details/domain/entities/restaurant_entity.dart';
import 'package:food_delivery/features/restaurant_details/domain/usecases/get_restaurant_details_usecase.dart';
import 'package:food_delivery/features/restaurant_details/domain/usecases/get_restaurants_usecase.dart';
import 'package:injectable/injectable.dart';

part 'restaurant_state.dart';

@injectable
class RestaurantCubit extends Cubit<RestaurantState> {
  final GetRestaurantDetailsUseCase getRestaurantDetails;
  final GetRestaurantsUsecase getRestaurantsUsecase;

  RestaurantCubit({
    required this.getRestaurantDetails,
    required this.getRestaurantsUsecase,
  }) : super(RestaurantInitial());

  Future<void> fetchRestaurantDetails(String id) async {
    emit(RestaurantLoading());
    try {
      final restaurant = await getRestaurantDetails(id);
      emit(RestaurantLoaded(restaurant));
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }

  Future<void> fetchRestaurants({int? limit}) async {
    emit(RestaurantLoading());
    try {
      final restaurants = await getRestaurantsUsecase(limit: limit);
      emit(RestaurantListLoaded(restaurants));
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }
}
