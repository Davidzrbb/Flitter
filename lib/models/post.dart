import 'package:flitter/models/comment.dart';
import 'package:flitter/models/get_post.dart';

class Post {
  final int id;
  final int createdAt;
  final String content;
  final Image? image;
  final Author author;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.image,
    required this.author,
    required this.comments,
  });

  //convert model post to model item

  Item toModelItem() {
    return Item(
        id: id,
        createdAt: createdAt,
        content: content,
        image: image,
        author: author,
        commentsCount: comments.length);
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      createdAt: json['created_at'] as int,
      content: json['content'] as String,
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      author: Author.fromJson(json['author']),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
