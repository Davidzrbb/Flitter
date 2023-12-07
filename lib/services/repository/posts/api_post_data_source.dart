import 'package:dio/dio.dart';
import 'package:flitter/models/write_post.dart';
import 'package:flitter/services/repository/posts/posts_data_source.dart';

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

  @override
  Future<bool> createPost(WritePost writePost, String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    FormData formData;

    if (writePost.imageBase64 != null) {
      String fileName = 'image.png';
      formData = FormData.fromMap({
        'base_64_image': await MultipartFile.fromFile(
          writePost.imageBase64!.path,
          filename: fileName,
        ),
        'content': writePost.content,
      });
    } else {
      formData = FormData.fromMap({
        'content': writePost.content,
      });
    }

    await dio
        .post(
          '/post',
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
              "Authorization": "Bearer $token",
            },
          ),
        )
        .catchError((error) => throw Exception(error));
    return true;
  }

  @override
  Future<void> deletePost(String id, String token) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );
    await dio.delete(
      '/post/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<bool> patchPost(WritePost writePost, String token, int id) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    FormData formData;

    if (writePost.imageBase64 != null) {
      String fileName = 'image.png';
      formData = FormData.fromMap({
        'base_64_image': await MultipartFile.fromFile(
          writePost.imageBase64!.path,
          filename: fileName,
        ),
        'content': writePost.content,
      });
    } else {
      formData = FormData.fromMap({
        'content': writePost.content,
      });
    }

    await dio
        .patch(
          '/post/$id',
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
              "Authorization": "Bearer $token",
            },
          ),
        )
        .catchError((error) => throw Exception(error));
    return true;
  }
}
