import 'dart:async';

import 'package:flitter/models/get_post.dart';
import 'package:flitter/utils/ui/tile_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../services/connexion/connexion_bloc.dart';
import '../../services/post_get/post_get_bloc.dart';
import '../icons/comment_icon.dart';
import '../icons/post/icons_is_me_post.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _getAll();
    _controller.addListener(() {
      if (_controller.offset == _controller.position.maxScrollExtent) {
        _getAll();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: BlocBuilder<PostGetBloc, PostGetState>(
        builder: (context, state) {
          switch (state.status) {
            case PostGetStatus.initial:
              return const SizedBox();
            case PostGetStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostGetStatus.error:
              return Center(
                child: Text(state.error.toString()),
              );
            case PostGetStatus.success:
              if (state.items == null) {
                return const SizedBox();
              } else {
                return ListView.separated(
                  controller: _controller,
                  itemCount: state.items!.length + 1,
                  separatorBuilder: (context, index) {
                    if (state.items![index].content != '') {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                      );
                    } else {
                      // Retourne un conteneur vide si la condition n'est pas remplie
                      return const SizedBox();
                    }
                  },
                  itemBuilder: (context, index) {
                    if (index < state.items!.length) {
                      Item item = state.items![index];
                      if (item.content == '') {
                        return const SizedBox();
                      }
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
                          child: state.hasMore ?? false
                              ? const CircularProgressIndicator()
                              : const Text('Il n y a plus de posts !'),
                        ),
                      );
                    }
                  },
                );
              }
          }
        },
      ),
    );
  }

  Future<void> _refresh() async {
    final productsBloc = BlocProvider.of<PostGetBloc>(context);
    productsBloc.add(PostGetAll(refresh: true));
  }

  Future<void> _getAll() async {
    final productsBloc = BlocProvider.of<PostGetBloc>(context);
    productsBloc.add(PostGetAll());
  }
}
