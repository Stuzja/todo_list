class Note {
  final int id;
  String title;
  String text;
  bool completed;
  DateTime date;

  Note({
    required this.id,
    required this.title,
    required this.text,
    required this.completed,
    required this.date,
  });
}
