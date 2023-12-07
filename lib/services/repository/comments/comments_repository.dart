import 'package:flitter/services/repository/comments/comment_data_source.dart';

import '../../../models/post.dart';


class CommentsRepository {
  final CommentsDataSource commentsDataSource;

  CommentsRepository({required this.commentsDataSource});

  Future<Post> getAllComments(int postId, String token) async {
    return commentsDataSource.getAllComments(postId, token);
  }

  Future<void> deleteComment(int id, String token) async {
    return commentsDataSource.deleteComment(id, token);
  }

  Future<int> createComment(String comment, int postId, String token) async {
    return commentsDataSource.createComment(comment, postId, token);
  }
}
