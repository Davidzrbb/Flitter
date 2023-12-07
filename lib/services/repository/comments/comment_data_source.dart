import 'package:flitter/models/post.dart';

abstract class CommentsDataSource {
  Future<Post> getAllComments(int postId, String token);

  createComment(String comment, int postId, String token);

  Future<void> deleteComment(int id, String token);
// Future<bool> patchComment(WriteComment writeComment, String token, int id);
}
