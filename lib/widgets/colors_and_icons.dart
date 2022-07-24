import 'package:flutter/material.dart';

const beige = Color.fromRGBO(202, 163, 134, 1);
const back = Colors.white54;
const lightBlue = Color.fromRGBO(142, 211, 224, 0.7);
const lightGrey = Color.fromARGB(255, 211, 209, 209);
const buttonBlue = Color.fromARGB(255, 126, 212, 238);

class IconLowWidget extends StatelessWidget {
  const IconLowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30, width: 30, child: Image.asset("assets/images/yellow1.png"));
  }
}

class IconMediumWidget extends StatelessWidget {
  const IconMediumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30, width: 30, child: Image.asset("assets/images/blue4.png"));
  }
}

class IconHighWidget extends StatelessWidget {
  const IconHighWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30, width: 30, child: Image.asset("assets/images/red11.png"));
  }
}
