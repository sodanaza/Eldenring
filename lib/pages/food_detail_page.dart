import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/food_item.dart';
import '../models/cart_item.dart';
import '../services/cart_service.dart';

class FoodDetailPage extends StatefulWidget {
  final FoodItem food;

  const FoodDetailPage({super.key, required this.food});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  late YoutubePlayerController _controller;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.food.videoUrl) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied)
      return;

    final pos = await Geolocator.getCurrentPosition();
    setState(() => _currentPosition = pos);
  }

  Future<void> _navigate() async {
    final f = widget.food;
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${f.lat},${f.lng}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _addToCart() {
    CartService.add(
      CartItem(
        id: widget.food.name,
        name: widget.food.name,
        image: widget.food.image,
        price: widget.food.price,
      ),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('เพิ่มสินค้าเข้าตะกร้าแล้ว')));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;

    return Scaffold(
      appBar: AppBar(title: Text(food.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ▶ วิดีโอ
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),

            /// 🖼 รูปอาหาร
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  food.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// 💰 ราคา
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'ราคา ${food.price.toStringAsFixed(0)} บาท',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

            /// 🛒 ปุ่มเพิ่มเข้า Cart
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    textStyle: const TextStyle(fontSize: 12),
                    minimumSize: const Size(0, 0),
                  ),
                  icon: const Icon(Icons.add_shopping_cart, size: 16),
                  label: const Text('เพิ่มลงในตะกร้า'),
                  onPressed: _addToCart,
                ),
              ),
            ),

         

            /// 📋 ส่วนประกอบ
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'ส่วนประกอบ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: food.ingredients.map((e) => Text('• $e')).toList(),
              ),
            ),

            /// 👩‍🍳 วิธีทำ
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'วิธีการทำ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: food.steps
                    .asMap()
                    .entries
                    .map((e) => Text('${e.key + 1}. ${e.value}'))
                    .toList(),
              ),
            ),

            const Divider(),

            /// 📍 พิกัด
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('พิกัดร้าน: ${food.lat}, ${food.lng}'),
                  const SizedBox(height: 4),
                  Text(
                    _currentPosition == null
                        ? 'พิกัดปัจจุบัน: กำลังค้นหา...'
                        : 'พิกัดปัจจุบัน: '
                              '${_currentPosition!.latitude}, '
                              '${_currentPosition!.longitude}',
                  ),
                ],
              ),
            ),

            /// 🧭 ปุ่มนำทาง
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.navigation),
                  label: const Text('นำทางไปยังร้าน'),
                  onPressed: _navigate,
                ),
              ),
            ),

            /// 🗺 แผนที่ (ล่างสุด)
            SizedBox(
              height: 250,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(food.lat, food.lng),
                  initialZoom: 16,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(food.lat, food.lng),
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                      if (_currentPosition != null)
                        Marker(
                          point: LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          ),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.person_pin_circle,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
