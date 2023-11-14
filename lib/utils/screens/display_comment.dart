import 'package:flitter/services/get_comment/get_comment_bloc.dart';
import 'package:flitter/utils/icons/comment/edit_comment_icon.dart';
import 'package:flitter/utils/screens/tile_comment.dart';
import 'package:flitter/utils/screens/tile_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../icons/comment/delete_comment_icon.dart';

class DisplayComment extends StatefulWidget {
  const DisplayComment({super.key, required this.state});

  final GoRouterState state;

  @override
  State<DisplayComment> createState() => _DisplayCommentState();
}

class _DisplayCommentState extends State<DisplayComment> {
  @override
  void initState() {
    _getCommentByIdPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Comment'),
      ),
      body: BlocBuilder<GetCommentBloc, GetCommentState>(
        builder: (context, state) {
          switch (state.status) {
            case GetCommentStatus.initial:
              return const SizedBox();
            case GetCommentStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case GetCommentStatus.error:
              return Center(
                child: Text(state.error.toString()),
              );
            case GetCommentStatus.success:
              if (state.post != null) {
                if (state.post!.comments.isEmpty) {
                  return const Center(
                    child: Text('Pas de commentaire ...'),
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TilePost(
                          item: state.post!.toModelItem(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListView.separated(
                          itemCount: state.post!.comments.length,
                          separatorBuilder: (context, _) => Container(
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                TileComment(
                                  comment: state.post!.comments[index],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    EditCommentIcon(
                                      comment: state.post!.comments[index],
                                    ),
                                    DeleteCommentIcon(
                                      id: state.post!.comments[index].id,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              } else {
                return const Center(
                  child: Text('Erreur avec le post ...'),
                );
              }
          }
        },
      ),
    );
  }

  _getCommentByIdPost() {
    final postId = widget.state.pathParameters['postId'];
    if (postId != null) {
      final productsBloc = BlocProvider.of<GetCommentBloc>(context);
      productsBloc.add(GetComment(int.parse(postId)));
    }
  }
}
