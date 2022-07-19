import 'note.dart';

List<Note> ListNotes = [
  Note(
    title: "First",
    text: "lol",
    completed: false,
    id: 0,
    date: DateTime.now(),
    deleteFunc: (int id) {},
    editFunc: (int id, String title, String text, DateTime date) {},
  )
];
