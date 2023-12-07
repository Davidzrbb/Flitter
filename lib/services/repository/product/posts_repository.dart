import 'package:flitter/models/get_post.dart';
import 'package:flitter/services/repository/product/posts_data_source.dart';

class PostsRepository {
  final PostsDataSource productsDataSource;

  PostsRepository({required this.productsDataSource});

  Future<GetPost> getAllProducts(int? page, int? perPage) async {
    return productsDataSource.getAllPosts(page, perPage);
  }
}
