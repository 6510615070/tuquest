import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../noti.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final bool showNotificationIcon;

  const CustomTopBar({
    super.key,
    this.showBackButton = false,
    this.onBackPressed,
    this.title = "NotiTU",
    this.backgroundColor = Colors.white,
    this.textColor = const Color(0xFFA00000),
    this.showNotificationIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.05),
      surfaceTintColor: backgroundColor,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),
      ),
      //centerTitle: true,
      actions: showNotificationIcon
          ? [
              Icon(Icons.chat_bubble_outline, color: Colors.red[200]),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.notifications_none, color: textColor),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotiPage()),
                  );
                },
              ),
              const SizedBox(width: 10),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}