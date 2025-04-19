import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'widgets_v2/topbar.dart';
import 'providers/fav_provider.dart';
import 'models/post_model.dart';
import 'widgets_v2/navbar.dart';

class PostDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final bool isNetworkImage; // ใช้ตรวจสอบว่าเป็นรูปจาก network หรือไม่
  final DateTime? createdAt;
  final String? id;

  const PostDetailPage({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.isNetworkImage = true, // ค่า default เป็น true สำหรับ API ใหม่
    this.createdAt,
    this.id,
  });

  // Constructor สำหรับรับ Post object
  factory PostDetailPage.fromPost({
    Key? key,
    required Post post,
  }) {
    return PostDetailPage(
      key: key,
      title: post.topic,
      description: post.detail,
      imageUrl: post.imageUrl,
      isNetworkImage: post.isNetworkImage ?? true, // ใช้ค่าจาก Post object
      createdAt: post.createdAt,
      id: post.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavProvider>(context);
    final post = _toPost();

    return Scaffold(
      backgroundColor: const Color(0xFFFF9D00),
      appBar: const CustomTopBar(),
      bottomNavigationBar: const CustomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "รายละเอียดโพสต์",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          favProvider.isFavorite(post)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favProvider.isFavorite(post)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          if (favProvider.isFavorite(post)) {
                            favProvider.remove(post);
                          } else {
                            favProvider.add(post);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // ส่วนแสดงรูปภาพ (รองรับทั้ง Asset และ Network)
                  if (imageUrl?.isNotEmpty ?? false)
                    _buildImageWidget(),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (createdAt != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      "วันที่: ${DateFormat('d MMM yyyy', 'th_TH').format(createdAt!)}",
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับแสดงรูปภาพ
  Widget _buildImageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: isNetworkImage
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, size: 50),
              ),
            )
          : Image.asset(
              imageUrl!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, size: 50),
              ),
            ),
    );
  }

  // สร้าง Post object จากข้อมูลที่มี
  Post _toPost() {
    return Post(
      id: id ?? DateTime.now().toString(),
      topic: title,
      detail: description,
      imageUrl: imageUrl ?? '',
      isNetworkImage: isNetworkImage,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}