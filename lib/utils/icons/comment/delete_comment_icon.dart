import 'package:flutter/material.dart';

class DeleteCommentIcon extends StatelessWidget {
  const DeleteCommentIcon({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (),/*_onDeleted(context),*/
      child: const Icon(
        Icons.delete_outlined,
        color: Colors.grey,
        size: 15,
      ),
    );
  }

/*  Future<void> _onDeleted(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocListener<PostDeleteBloc, PostDeleteState>(
          listener: (context, state) {
            if (state.status == PostDeleteStatus.success) {
              BlocProvider.of<PostGetBloc>(context)
                  .add(PostGetAll(refresh: true));
              Navigator.of(context).pop();
            }
          },
          child: AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Êtes-vous sûr de vouloir supprimer ce post ?"),
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
    BlocProvider.of<PostDeleteBloc>(context).add(PostDelete(id));
  }*/
}
