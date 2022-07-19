import 'package:flutter/material.dart';
import 'package:todo_list/widgets/add_note.dart';
import 'package:todo_list/widgets/list_notes.dart';
import 'note.dart';

class NotesWidget extends StatefulWidget {
  List<Note> notes;
  NotesWidget({Key? key, required this.notes}) : super(key: key);

  @override
  createState() => NotesWidgetState();
}

class NotesWidgetState extends State<NotesWidget> {
  Future<void> _displayAddNoteDialog(BuildContext contex) async {
    String title = "";
    String text = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Добавить задачу'),
            content: SingleChildScrollView(
                child: Wrap(children: [
              Text("Введите название:"),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              Text("Введите описание:"),
              TextFormField(
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
              ),
            ])),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Отмена'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text('Добавить'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    widget.notes
                        .add(Note(title: title, text: text, completed: false));
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset("assets/images/background.jpg").image,
                    fit: BoxFit.fill))),
        SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "~To Do List~",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Wrap(
                      runSpacing: MediaQuery.of(context).size.height * 0.01,
                      children: <Widget>[
                        for (var note in ListNotes)
                          Note(
                              title: note.title,
                              text: note.text,
                              completed: note.completed),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          _displayAddNoteDialog(context);
                          setState(() {});
                        },
                        icon: const Icon(Icons.add_circle_outline))
                  ],
                )))
      ],
    );
  }
}
