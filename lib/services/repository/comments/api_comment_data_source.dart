import 'package:dio/dio.dart';
import 'package:flitter/models/post.dart';
import 'package:flitter/services/repository/comments/comment_data_source.dart';

class ApiCommentDataSource extends CommentsDataSource {
  @override
  Future<Post> getAllComments(int postId, String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );
    final response = await dio.get(
      '/post/$postId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return Post.fromJson(response.data as Map<String, dynamic>);
  }
}
