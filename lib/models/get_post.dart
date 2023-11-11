class GetPost {
  final int itemsReceived;
  final int curPage;
  final int? nextPage;
  final int? prevPage;
  final int offset;
  final int itemsTotal;
  final int pageTotal;
  final List<Item> items;

  GetPost({
    required this.itemsReceived,
    required this.curPage,
    this.nextPage,
    this.prevPage,
    required this.offset,
    required this.itemsTotal,
    required this.pageTotal,
    required this.items,
  });

  factory GetPost.fromJson(Map<String, dynamic> json) {
    List<Item> itemsList = [];

    if (json['items'] != null) {
      var itemsArray = json['items'] as List;
      itemsList = itemsArray
          .map((item) => Item.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return GetPost(
      itemsReceived: json['itemsReceived'],
      curPage: json['curPage'],
      nextPage: json['nextPage'],
      prevPage: json['prevPage'],
      offset: json['offset'],
      itemsTotal: json['itemsTotal'],
      pageTotal: json['pageTotal'],
      items: itemsList,
    );
  }
}

class Item {
  final int id;
  final int createdAt;
  final String content;
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
      url: json['url'] ?? '',
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
