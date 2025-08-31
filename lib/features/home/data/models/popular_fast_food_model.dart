import 'package:equatable/equatable.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';

class PopularFastFoodModel extends Equatable {
  final String id;
  final String image;
  final String title;
  final String subtitle;

  const PopularFastFoodModel({
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  List<Object?> get props => [id, image, title, subtitle];

  static final List<PopularFastFoodModel> popularFastFoodList = [
    PopularFastFoodModel(
      id: "1",
      image: Assets.images.food.buffaloPizza.path,
      title: "Buffalo Pizza",
      subtitle: "Cafenio Coffee Club",
    ),
    PopularFastFoodModel(
      id: "2",
      image: Assets.images.food.europeanPizza.path,
      title: "European Pizza",
      subtitle: "Uttora Coffe House",
    ),
    PopularFastFoodModel(
      id: "3",
      image: Assets.images.food.buffaloPizza.path,
      title: "Buffalo Pizza",
      subtitle: "Cafenio Coffee Club",
    ),
    PopularFastFoodModel(
      id: "4",
      image: Assets.images.food.europeanPizza.path,
      title: "European Pizza",
      subtitle: "Uttora Coffe House",
    ),
  ];
}
