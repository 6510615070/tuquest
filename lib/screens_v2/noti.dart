// noti.dart
import 'package:flutter/material.dart';

class NotiPage extends StatelessWidget {
  const NotiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Color(0xFFFF9D00),
      ),
      body: Center(
        child: Text("ยังไม่มีการแจ้งเตือน"),
      ),
    );
  }
}
