import 'package:dio/dio.dart';
import 'package:flitter/services/repository/profile/profile_data_source.dart';
import '../../../models/get_profile.dart';
import '../../../models/get_profile_posts.dart';

class ApiProfileDataSource extends ProfileDataSource {
  @override
  Future<GetProfile> doGetProfile(int userId) async {
    final dio = Dio(BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi'));

    final response = await dio.get(
      '/user/$userId',
    );

    return GetProfile.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<GetProfilePosts> doGetProfilePosts(int userId, int page, int perPage) async {
    final dio = Dio(BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi'));

    final response = await dio.get(
      '/user/$userId/posts?page=$page&per_page=$perPage',
    );

    return GetProfilePosts.fromJson(response.data as Map<String, dynamic>);
  }
}
