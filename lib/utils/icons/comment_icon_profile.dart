import 'package:flutter/material.dart';

import '../../models/get_profile_posts.dart';

class CommentIconProfile extends StatelessWidget {
  const CommentIconProfile({super.key, required this.item,
    required this.onTap,
  });

  final Item item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
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
