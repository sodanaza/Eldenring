class CartItem {
  final String id;
  final String name;
  final String image; // ✅ เพิ่มรูป
  final double price;
  int qty;

  CartItem({
    required this.id,
    required this.name,
    required this.image, // ✅
    required this.price,
    this.qty = 1,
  });

  double get total => price * qty;
}
