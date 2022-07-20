import 'package:flutter/material.dart';

class EditNoteDialog extends StatefulWidget {
  final int id;
  String title;
  String text;
  DateTime date;
  final void Function(int, String, String, DateTime) editFunc;

  EditNoteDialog({
    Key? key,
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.editFunc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditNoteDialogState();
}

class EditNoteDialogState extends State<EditNoteDialog> {
  @override
  Widget build(BuildContext context) {
    var textControllerTitle = TextEditingController();
    textControllerTitle.text = widget.title;
    var textControllerText = TextEditingController();
    textControllerText.text = widget.text;

    return AlertDialog(
      title: const Text('Изменение задачи'),
      content: SingleChildScrollView(
          child: Wrap(runSpacing: 2, children: [
        const Text("Введите название:"),
        TextFormField(
          controller: textControllerTitle,
          onChanged: (value) {
            setState(() {
              widget.title = value;
            });
          },
        ),
        const Text("Введите описание:"),
        TextFormField(
          maxLines: 2,
          controller: textControllerText,
          onChanged: (value) {
            setState(() {
              widget.text = value;
            });
          },
        ),
        const Text("Введите дату:"),
        TextFormField(
          maxLines: 2,
          onChanged: (value) {
            setState(() {
              widget.date = DateTime.parse(value);
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
            widget.editFunc(widget.id, widget.title, widget.text, widget.date);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
