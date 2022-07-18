import 'package:flutter/cupertino.dart';

class Note extends StatelessWidget {
  final String title;
  final String text;
  final bool completed;

  const Note(
      {Key? key,
      required this.title,
      required this.text,
      required this.completed})
      : super(key: key);

  @override
  Widget build(Object context) {
    return Container(child: Column(children: [Text(title)]));
  }
}
