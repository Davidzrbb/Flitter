import 'package:flitter/models/comment.dart';
import 'package:flitter/services/comment_get/get_comment_bloc.dart';
import 'package:flitter/services/post_get/post_get_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/patch_comment.dart';
import '../../../services/comment_delete/comment_delete_bloc.dart';
import '../../../services/comment_patch/comment_patch_bloc.dart';
import '../../ui/floating_action_button_screen.dart';
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
                return FloatingActionButtonScreen(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<CommentPatchBloc>(context).add(
                        CommentPatch(
                          CommentPatchModel(
                            id: comment.id,
                            comment: textFieldController.text,
                          ),
                        ),
                      );
                    }
                  },
                  url: null,
                  content: comment.content,
                );
              },
            );
          },
        ),
        BlocListener<CommentDeleteBloc, CommentDeleteState>(
          listener: (context, state) {
            if (state.status == CommentDeleteStatus.success) {
              BlocProvider.of<GetCommentBloc>(context).add(GetComment(postId));
              BlocProvider.of<PostGetBloc>(context)
                  .add(PostGetAll(refresh: true));
              Navigator.of(context).pop();
            }
          },
          child: DeleteIcon(
            fontSize: 15,
            onDeleted: () {
              BlocProvider.of<CommentDeleteBloc>(context)
                  .add(CommentDelete(comment.id));
            },
          ),
        ),
      ],
    );
  }
}
