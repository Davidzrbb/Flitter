import 'package:dio/dio.dart';
import 'package:flitter/models/patch_comment.dart';
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

  @override
  Future<void> deleteComment(int id, String token) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    return dio
        .delete(
          '/comment/$id',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          ),
        )
        .then((value) => true);
  }

  @override
  Future<int> createComment(String comment, int postId, String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );
    Map<String, dynamic> data = {
      'content': comment,
      'post_id': postId,
    };
    Response<dynamic> response = await dio
        .post(
          '/comment',
          data: data,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          ),
        )
        .catchError((error) => throw error.response.data['message']);

    return response.data['post_id'];
  }

  @override
  Future<int> patchComment(
      CommentPatchModel commentPatchModel, String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    Map<String, dynamic> data = {
      'content': commentPatchModel.comment,
    };
    Response<dynamic> response = await dio
        .patch(
          '/comment/${commentPatchModel.id}',
          data: data,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
          ),
        )
        .catchError((error) => throw error.response.data['message']);
    return response.data['post_id'];
  }
}
