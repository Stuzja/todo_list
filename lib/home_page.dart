import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/widgets/colors_and_icons.dart';
import 'package:todo_list/widgets/dialogs/addnote_dialog.dart';
import 'package:todo_list/widgets/list_notes.dart';
import 'widgets/functions.dart';
import 'widgets/note_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  refresh(void Function() func) {
    setState(() {
      func();
      listWaiting.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.9,
                    image: Image.asset("assets/images/background.jpg").image,
                    fit: BoxFit.fill))),
        SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: MediaQuery.of(context).size.height * 0.01,
                        children: [
                          Text("Нужно выполнить:",
                              style: Theme.of(context).textTheme.headline1),
                          for (var arr in listDivider(listWaiting))
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              color: back,
                              child: Wrap(
                                  runSpacing:
                                      MediaQuery.of(context).size.height * 0.01,
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                            DateFormat.MMMMEEEEd()
                                                .format(arr.first.date),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2)),
                                    for (var elem in arr)
                                      NoteWidget(
                                        note: elem,
                                        refreshFunc: refresh,
                                      ),
                                  ]),
                            ),
                          Text(
                            "Завершенные:",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          for (var elem in listReady)
                            Opacity(
                              opacity: 0.7,
                              child: NoteWidget(
                                note: elem,
                                refreshFunc: refresh,
                              ),
                            ),
                        ]),
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
    ));
  }
}
