import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../post_detail.dart';

class AnnounceCard extends StatefulWidget {
  const AnnounceCard({super.key});

  @override
  State<AnnounceCard> createState() => _AnnounceCardState();
}

class _AnnounceCardState extends State<AnnounceCard> {
  List<Map<String, String>> announcements = [
    {
      "topic": "กิจกรรมรับน้อง TU",
      "description": "มาร่วมสนุกกับกิจกรรมรับน้องประจำปี 2025...",
      "picture": "assets/questboard.png"
    },
    {
      "topic": "แจ้งเตือนชำระเงินค่าหน่วยกิต",
      "description": "กรุณาชำระเงินก่อนวันที่ 30 มีนาคม...",
      "picture": "assets/google_logo.png"
    }
  ];
  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      setState(() {
        currentIndex = (currentIndex + 1) % announcements.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var current = announcements[currentIndex];
    return Container(
      margin: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // ส่วนรูปภาพ
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(current["picture"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient Overlay
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Indicator dots
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      announcements.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index 
                              ? Colors.white 
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ส่วนข้อความ
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  current["topic"]!,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  current["description"]!,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9D00),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "อ่านเพิ่มเติม",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}