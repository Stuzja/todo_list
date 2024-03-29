import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/widgets/colors_and_icons.dart';
import 'package:todo_list/widgets/list_notes.dart';
import 'dialogs/deletenote_dialog.dart';
import 'dialogs/editnote_dialog.dart';
import 'note.dart';

// ignore: must_be_immutable
class NoteWidget extends StatefulWidget {
  Note note;
  final void Function(void Function()) refreshFunc;

  NoteWidget({Key? key, required this.note, required this.refreshFunc})
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
              if (widget.note.priority == Priority.low) const IconLowWidget(),
              if (widget.note.priority == Priority.medium)
                const IconMediumWidget(),
              if (widget.note.priority == Priority.high) const IconHighWidget(),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 128,
                  child: Text(widget.note.title,
                      style: Theme.of(context).textTheme.headline3)),
              const Spacer(),
              SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                      onPressed: () {
                        widget.refreshFunc(() => setState(() {
                              if (!widget.note.completed) {
                                listReady.add(widget.note);
                                listWaiting.remove(widget.note);
                              } else {
                                listWaiting.add(widget.note);
                                listReady.remove(widget.note);
                              }
                              widget.note.completed = !widget.note.completed;
                            }));
                      },
                      icon: widget.note.completed
                          ? const Icon(Icons.check_circle_outlined,
                              color: beige)
                          : const Icon(Icons.circle_outlined, color: beige)))
            ],
          ),
          const Divider(),
          Text(widget.note.text, style: Theme.of(context).textTheme.bodyText1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(DateFormat("yyyy-MM-dd").format(widget.note.date)),
              if (!widget.note.completed)
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => EditNoteDialog(
                            id: widget.note.id,
                            title: widget.note.title,
                            text: widget.note.text,
                            date: widget.note.date,
                            priority: widget.note.priority,
                            refreshFunc: widget.refreshFunc),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined, color: beige)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => DeleteNoteDialog(
                          id: widget.note.id, refreshFunc: widget.refreshFunc),
                    );
                  },
                  icon: const Icon(Icons.delete_outline_outlined, color: beige))
            ],
          )
        ]));
  }
}
