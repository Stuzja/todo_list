import 'package:flutter/material.dart';
import 'package:todo_list/widgets/dialogs/addnote_dialog.dart';
import 'package:todo_list/widgets/list_notes.dart';
import 'note.dart';
import 'note_widget.dart';

class NotesWidget extends StatefulWidget {
  NotesWidget({Key? key}) : super(key: key);
  @override
  createState() => NotesWidgetState();
}

class NotesWidgetState extends State<NotesWidget> {
  refresh(void Function() func) {
    setState(() {
      func();
    });
  }

  //Процедура удаления и обновления родительского состояния(передаю в дочерний виджет самой задачи)
  addNote(String title, String text, DateTime date) {
    setState(() {
      listWaiting.add(Note(
        title: title,
        text: text,
        completed: false,
        id: count + 1,
        date: date,
      ));
      count++;
    });
  }

  //Я хз как это можно было иначе сделать~~~
  deleteNote(int id) {
    setState(() {
      if (listWaiting.where((element) => element.id == id).isNotEmpty) {
        listWaiting.removeWhere((element) => element.id == id);
      } else {
        listReady.removeWhere((element) => element.id == id);
      }
    });
  }

  //Процедура редактирования и обновления
  editNote(int id, String title, String text, DateTime date) {
    setState(() {
      listWaiting[id].title = title;
      listWaiting[id].text = text;
      listWaiting[id].date = date;
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
                        for (var elem in listWaiting)
                          NoteWidget(
                            note: elem,
                            deleteFunc: deleteNote,
                            editFunc: editNote,
                            refreshFunc: refresh,
                          ),
                        Text(
                          "Завершенные:",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        for (var elem in listReady)
                          NoteWidget(
                            note: elem,
                            deleteFunc: deleteNote,
                            editFunc: editNote,
                            refreshFunc: refresh,
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
