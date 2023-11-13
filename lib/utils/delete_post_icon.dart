import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/post_delete_bloc/post_delete_bloc.dart';
import '../services/post_get_bloc/post_get_bloc.dart';

class DeletePostIcon extends StatelessWidget {
  const DeletePostIcon({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDeleted(context),
      child: const Icon(
        Icons.delete_outlined,
        color: Colors.grey,
        size: 20,
      ),
    );
  }

  Future<void> _onDeleted(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Êtes-vous sûr de vouloir supprimer ce post ?"),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () => _onDeletedBloc(context),
              child:
                  const Text("Supprimer", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _onDeletedBloc(BuildContext context) {
    BlocProvider.of<PostDeleteBloc>(context).add(PostDelete(id));
    BlocProvider.of<PostDeleteBloc>(context).stream.listen((state) {
      if (state.status == PostDeleteStatus.success ||
          state.status == PostDeleteStatus.error) {
        BlocProvider.of<PostGetBloc>(context)
            .add(PostGetAll(refresh: true));
        Navigator.of(context).pop();
      }
    });
  }
}
