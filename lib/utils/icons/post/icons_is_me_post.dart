import 'package:flitter/utils/icons/comment_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/get_post.dart';
import '../../../services/post_delete_bloc/post_delete_bloc.dart';
import '../../../services/post_get_bloc/post_get_bloc.dart';
import '../edit_icon.dart';
import '../delete_icon.dart';
import '../../screens/edit_post.dart';

class IconsIsMe extends StatelessWidget {
  const IconsIsMe({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommentIcon(item: item),
        EditIcon(
          id: item.id,
          fontSize: 20,
          onEdited: () {
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
        ),
        DeleteIcon(
          idPost: item.id,
          fontSize: 20,
          onDeleted: () {
            BlocProvider.of<PostDeleteBloc>(context).add(PostDelete(item.id));
          },
        ),
      ],
    );
  }
}
