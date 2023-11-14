import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/get_post.dart';

class CommentIcon extends StatelessWidget {
  const CommentIcon({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('display_comment', pathParameters: {
          'postId': item.id.toString(),
        });
      },
      child: Row(
        children: [
          const Icon(
            Icons.comment_outlined,
            color: Colors.grey,
            size: 20,
          ),
          Text(" ${item.commentsCount.toString()}"),
        ],
      ),
    );
  }
}
