import 'package:equatable/equatable.dart';

abstract class FoodItem extends Equatable {
  final String id;
  final String title;
  final String image;
  final String subtitle;
  final double price;
  final int quantity;
  final double rating;
  final String deliveryTime;
  final String deliveryCost;
  final String description;

  const FoodItem({
    required this.id,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.price,
    required this.quantity,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryCost,
    required this.description,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    image,
    subtitle,
    price,
    quantity,
    rating,
    deliveryTime,
    deliveryCost,
    description,
  ];
}
