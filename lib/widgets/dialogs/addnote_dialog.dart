import 'package:flutter/material.dart';
import 'package:todo_list/widgets/dialogs/date_picker.dart';
import 'package:todo_list/widgets/dialogs/priority_picker.dart';
import 'package:todo_list/widgets/note.dart';
import '../colors_and_icons.dart';
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
  bool wasTap1 = false;
  bool wasTap2 = true;
  bool wasTap3 = false;
  bool wasTapCalendar = false;

  void refreshDate(DateTime newDate, bool wasTap) {
    setState(() {
      date = newDate;
      wasTapCalendar = wasTap;
    });
  }

  void refreshPriority(Priority newPriority, bool tap1, bool tap2, bool tap3) {
    setState(() {
      priority = newPriority;
      wasTap1 = tap1;
      wasTap2 = tap2;
      wasTap3 = tap3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text('Добавление задачи',
              style: Theme.of(context).textTheme.headline1)),
      content: SingleChildScrollView(
        child: Wrap(
          runSpacing: 4,
          children: [
            Text("Введите название:",
                style: Theme.of(context).textTheme.bodyText2),
            TextFormField(
              style: Theme.of(context).textTheme.headline3,
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            Text("Введите описание:",
                style: Theme.of(context).textTheme.bodyText2),
            TextFormField(
              maxLines: 3,
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
            ),
            DateTimeWidget(
                date: date, wasTap: wasTapCalendar, refreshFunc: refreshDate),
            Text("Выберите приоритет выполнения:",
                style: Theme.of(context).textTheme.bodyText2),
            PriorityPickerWidget(
                wasTap1: wasTap1,
                wasTap2: wasTap2,
                wasTap3: wasTap3,
                priority: priority,
                refreshFunc: refreshPriority)
          ],
        ),
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
            widget.refreshFunc(() => addNote(title, text, date, priority));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
