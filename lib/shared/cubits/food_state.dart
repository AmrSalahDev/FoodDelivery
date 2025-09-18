import 'package:equatable/equatable.dart';
import 'package:food_delivery/shared/domain/entities/food_entity.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object?> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<FoodEntity> foods;

  const FoodLoaded(this.foods);

  @override
  List<Object?> get props => [foods];
}

class FoodFailure extends FoodState {
  final String message;

  const FoodFailure(this.message);

  @override
  List<Object?> get props => [message];
}
