import 'package:flutter/material.dart';

import 'list_notes.dart';

class Note extends StatefulWidget {
  String title;
  String text;
  bool completed;
  int id;

  Note(
      {Key? key,
      required this.title,
      required this.text,
      required this.completed,
      required this.id})
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
          Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: () {
                    _displayDeleteDialog(context, widget.id);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete_outline_outlined)))
        ]));
  }

  Future<void> _displayDeleteDialog(BuildContext context, int id) async {
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
                  setState(() {
                    ListNotes.removeWhere((item) => item.id == id);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
