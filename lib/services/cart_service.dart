import '../models/cart_item.dart';

class CartService {
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  static void add(CartItem item) {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index >= 0) {
      _items[index].qty++;
    } else {
      _items.add(item);
    }
  }

  static double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.total);

  // ✅ เพิ่ม method clear
  static void clear() {
    _items.clear();
  }
}
