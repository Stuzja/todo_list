import 'package:flutter/material.dart';

class AddNoteDialog extends StatefulWidget {
  final void Function(String title, String text, DateTime date) addFunc;
  const AddNoteDialog({Key? key, required this.addFunc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddNoteDialogState();
}

class AddNoteDialogState extends State<AddNoteDialog> {
  String title = "";
  String text = "";
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
        ElevatedButton(
          child: const Text('Выберите дату'),
          onPressed: () {
            //  _selectDate(context);
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
              widget.addFunc(title, text, DateTime.now());
              Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
