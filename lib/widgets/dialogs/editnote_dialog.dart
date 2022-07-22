import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../colors.dart';
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
    bool wasTap1 = widget.priority == Priority.low;
    bool wasTap2 = widget.priority == Priority.medium;
    bool wasTap3 = widget.priority == Priority.high;
    bool wasTapCalendar = true;
    return AlertDialog(
      title: Center(
          child: Text('Изменение задачи',
              style: Theme.of(context).textTheme.headline1)),
      content: SingleChildScrollView(
          child: Wrap(runSpacing: 4, children: [
        Text("Введите название:", style: Theme.of(context).textTheme.bodyText2),
        TextFormField(
          style: Theme.of(context).textTheme.headline3,
          controller: textControllerTitle,
          onChanged: (value) {
            setState(() {
              widget.title = value;
            });
          },
        ),
        Text("Введите описание:", style: Theme.of(context).textTheme.bodyText2),
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
        Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: lightGrey,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 44, 40),
                    textStyle: Theme.of(context).textTheme.bodyText2),
                child: Text(DateFormat("yyyy-MM-dd").format(widget.date)),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: widget.date,
                      firstDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime(2100));
                  if (newDate == null) return;
                  setState(() {
                    widget.date = newDate;
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
                    primary: wasTap1 ? lightGrey : buttonBlue),
                onPressed: () {
                  setState(() {
                    widget.priority = Priority.low;
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
                    primary: wasTap2 ? lightGrey : buttonBlue),
                onPressed: () {
                  setState(() {
                    widget.priority = Priority.medium;
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
                    primary: wasTap3 ? lightGrey : buttonBlue),
                onPressed: () {
                  setState(() {
                    widget.priority = Priority.high;
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
            widget.refreshFunc(() => editNote(widget.id, widget.title,
                widget.text, widget.date, widget.priority));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
