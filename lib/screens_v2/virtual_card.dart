import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'widgets_v2/topbar.dart';

class VirtualCardPage extends StatelessWidget {
  final VoidCallback onBackToTop;

  const VirtualCardPage({super.key, required this.onBackToTop});

  // Mock student data
  final String studentId = "6510615999";
  final String studentName = "สมศักดิ์ สมชาย";
  final String faculty = "วิศวกรรมศาสตร์";
  final String profileImageUrl = "https://i.pravatar.cc/300?img=8";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9D00),
      appBar: const CustomTopBar(),
      body: Column(
        children: [
          // 🧾 Card แสดงข้อมูล
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 58),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 48),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF000000), Color(0xFFFF0004)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Column(
                      children: [
                        // โลโก้ธรรมศาสตร์
                        Image.asset(
                          'assets/thammasat_logo.png',
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),

                        // QR Code ฝังรูปตรงกลาง
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              QrImageView(
                                data: studentId, // ใช้รหัสนักศึกษาเป็นข้อมูลใน QR Code
                                version: QrVersions.auto,
                                size: 200,
                                backgroundColor: Colors.white,
                                eyeStyle: const QrEyeStyle(
                                  eyeShape: QrEyeShape.square,
                                  color: Colors.black,
                                ),
                                dataModuleStyle: const QrDataModuleStyle(
                                  dataModuleShape: QrDataModuleShape.square,
                                  color: Colors.black,
                                ),
                              ),
                              // วงกลมโปรไฟล์
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(profileImageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Barcode ที่สามารถสแกนได้จริง
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: BarcodeWidget(
                            barcode: Barcode.code128(), // ใช้ Barcode ที่สแกนได้จริง
                            data: studentId, // ใช้รหัสนักศึกษาเป็นข้อมูลใน Barcode
                            width: 200,
                            height: 60,
                            drawText: false,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 👨🏻‍🎓 ข้อมูลนักศึกษา
                        Text(
                          "Student ID: $studentId",
                          style: GoogleFonts.montserrat(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          studentName,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "นักศึกษาคณะ$faculty",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ⬆️ ปุ่ม "กลับไปหน้าแรก"
          Container(
            padding: const EdgeInsets.only(top: 4, bottom: 12),
            width: double.infinity,
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
              onTap: onBackToTop,
              child: Column(
                children: const [
                  Icon(Icons.keyboard_arrow_up_rounded,
                      color: Colors.grey, size: 36),
                  SizedBox(height: 4),
                  Text(
                    "กดเพื่อกลับไปหน้าแรก",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}