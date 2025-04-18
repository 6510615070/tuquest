import 'package:flutter/material.dart';
import '../widgets_v2/topbar.dart';
import '../widgets_v2/navbar.dart';
import 'sections/home_container.dart';
import '../schedule_page.dart';
import '../virtual_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  DateTime _selectedDate = DateTime.now();

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9D00),
      appBar: const CustomTopBar(),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 1),
      body: Stack(
        children: [
          // Gesture โอบคลุมทั้งพื้นหลัง
          GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity != null && details.primaryVelocity! > 200) {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VirtualCardPage()),
                );*/
                // ตัวอย่างการเรียกใช้จากหน้า Home
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => VirtualCardPage(
      onBackToTop: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    ),
  ),
);
              }
            },
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null && details.primaryVelocity! < -300) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SchedulePage()),
                );
              }
            },
            // พื้นหลังสีส้ม
            child: Container(color: const Color(0xFFFF9D00)),
          ),

          // กล่องขาวซ้อนทับ
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 50), // <-- เพิ่ม space 
              child: HomeContainer(
                scrollController: _scrollController,
                selectedDate: _selectedDate,
                onDateSelected: _onDateSelected,
              ),
            ),
          ),
        ],
      ),
    );
  }
}