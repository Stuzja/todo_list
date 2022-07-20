import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'list_notes.dart';
import 'note_widget.dart';

class WeekWidget extends StatefulWidget {
  final void Function(void Function()) refreshFunc;
  const WeekWidget({Key? key, required this.refreshFunc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WeekWidgetState();
}

class WeekWidgetState extends State<WeekWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: MediaQuery.of(context).size.height * 0.01,
        children: [
          for (var elem in 
          listWaiting
          )
            Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(DateFormat.MMMMEEEEd().format(elem.date),
                        style: const TextStyle(fontSize: 23))),
                NoteWidget(
                  note: elem,
                  refreshFunc: widget.refreshFunc,
                ),
              ],
            )
        ]);
  }
}
