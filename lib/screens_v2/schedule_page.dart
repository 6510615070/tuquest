import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'virtual_card.dart';
import 'home/home.dart';
import 'widgets_v2/topbar.dart';
import 'widgets_v2/navbar.dart';

/// ------------------------------------------------------------------------
/// 🟧 Stateful Widget: Schedule Page
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

/// ------------------------------------------------------------------------
/// 🟨 State Class
class _SchedulePageState extends State<SchedulePage> {
  final List<String> days = ['S', 'M', 'T', 'W', 'TH', 'F', 'SA'];
  String selectedDay = 'M';

  final Map<String, List<Map<String, String>>> scheduleData = {
    'M': [
      {'start': '09:30 AM', 'end': '12:30 PM', 'code': 'CN331', 'subject': 'Software Engineer', 'room': 'วศ.316'},
      {'start': '13:30 PM', 'end': '16:30 PM', 'code': 'CN311', 'subject': 'Operating System', 'room': 'วศ.502'},
    ],
    'T': [], 'W': [], 'TH': [], 'F': [], 'SA': [], 'S': [],
  };

/// ------------------------------------------------------------------------
/// 🔵 Reusable TextField
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

/// ------------------------------------------------------------------------
/// 🟢 Add Schedule Dialog
  void _showAddDialog() {
  final start = TextEditingController();
  final end = TextEditingController();
  final code = TextEditingController();
  final subject = TextEditingController();
  final room = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: const EdgeInsets.only(left: 20, right: 4, top: 20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'เพิ่มตารางเรียน',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepOrange,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField('เวลาเริ่ม', start),
            _buildTextField('เวลาเลิก', end),
            _buildTextField('รหัสวิชา', code),
            _buildTextField('ชื่อวิชา', subject),
            _buildTextField('ห้องเรียน', room),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Discard', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF9800),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            setState(() {
              scheduleData[selectedDay]!.add({
                'start': start.text,
                'end': end.text,
                'code': code.text,
                'subject': subject.text,
                'room': room.text,
              });
            });
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

/// ------------------------------------------------------------------------
/// 🟣 Edit Schedule Dialog
  void _showEditDialog(int index) {
  final item = scheduleData[selectedDay]![index];
  final start = TextEditingController(text: item['start']);
  final end = TextEditingController(text: item['end']);
  final code = TextEditingController(text: item['code']);
  final subject = TextEditingController(text: item['subject']);
  final room = TextEditingController(text: item['room']);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: const EdgeInsets.only(left: 20, right: 4, top: 20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'แก้ไขตารางเรียน',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepOrange,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField('เวลาเริ่ม', start),
            _buildTextField('เวลาเลิก', end),
            _buildTextField('รหัสวิชา', code),
            _buildTextField('ชื่อวิชา', subject),
            _buildTextField('ห้องเรียน', room),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() => scheduleData[selectedDay]!.removeAt(index));
            Navigator.pop(context);
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF9800),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            setState(() {
              scheduleData[selectedDay]![index] = {
                'start': start.text,
                'end': end.text,
                'code': code.text,
                'subject': subject.text,
                'room': room.text,
              };
            });
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
/// ------------------------------------------------------------------------
/// 🟧 Main Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9D00),
      appBar: const CustomTopBar(),
      bottomNavigationBar: const CustomNavBar(),
      body: GestureDetector(
        onVerticalDragEnd: (d) {
          if (d.primaryVelocity! > 300) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => VirtualCardPage(onBackToTop: () => Navigator.pop(context))));
          }
        },
        onHorizontalDragEnd: (d) {
          if (d.primaryVelocity! > 300) Navigator.pop(context);
        },
        child: Container(
          color: const Color(0xFFFF9D00),
          child: Column(
            children: [
              const SizedBox(height: 50),

              // 🧾 White Box
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
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🟠 Header + Add
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Classroom Schedule", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepOrange)),
                            IconButton(
                              onPressed: _showAddDialog,
                              icon: const Icon(Icons.add_circle_outline, color: Colors.orange),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // 🔵 ปุ่มวัน Center & Symmetric
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 18,
                            children: days.map((d) {
                              final selected = selectedDay == d;
                              return GestureDetector(
                                onTap: () => setState(() => selectedDay = d),
                                child: CircleAvatar(
                                  backgroundColor: selected ? Colors.orange : Colors.grey[300],
                                  radius: 18,
                                  child: Text(d, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // 🟡 รายการตารางเรียน
                        Expanded(
                          child: ListView.builder(
                            itemCount: scheduleData[selectedDay]?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = scheduleData[selectedDay]![index];
                              return GestureDetector(
                                onTap: () => _showEditDialog(index),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF9D00),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: Text(
                                          "${item['start']} - ${item['end']}",
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.white),
                                        ),
                                      ),
                                      const VerticalDivider(color: Colors.white),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${item['code']} · ${item['subject']}", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold)),
                                            Text("📍 ${item['room']}", style: GoogleFonts.montserrat(color: Colors.white70)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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