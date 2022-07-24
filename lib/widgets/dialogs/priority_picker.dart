import 'package:flutter/material.dart';
import '../colors_and_icons.dart';
import '../note.dart';

// ignore: must_be_immutable
class PriorityPickerWidget extends StatefulWidget {
  final bool wasTap1;
  final bool wasTap2;
  final bool wasTap3;
  final Priority priority;
  final Function(Priority, bool, bool, bool) refreshFunc;
  const PriorityPickerWidget({
    Key? key,
    required this.wasTap1,
    required this.wasTap2,
    required this.wasTap3,
    required this.priority,
    required this.refreshFunc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PriorityPickerWidgetState();
}

class PriorityPickerWidgetState extends State<PriorityPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: widget.wasTap1 ? lightGrey : buttonBlue),
            onPressed: () {
              setState(() {
                widget.refreshFunc(Priority.low, true, false, false);
              });
            },
            child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset("assets/images/yellow1.png"))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: widget.wasTap2 ? lightGrey : buttonBlue),
            onPressed: () {
              setState(() {
                widget.refreshFunc(Priority.medium, false, true, false);
              });
            },
            child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset("assets/images/blue4.png"))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: widget.wasTap3 ? lightGrey : buttonBlue),
            onPressed: () {
              setState(() {
                widget.refreshFunc(Priority.high, false, false, true);
              });
            },
            child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset("assets/images/red11.png"))),
      ],
    );
  }
}
