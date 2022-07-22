import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/widgets/note.dart';

import '../colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text('Добавление задачи',
              style: Theme.of(context).textTheme.headline1)),
      content: SingleChildScrollView(
          child: Wrap(runSpacing: 4, children: [
        Text("Введите название:", style: Theme.of(context).textTheme.bodyText2),
        TextFormField(
          style: Theme.of(context).textTheme.headline3,
          onChanged: (value) {
            setState(() {
              title = value;
            });
          },
        ),
        Text("Введите описание:", style: Theme.of(context).textTheme.bodyText2),
        TextFormField(
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyText1,
          onChanged: (value) {
            setState(() {
              text = value;
            });
          },
        ),
        Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: wasTapCalendar ? lightGrey : lightBlue,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 44, 40),
                    textStyle: Theme.of(context).textTheme.bodyText2),
                child: wasTapCalendar
                    ? Text(DateFormat("yyyy-MM-dd").format(date))
                    : const Text("Введите дату"),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime(2100));
                  if (newDate == null) return;
                  setState(() {
                    date = newDate;
                    wasTapCalendar = true;
                  });
                })),
        Text("Выберите приоритет выполнения:",
            style: Theme.of(context).textTheme.bodyText2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: wasTap1 ? lightGrey : lightBlue),
                onPressed: () {
                  setState(() {
                    priority = Priority.low;
                    wasTap1 = true;
                    wasTap2 = false;
                    wasTap3 = false;
                  });
                },
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset("assets/images/yellow1.png"))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: wasTap2 ? lightGrey : lightBlue),
                onPressed: () {
                  setState(() {
                    priority = Priority.medium;
                    wasTap2 = true;
                    wasTap1 = false;
                    wasTap3 = false;
                  });
                },
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset("assets/images/blue4.png"))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: wasTap3 ? lightGrey : lightBlue),
                onPressed: () {
                  setState(() {
                    priority = Priority.high;
                    wasTap3 = true;
                    wasTap1 = false;
                    wasTap2 = false;
                  });
                },
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset("assets/images/red11.png"))),
          ],
        )
      ])),
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
