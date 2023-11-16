import 'package:flutter/material.dart';

class VoirPlusString extends StatelessWidget {
  const VoirPlusString({super.key, required this.content});

  final String? content;

  @override
  Widget build(BuildContext context) {
    return _showMore(content, context);
  }

  _showMore(String? content, BuildContext context) {
    if (content == null) {
      return const Text('');
    }
    if (content.trim().length > 15) {
      return Row(
        children: [
          Text(
            '${content.substring(0, 15)}...',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black),
          ),
          TextButton(
            //remove the button's padding and margin because it's inside a row
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
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
