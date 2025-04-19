import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets_v2/topbar.dart';
import 'models/post_model.dart';
import 'providers/fav_provider.dart';
import 'widgets_v2/post_card.dart';
import 'widgets_v2/navbar.dart';
import 'post_detail.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = Provider.of<FavProvider>(context).favs;

    return Scaffold(
      backgroundColor: const Color(0xFFFF9D00),
      appBar: const CustomTopBar(),
      bottomNavigationBar: const CustomNavBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                        Text(
                          "โพสต์ที่บันทึกไว้",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (favs.isEmpty)
                          Center(
                            child: Text(
                              "ยังไม่มีโพสต์ที่บันทึกไว้",
                              style: GoogleFonts.montserrat(
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        else
                          ...favs.map((post) {
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
                                const SizedBox(height: 12),
                              ],
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}