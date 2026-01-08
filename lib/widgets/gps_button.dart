import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GpsButton extends StatefulWidget {
  const GpsButton({super.key});

  @override
  State<GpsButton> createState() => _GpsButtonState();
}

class _GpsButtonState extends State<GpsButton> {
  double? lat;
  double? lng;

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

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.gps_fixed),
      label: const Text("ระบุพิกัด"),
      onPressed: () {
        _getGPS();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("📍 พิกัด GPS ปัจจุบัน"),
            content: lat == null
                ? const Text("กำลังดึงพิกัด...")
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Latitude: $lat"),
                      Text("Longitude: $lng"),
                    ],
                  ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("ตกลง"),
              ),
            ],
          ),
        );
      },
    );
  }
}
