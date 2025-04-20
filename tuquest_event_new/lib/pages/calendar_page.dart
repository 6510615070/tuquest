import 'package:flutter/material.dart';
import 'package:tuquest_event_new/pages/add_edit_event_page.dart';
import '../models/event_model.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/event_list_widget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  final Map<DateTime, List<String>> _events = {};

  // Get events for the current month
  List<EventModel> _getEventsForMonth(DateTime month) {
    return _events.entries
        .where((entry) =>
            entry.key.year == month.year && entry.key.month == month.month)
        .expand((entry) =>
            entry.value.map((event) => EventModel(date: entry.key, title: event, description: '', id: '', start: month, end: month, createdBy: '')))
        .toList();
  }

  // Add new event
  void _addEvent(DateTime date, String title) {
    setState(() {
      _events.putIfAbsent(date, () => []).add(title);
    });
  }

  // Delete an event
  void _deleteEvent(DateTime date, String title) {
    setState(() {
      _events[date]?.remove(title);
      if (_events[date]?.isEmpty ?? false) {
        _events.remove(date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final events = _getEventsForMonth(_focusedDay);

    return Scaffold(
      appBar: AppBar(title: const Text('Event Calendar')),
      body: Column(
        children: [
          CalendarWidget(
            focusedDay: _focusedDay,
            events: _events,
            onMonthChanged: (day) => setState(() => _focusedDay = day),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _showAddEventDialog(context),
            child: const Text('Add Event'),
          ),
          const SizedBox(height: 10),
          EventListWidget(events: events, onDelete: _deleteEvent),
        ],
      ),
    );
  }

  // Add Event Dialog
  void _showAddEventDialog(BuildContext context) {
    ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditEventPage(
          onSave: ({required title, required description, required start, required end, required imagePath}) {
            // TODO: บันทึกไป Firestore หรือ local _events
          },
        ),
      ),
    );
  },
  child: const Text('Add Event'),
);

  }
}
