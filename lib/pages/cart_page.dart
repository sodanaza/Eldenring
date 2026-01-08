import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  Future<void> _checkout(BuildContext context) async {
    await FirebaseFirestore.instance.collection('orders').add({
      'total': CartService.totalPrice,
      'items': CartService.items.map((e) => {
        'name': e.name,
        'price': e.price,
        'qty': e.qty,
        'image': e.image,
      }).toList(),
      'createdAt': Timestamp.now(),
    });

    CartService.clear(); // ✅ ตอนนี้ไม่ error แล้ว

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('สั่งซื้อเรียบร้อยแล้ว')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final items = CartService.items;

    return Scaffold(
      appBar: AppBar(title: const Text('🧾 ตะกร้าสินค้า')),
      body: items.isEmpty
          ? const Center(child: Text('ยังไม่มีสินค้าในตะกร้า'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final item = items[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.image, // ✅ ใช้ได้แล้ว
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(item.name),
                          subtitle: Text(
                              'จำนวน ${item.qty} × ${item.price} บาท'),
                          trailing: Text(
                            '${item.total} บาท',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        'รวมทั้งหมด: ${CartService.totalPrice} บาท',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => _checkout(context),
                        child: const Text('ยืนยันสั่งซื้อ'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
