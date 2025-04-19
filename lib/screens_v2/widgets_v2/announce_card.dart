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
      "picture": "assets/questboard.png",
      "detail": "รายละเอียดเต็มของกิจกรรมรับน้อง TU:\n\n- วันที่: 15-20 มิถุนายน 2025\n- สถานที่: ลานกิจกรรมมหาวิทยาลัย\n- ต้องนำบัตรนักศึกษาแสดง\n- แต่งกายชุดนักศึกษา"
    },
    {
      "topic": "แจ้งเตือนชำระเงินค่าหน่วยกิต",
      "description": "กรุณาชำระเงินก่อนวันที่ 30 มีนาคม...",
      "picture": "assets/google_logo.png",
      "detail": "รายละเอียดการชำระเงินค่าหน่วยกิต:\n\n- ชำระผ่านระบบ TU Wallet\n- หรือชำระที่ตึกบริหาร\n- หลังวันที่ 30 มีนาคม จะมีค่าปรับ 10%\n- สอบถามเพิ่มเติมที่งานทะเบียน"
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

  void _navigateToDetail(BuildContext context) {
    final current = announcements[currentIndex];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostDetailPage(
          title: current["topic"]!,
          description: current["detail"]!,
          imageUrl: current["picture"],
          isNetworkImage: false,
          id: "announce_${currentIndex}", // กำหนด id เฉพาะสำหรับ announce
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var current = announcements[currentIndex];
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        margin: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // ส่วนรูปภาพ
            if (current["picture"]?.isNotEmpty ?? false)
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}