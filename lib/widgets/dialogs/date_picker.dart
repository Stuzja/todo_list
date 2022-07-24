import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../colors_and_icons.dart';

class DateTimeWidget extends StatefulWidget {
  final bool wasTap;
  final DateTime date;
  final Function(DateTime, bool) refreshFunc;
  const DateTimeWidget(
      {Key? key,
      required this.date,
      required this.wasTap,
      required this.refreshFunc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => DateTimeWidgetState();
}

class DateTimeWidgetState extends State<DateTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: widget.wasTap ? lightGrey : buttonBlue,
            minimumSize: Size(MediaQuery.of(context).size.width - 44, 40)),
        child: widget.wasTap
            ? Text(DateFormat("yyyy-MM-dd").format(widget.date))
            : const Text("Введите дату"),
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day),
              lastDate: DateTime(2100));
          if (newDate == null) return;
          setState(() {
            widget.refreshFunc(newDate, true);
          });
        },
      ),
    );
  }
}
