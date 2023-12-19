import 'package:flitter/models/get_profile.dart';
import 'package:flitter/utils/icons/comment_icon_profile.dart';
import 'package:flitter/utils/ui/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../models/get_profile_posts.dart';
import '../services/connexion/connexion_bloc.dart';
import '../services/profile_get/profile_get_bloc.dart';
import '../utils/icons/post/icons_is_me_post.dart';
import '../utils/icons/post/icons_is_me_profile_post.dart';
import '../utils/ui/tile_post.dart';
import '../utils/ui/tile_profile_post.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.state});

  final GoRouterState state;


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _getProfileByIdUser();
    _getProfilePostsByIdUser();
    _controller.addListener(() {
      if (_controller.offset == _controller.position.maxScrollExtent) {
        _getProfilePostsByIdUser();
      }
    });
    super.initState();
  }

  int get userId {
    final userIdString = widget.state.pathParameters['userId'];
    return userIdString != null
        ? int.parse(userIdString)
        : 0; // or another default value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: BlocBuilder<ProfileGetBloc, ProfileGetState>(
              builder: (context, state) {
                switch (state.statusProfileInfo) {
                  case GetProfileInfoStatus.initialInfo:
                    return const SizedBox();
                  case GetProfileInfoStatus.loadingInfo:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case GetProfileInfoStatus.errorInfo:
                    return Center(
                      child: Text(state.error.toString()),
                    );
                  case GetProfileInfoStatus.successInfo:
                    final GetProfile profile = state.profile!;
                    return ProfileHeader(
                      profile: profile,
                      postNumber: 0,
                    );
                }
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<ProfileGetBloc, ProfileGetState>(
              builder: (context, state) {
                switch (state.statusProfilePosts) {
                  case GetProfilePostsStatus.initialPosts:
                    return const SizedBox();
                  case GetProfilePostsStatus.loadingPosts:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case GetProfilePostsStatus.errorPosts:
                    return Center(
                      child: Text(state.error.toString()),
                    );
                  case GetProfilePostsStatus.successPosts:
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
                                TileProfilePost(
                                  item: item,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 8.0),
                                  child: BlocBuilder<ConnexionBloc, ConnexionState>(
                                    builder: (context, stateConnexion) {
                                      if (stateConnexion.user?.id == item.userId) {
                                        return IconsIsMeProfile(item: item);
                                      }
                                      return CommentIconProfile(
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
          ),
        ],
      ),
    );
  }

  _getProfileByIdUser() {
    final productsBloc = BlocProvider.of<ProfileGetBloc>(context);
    productsBloc.add(GetProfileInfo(userId));
  }

  _getProfilePostsByIdUser() {
    final productsBloc = BlocProvider.of<ProfileGetBloc>(context);
    productsBloc.add(GetProfileAllPosts(userId));
  }
}
