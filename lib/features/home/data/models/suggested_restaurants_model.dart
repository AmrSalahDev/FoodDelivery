import 'package:equatable/equatable.dart';

class SuggestedRestaurantsModel extends Equatable {
  final String id;
  final String name;
  final String rate;
  final String image;

  const SuggestedRestaurantsModel({
    required this.id,
    required this.name,
    required this.rate,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, rate, image];

  static final List<SuggestedRestaurantsModel> suggestedRestaurants = [
    const SuggestedRestaurantsModel(
      id: '1',
      name: 'Pansi Restaurant',
      rate: '4.7',
      image:
          'https://images.pexels.com/photos/2977514/pexels-photo-2977514.jpeg',
    ),
    const SuggestedRestaurantsModel(
      id: '2',
      name: 'American Spicy Burger Shop',
      rate: '4.3',
      image:
          'https://images.pexels.com/photos/4252146/pexels-photo-4252146.jpeg',
    ),
    const SuggestedRestaurantsModel(
      id: '3',
      name: 'Cafenio Coffee Club',
      rate: '4.0',
      image:
          'https://images.pexels.com/photos/3717880/pexels-photo-3717880.jpeg',
    ),
  ];
}
