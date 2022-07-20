import 'package:flutter/material.dart';
import 'package:todo_list/widgets/dialogs/addnote_dialog.dart';
import 'package:todo_list/widgets/list_notes.dart';
import 'note.dart';
import 'note_widget.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({Key? key}) : super(key: key);

  @override
  createState() => NotesWidgetState();
}

class NotesWidgetState extends State<NotesWidget> {
  //Процедура удаления и обновления родительского состояния(передаю в дочерний виджет самой задачи)
  addNote(String title, String text, DateTime date) {
    setState(() {
      ListNotes.add(Note(
        title: title,
        text: text,
        completed: false,
        id: ListNotes.length,
        date: date,
      ));
    });
  }

  //Я хз как это можно было иначе сделать~~~
  deleteNote(int id) {
    setState(() {
      ListNotes.removeAt(id);
    });
  }

  //Процедура редактирования и обновления
  editNote(int id, String title, String text, DateTime date) {
    setState(() {
       ListNotes[id].title = title;
       ListNotes[id].text = text;
       ListNotes[id].date = date;
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
                        for (var elem in ListNotes)
                          NoteWidget(
                            note: elem,
                            deleteFunc: deleteNote,
                            editFunc: editNote,
                          ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AddNoteDialog(addFunc: addNote),
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline))
                  ],
                )))
      ],
    );
  }
}
