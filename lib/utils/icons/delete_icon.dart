import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/comment_delete/comment_delete_bloc.dart';
import '../../services/get_comment/get_comment_bloc.dart';
import '../../services/post_delete/post_delete_bloc.dart';
import '../../services/post_get/post_get_bloc.dart';


class DeleteIcon extends StatelessWidget {
  const DeleteIcon({
    Key? key,
    required this.idPost,
    required this.onDeleted,
    required this.fontSize,
  }) : super(key: key);

  final int idPost;
  final VoidCallback onDeleted;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDeleted(context),
      child: Icon(
        Icons.delete_outlined,
        color: Colors.grey,
        size: fontSize,
      ),
    );
  }

  Future<void> _onDeleted(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return MultiBlocListener(
          listeners: [
            BlocListener<PostDeleteBloc, PostDeleteState>(
              listener: (context, state) {
                if (state.status == PostDeleteStatus.success) {
                  BlocProvider.of<PostGetBloc>(context)
                      .add(PostGetAll(refresh: true));
                  Navigator.of(context).pop();
                }
              },
            ),
            BlocListener<CommentDeleteBloc, CommentDeleteState>(
              listener: (context, state) {
                if (state.status == CommentDeleteStatus.success) {
                  BlocProvider.of<GetCommentBloc>(context)
                      .add(GetComment(idPost));
                  BlocProvider.of<PostGetBloc>(context)
                      .add(PostGetAll(refresh: true));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
          child: AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Êtes-vous sûr de vouloir supprimer ?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Annuler"),
              ),
              TextButton(
                onPressed: () {
                  onDeleted();
                },
                child: const Text("Supprimer"),
              ),
            ],
          ),
        );
      },
    );
  }
}
