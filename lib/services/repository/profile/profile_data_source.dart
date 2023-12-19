import 'package:flitter/models/get_post.dart';

import '../../../models/get_profile.dart';
import '../../../models/get_profile_posts.dart';
import '../../../models/write_post.dart';

abstract class ProfileDataSource {
  Future<GetProfile> doGetProfile(int userId);

  Future<GetProfilePosts> doGetProfilePosts(int userId, int page, int perPage);

}
