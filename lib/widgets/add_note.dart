import 'package:flutter/material.dart';

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddNoteWidgetState();
}

class AddNoteWidgetState extends State<AddNoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(),
      ],
    );
  }
}
