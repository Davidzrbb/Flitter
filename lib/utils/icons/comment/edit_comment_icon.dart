import 'package:flutter/material.dart';

import '../../../models/comment.dart';
import '../../screens/edit_comment.dart';

class EditCommentIcon extends StatelessWidget {
  const EditCommentIcon({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      /*remove padding and marge*/
      heroTag: 'edit',
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return EditComment(
              comment: comment,
            );
          },
        );
      },
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: const Icon(
        Icons.edit_outlined,
        color: Colors.grey,
        size: 15,
      ),
    );
  }
}
