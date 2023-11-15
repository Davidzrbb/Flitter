import 'package:flitter/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/comment_delete_bloc/comment_delete_bloc.dart';
import '../../screens/edit_comment.dart';
import '../delete_icon.dart';
import '../edit_icon.dart';

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
        EditIcon(
          id: comment.id,
          fontSize: 15,
          onEdited: () {
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
        ),
        DeleteIcon(
          idPost: postId,
          fontSize: 15,
          onDeleted: () {
            BlocProvider.of<CommentDeleteBloc>(context)
                .add(CommentDelete(comment.id));
          },
        ),
      ],
    );
  }
}
