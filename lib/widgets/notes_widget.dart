import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/widgets/dialogs/addnote_dialog.dart';
import 'package:todo_list/widgets/list_notes.dart';
import 'functions.dart';
import 'note_widget.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({Key? key}) : super(key: key);
  @override
  createState() => NotesWidgetState();
}

class NotesWidgetState extends State<NotesWidget> {
  refresh(void Function() func) {
    setState(() {
      func();
      listWaiting.sort();
      listReady.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset("assets/images/background.jpg").image,
                    fit: BoxFit.fill))),
        SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "~To Do List~",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Wrap(
                      runSpacing: MediaQuery.of(context).size.height * 0.02,
                      children: [
                        for (var arr in listDivider(listWaiting))
                          Wrap(
                              runSpacing:
                                  MediaQuery.of(context).size.height * 0.02,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        DateFormat.MMMMEEEEd()
                                            .format(arr.first.date),
                                        style: const TextStyle(fontSize: 23))),
                                for (var elem in arr)
                                  NoteWidget(
                                    note: elem,
                                    refreshFunc: refresh,
                                  ),
                              ]),
                        Text(
                          "Завершенные:",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        for (var elem in listReady)
                          NoteWidget(
                            note: elem,
                            refreshFunc: refresh,
                          ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  AddNoteDialog(refreshFunc: refresh),
                            );
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline))
                  ],
                )))
      ],
    );
  }
}
