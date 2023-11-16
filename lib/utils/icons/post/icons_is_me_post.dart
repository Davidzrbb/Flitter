import 'package:flitter/utils/icons/comment_icon.dart';
import 'package:flitter/utils/ui/floating_action_button_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../models/get_post.dart';
import '../../../models/write_post.dart';
import '../../../services/post_create/post_bloc.dart';
import '../../../services/post_delete/post_delete_bloc.dart';
import '../../../services/post_patch/post_patch_bloc.dart';
import '../edit_icon.dart';
import '../delete_icon.dart';

class IconsIsMe extends StatelessWidget {
  const IconsIsMe({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommentIcon(
            item: item,
            onTap: () {
              context.pushNamed('display_comment', pathParameters: {
                'postId': item.id.toString(),
              });
            }),
        EditIcon(
          id: item.id,
          fontSize: 20,
          onEdited: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                  return FloatingActionButtonScreen(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<PostPatchBloc>(context).add(
                          PostPatch(
                              WritePost(
                                content: textFieldController.text,
                                imageBase64: state.imageBase64 != null
                                    ? state.imageBase64!.path.contains(
                                            'https://xoc1-kd2t-7p9b.n7c.xano.io')
                                        ? null
                                        : state.imageBase64
                                    : null,
                              ),
                              item.id),
                        );
                      }
                    },
                    url: item.image?.url,
                    content: item.content,
                    imagePicker: true,
                  );
                });
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
