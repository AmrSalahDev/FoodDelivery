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
      image:
          "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
      foodTypes: ["Burger", "Chiken", "Riche", "Wings"],
      rate: "4.9",
      deliveryTime: "25 min",
    ),
    RestaurantItemsModel(
      id: "1",
      name: AppStrings.roseGardenRestaurant,
      deliveryCost: "Free",
      image: "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg",
      foodTypes: ["Burger", "Chiken", "Riche", "Wings"],
      rate: "4.7",
      deliveryTime: "10 min",
    ),
    RestaurantItemsModel(
      id: "1",
      name: AppStrings.roseGardenRestaurant,
      deliveryCost: "Free",
      image: "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg",
      foodTypes: ["Burger", "Chiken", "Riche", "Wings"],
      rate: "4.3",
      deliveryTime: "30 min",
    ),
    RestaurantItemsModel(
      id: "1",
      name: AppStrings.roseGardenRestaurant,
      deliveryCost: "Free",
      image:
          "https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg",
      foodTypes: ["Burger", "Chiken", "Riche", "Wings"],
      rate: "4.0",
      deliveryTime: "6 min",
    ),
  ];
}
