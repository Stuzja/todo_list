import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/widgets/note.dart';

import '../functions.dart';

class AddNoteDialog extends StatefulWidget {
  final void Function(void Function()) refreshFunc;
  const AddNoteDialog({Key? key, required this.refreshFunc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddNoteDialogState();
}

class AddNoteDialogState extends State<AddNoteDialog> {
  String title = "";
  String text = "";
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Priority priority = Priority.medium;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавление задачи'),
      content: SingleChildScrollView(
          child: Wrap(runSpacing: 2, children: [
        const Text("Введите название:"),
        TextFormField(
          onChanged: (value) {
            setState(() {
              title = value;
            });
          },
        ),
        const Text("Введите описание:"),
        TextFormField(
          maxLines: 2,
          onChanged: (value) {
            setState(() {
              text = value;
            });
          },
        ),
        const Text("Введите дату:"),
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            minimumDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            onDateTimeChanged: (DateTime newDateTime) {
              date = newDateTime;
            },
          ),
        ),
        const Text("Выберите приоритет выполнения:"),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  priority = Priority.low;
                },
                icon: const Icon(Icons.square)),
            IconButton(
                onPressed: () {
                  priority = Priority.medium;
                },
                icon: const Icon(Icons.square)),
            IconButton(
                onPressed: () {
                  priority = Priority.high;
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
            widget.refreshFunc(() => addNote(title, text, date, priority));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
