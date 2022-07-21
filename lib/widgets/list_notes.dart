import 'note.dart';

int count = 0;

List<Note> listWaiting = [
  Note(
      id: 0,
      title: "Приготовить пирожки с картошкой",
      text:
          "To prepare it, you need: boiled water, sugar - 1 teaspoon, yeast - 11 grams, salt - 1.5 teaspoons, flour - 700 g, potatoes - 5 pieces, vegetable oil – 450 ml, optional - onion - 2 pieces.",
      date: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      completed: false,
      priority: Priority.medium)
];

List<Note> listReady = [];
