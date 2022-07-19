import 'package:flutter/material.dart';
import 'package:todo_list/widgets/list_notes.dart';
import 'note.dart';

class NotesWidget extends StatefulWidget {
  List<Note> notes;
  NotesWidget({Key? key, required this.notes}) : super(key: key);

  @override
  createState() => NotesWidgetState();
}

class NotesWidgetState extends State<NotesWidget> {
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
                          _displayAddNoteDialog(context);
                          setState(() {});
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

//Диалог при добавлении задачи
  Future<void> _displayAddNoteDialog(BuildContext context) async {
    String title = "";
    String text = "";
    //DateTime date = DateTime.now();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Добавление задачи'),
            content: SingleChildScrollView(
                child: Wrap(runSpacing: 2, children: [
              const Text("Введите название:"),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              const Text("Введите описание:"),
              TextFormField(
                maxLines: 2,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
              ),
              const Text("Введите дату:"),
              ElevatedButton(
                child: const Text('Выберите дату'),
                onPressed: () {
                  _selectDate(context);
                },
              ),
            ])),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Отмена'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('Подтвердить'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    widget.notes.add(Note(
                      title: title,
                      text: text,
                      completed: false,
                      id: ListNotes.length,
                      date: date,
                      deleteFunc: deleteNote,
                      editFunc: editNote,
                    ));
                  });
                },
              ),
            ],
          );
        });
  }
}
