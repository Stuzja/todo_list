import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  String title;
  String text;
  bool completed;

  Note(
      {Key? key,
      required this.title,
      required this.text,
      required this.completed})
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
        child: 
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        ]));
  }
}
