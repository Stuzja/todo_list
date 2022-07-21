import 'package:flutter/material.dart';
import '../colors.dart';
import '../functions.dart';

class DeleteNoteDialog extends StatefulWidget {
  final int id;
  final void Function(void Function()) refreshFunc;
  const DeleteNoteDialog(
      {Key? key, required this.id, required this.refreshFunc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => DeleteNoteDialogState();
}

class DeleteNoteDialogState extends State<DeleteNoteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text('Удаление задачи',
              style: Theme.of(context).textTheme.headline1)),
      content: const Text("Вы действительно хотите удалить эту задачу?"),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: buttonBlue),
          child: const Text('Отмена'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: buttonBlue),
          child: const Text('Подтвердить'),
          onPressed: () {
            widget.refreshFunc(() => deleteNote(widget.id));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
