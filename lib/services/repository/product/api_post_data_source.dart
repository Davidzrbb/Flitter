import 'package:dio/dio.dart';
import 'package:flitter/services/repository/product/posts_data_source.dart';

import '../../../models/get_post.dart';

class ApiPostDataSource extends PostsDataSource {
  @override
  Future<GetPost> getAllPosts(int? page, int? perPage) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );
    final response = await dio.get(
      '/post',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );
    return GetPost.fromJson(response.data as Map<String, dynamic>);
  }
}
