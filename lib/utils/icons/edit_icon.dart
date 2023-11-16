import 'package:flutter/material.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({
    super.key,
    required this.id,
    required this.onEdited,
    required this.fontSize,
  });

  final int id;
  final VoidCallback onEdited;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'editComment$id',
      onPressed: () => onEdited(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Icon(
        Icons.edit_outlined,
        color: Colors.grey,
        size: fontSize,
      ),
    );
  }
}
