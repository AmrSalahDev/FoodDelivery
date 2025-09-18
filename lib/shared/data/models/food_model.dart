import 'package:equatable/equatable.dart';
import 'package:food_delivery/shared/domain/entities/food_entity.dart';

class FoodModel extends Equatable {
  final String id;
  final String image;
  final String title;
  final String description;
  final int price;
  final String restaurantName;
  final int quantity;
  final double rating;
  final String deliveryTime;
  final String deliveryCost;
  final String size;
  final String category;

  const FoodModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.restaurantName,
    required this.quantity,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryCost,
    required this.size,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, quantity];

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
    id: json['id']?.toString() ?? '',
    image: json['image'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    price: (json['price'] is int)
        ? json['price']
        : (json['price'] as num?)?.toInt() ?? 0,
    restaurantName: json['restaurant_name'] ?? '',
    quantity: (json['quantity'] is int)
        ? json['quantity']
        : (json['quantity'] as num?)?.toInt() ?? 0,
    rating: (json['rating'] is double)
        ? json['rating']
        : (json['rating'] as num?)?.toDouble() ?? 0.0,
    deliveryTime: json['delivery_time'] ?? '',
    deliveryCost: json['delivery_cost'] ?? '',
    size: json['size']?.toString() ?? '',
    category: json['category']?.toString() ?? '',
  );

  FoodEntity toEntity() => FoodEntity(
    id: id,
    image: image,
    title: title,
    description: description,
    price: price,
    restaurantName: restaurantName,
    quantity: quantity,
    rating: rating,
    deliveryTime: deliveryTime,
    deliveryCost: deliveryCost,
    size: size,
    category: category,
  );
}
