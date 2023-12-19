import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flitter/models/get_profile.dart';
import 'package:flitter/services/repository/profile/profile_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../models/get_profile_posts.dart';

part 'profile_get_event.dart';

part 'profile_get_state.dart';


class ProfileGetBloc extends Bloc<ProfileGetEvent, ProfileGetState> {

  final ProfileRepository profileRepository;

  ProfileGetBloc({required this.profileRepository}) : super(ProfileGetState()) {
    on<GetProfileInfo>(_getProfileInfo);
    on<GetProfileAllPosts>(_getProfilePosts);
  }

  _getProfileInfo(GetProfileInfo event, Emitter<ProfileGetState> emit) async {
    try {
      emit(state.copyWith(
        statusInfo: GetProfileInfoStatus.loadingInfo,
      ));
      GetProfile profile = await profileRepository.doGetProfile(event.userId);
      emit(state.copyWith(
        statusInfo: GetProfileInfoStatus.successInfo,
        profile: profile,
      ));
    } catch (error) {
      emit(state.copyWith(
        statusInfo: GetProfileInfoStatus.errorInfo,
        error: error,
      ));
    }
  }

  _getProfilePosts(GetProfileAllPosts event, Emitter<ProfileGetState> emit) async {
    try {
      int page = 1;
      GetProfilePosts posts;
      List<Item> allItem = [];

      if (event.refresh) {
        emit(state.copyWith(statusPosts: GetProfilePostsStatus.loadingPosts));
        posts = await profileRepository.doGetProfilePosts(event.userId, page, state.perPage);
        allItem = posts.items;
      } else {
        page = state.page != null ? state.page! + 1 : page;
        posts = await profileRepository.doGetProfilePosts(event.userId, page, state.perPage);
        allItem = state.items ?? [];
        allItem.addAll(posts.items
            .where((item) => !allItem.any((element) => element.id == item.id)));
      }

      bool hasMore = posts.nextPage != null;

      emit(state.copyWith(
        statusPosts: GetProfilePostsStatus.successPosts,
        profilePosts: posts,
        items: allItem,
        page: page,
        perPage: state.perPage,
        hasMore: hasMore,
      ));
    } catch (error) {
      emit(state.copyWith(
        statusPosts: GetProfilePostsStatus.errorPosts,
        error: error,
      ));
    }
  }


}
