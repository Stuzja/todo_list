import 'package:flutter/material.dart';
import 'package:todo_list/widgets/colors.dart';
import 'package:todo_list/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 35,
              fontFamily: "LemonTuesday",
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  blurRadius: 8,
                  color: Colors.lightBlue,
                  offset: Offset(-2.0, 1.0),
                ),
              ],
            ),
            headline2: TextStyle(
                fontSize: 27, fontFamily: "Parabola", color: Colors.black87),
            headline3: TextStyle(
                fontSize: 16,
                fontFamily: "MullerNarrow",
                color: Colors.black87,
                fontWeight: FontWeight.w500),
            bodyText1: TextStyle(
                fontSize: 15,
                fontFamily: "MullerNarrow",
                color: Colors.black87,
                fontWeight: FontWeight.w500),
            bodyText2: TextStyle(
                fontSize: 16,
                fontFamily: "MullerNarrow",
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          )),
      home: const HomePage(),
    );
  }
}
