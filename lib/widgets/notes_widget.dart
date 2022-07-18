import 'package:flutter/material.dart';
import 'package:todo_list/widgets/list_notes.dart';
import 'note.dart';

class NotesWidget extends StatefulWidget {
  final List<Note> notes;
  const NotesWidget({Key? key, required this.notes}) : super(key: key);

  @override
  createState() => NotesWidgetState();
}

class NotesWidgetState extends State<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset("assets/images/background.jpg").image,
                    fit: BoxFit.fill))),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  "~To Do List~",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [ for (var note in ListNotes)
                    Note(title: note.title, text: note.text, completed: note.completed)],
                  ),
                )
              ],
            ))
      ],
    );
  }
}
