import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Note extends StatefulWidget {
  String title;
  String text;
  bool completed;
  int id;
  DateTime date;
  final void Function(int) deleteFunc;
  final void Function(int, String, String, DateTime) editFunc;

  Note(
      {Key? key,
      required this.title,
      required this.text,
      required this.completed,
      required this.id,
      required this.date,
      required this.deleteFunc,
      required this.editFunc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => NoteState();
}

class NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(widget.title),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.completed = !widget.completed;
                    });
                  },
                  icon: widget.completed
                      ? const Icon(Icons.check_circle_outlined)
                      : const Icon(Icons.circle_outlined))
            ],
          ),
          const Divider(),
          Text(widget.text),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(DateFormat("yyyy-MM-dd").format(widget.date)),
              IconButton(
                  onPressed: () {
                    _displayEditDialog(context, widget.id, widget.title,
                        widget.text, widget.date, widget.editFunc);
                  },
                  icon: const Icon(Icons.edit_outlined)),
              IconButton(
                  onPressed: () {
                    _displayDeleteDialog(context, widget.id, widget.deleteFunc);
                  },
                  icon: const Icon(Icons.delete_outline_outlined))
            ],
          )
        ]));
  }

//Диалог при удалении задачи
  Future<void> _displayDeleteDialog(
      BuildContext context, int id, void Function(int) delete) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Удаление задачи'),
            content: const Text("Вы действительно хотите удалить эту задачу?"),
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
                  delete(id);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

//Диалог при изменении задачи
  Future<void> _displayEditDialog(
      BuildContext context,
      int id,
      String title,
      String text,
      DateTime date,
      void Function(int, String, String, DateTime) edit) async {
    var textControllerTitle = TextEditingController();
    textControllerTitle.text = title;
    var textControllerText = TextEditingController();
    textControllerText.text = text;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Изменение задачи'),
            content: SingleChildScrollView(
                child: Wrap(runSpacing: 2, children: [
              const Text("Введите название:"),
              TextFormField(
                controller: textControllerTitle,
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              const Text("Введите описание:"),
              TextFormField(
                maxLines: 2,
                controller: textControllerText,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
              ),
              const Text("Введите дату:"),
              TextFormField(
                maxLines: 2,
                onChanged: (value) {
                  setState(() {
                    date = DateTime.parse(value);
                  });
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
                  edit(id, title, text, date);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  
}
