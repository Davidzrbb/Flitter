import 'package:bloc/bloc.dart';
import 'package:flitter/models/get_profile.dart';
import 'package:flitter/services/repository/profile/profile_repository.dart';
import 'package:meta/meta.dart';
part 'profile_get_event.dart';
part 'profile_get_state.dart';


class ProfileGetBloc extends Bloc<ProfileGetEvent, ProfileGetState> {

  final ProfileRepository profileRepository;

  ProfileGetBloc({required this.profileRepository}) : super(ProfileGetState()) {
    on<GetProfileInfo>(_getProfileInfo);
  }

  _getProfileInfo(GetProfileInfo event, Emitter<ProfileGetState> emit) async {
    try {
      emit(state.copyWith(
        status: ProfileGetStatus.loading,
      ));
      GetProfile profile = await profileRepository.doGetProfile(event.userId);
      emit(state.copyWith(
        status: ProfileGetStatus.success,
        profile: profile,
      ));

    } catch (error) {
      emit(state.copyWith(
        status: ProfileGetStatus.error,
        error: error,
      ));
    }
  }



}
