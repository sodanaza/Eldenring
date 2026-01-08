class FoodItem {
  final String name;
  final String image;
  final String videoUrl;
  final List<String> ingredients;
  final List<String> steps;

  final double lat;
  final double lng;
  final double price; // ✅ ราคาอาหาร

  FoodItem({
    required this.name,
    required this.image,
    required this.videoUrl,
    required this.ingredients,
    required this.steps,
    required this.lat,
    required this.lng,
    required this.price, // ✅ ต้องมี
  });
}
