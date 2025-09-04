import 'package:food_delivery/core/constants/app_strings.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String deliveryCost;
  final String image;
  final List<String> images;
  final List<String> foodTypes;
  final String rate;
  final String description;
  final String deliveryTime;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.deliveryCost,
    required this.images,
    required this.image,
    required this.foodTypes,
    required this.rate,
    required this.description,
    required this.deliveryTime,
  });

  static final List<RestaurantModel> restaurantItems = [
    RestaurantModel(
      id: "1",
      name: AppStrings.roseGardenRestaurant,
      deliveryCost: "Free",
      images: [
        "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
        "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg",
        "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg",
        "https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg",
      ],
      image:
          "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
      foodTypes: ["Burger", "Chiken", "Riche", "Wings"],
      rate: "4.9",
      deliveryTime: "25 min",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
    ),
    RestaurantModel(
      id: "1",
      name: AppStrings.roseGardenRestaurant,
      deliveryCost: "Free",
      image: "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg",
      foodTypes: ["Burger", "Chiken", "Riche", "Wings"],
      rate: "4.7",
      images: [
        "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
        "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg",
        "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg",
        "https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg",
      ],
      deliveryTime: "10 min",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
    ),
    RestaurantModel(
      id: "1",
      name: AppStrings.roseGardenRestaurant,
      deliveryCost: "Free",
      image: "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg",
      foodTypes: ["Burger", "Chiken", "Riche", "Wings"],
      rate: "4.3",
      deliveryTime: "30 min",
      images: [
        "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
        "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg",
        "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg",
        "https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg",
      ],
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
    ),
    RestaurantModel(
      id: "1",
      name: AppStrings.roseGardenRestaurant,
      deliveryCost: "Free",
      image:
          "https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg",
      foodTypes: ["Burger", "Chiken", "Riche", "Wings"],
      rate: "4.0",
      deliveryTime: "6 min",
      images: [
        "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
        "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg",
        "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg",
        "https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg",
      ],
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
    ),
  ];
}
