import 'package:food_delivery/core/constants/app_images.dart';
import 'package:food_delivery/core/constants/app_strings.dart';

class FoodItemsModel {
  final String title;
  final String image;

  FoodItemsModel({required this.title, required this.image});

  static final List<FoodItemsModel> foodItems = <FoodItemsModel>[
    FoodItemsModel(title: AppStrings.burger, image: AppImages.burger),
    FoodItemsModel(title: AppStrings.pizza, image: AppImages.pizza),
    FoodItemsModel(title: AppStrings.pasta, image: AppImages.pasta),
    FoodItemsModel(title: AppStrings.salad, image: AppImages.salad),
    FoodItemsModel(title: AppStrings.frenchFries, image: AppImages.frenchFries),
    FoodItemsModel(title: AppStrings.soup, image: AppImages.soup),
    FoodItemsModel(title: AppStrings.steak, image: AppImages.steak),
  ];
}
