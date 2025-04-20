import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'widgets_v2/topbar.dart';
import 'widgets_v2/navbar.dart';
import 'widgets_v2/post_card.dart';
import 'models/post_model.dart';
import 'post_detail.dart';
import 'virtual_card.dart';

class NotiPage extends StatelessWidget {
  const NotiPage({super.key});

  List<Post> _getMockNotifications() {
    return [
      Post(
        id: 'noti_1',
        topic: 'กิจกรรมรับDoraemon',
        detail: 'มีการเปลี่ยนแปลงเวลากิจกรรมรับน้องเป็น 10:00 น. โปรดตรวจสอบ',
        imageUrl: 'https://www.ilovejapantours.com/images/easyblog_articles/6/doraemon-gadget-cat-from-the-future-wallpaper-4.jpg',
        isNetworkImage: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Post(
        id: 'noti_2',
        topic: 'แจ้งเตือนeiei',
        detail: 'ค่าหน่วยกิตภาคเรียนที่ 2/2566 ครบกำหนดชำระวันที่ 30 มิ.ย.',
        imageUrl: 'https://www.mangozero.com/wp-content/uploads/2016/11/conan-high-tech-gadget.jpg',
        isNetworkImage: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Post(
        id: 'noti_3',
        topic: 'ประกาศผลสอบกลางภาค',
        detail: 'ผลสอบวิชา Mobile App Development ออกแล้ว',
        imageUrl: 'assets/google_logo.png',
        isNetworkImage: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mockNotifications = _getMockNotifications();

    return Scaffold(
      backgroundColor: const Color(0xFFFF9D00),
      appBar: const CustomTopBar(),
      bottomNavigationBar: const CustomNavBar(),
      body: GestureDetector(
        onVerticalDragEnd: (d) {
          if (d.primaryVelocity! > 300) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VirtualCardPage(
                  onBackToTop: () => Navigator.pop(context),
                ),
              ),
            );
          }
        },
        child: Container(
          color: const Color(0xFFFF9D00),
          child: Column(
            children: [
              const SizedBox(height: 50),
              // White Container
              Expanded(
                child: Container(
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
                  child: Column(
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "การแจ้งเตือน",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF8000),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.search, color: Color(0xFFFF8000)),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      
                      // Notification List
                      Expanded(
                        child: mockNotifications.isEmpty
                            ? Center(
                                child: Text(
                                  'ไม่มีการแจ้งเตือน',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                itemCount: mockNotifications.length,
                                itemBuilder: (context, index) {
                                  final post = mockNotifications[index];
                                  return Column(
                                    children: [
                                      PostCard(
                                        post: post,
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => PostDetailPage.fromPost(post: post),
                                          ),
                                        ),
                                      ),
                                      if (index != mockNotifications.length - 1)
                                        const SizedBox(height: 12),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}