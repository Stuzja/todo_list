import 'package:flutter/material.dart';
import 'package:todo_list/widgets/addnote_dialog.dart';
import 'package:todo_list/widgets/list_notes.dart';
import 'note.dart';

class NotesWidget extends StatefulWidget {
  NotesWidget({Key? key}) : super(key: key);

  @override
  createState() => NotesWidgetState();
}

class NotesWidgetState extends State<NotesWidget> {
  addNote(String title, String text, DateTime date) {
    setState(() {
      ListNotes.add(Note(
        title: title,
        text: text,
        completed: false,
        id: ListNotes.length,
        date: DateTime.now(),
        deleteFunc: deleteNote,
        editFunc: editNote,
      ));
    });
  }

  //Процедура удаления и обновления родительского состояния(передаю в дочерний виджет самой задачи)
  deleteNote(int id) {
    setState(() {
      ListNotes.removeAt(id);
    });
  }

  //Процедура редактирования и обновления
  editNote(int id, String title, String text, DateTime date) {
    setState(() {
      ListNotes.removeAt(id);
      ListNotes.add(Note(
        title: title,
        text: text,
        completed: false,
        id: id,
        date: date,
        deleteFunc: deleteNote,
        editFunc: editNote,
      ));
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
                            completed: note.completed,
                            id: note.id,
                            date: note.date,
                            deleteFunc: note.deleteFunc,
                            editFunc: note.editFunc,
                          ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (_) => AddNoteDialog(addFunc: addNote),
                            );
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline))
                  ],
                )))
      ],
    );
  }

  DateTime date = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime.utc(2100));
    if (datePicker != null && datePicker != date) {
      setState(() {
        date = datePicker;
      });
    }
  }
}
