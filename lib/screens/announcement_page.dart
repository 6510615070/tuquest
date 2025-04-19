import 'package:flutter/material.dart';
import 'package:tuquest/widgets/announcement_box.dart';

class AnnouncementDetailPage extends StatelessWidget {
  final String title;
  final String message;
  final String? imagePath;

  const AnnouncementDetailPage({
    Key? key,
    required this.title,
    required this.message,
    this.imagePath,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Announcement Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imagePath != null && imagePath!.isNotEmpty
                ? Image.network(imagePath!) 
                : Container(
                    width: double.infinity,
                    height: 200, 
                    color: Colors.grey.shade200, 
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported, 
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
