import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  final String title;
  final String text;
  final bool completed;

  Note(
      {Key? key,
      required this.title,
      required this.text,
      required this.completed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      NoteState(this.title, this.text, this.completed);
}

class NoteState extends State<Note> {
  String title;
  String text;
  bool completed;

  NoteState(this.title, this.text, this.completed);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(title),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      completed = !completed;
                    });
                  },
                  icon: completed
                      ? Icon(Icons.check_circle_outlined)
                      : Icon(Icons.circle_outlined))
            ],
          ),
          const Divider(),
          Text(text),
        ]));
  }
}
