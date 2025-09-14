import 'package:food_delivery/features/home/domain/entities/category_entity.dart';

class CategoryModel {
  final String id;
  final String title;
  final String image;
  final double startingPrice;

  CategoryModel({
    required this.id,
    required this.title,
    required this.image,
    required this.startingPrice,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] == null ? '' : json['id'] as String,
      title: json['title'] == null ? '' : json['title'] as String,
      image: json['image'] == null ? '' : json['image'] as String,
      startingPrice: json['startingPrice'] == null
          ? 0.0
          : (json['startingPrice'] as num).toDouble(),
    );
  }

  CategoryEntity toEntity() => CategoryEntity(
    id: id,
    title: title,
    image: image,
    startingPrice: startingPrice,
  );

  @override
  String toString() {
    return 'CategoryModel(id: $id, title: $title, price: $startingPrice)';
  }
}
