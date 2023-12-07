import 'package:flitter/models/get_post.dart';

import '../../../models/write_post.dart';

abstract class PostsDataSource {
  Future<GetPost> getAllPosts(int? page, int? perPage);

  Future<bool> createPost(WritePost writePost, String token);

  Future<void> deletePost(String id, String token);
}
