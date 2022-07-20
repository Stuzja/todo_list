import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dialogs/deletenote_dialog.dart';
import 'dialogs/editnote_dialog.dart';


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
                    showDialog(
                      context: context,
                      builder: (_) => EditNoteDialog(
                          id: widget.id,
                          title: widget.title,
                          text: widget.text,
                          date: widget.date,
                          editFunc: widget.editFunc),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => DeleteNoteDialog(
                          id: widget.id, deleteFunc: widget.deleteFunc),
                    );
                  },
                  icon: const Icon(Icons.delete_outline_outlined))
            ],
          )
        ]));
  }
}
