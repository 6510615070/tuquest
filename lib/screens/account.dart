import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'contact.dart';
import 'package:tuquest/auth.dart';
import 'package:tuquest/screens/login.dart';
import 'package:tuquest/widgets/pfp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _profileImage;
  final picker = ImagePicker();
  bool isEnglish = true;
  bool notificationsEnabled = true;
final user = FirebaseAuth.instance.currentUser;
  Future<void> _pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0xFFA00000),
                      Color(0xFFEA2520),
                      Color(0xFFFF8000),
                    ],
                    stops: [0.01, 0.52, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF000000), Color(0xFFFF0004)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ProfileImage(radius: 50),
                    GestureDetector(
                      onTap: _pickProfileImage,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.orange,
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  user?.displayName ?? "Guest",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              _buildLanguageToggle(),
              _buildNotificationToggle(),
              _buildMenuItem(Icons.mail, "Contact us", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(),
                  ),
                );
              }),

              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await TQauth.logout();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Logged out successfully!")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout", style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _buildLanguageToggle() {
    return ListTile(
      leading: const Icon(Icons.language, color: Colors.orange),
      title: const Text("Language", style: TextStyle(color: Colors.white)),
      trailing: ToggleButtons(
        isSelected: [!isEnglish, isEnglish],
        onPressed: (index) {
          setState(() {
            isEnglish = index == 1;
          });
        },
        borderRadius: BorderRadius.circular(20),
        selectedColor: Colors.black,
        fillColor: Colors.orange,
        color: Colors.white,
        children: const [Text("TH"), Text("EN")],
        constraints: const BoxConstraints(minWidth: 50, minHeight: 30),
      ),
    );
  }

  Widget _buildNotificationToggle() {
    return SwitchListTile(
      secondary: const Icon(Icons.notifications, color: Colors.orange),
      title: const Text("Notifications", style: TextStyle(color: Colors.white)),
      value: notificationsEnabled,
      onChanged: (value) {
        setState(() {
          notificationsEnabled = value;
        });
      },
      activeColor: Colors.orange,
    );
  }
}
