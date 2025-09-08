import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

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
  });

  FoodModel copyWith({
    String? id,
    String? image,
    String? title,
    String? description,
    int? price,
    String? restaurantName,
    int? quantity,
    double? rating,
    String? deliveryTime,
    String? deliveryCost,
  }) => FoodModel(
    id: id ?? this.id,
    image: image ?? this.image,
    title: title ?? this.title,
    description: description ?? this.description,
    price: price ?? this.price,
    restaurantName: restaurantName ?? this.restaurantName,
    quantity: quantity ?? this.quantity,
    rating: rating ?? this.rating,
    deliveryTime: deliveryTime ?? this.deliveryTime,
    deliveryCost: deliveryCost ?? this.deliveryCost,
  );

  @override
  List<Object?> get props => [id, title, quantity];

  static final List<FoodModel> foodCategoriesList = <FoodModel>[
    FoodModel(
      title: "Burger",
      image: Assets.images.food.burger.burger2.path,
      id: uuid.v4(),
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      title: "Pizza",
      image: Assets.images.food.pizza.pizza4.path,
      id: uuid.v4(),
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      title: "Pasta",
      image: Assets.images.food.pasta.pasta1.path,
      id: uuid.v4(),
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      title: "Salad",
      image: Assets.images.food.salad.path,
      id: uuid.v4(),
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      title: "French Fries",
      image: Assets.images.food.frenchFries.path,
      id: uuid.v4(),
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      title: "Soup",
      image: Assets.images.food.soup.path,
      id: uuid.v4(),
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      title: "Steak",
      image: Assets.images.food.steak.path,
      id: uuid.v4(),
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
  ];

  static final List<FoodModel> sandwichList = [
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.sandwich.sand1.path,
      title: "Sandwich",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.sandwich.sand2.path,
      title: "Sandwich",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
  ];

  static final List<FoodModel> pastaList = [
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pasta.pasta1.path,
      title: "Pasta",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pasta.pasta2.path,
      title: "Pasta",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pasta.pasta3.path,
      title: "Pasta",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pasta.pasta4.path,
      title: "Pasta",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pasta.pasta5.path,
      title: "Pasta",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pasta.pasta6.path,
      title: "Pasta",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pasta.pasta7.path,
      title: "Pasta",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
  ];

  static final List<FoodModel> pizzaList = [
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pizza.pizza1.path,
      title: "Pizza",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pizza.pizza2.path,
      title: "Pizza",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pizza.pizza3.path,
      title: "Pizza",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pizza.pizza4.path,
      title: "Pizza",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pizza.pizza5.path,
      title: "Pizza",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pizza.pizza6.path,
      title: "Pizza",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
  ];

  static final List<FoodModel> burgerList = [
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.burger.burger1.path,
      title: "Burger",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.burger.burger2.path,
      title: "Burger",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.burger.burger3.path,
      title: "Burger",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.burger.burger4.path,
      title: "Burger",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
  ];

  static final List<FoodModel> foodList = [
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.burger.burger1.path,
      title: "Buffalo Pizza",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      quantity: 0,
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pizza.pizza1.path,
      title: "European Pizza",
      restaurantName: "Uttora Coffe House",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
      quantity: 0,
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.pasta.pasta1.path,
      title: "Buffalo Pizza",
      restaurantName: "Cafenio Coffee Club",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
      quantity: 0,
    ),
    FoodModel(
      id: uuid.v4(),
      image: Assets.images.food.sandwich.sand1.path,
      title: "European Pizza",
      restaurantName: "Uttora Coffe House",
      description:
          "Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
      price: faker.randomGenerator.integer(100),
      rating: 4.5,
      deliveryTime: "10 min",
      deliveryCost: "Free",
      quantity: 0,
    ),
  ];
}
