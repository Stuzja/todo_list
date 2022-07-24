import 'package:flutter/material.dart';
import 'package:todo_list/widgets/dialogs/priority_picker.dart';
import '../colors_and_icons.dart';
import '../functions.dart';
import '../note.dart';
import 'date_picker.dart';

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
    bool wasTap1 = widget.priority == Priority.low;
    bool wasTap2 = widget.priority == Priority.medium;
    bool wasTap3 = widget.priority == Priority.high;

    void refreshDate(DateTime childDate, bool childTap) {
      setState(() {
        widget.date = childDate;
      });
    }

    void refreshPriority(
        Priority newPriority, bool tap1, bool tap2, bool tap3) {
      setState(() {
        widget.priority = newPriority;
        wasTap1 = tap1;
        wasTap2 = tap2;
        wasTap3 = tap3;
      });
    }

    return AlertDialog(
      title: Center(
          child: Text('Изменение задачи',
              style: Theme.of(context).textTheme.headline1)),
      content: SingleChildScrollView(
        child: Wrap(runSpacing: 4, children: [
          Text("Введите название:",
              style: Theme.of(context).textTheme.bodyText2),
          TextFormField(
            style: Theme.of(context).textTheme.headline3,
            controller: textControllerTitle,
            onChanged: (value) {
              setState(() {
                widget.title = value;
              });
            },
          ),
          Text("Введите описание:",
              style: Theme.of(context).textTheme.bodyText2),
          TextFormField(
            maxLines: 3,
            style: Theme.of(context).textTheme.bodyText1,
            controller: textControllerText,
            onChanged: (value) {
              setState(() {
                widget.text = value;
              });
            },
          ),
          DateTimeWidget(
              date: widget.date, wasTap: true, refreshFunc: refreshDate),
          Text("Выберите приоритет выполнения:",
              style: Theme.of(context).textTheme.bodyText2),
          PriorityPickerWidget(
              wasTap1: wasTap1,
              wasTap2: wasTap2,
              wasTap3: wasTap3,
              priority: widget.priority,
              refreshFunc: refreshPriority)
        ]),
      ),
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
            widget.refreshFunc(() => editNote(widget.id, widget.title,
                widget.text, widget.date, widget.priority));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
