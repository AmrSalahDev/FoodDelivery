part of 'restaurant_cubit.dart';

sealed class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final RestaurantEntity restaurant;
  const RestaurantLoaded(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}

class RestaurantError extends RestaurantState {
  final String message;
  const RestaurantError(this.message);

  @override
  List<Object> get props => [message];
}

class RestaurantListLoaded extends RestaurantState {
  final List<RestaurantEntity> restaurants;
  const RestaurantListLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}
