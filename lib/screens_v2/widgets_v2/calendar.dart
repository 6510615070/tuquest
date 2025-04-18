import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSection extends StatefulWidget {
  final Function(DateTime selectedDay)? onDateSelected;

  const CalendarSection({super.key, this.onDateSelected});

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mock event list
  final List<DateTime> _eventDays = [
    DateTime.utc(2025, 2, 2),
    DateTime.utc(2025, 2, 21),
    DateTime.utc(2025, 2, 26),
  ];

  // สำหรับให้ TableCalendar สร้าง marker
  List<dynamic> _getEventsForDay(DateTime day) {
    return _eventDays.where((d) => isSameDay(d, day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    _selectedDay ??= today;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // หัวข้อด้านบน
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
          child: Text(
            'ปฏิทินกิจกรรม',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFA00000),
            ),
          ),
        ),

        // กล่องปฏิทิน
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFF9D00),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              // Header (เดือน)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime(
                            _focusedDay.year,
                            _focusedDay.month - 1,
                            1,
                          );
                        });
                      },
                    ),
                    Text(
                      '${_monthName(_focusedDay.month)} ${_focusedDay.year}',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime(
                            _focusedDay.year,
                            _focusedDay.month + 1,
                            1,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),

              // ปฏิทิน
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });

                  if (widget.onDateSelected != null) {
                    widget.onDateSelected!(selectedDay);
                  }
                },
                calendarFormat: CalendarFormat.month,
                headerVisible: false,
                eventLoader: _getEventsForDay,
                daysOfWeekHeight: 36,
                rowHeight: 42,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  todayDecoration: const BoxDecoration(
                    color: Color(0xFFA00000),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFFFF9D00),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFA00000), width: 2),
                  ),
                  selectedTextStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA00000),
                    fontWeight: FontWeight.w700,
                  ),
                  defaultTextStyle: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  todayTextStyle: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  weekendTextStyle: GoogleFonts.montserrat(
                    color: Color(0xFFA00000),
                    fontWeight: FontWeight.w700,
                  ),
                  markerDecoration: const BoxDecoration(
                    color: Color(0xFFA00000),
                    shape: BoxShape.circle,
                  ),
                  markersAlignment: Alignment.bottomCenter,
                  markersMaxCount: 1,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  weekendStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA00000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ชื่อเดือนภาษาไทย
  String _monthName(int month) {
    const monthNames = [
      '',
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฎาคม',
      'สิงหาคม',
      'กันยายน',
      'ตุลาคม',
      'พฤศจิกายน',
      'ธันวาคม',
    ];
    return monthNames[month];
  }
}