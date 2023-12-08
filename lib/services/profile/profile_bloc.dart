import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../models/profile.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<GetProfile>(_getProfile);
  }

  _getProfile(GetProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(
        status: ProfileStatus.loading,
      ));
      Profile profile = await _doGetProfile(event.userId);
      emit(state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        error: error,
      ));
    }
  }

  Future<Profile> _doGetProfile(int userId) async {
    final dio = Dio(BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi'));

    final response = await dio.get(
      '/user/$userId',
    );

    return Profile.fromJson(response.data as Map<String, dynamic>);
  }
}
