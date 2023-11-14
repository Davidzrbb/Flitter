import 'package:flitter/services/comment_delete_bloc/comment_delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/get_comment/get_comment_bloc.dart';
import '../../../services/post_get_bloc/post_get_bloc.dart';

class DeleteCommentIcon extends StatelessWidget {
  const DeleteCommentIcon({super.key, required this.id, required this.idPost});

  final int id;
  final int idPost;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDeleted(context),
      child: const Icon(
        Icons.delete_outlined,
        color: Colors.grey,
        size: 15,
      ),
    );
  }

  Future<void> _onDeleted(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocListener<CommentDeleteBloc, CommentDeleteState>(
          listener: (context, state) {
            if (state.status == CommentDeleteStatus.success) {
              BlocProvider.of<GetCommentBloc>(context).add(GetComment(idPost));
              BlocProvider.of<PostGetBloc>(context)
                  .add(PostGetAll(refresh: true));
              Navigator.of(context).pop();
            }
          },
          child: AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Êtes-vous sûr de vouloir supprimer ce commentaire ?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Annuler"),
              ),
              TextButton(
                onPressed: () {
                  _onDeletedBloc(context);
                },
                child: const Text("Supprimer",
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onDeletedBloc(BuildContext context) {
    BlocProvider.of<CommentDeleteBloc>(context).add(CommentDelete(id));
  }
}
