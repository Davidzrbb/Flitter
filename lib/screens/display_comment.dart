import 'package:flitter/services/get_comment/get_comment_bloc.dart';
import 'package:flitter/utils/ui/tile_comment.dart';
import 'package:flitter/utils/ui/tile_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../services/comment_post/comment_post_bloc.dart';
import '../services/connexion/connexion_bloc.dart';
import '../utils/icons/comment/icons_is_me_comment.dart';
import '../utils/ui/floating_action_button_screen.dart';

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

  int get postId {
    final postIdString = widget.state.pathParameters['postId'];
    return postIdString != null
        ? int.parse(postIdString)
        : 0; // or another default value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Comment'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: FloatingActionButton(
          heroTag: 'addComment',
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return FloatingActionButtonScreen(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final postBloc =
                          BlocProvider.of<CommentPostBloc>(context);
                      postBloc.add(CommentPostSubmitted(
                        comment: textFieldController.text,
                        postId: postId,
                      ));
                    }
                  },
                  url: null,
                  content: null,
                );
              },
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.comment_outlined),
        ),
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
                                BlocBuilder<ConnexionBloc, ConnexionState>(
                                  builder: (context, stateConnexion) {
                                    if (stateConnexion.user?.id ==
                                        state.post!.comments[index].author.id) {
                                      return IconIsMeComment(
                                        comment: state.post!.comments[index],
                                        postId: postId,
                                      );
                                    }
                                    return const SizedBox();
                                  },
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
    final productsBloc = BlocProvider.of<GetCommentBloc>(context);
    productsBloc.add(GetComment(postId));
  }
}
