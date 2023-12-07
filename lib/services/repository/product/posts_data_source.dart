import 'package:flitter/models/get_post.dart';

abstract class PostsDataSource {
  Future<GetPost> getAllPosts(int? page, int? perPage);
}
