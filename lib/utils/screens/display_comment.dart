import 'package:flitter/services/get_comment/get_comment_bloc.dart';
import 'package:flitter/utils/screens/tile_post.dart';
import 'package:flitter/utils/voir_plus_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:random_avatar/random_avatar.dart';

import '../date_formater_get_timestamp.dart';

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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: ListView.separated(
                            separatorBuilder: (context, _) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: RandomAvatar(
                                  state.post!.comments[index].author.id
                                      .toString(),
                                  height: 30,
                                  width: 30,
                                ),
                                title: Text(
                                    state.post!.comments[index].author.name),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: VoirPlusString(
                                      content:
                                          state.post!.comments[index].content),
                                ),
                                trailing: DateFormatGetTimestamp(
                                    timestamp:
                                        state.post!.comments[index].createdAt,
                                    fontSize: 11),
                              );
                            },
                            itemCount: state.post!.comments.length,
                          ),
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
