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
      body: Column(
        children: [
          const CustomTopBar(
            showBackButton: true,
            backgroundColor: Color(0xFFFF9D00),
            textColor: Colors.white,
            showNotificationIcon: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  
                  // Card Container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF5C0000), Color(0xFFFF0000)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/thammasat_logo.png',
                          width: 220,
                        ),
                        const SizedBox(height: 16),

                        // QR Code Section
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            QrImageView(
                              data: studentId,
                              version: QrVersions.auto,
                              size: 220,
                              backgroundColor: Colors.white,
                              eyeStyle: const QrEyeStyle(
                                eyeShape: QrEyeShape.circle,
                                color: Colors.black,
                              ),
                              dataModuleStyle: const QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.circle,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                image: DecorationImage(
                                  image: NetworkImage(profileImageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Barcode Section
                        BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: studentId,
                          width: 200,
                          height: 70,
                          drawText: false,
                          backgroundColor: Colors.white,
                        ),

                        const SizedBox(height: 12),

                        // Student Info Section
                        Text(
                          "Student ID: $studentId",
                          style: GoogleFonts.montserrat(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          studentName,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "คณะ$faculty",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Back to Home Button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: GestureDetector(
              onTap: onBackToTop,
              child: Column(
                children: const [
                  Icon(Icons.keyboard_arrow_up_rounded, 
                      color: Colors.grey, size: 32),
                  Text("กดเพื่อกลับไปหน้าแรก", 
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}