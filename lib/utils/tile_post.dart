import 'package:flitter/models/get_post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_avatar/random_avatar.dart';

class TilePost extends StatelessWidget {
  const TilePost({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RandomAvatar(
        item.author.id.toString(),
        height: 50,
        width: 52,
      ),
      title: Text(item.author.name),
      subtitle: _showMore(item.content, context),
      trailing: Text(
        DateFormat('dd/MM à HH:mm', 'fr_FR').format(
          DateTime.fromMillisecondsSinceEpoch(item.createdAt),
        ),
      ),
    );
  }

  _showMore(String content, BuildContext context) {
    if (content.length > 15) {
      return SizedBox(
        width: 200, // Adjust the width as needed
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$content ...',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(item.author.name),
                      content: Text(item.content),
                    );
                  },
                );
              },
              child: const Text('Voir plus'),
            ),
          ],
        ),
      );
    } else {
      return Text(content);
    }
  }


}
