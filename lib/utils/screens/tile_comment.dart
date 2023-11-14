import 'package:flitter/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import '../date_formater_get_timestamp.dart';
import '../voir_plus_string.dart';

class TileComment extends StatelessWidget {
  const TileComment({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RandomAvatar(
        comment.author.id.toString(),
        height: 30,
        width: 30,
      ),
      title: Text(comment.author.name),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: VoirPlusString(content: comment.content),
      ),
      trailing:
          DateFormatGetTimestamp(timestamp: comment.createdAt, fontSize: 11),
    );
  }
}
