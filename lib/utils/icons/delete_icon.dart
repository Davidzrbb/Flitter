import 'package:flutter/material.dart';

class DeleteIcon extends StatelessWidget {
  const DeleteIcon({
    Key? key,
    required this.onDeleted,
    required this.fontSize,
  }) : super(key: key);

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
        return AlertDialog(
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
        );
      },
    );
  }
}
