import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPage extends StatelessWidget {
  final String title;
  final String videoUrl;

  const VideoPage({
    super.key,
    required this.title,
    required this.videoUrl,
  });

  Future<void> _openYoutube() async {
    final uri = Uri.parse(videoUrl);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'ไม่สามารถเปิดวิดีโอได้';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.play_circle_fill),
          label: const Text("เปิดวิดีโอ YouTube"),
          onPressed: _openYoutube,
        ),
      ),
    );
  }
}
