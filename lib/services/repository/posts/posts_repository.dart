import 'package:flitter/models/get_post.dart';
import 'package:flitter/services/repository/posts/posts_data_source.dart';

import '../../../models/write_post.dart';

class PostsRepository {
  final PostsDataSource productsDataSource;

  PostsRepository({required this.productsDataSource});

  Future<GetPost> getAllProducts(int? page, int? perPage) async {
    return productsDataSource.getAllPosts(page, perPage);
  }

  Future<bool> createPost(WritePost writePost, String token) async {
    return productsDataSource.createPost(writePost, token);
  }

  Future<void> deletePost(String id, String token) async {
    return productsDataSource.deletePost(id, token);
  }
}
