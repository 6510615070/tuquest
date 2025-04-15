// virtual_card.dart
import 'package:flutter/material.dart';

class VirtualCardWidget extends StatelessWidget {
  const VirtualCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300], // คุณจะเปลี่ยนเป็นรูปภาพจริงก็ได้
      ),
      child: Center(
        child: Text(
          "Virtual Student Card",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
