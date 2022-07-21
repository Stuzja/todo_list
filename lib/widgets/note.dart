enum Priority { low, medium, high }

class Note implements Comparable {
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

  @override
  int compareTo(other) {
    if (date.isAfter(other.date)) {
      return 1;
    } else if (date.isBefore(other.date)) {
      return -1;
    } else if (priority == Priority.low && other.priority != Priority.low ||
        priority == Priority.medium && other.priority == Priority.high) {
      return 1;
    } else if (priority == other.priority) {
      return 0;
    } else {
      return -1;
    }
  }
}
