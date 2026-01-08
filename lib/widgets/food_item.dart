import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../pages/food_detail_page.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItem food;

  const FoodItemCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          food.image,
          width: 100,
          height: 80,
          fit: BoxFit.cover,
        ),
        Text(
          food.name,
          style: const TextStyle(fontSize: 12),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FoodDetailPage(food: food),
              ),
            );
          },
          child: const Text("ดู"),
        ),
      ],
    );
  }
}
