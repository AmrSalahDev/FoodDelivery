import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';

class FoodItemsModel {
  final String title;
  final String image;

  FoodItemsModel({required this.title, required this.image});

  static final List<FoodItemsModel> foodItems = <FoodItemsModel>[
    FoodItemsModel(
      title: AppStrings.burger,
      image: Assets.images.food.burger.path,
    ),
    FoodItemsModel(
      title: AppStrings.pizza,
      image: Assets.images.food.pizza.path,
    ),
    FoodItemsModel(
      title: AppStrings.pasta,
      image: Assets.images.food.pasta.path,
    ),
    FoodItemsModel(
      title: AppStrings.salad,
      image: Assets.images.food.salad.path,
    ),
    FoodItemsModel(
      title: AppStrings.frenchFries,
      image: Assets.images.food.frenchFries.path,
    ),
    FoodItemsModel(title: AppStrings.soup, image: Assets.images.food.soup.path),
    FoodItemsModel(
      title: AppStrings.steak,
      image: Assets.images.food.steak.path,
    ),
  ];
}
