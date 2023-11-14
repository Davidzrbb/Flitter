import 'package:flitter/models/comment.dart';
import 'package:flutter/material.dart';

import 'delete_comment_icon.dart';
import 'edit_comment_icon.dart';

class IconIsMeComment extends StatelessWidget {
  const IconIsMeComment(
      {super.key, required this.comment, required this.postId});

  final Comment comment;
  final int postId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        EditCommentIcon(
          comment: comment,
        ),
        DeleteCommentIcon(
          idPost: postId,
          id: comment.id,
        ),
      ],
    );
  }
}
