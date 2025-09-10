import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery/core/models/food_model.dart';
import 'package:injectable/injectable.dart';

part 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<List<FoodModel>> {
  CartCubit() : super([]) {
    //loadInitialFoods();
  }

  void loadInitialFoods() {
    emit([
      ...FoodModel.burgerList,
      ...FoodModel.pizzaList,
      ...FoodModel.pastaList,
      ...FoodModel.sandwichList,
      ...FoodModel.foodList,
    ]);
  }

  void changeSize({required FoodModel food, required String size}) => emit(
    state.map((p) => p.id == food.id ? p.copyWith(size: size) : p).toList(),
  );

  void incrementQuantity(FoodModel food) {
    if (isClosed) return;
    final index = state.indexWhere((p) => p.id == food.id);

    if (index == -1) {
      emit([...state, food.copyWith(quantity: 1)]);
    } else {
      final updated = state[index].copyWith(
        quantity: state[index].quantity + 1,
      );

      final newState = [...state];
      newState[index] = updated;
      emit(newState);
    }
  }

  void decrementQuantity(FoodModel food) {
    if (isClosed) return;

    final index = state.indexWhere((p) => p.id == food.id);
    if (index == -1) return;

    final current = state[index];
    if (current.quantity > 1) {
      final updated = current.copyWith(quantity: current.quantity - 1);

      final newState = [...state];
      newState[index] = updated;
      emit(newState);
    } else {
      final newState = [...state]..removeAt(index);
      emit(newState);
    }
  }

  void clearCart() => emit([]);

  void removeFromCart(FoodModel food) =>
      emit(state.where((p) => p.id != food.id).toList());

  FoodModel getFoodFromCart(FoodModel food) => state.firstWhere(
    (p) => p.id == food.id,
    orElse: () => food.copyWith(quantity: 0),
  );

  bool isInCart(FoodModel food) {
    return state.any((f) => f.id == food.id);
  }

  double getTotalPrice() {
    return state.fold(
      0.0,
      (previousValue, food) => previousValue + (food.price * food.quantity),
    );
  }
}
