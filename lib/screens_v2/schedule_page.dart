import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9D00),
        title: const Text('Classroom Schedule'),
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              children: const [
                _DayBadge('S', Colors.red),
                _DayBadge('M', Colors.deepOrange),
                _DayBadge('T', Colors.yellow),
                _DayBadge('W', Colors.green),
                _DayBadge('TH', Colors.orange),
                _DayBadge('F', Colors.cyan),
                _DayBadge('SA', Colors.purple),
              ],
            ),
            const SizedBox(height: 24),
            const _ScheduleTile(time: '09:30 AM - 12:30 PM', subject: 'CN331 · Software Engineer', room: 'วศ.316'),
            const _ScheduleTile(time: '13:30 PM - 16:30 PM', subject: 'CN311 · OS', room: 'วศ.502'),
          ],
        ),
      ),
    );
  }
}

class _DayBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _DayBadge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: color,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}

class _ScheduleTile extends StatelessWidget {
  final String time;
  final String subject;
  final String room;

  const _ScheduleTile({
    required this.time,
    required this.subject,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9D00),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            alignment: Alignment.center,
            child: Text(time,
                style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
          const VerticalDivider(color: Colors.white, thickness: 1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.white)),
                Text('📍 $room', style: GoogleFonts.montserrat(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}