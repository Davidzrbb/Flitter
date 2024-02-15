import 'package:flitter/models/get_post.dart';
import 'package:flitter/services/post_profile_get/post_profile_get_bloc.dart';
import 'package:flitter/utils/ui/tile_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../services/connexion/connexion_bloc.dart';
import '../icons/comment_icon.dart';
import '../icons/post/icons_is_me_post.dart';

class ProfileBody extends StatefulWidget {
  //const ProfileBody({super.key, required this.items ,required this.hasMore});
  const ProfileBody({super.key, required this.idUser});

  final int idUser;

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  int postNumber = 0;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _getAll();
    _controller.addListener(() {
      if (_controller.offset == _controller.position.maxScrollExtent) {
        //_getAll();
        _getUpdateList();
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
      child: BlocBuilder<PostProfileGetBloc, PostProfileGetState>(
        builder: (context, state) {
          switch (state.status) {
            case PostProfileGetStatus.initial:
              return const SizedBox();
            case PostProfileGetStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostProfileGetStatus.error:
              return Center(
                child: Text(state.error.toString()),
              );
            case PostProfileGetStatus.success:
              if (state.items == null) {
                return const SizedBox();
              } else {
                if (postNumber != state.itemsTotal) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _changePostNumber(state.itemsTotal);
                  });
                  //postNumber = state.itemsTotal;
                }

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
                          child: state.hasMore!
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
    print('refresh !');
    final productsBloc = BlocProvider.of<PostProfileGetBloc>(context);
    productsBloc.add(GetProfileAllPosts(widget.idUser, true));
  }

  _changePostNumber(int number) {
    setState(() {
      postNumber = number;
    });
  }

  Future<void> _getAll() async {
    final productsBloc = BlocProvider.of<PostProfileGetBloc>(context);
    productsBloc.add(GetProfileAllPosts(widget.idUser, false));
  }

  Future<void> _getUpdateList() async {
    final productsBloc = BlocProvider.of<PostProfileGetBloc>(context);
    productsBloc.add(GetProfileAllPosts(widget.idUser, true));
  }
}
