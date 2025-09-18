import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/shared/cubits/food_state.dart';
import 'package:food_delivery/shared/domain/usecases/get_foods_usecase.dart';
import 'package:food_delivery/shared/domain/usecases/get_one_food_per_category_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodCubit extends Cubit<FoodState> {
  final GetFoodsUsecase getFoodsUsecase;
  final GetOneFoodPerCategoryUsecase getOneFoodPerCategoryUsecase;

  FoodCubit(this.getFoodsUsecase, this.getOneFoodPerCategoryUsecase)
    : super(FoodInitial());

  Future<void> fetchFoods({String? category, int? limit}) async {
    emit(FoodLoading());
    try {
      final foods = await getFoodsUsecase(category: category, limit: limit);
      emit(FoodLoaded(foods));
    } catch (e) {
      emit(FoodFailure(e.toString()));
    }
  }

  Future<void> getOneFoodPerCategory() async {
    emit(FoodLoading());
    try {
      final foods = await getOneFoodPerCategoryUsecase();
      emit(FoodLoaded(foods));
    } catch (e) {
      emit(FoodFailure(e.toString()));
    }
  }

  // void incrementQuantity(String id) {
  //   emit(
  //     state.map((food) {
  //       if (food.id == id) {
  //         return food.copyWith(quantity: food.quantity + 1);
  //       }
  //       return food;
  //     }).toList(),
  //   );
  // }

  // void decrementQuantity(String id) {
  //   emit(
  //     state
  //         .map((food) {
  //           if (food.id == id) {
  //             final newQty = food.quantity - 1;
  //             return newQty > 0 ? food.copyWith(quantity: newQty) : null;
  //           }
  //           return food;
  //         })
  //         .whereType<FoodModel>()
  //         .toList(),
  //   );
  // }

  // int getQuantity(String id) {
  //   try {
  //     return state.firstWhere((food) => food.id == id).quantity;
  //   } catch (_) {
  //     return 0;
  //   }
  // }
}
