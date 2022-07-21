enum Priority { low, medium, high }

class Note {
  final int id;
  String title;
  String text;
  bool completed;
  DateTime date;
  Priority priority;
  Note({
    required this.id,
    required this.title,
    required this.text,
    required this.completed,
    required this.date,
    required this.priority,
  });
}
