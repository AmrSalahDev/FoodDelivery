import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/app/models/food_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FoodCubit extends Cubit<List<FoodModel>> {
  FoodCubit() : super([]) {
    loadInitialFoods();
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

  void incrementQuantity(String id) {
    emit(
      state.map((food) {
        if (food.id == id) {
          return food.copyWith(quantity: food.quantity + 1);
        }
        return food;
      }).toList(),
    );
  }

  void decrementQuantity(String id) {
    emit(
      state
          .map((food) {
            if (food.id == id) {
              final newQty = food.quantity - 1;
              return newQty > 0 ? food.copyWith(quantity: newQty) : null;
            }
            return food;
          })
          .whereType<FoodModel>()
          .toList(),
    );
  }

  int getQuantity(String id) {
    try {
      return state.firstWhere((food) => food.id == id).quantity;
    } catch (_) {
      return 0;
    }
  }
}
