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
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              onChanged: (value) {
                setState(() {});
              },
              //  controller: _textFieldController,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
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
                           _displayTextInputDialog(context);
                          setState(() {
                            widget.notes.add(
                                Note(title: "", text: "", completed: false));
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline))
                  ],
                )))
      ],
    );
  }
}
