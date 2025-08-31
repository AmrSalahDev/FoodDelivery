import 'package:equatable/equatable.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';

class PopularFoodModel extends Equatable {
  final String id;
  final String title;
  final String image;
  final String subtitle;
  final double price;
  final int quantity;

  const PopularFoodModel({
    required this.id,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, title, image, subtitle, price, quantity];

  static final List<PopularFoodModel> popularFoodList = [
    PopularFoodModel(
      id: '1',
      title: 'Burger Bistro',
      image: Assets.images.food.burgerBistro.path,
      subtitle: 'Rose garden',
      price: 40,
      quantity: 0,
    ),
    PopularFoodModel(
      id: '2',
      title: "Smokin' Burger",
      image: Assets.images.food.smokinBurger.path,
      subtitle: 'Cafenio Restaurant',
      price: 60,
      quantity: 0,
    ),
    PopularFoodModel(
      id: '3',
      title: 'Buffalo Burgers',
      image: Assets.images.food.buffaloBurger.path,
      subtitle: 'Kaji Firm Kitchen',
      price: 75,
      quantity: 0,
    ),
    PopularFoodModel(
      id: '4',
      title: 'Bullseye Burgers',
      image: Assets.images.food.bullseyeBurger.path,
      subtitle: 'Kabab restaurant',
      price: 94,
      quantity: 0,
    ),
  ];
}
