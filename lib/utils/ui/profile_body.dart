import 'package:flitter/models/get_post.dart';
import 'package:flitter/models/get_profile.dart';
import 'package:flitter/services/post_profile_get/post_profile_get_bloc.dart';
import 'package:flitter/utils/date_formater_get_timestamp.dart';
import 'package:flitter/utils/shimmer_image_url.dart';
import 'package:flitter/utils/ui/tile_post.dart';
import 'package:flitter/utils/voir_plus_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:random_avatar/random_avatar.dart';
import 'dart:math' as math;

import '../../services/connexion/connexion_bloc.dart';
import '../icons/comment_icon.dart';
import '../icons/post/icons_is_me_post.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.items ,required this.hasMore});

  final List<Item> items;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: items.length + 1,
      separatorBuilder: (context, _) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
      ),
      itemBuilder: (context, index) {
        if (index < items.length) {
          Item item = items[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TilePost(
                item: item,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 8.0),
                child: BlocBuilder<ConnexionBloc, ConnexionState>(
                  builder: (context, stateConnexion) {
                    if (stateConnexion.user?.id == item.author.id) {
                      return IconsIsMe(item: item);
                    }
                    return CommentIcon(
                        item: item,
                        onTap: () {
                          context.pushNamed('display_comment',
                              pathParameters: {
                                'postId': item.id.toString(),
                              });
                        });
                  },
                ),
              ),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Center(
              child: hasMore
                  ? const CircularProgressIndicator()
                  : const Text('Il n y a plus de posts !'),
            ),
          );
        }
      },
    );
  }


}
