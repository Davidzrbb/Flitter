import 'get_post.dart';

class Comment {
  final int id;
  final int createdAt;
  final String content;
  final String?
      image; // Il semble que "image" puisse être null d'après votre exemple
  final Author author;

  Comment({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.image,
    required this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      createdAt: json['created_at'] as int,
      content: json['content'] as String,
      image: json['image'] as String?,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
    );
  }
}
