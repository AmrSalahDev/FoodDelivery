import 'package:food_delivery/core/constants/app_images.dart';
import 'package:food_delivery/core/constants/app_strings.dart';

class RestaurantItemsModel {
  final String id;
  final String name;
  final String deliveryCost;
  final String image;
  final List<String> foodTypes;
  final String rate;
  final String deliveryTime;

  RestaurantItemsModel({
    required this.id,
    required this.name,
    required this.deliveryCost,
    required this.image,
    required this.foodTypes,
    required this.rate,
    required this.deliveryTime,
  });

  static final List<RestaurantItemsModel> restaurantItems = [
    RestaurantItemsModel(
      id: "1",
      name: AppStrings.roseGardenRestaurant,
      deliveryCost: "Free",
      image: AppImages.restaurant1,
      foodTypes: ["Burger", "Chiken", "Riche", "Wings"],
      rate: "4.5",
      deliveryTime: "20 min",
    ),
  ];
}
