import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar navBar({int noti = 0}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    centerTitle: false,
    title: Padding(
      padding: const EdgeInsets.only(left: 16),
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFFA00000), Color(0xFFEA2520), Color(0xFFFF8000)],
        ).createShader(bounds),
        child: Text(
          "TUQuest",
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white, // Ignored by ShaderMask
          ),
        ),
      ),
    ),
    actions: [
      // WIP message icon (greyed out)
      IconButton(
        onPressed: null,
        icon: const Icon(Icons.message, color: Colors.grey),
        tooltip: "Messages (coming soon)",
      ),
      // Notification icon with badge
      Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Handle notification press
            },
          ),
          if (noti > 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                constraints: const BoxConstraints(minWidth: 20, minHeight: 16),
                child: Text(
                  '$noti',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      const SizedBox(width: 12),
    ],
  );
}
