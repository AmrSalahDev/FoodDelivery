import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String title;
  final String image;
  final double startingPrice;

  const CategoryEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.startingPrice,
  });

  @override
  List<Object?> get props => [id, title, image, startingPrice];
}
