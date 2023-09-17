import 'dart:async';

import 'package:flutter/material.dart';

class TimerReverse extends StatefulWidget {
  final DateTime counter;
  const TimerReverse({required this.counter, Key? key}) : super(key: key);

  @override
  State<TimerReverse> createState() => _TimerReverseState();
}

class _TimerReverseState extends State<TimerReverse> {
  String count = '';
  Timer? t;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    t = Timer.periodic(const Duration(seconds: 1), (timer) {
      count = widget.counter
          .subtract(Duration(
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second,
          ))
          .toString()
          .split(" ")[1]
          .substring(0, 8);
      setState(() {});
      if (count.isNotEmpty &&
          count.split(":")[0].toString() == "00" &&
          count.split(":")[1].toString() == "00" &&
          count.split(":")[2].toString() == "00") {
        t!.cancel();
      }
      // print('count$count');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    t!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '- $count',
      style: TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}
