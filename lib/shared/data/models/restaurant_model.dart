import 'package:equatable/equatable.dart';
import 'package:food_delivery/shared/domain/entities/restaurant_entity.dart';

class RestaurantModel extends Equatable {
  final String id;
  final String name;
  final String deliveryCost;
  final String imageUrl;
  final List<String> images;
  final List<String> foundFood;
  final String rate;
  final String description;
  final String deliveryTime;
  final List<String> categories;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.deliveryCost,
    required this.imageUrl,
    required this.images,
    required this.foundFood,
    required this.rate,
    required this.description,
    required this.deliveryTime,
    required this.categories,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id']?.toString() ?? '', // ensures String
      name: json['name']?.toString() ?? '',
      deliveryCost:
          json['delivery_cost']?.toString() ?? '0', // handles int/double/null
      imageUrl: json['image_url']?.toString() ?? '',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      foundFood:
          (json['found_food'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      rate: json['rate']?.toString() ?? '0',
      description: json['description']?.toString() ?? '',
      deliveryTime: json['delivery_time']?.toString() ?? '',
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  RestaurantEntity toEntity() => RestaurantEntity(
    id: id,
    name: name,
    deliveryCost: deliveryCost,
    imageUrl: imageUrl,
    images: images,
    foundFood: foundFood,
    rate: rate,
    description: description,
    deliveryTime: deliveryTime,
    categories: categories,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    deliveryCost,
    imageUrl,
    images,
    foundFood,
    rate,
    description,
    deliveryTime,
    categories,
  ];
}
