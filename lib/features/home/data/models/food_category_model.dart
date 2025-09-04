import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';

class FoodCategoryModel {
  final String title;
  final String image;

  FoodCategoryModel({required this.title, required this.image});

  static final List<FoodCategoryModel> foodItems = <FoodCategoryModel>[
    FoodCategoryModel(
      title: AppStrings.burger,
      image: Assets.images.food.burger.burger1.path,
    ),
    FoodCategoryModel(
      title: AppStrings.pizza,
      image: Assets.images.food.pizza.pizza1.path,
    ),
    FoodCategoryModel(
      title: AppStrings.pasta,
      image: Assets.images.food.pasta.pasta1.path,
    ),
    FoodCategoryModel(
      title: AppStrings.salad,
      image: Assets.images.food.salad.path,
    ),
    FoodCategoryModel(
      title: AppStrings.frenchFries,
      image: Assets.images.food.frenchFries.path,
    ),
    FoodCategoryModel(
      title: AppStrings.soup,
      image: Assets.images.food.soup.path,
    ),
    FoodCategoryModel(
      title: AppStrings.steak,
      image: Assets.images.food.steak.path,
    ),
  ];
}
