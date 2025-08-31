import 'package:equatable/equatable.dart';
import 'package:food_delivery/core/constants/app_images.dart';

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
      image: AppImages.buffaloPizza,
      title: "Buffalo Pizza",
      subtitle: "Cafenio Coffee Club",
    ),
    PopularFastFoodModel(
      id: "2",
      image: AppImages.europeanPizza,
      title: "European Pizza",
      subtitle: "Uttora Coffe House",
    ),
    PopularFastFoodModel(
      id: "3",
      image: AppImages.buffaloPizza,
      title: "Buffalo Pizza",
      subtitle: "Cafenio Coffee Club",
    ),
    PopularFastFoodModel(
      id: "4",
      image: AppImages.europeanPizza,
      title: "European Pizza",
      subtitle: "Uttora Coffe House",
    ),
  ];
}
