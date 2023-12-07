import 'package:flitter/models/post.dart';

import '../../../models/patch_comment.dart';

abstract class CommentsDataSource {
  Future<Post> getAllComments(int postId, String token);

  Future<int> createComment(String comment, int postId, String token);

  Future<void> deleteComment(int id, String token);

  Future<int> patchComment(CommentPatchModel commentPatchModel, String token);
}
