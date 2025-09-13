part of 'home_category_cubit.dart';

class HomeCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeCategoryInitial extends HomeCategoryState {
  @override
  List<Object?> get props => [];
}

class HomeCategoryLoading extends HomeCategoryState {
  @override
  List<Object?> get props => [];
}

class HomeCategoryLoaded extends HomeCategoryState {
  final List<CategoryModel> categories;
  HomeCategoryLoaded({required this.categories});
  @override
  List<Object?> get props => [categories];
}

class HomeCategoryFaulure extends HomeCategoryState {
  final String message;
  HomeCategoryFaulure({required this.message});
  @override
  List<Object?> get props => [message];
}
