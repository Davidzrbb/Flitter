import 'package:flitter/services/post_profile_get/post_profile_get_bloc.dart';
import 'package:flitter/utils/ui/profile_body.dart';
import 'package:flitter/utils/ui/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../models/get_post.dart';
import '../models/get_profile.dart';
import '../models/get_profile_posts.dart';
import '../services/connexion/connexion_bloc.dart';
import '../services/profile_get/profile_get_bloc.dart';
import '../utils/icons/comment_icon.dart';
import '../utils/icons/post/icons_is_me_post.dart';
import '../utils/ui/tile_post.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.state});

  final GoRouterState state;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    _getProfileByIdUser();
    _getProfilePostsByIdUser();

    super.initState();
  }

  int get userId {
    final userIdString = widget.state.pathParameters['userId'];
    return userIdString != null
        ? int.parse(userIdString)
        : 0; // or another default value
  }

  bool refresh = false;
  int postNumber = 0;

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
                switch (state.status) {
                  case ProfileGetStatus.initial:
                    return const SizedBox();
                  case ProfileGetStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ProfileGetStatus.error:
                    return Center(
                      child: Text(state.error.toString()),
                    );
                  case ProfileGetStatus.success:
                    final GetProfile profile = state.profile!;
                    if (postNumber == 0) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ProfileHeader(
                      profile: profile,
                      postNumber: postNumber,
                    );
                }
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: RefreshIndicator(
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
                          _changePostNumber(state.itemsTotal);
                          postNumber = state.itemsTotal;
                        }
                        return ProfileBody(
                          items: state.items!,
                          hasMore: state.hasMore!,
                        );
                      }
                  }
                },
              ),
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
    final productsBloc = BlocProvider.of<PostProfileGetBloc>(context);
    productsBloc.add(GetProfileAllPosts(userId, refresh));
    refresh = true;
  }

  SchedulerBinding? get scheduler => SchedulerBinding.instance;

  _changePostNumber(int number) {
    scheduler!.addPostFrameCallback((_) {
      setState(() {
        postNumber = number;
      });
    });
  }

  Future<void> _refresh() async {
    final productsBloc = BlocProvider.of<PostProfileGetBloc>(context);
    productsBloc.add(GetProfileAllPosts(userId, true));
  }
}
