import 'package:flitter/services/post_get/post_get_bloc.dart';
import 'package:flitter/services/profile_get/profile_get_bloc.dart';
import 'package:flitter/utils/ui/floating_action_button_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../models/get_profile_posts.dart';
import '../../../models/write_post.dart';
import '../../../services/post_create/post_bloc.dart';
import '../../../services/post_delete/post_delete_bloc.dart';
import '../../../services/post_patch/post_patch_bloc.dart';
import '../comment_icon_profile.dart';
import '../edit_icon.dart';
import '../delete_icon.dart';

class IconsIsMeProfile extends StatelessWidget {
  const IconsIsMeProfile({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommentIconProfile(
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
        BlocListener<PostDeleteBloc, PostDeleteState>(
          listener: (context, state) {
            if (state.status == PostDeleteStatus.success) {
              BlocProvider.of<PostGetBloc>(context)
                  .add(PostGetAll(refresh: true));
              Navigator.of(context).pop();
            }
          },
          child: DeleteIcon(
            fontSize: 20,
            onDeleted: () {
              BlocProvider.of<PostDeleteBloc>(context).add(PostDelete(item.id));
            },
          ),
        ),
      ],
    );
  }
}
