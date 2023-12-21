import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flitter/models/get_profile.dart';
import 'package:flitter/models/get_profile_posts.dart';
import 'package:flitter/services/repository/profile/profile_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../models/get_post.dart';


part 'post_profile_get_event.dart';

part 'post_profile_get_state.dart';


class PostProfileGetBloc extends Bloc<PostProfileGetEvent, PostProfileGetState> {

  final ProfileRepository profileRepository;

  PostProfileGetBloc({required this.profileRepository}) : super(PostProfileGetState()) {
    on<GetProfileAllPosts>(_getProfilePosts);
  }

  _getProfilePosts(GetProfileAllPosts event, Emitter<PostProfileGetState> emit) async {
    try {
      int page = 1;
      List<Item> allItem = [];
      GetPost getPost;
      GetProfilePosts profilePosts;
      print("test");
      if (!event.refresh) {
        print("test1");
        emit(state.copyWith(status: PostProfileGetStatus.loading));
        profilePosts = await profileRepository.doGetProfilePosts(event.userId, page, state.perPage);
        getPost = GetPost.fromGetPostProfile(profilePosts);
        allItem = getPost.items;
      } else {
        print("test2");
        page = state.page != null ? state.page! + 1 : page;
        profilePosts = await profileRepository.doGetProfilePosts(event.userId, page, state.perPage);
        getPost = GetPost.fromGetPostProfile(profilePosts);
        allItem = state.items ?? [];
        allItem.addAll(getPost.items
            .where((item) => !allItem.any((element) => element.id == item.id)));
      }

      bool hasMore = getPost.nextPage != null;

      emit(state.copyWith(
        status: PostProfileGetStatus.success,
        profilePosts: getPost,
        items: allItem,
        page: page,
        perPage: state.perPage,
        hasMore: hasMore,
        itemsTotal: profilePosts.itemsTotal,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostProfileGetStatus.error,
        error: error,
      ));
    }
  }

}
