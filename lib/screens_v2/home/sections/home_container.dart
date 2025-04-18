import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets_v2/announce_card.dart';
import '../../widgets_v2/calendar.dart';
import '../../widgets_v2/listpost.dart';
import '../../schedule_page.dart';

class HomeContainer extends StatelessWidget {
  final ScrollController scrollController;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const HomeContainer({
    super.key,
    required this.scrollController,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! < -300) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SchedulePage()),
            );
          }
        },
        child: ListView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: AnnounceCard(),
            ),
            const SizedBox(height: 16),
            CalendarSection(onDateSelected: onDateSelected),
            const SizedBox(height: 16),
            ListPostSection(selectedDate: selectedDate),
            const SizedBox(height: 100), // เผื่อ space ด้านล่าง
          ],
        ),
      ),
    );
  }
}
