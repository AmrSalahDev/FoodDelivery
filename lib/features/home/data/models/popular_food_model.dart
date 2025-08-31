import 'package:equatable/equatable.dart';
import 'package:food_delivery/core/constants/app_images.dart';

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

  static final List<PopularFoodModel> popularFoodList = const [
    PopularFoodModel(
      id: '1',
      title: 'Burger Bistro',
      image: AppImages.burgerBistro,
      subtitle: 'Rose garden',
      price: 40,
      quantity: 0,
    ),
    PopularFoodModel(
      id: '2',
      title: "Smokin' Burger",
      image: AppImages.smokinBurger,
      subtitle: 'Cafenio Restaurant',
      price: 60,
      quantity: 0,
    ),
    PopularFoodModel(
      id: '3',
      title: 'Buffalo Burgers',
      image: AppImages.buffaloBurger,
      subtitle: 'Kaji Firm Kitchen',
      price: 75,
      quantity: 0,
    ),
    PopularFoodModel(
      id: '4',
      title: 'Bullseye Burgers',
      image: AppImages.bullseyeBurger,
      subtitle: 'Kabab restaurant',
      price: 94,
      quantity: 0,
    ),
  ];
}
