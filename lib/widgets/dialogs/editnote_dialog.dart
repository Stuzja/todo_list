import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../functions.dart';
import '../note.dart';

// ignore: must_be_immutable
class EditNoteDialog extends StatefulWidget {
  final int id;
  String title;
  String text;
  DateTime date;
  Priority priority;
  final void Function(void Function()) refreshFunc;

  EditNoteDialog({
    Key? key,
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.priority,
    required this.refreshFunc,
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
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              widget.date = newDateTime;
            },
          ),
        ),
        const Text("Выберите приоритет выполнения:"),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  widget.priority = Priority.low;
                },
                icon: const Icon(Icons.square)),
            IconButton(
                onPressed: () {
                  widget.priority = Priority.medium;
                },
                icon: const Icon(Icons.square)),
            IconButton(
                onPressed: () {
                  widget.priority = Priority.high;
                },
                icon: const Icon(Icons.square)),
          ],
        )
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
            widget.refreshFunc(() =>
                editNote(widget.id, widget.title, widget.text, widget.date, widget.priority));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
