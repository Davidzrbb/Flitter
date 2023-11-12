import 'package:flutter/material.dart';

class VoirPlusString extends StatelessWidget {
  const VoirPlusString({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return _showMore(content, context);
  }

  _showMore(String content, BuildContext context) {
    if (content.length > 15) {
      return Row(
        children: [
          Expanded(
            child: Text(
              '$content ...',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(content),
                  );
                },
              );
            },
            child: const Text('Voir plus'),
          ),
        ],
      );
    } else {
      return Text(
        content,
        style: const TextStyle(color: Colors.black),
      );
    }
  }
}
