class RestaurantEntity {
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

  const RestaurantEntity({
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
}
