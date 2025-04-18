import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'profile.dart';
import 'contact.dart';
import 'login.dart';
import 'widgets_v2/topbar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isNotificationOn = true;
  String selectedLang = 'TH';
  String? _profileImageUrl =
      'https://i.pinimg.com/564x/5e/b5/5e/5eb55ec2482b119c9bb8a207d255b07e.jpg'; // mock API

  void _changeLanguage(String lang) {
    setState(() {
      selectedLang = lang;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (pickedImage != null) {
      setState(() {
        _profileImageUrl = pickedImage.path; // Local file path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9800),
      body: Column(
        children: [
          const CustomTopBar(),

          // Back + Help row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      const Icon(Icons.chevron_left, color: Colors.brown, size: 28),
                      Text(
                        "Back",
                        style: GoogleFonts.montserrat(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.help_outline, color: Colors.brown), // can't tap
              ],
            ),
          ),

          // Profile image
          const SizedBox(height: 4),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: _profileImageUrl != null &&
                          !_profileImageUrl!.startsWith('http')
                      ? Image.file(File(_profileImageUrl!)).image
                      : NetworkImage(_profileImageUrl!),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.edit, size: 20, color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Name
          Text(
            'สมศักดิ์ สมชาย',
            style: GoogleFonts.montserrat(
              color: Colors.red[800],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),
          const Text(
            'Student ID: 6510615999',
            style: TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 20),

          // White box container
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  _buildTile(
                    icon: Icons.person,
                    title: "Profile",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    ),
                  ),
                  _buildLanguageToggle(),
                  _buildNotificationToggle(),
                  _buildTile(
                    icon: Icons.mail,
                    title: "Contact us",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ContactPage()),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9800),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16)),
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

  Widget _buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
      onTap: onTap,
    );
  }

  Widget _buildLanguageToggle() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(Icons.language, color: Colors.white),
      ),
      title: const Text(
        "Language",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: ["TH", "EN"].map((lang) => _langToggle(lang)).toList(),
      ),
    );
  }

  Widget _langToggle(String lang) {
    final isSelected = lang == selectedLang;
    return GestureDetector(
      onTap: () => _changeLanguage(lang),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          lang,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildNotificationToggle() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(Icons.notifications, color: Colors.white),
      ),
      title: const Text(
        "Notifications",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
      trailing: Switch(
        value: isNotificationOn,
        onChanged: (value) => setState(() => isNotificationOn = value),
      ),
    );
  }
}
/*class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String studentName = "สมศักดิ์ สมชาย"; // mock API
    final String studentID = "6510615999"; // mock API

    return Scaffold(
      backgroundColor: const Color(0xFFFF9800),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9800),
        elevation: 0,
        leading: Row(
          children: [
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF870000)),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              "Back",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF870000),
              ),
            ),
          ],
        ),
        leadingWidth: 100,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.help_outline, color: Colors.brown),
          )
        ],
      ),
      body: Column(
        children: [
          // ---------------- Profile Image ----------------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      'https://youruniversity.api/photo.jpg', // mock url
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.edit, size: 16, color: Colors.red),
                      onPressed: () {
                        // TODO: เชื่อมหน้าเลือกรูปจากเครื่อง
                      },
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ---------------- Student Name + ID ----------------
          Text(
            studentName,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Student ID: $studentID",
            style: const TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 20),

          // ---------------- White Box ----------------
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.person,
                    text: "Profile",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.language,
                    text: "Language",
                    trailing: _buildToggleButtons(["TH", "EN"], selected: "TH"),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.notifications,
                    text: "Notifications",
                    trailing: _buildToggleButtons(["OFF", "ON"], selected: "ON"),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.mail,
                    text: "Contact us",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ContactPage()),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9800),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16)),
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

  // --------------- Tile Generator ----------------
  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFFF9800),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        text,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF870000),
        ),
      ),
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF870000)),
      onTap: onTap,
    );
  }

  // --------------- Toggle Style ----------------
  Widget _buildToggleButtons(List<String> labels, {required String selected}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: labels.map((label) {
        final bool isSelected = label == selected;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF9800) : Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }
}
*/