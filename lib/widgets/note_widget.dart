import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dialogs/deletenote_dialog.dart';
import 'dialogs/editnote_dialog.dart';
import 'note.dart';

// ignore: must_be_immutable
class NoteWidget extends StatefulWidget {
  Note note;
  final void Function(int) deleteFunc;
  final void Function(int, String, String, DateTime) editFunc;

  NoteWidget(
      {Key? key,
       required this.note,
      required this.deleteFunc,
      required this.editFunc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => NoteWidgetState();
}

class NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(widget.note.title),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.note.completed = !widget.note.completed;
                    });
                  },
                  icon: widget.note.completed
                      ? const Icon(Icons.check_circle_outlined)
                      : const Icon(Icons.circle_outlined))
            ],
          ),
          const Divider(),
          Text(widget.note.text),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(DateFormat("yyyy-MM-dd").format(widget.note.date)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => EditNoteDialog(
                          id: widget.note.id,
                          title: widget.note.title,
                          text: widget.note.text,
                          date: widget.note.date,
                          editFunc: widget.editFunc),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => DeleteNoteDialog(
                          id: widget.note.id, deleteFunc: widget.deleteFunc),
                    );
                  },
                  icon: const Icon(Icons.delete_outline_outlined))
            ],
          )
        ]));
  }
}