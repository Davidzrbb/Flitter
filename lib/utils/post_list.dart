import 'dart:async';

import 'package:flitter/models/get_post.dart';
import 'package:flitter/services/connexion_bloc/connexion_bloc.dart';
import 'package:flitter/utils/edit_post.dart';
import 'package:flitter/utils/tile_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/post_get_bloc/post_get_bloc.dart';
import 'delete_post_icon.dart';

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
                  separatorBuilder: (context, _) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    if (index < state.items!.length) {
                      Item item = state.items![index];
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
                                Widget commentIcon = const Icon(
                                  Icons.comment_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                );

                                if (stateConnexion.user?.id == item.author.id) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      commentIcon,
                                      FloatingActionButton(
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
                                return commentIcon;
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
