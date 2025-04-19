import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'widgets_v2/topbar.dart';
import 'providers/fav_provider.dart';
import 'models/post_model.dart';
import 'widgets_v2/navbar.dart';
import 'virtual_card.dart';

class PostDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final bool isNetworkImage;
  final DateTime? createdAt;
  final String? id;

  const PostDetailPage({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.isNetworkImage = true,
    this.createdAt,
    this.id,
  });

  factory PostDetailPage.fromPost({
    Key? key,
    required Post post,
  }) {
    return PostDetailPage(
      key: key,
      title: post.topic,
      description: post.detail,
      imageUrl: post.imageUrl,
      isNetworkImage: post.isNetworkImage ?? true,
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
      body: GestureDetector(
        onVerticalDragEnd: (d) {
          if (d.primaryVelocity! > 200) {
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
                      // Scrollable Content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header with Favorite button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "รายละเอียดโพสต์",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFF8000),
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
                              
                              // Image section
                              if (imageUrl?.isNotEmpty ?? false)
                                _buildImageWidget(),
                              const SizedBox(height: 16),
                              
                              // Title
                              Text(
                                title,
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              // Date
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
                              
                              // Description
                              Text(
                                description,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Back Button at bottom
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          top: 10,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF8000),
                              foregroundColor: Color(0xFFFF8000),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                            ),
                            child: Text(
                              'ย้อนกลับ',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
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