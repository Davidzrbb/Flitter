import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/post_delete_bloc/post_delete_bloc.dart';

class DeletePostIcon extends StatelessWidget {
  const DeletePostIcon({
    Key? key,
    required this.id,
  }) : super(key: key);

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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Êtes-vous sûr de vouloir supprimer ce post ?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                // User confirmed deletion, dispatch the delete event
/*              BlocProvider.of<PostDeleteBloc>(context).add(PostDelete(id));
                Navigator.pop(context); // Close the dialog*/
              },
              child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
