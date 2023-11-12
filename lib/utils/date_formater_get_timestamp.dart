import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatGetTimestamp extends StatelessWidget {
  const DateFormatGetTimestamp({super.key,
    required this.timestamp,
  });

  final int timestamp;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('dd/MM/yyyy à HH:mm').format(DateTime.fromMillisecondsSinceEpoch(timestamp)),
      style: const TextStyle(fontSize: 12),
    );
  }
}
