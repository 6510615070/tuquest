import 'package:flutter/material.dart';

/*class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xFFFF9D00),
      ),
      body: Center(
        child: Text("no detail"),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account.dart'; 
import 'widgets_v2/topbar.dart'; 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data ที่จะถูกแทนด้วย API จริงในอนาคต
    final studentData = {
      'name': 'สมศักดิ์ สมชาย',
      'studentId': '6510615999',
      'faculty': 'วิศวกรรมศาสตร์',
      'email': 'somsakss@gmail.com',
      'gpax': '2.94',
      'credit': '102',
      'imageUrl':
          'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', // รูป Mock
    };

    return Scaffold(
      backgroundColor: const Color(0xFFFF9800),
      appBar: const CustomTopBar(), // Topbar ด้านบน
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          child: Column(
            children: [
              // ปุ่ม Back
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.red, size: 28),
                    onPressed: () => Navigator.pop(context),
                    /*onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const AccountPage()),
                      );
                    },*/
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Back',
                    style: GoogleFonts.montserrat(
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // รูปโปรไฟล์
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(studentData['imageUrl']!),
              ),
              const SizedBox(height: 24),

              // ข้อมูลนักศึกษา
              _buildLabel('ชื่อ - นามสกุล'),
              _buildField(studentData['name']!),
              const SizedBox(height: 16),

              _buildLabel('รหัสนักศึกษา'),
              _buildField(studentData['studentId']!),
              const SizedBox(height: 16),

              _buildLabel('คณะ'),
              _buildField(studentData['faculty']!),
              const SizedBox(height: 16),

              _buildLabel('Email'),
              _buildField(studentData['email']!),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('GPAX'),
                        _buildField(studentData['gpax']!),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Credit'),
                        _buildField(studentData['credit']!),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.montserrat(
        color: Colors.brown[900],
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget _buildField(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFA00000),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
