import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/post_model.dart';
import 'post_card.dart'; 

class ListPostSection extends StatelessWidget {
  final DateTime selectedDate;

  const ListPostSection({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = selectedDate.day == now.day &&
        selectedDate.month == now.month &&
        selectedDate.year == now.year;

    final String displayDate = isToday
        ? 'วันนี้'
        : DateFormat('d MMM', 'th_TH').format(selectedDate);

    // ✅ Mock post list ที่ใช้ Post Model
    final List<Post> allMockPosts = [
      Post(
        id: '1',
        topic: 'กิจกรรมเช้านี้',
        detail: 'รายละเอียดกิจกรรมเช้านี้...',
        imageUrl: '',
        createdAt: DateTime.now(),
      ),
      Post(
        id: '2',
        topic: 'สอบควิซ OS',
        detail: 'เตรียมตัวสอบควิซ OS...',
        imageUrl: '',
        createdAt: DateTime.now(),
      ),
      Post(
        id: '3',
        topic: 'เวิร์กช็อป AI Ethics',
        detail: 'เรียนรู้จริยธรรมใน AI...',
        imageUrl: '',
        createdAt: DateTime(2025, 4, 23),
      ),
    ];

    // ✅ กรองเฉพาะโพสต์ของวันที่เลือก
    final filteredPosts = allMockPosts.where((post) {
      return post.createdAt.year == selectedDate.year &&
          post.createdAt.month == selectedDate.month &&
          post.createdAt.day == selectedDate.day;
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // วันที่ + Search bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Text(
                  displayDate,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.tune, color: Colors.orange[800]),
              ],
            ),
          ),

          // ✅ Post list
          if (filteredPosts.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'ไม่มีกิจกรรมในวันนี้',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            )
          else
            ...filteredPosts.map((post) => PostCard(post: post)),
        ],
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../post_detail.dart';

class ListPostSection extends StatelessWidget {
  final DateTime selectedDate;

  const ListPostSection({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = selectedDate.day == now.day &&
        selectedDate.month == now.month &&
        selectedDate.year == now.year;

    // ✅ Mock event list
    final Map<String, List<String>> mockPosts = {
      DateFormat('yyyy-MM-dd').format(DateTime.now()): ['กิจกรรมเช้านี้', 'สอบควิซ OS'],
      '2025-04-23': ['เวิร์กช็อป AI Ethics'],
    };

    final String dateKey = DateFormat('yyyy-MM-dd').format(selectedDate);
    final List<String> posts = mockPosts[dateKey] ?? [];

    final String displayDate = isToday
        ? 'วันนี้'
        : DateFormat('d MMM', 'th_TH').format(selectedDate); // ✅ แสดง 23 เม.ย.

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // วันที่ + Search bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Text(
                  displayDate,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.tune, color: Colors.orange[800]),
              ],
            ),
          ),

          // Post list
          if (posts.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'ไม่มีกิจกรรมในวันนี้',
                style: GoogleFonts.montserrat(
                    fontSize: 14, color: Colors.grey[600]),
              ),
            )
          else
            ...posts.map(
              (postTitle) => PostItem(
                topic: postTitle,
                date: displayDate,
              ),
            ),
        ],
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final String topic;
  final String date;

  const PostItem({super.key, required this.topic, required this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostDetailPage(
            title: topic,
            description: "รายละเอียดโพสต์: $topic",
            imageUrl: "",
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(date,
                      style:
                          TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
    );
  }
}*/