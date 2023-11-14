import 'package:flitter/utils/icons/comment_icon.dart';
import 'package:flitter/utils/icons/edit_post.dart';
import 'package:flutter/material.dart';

import '../../models/get_post.dart';
import 'delete_post_icon.dart';

class IconsIsMe extends StatelessWidget {
  const IconsIsMe({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommentIcon(item: item),
        FloatingActionButton(
          heroTag: 'edit',
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return EditPostScreen(
                  item: item,
                );
              },
            );
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(
            Icons.edit_outlined,
            color: Colors.grey,
            size: 20,
          ),
        ),
        DeletePostIcon(
          id: item.id,
        ),
      ],
    );
  }
}
