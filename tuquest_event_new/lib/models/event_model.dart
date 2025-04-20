class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final String? imageUrl;
  final String createdBy;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.start,
    required this.end,
    this.imageUrl,
    required this.createdBy, required DateTime date,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'start': start.toIso8601String(),
    'end': end.toIso8601String(),
    'imageUrl': imageUrl,
    'createdBy': createdBy,
  };

  factory EventModel.fromMap(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      start: DateTime.parse(data['start']),
      end: DateTime.parse(data['end']),
      imageUrl: data['imageUrl'],
      createdBy: data['createdBy'],
    );
  }
}
