import 'dart:ffi';

import 'package:flitter/services/post_profile_get/post_profile_get_bloc.dart';
import 'package:flitter/utils/ui/profile_body.dart';
import 'package:flitter/utils/ui/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../models/get_profile.dart';
import '../services/profile_get/profile_get_bloc.dart';

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
                    return BlocBuilder<PostProfileGetBloc, PostProfileGetState>(
                      builder: (context, postState) {
                        return ProfileHeader(
                          profile: profile,
                          postNumber: postState.itemsTotal,
                        );
                      },
                    );
                }
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: ProfileBody(
              idUser: userId,
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
}
