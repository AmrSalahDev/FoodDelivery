class FoodEntity {
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

  const FoodEntity({
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
}
