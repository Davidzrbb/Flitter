import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatGetTimestamp extends StatelessWidget {
  const DateFormatGetTimestamp({
    super.key,
    required this.timestamp,
    required this.fontSize,
  });

  final int timestamp;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('dd/MM/yyyy à HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp)),
      style: TextStyle(fontSize: fontSize),
    );
  }
}
