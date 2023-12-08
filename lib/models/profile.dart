
class Profile {
  final int id;

  Profile({
    required this.id
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      return Profile(id: json['id']);
    }
    
    return Profile(id: -1);

    
  }
}

class Item {
  final int id;
  final int createdAt;
  final String? content;
  final Image? image;
  final Author author;
  final int commentsCount;

  Item({
    required this.id,
    required this.createdAt,
    required this.content,
    this.image,
    required this.author,
    required this.commentsCount,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      author: Author.fromJson(json['author']),
      commentsCount: json['comments_count'],
    );
  }
}

class Image {
  final String url;

  Image({
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
    );
  }
}

class Author {
  final int id;
  final int createdAt;
  final String name;

  Author({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      createdAt: json['created_at'],
      name: json['name'],
    );
  }
}
