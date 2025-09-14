import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/home/domain/entities/category_entity.dart';
import 'package:food_delivery/features/home/domain/usecases/fetch_categories_usecase.dart';
import 'package:injectable/injectable.dart';

part 'home_category_state.dart';

@injectable
class HomeCategoryCubit extends Cubit<HomeCategoryState> {
  final FetchCategoriesUsecase fetchCategoriesUsecase;
  HomeCategoryCubit(this.fetchCategoriesUsecase) : super(HomeCategoryInitial());

  Future<void> fetchCategories() async {
    emit(HomeCategoryLoading());
    try {
      final categories = await fetchCategoriesUsecase();

      emit(HomeCategoryLoaded(categories: categories));
    } catch (e) {
      emit(HomeCategoryFaulure(message: e.toString()));
    }
  }
}
