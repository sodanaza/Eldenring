import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/food_data.dart';
import '../models/food_item.dart';
import 'food_detail_page.dart';
import 'video_page.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  double? lat;
  double? lng;

  @override
  void initState() {
    super.initState();
    _getGPS();
  }

  /// 📍 ดึงพิกัดปัจจุบัน (ไม่ใช้ Google API)
  Future<void> _getGPS() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      lat = pos.latitude;
      lng = pos.longitude;
    });
  }

  /// 🧭 เปิดแอปแผนที่นำทาง
  Future<void> _navigateToShop(FoodItem f) async {
    if (lat == null || lng == null) return;

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=$lat,$lng'
      '&destination=${f.lat},${f.lng}',
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// ================= รายการอาหาร =================
  Widget foodSection(String title, List<FoodItem> foods) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          itemCount: foods.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            final f = foods[i];
            final distance = Geolocator.distanceBetween(
                  lat!,
                  lng!,
                  f.lat,
                  f.lng,
                ) /
                1000;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: ListTile(
                leading: Image.network(
                  f.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image),
                ),
                title: Text(
                  f.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'ระยะทาง: ${distance.toStringAsFixed(2)} กม.\n'
                  'พิกัดร้าน: ${f.lat}, ${f.lng}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.info_outline, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FoodDetailPage(food: f),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.play_circle_fill, color: Colors.red),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VideoPage(
                              title: f.name,
                              videoUrl: f.videoUrl,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.navigation, color: Colors.green),
                      onPressed: () => _navigateToShop(f),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// ================= BUILD =================
  @override
  Widget build(BuildContext context) {
    if (lat == null || lng == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ร้านอาหารใกล้ฉัน'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getGPS,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 📍 พิกัดปัจจุบัน
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'พิกัดปัจจุบัน: $lat , $lng',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            /// 🗺 แผนที่ (OpenStreetMap)
            SizedBox(
              height: 220,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(lat!, lng!),
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(lat!, lng!),
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

            foodSection('🍛 อาหารคาว', savoryFoods),
            const SizedBox(height: 20),
            foodSection('🍰 อาหารหวาน', sweetFoods),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
