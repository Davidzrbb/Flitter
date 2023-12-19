part of 'profile_get_bloc.dart';

enum GetProfileInfoStatus {
  initialInfo,
  loadingInfo,
  successInfo,
  errorInfo,
}

enum GetProfilePostsStatus {
  initialPosts,
  loadingPosts,
  successPosts,
  errorPosts,
}

final class ProfileGetState {
  final GetProfileInfoStatus statusProfileInfo;
  final GetProfilePostsStatus statusProfilePosts;
  final GetProfile? profile;
  final GetProfilePosts? profilePosts;
  final Object? error;
  final List<Item>? items;
  final int? page;
  final int perPage;
  final bool? hasMore;

  ProfileGetState({
    this.statusProfileInfo = GetProfileInfoStatus.initialInfo,
    this.statusProfilePosts = GetProfilePostsStatus.initialPosts,
    this.profile,
    this.profilePosts,
    this.error,
    this.items,
    this.page,
    this.perPage = 12,
    this.hasMore = true,
  });

  ProfileGetState copyWith({
    GetProfileInfoStatus? statusInfo,
    GetProfilePostsStatus? statusPosts,
    GetProfile? profile,
    GetProfilePosts? profilePosts,
    Object? error,
    List<Item>? items,
    int? page,
    int? perPage,
    bool? hasMore,
  }) {
    return ProfileGetState(
      statusProfileInfo: statusInfo ?? this.statusProfileInfo,
      statusProfilePosts: statusPosts ?? this.statusProfilePosts,
      profile: profile ?? this.profile,
      profilePosts: profilePosts ?? this.profilePosts,
      error: error ?? this.error,
      items: items ?? this.items,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
