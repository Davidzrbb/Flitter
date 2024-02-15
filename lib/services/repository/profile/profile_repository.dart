import 'package:flitter/services/repository/profile/profile_data_source.dart';
import '../../../models/get_profile.dart';
import '../../../models/get_profile_posts.dart';

class ProfileRepository {
  final ProfileDataSource profileDataSource;

  ProfileRepository({required this.profileDataSource});

  Future<GetProfile> doGetProfile(int userId) async {
    return profileDataSource.doGetProfile(userId);
  }

  Future<GetProfilePosts> doGetProfilePosts(int userId, int page, int perPage) async {
    return profileDataSource.doGetProfilePosts(userId, page, perPage);
  }


}
