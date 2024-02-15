class GetProfilePosts {
  final int itemsReceived;
  final int curPage;
  final int? nextPage;
  final int? prevPage;
  final int offset;
  final int itemsTotal;
  final int pageTotal;
  final List<ItemPostProfile> items;

  GetProfilePosts({
    required this.itemsReceived,
    required this.curPage,
    this.nextPage,
    this.prevPage,
    required this.offset,
    required this.itemsTotal,
    required this.pageTotal,
    required this.items,
  });

  factory GetProfilePosts.fromJson(Map<String, dynamic> json) {
    List<ItemPostProfile> itemsList = [];
    if (json['items'] != null) {
      var itemsArray = json['items'] as List;
      itemsList = itemsArray
          .map((item) => ItemPostProfile.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return GetProfilePosts(
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

class ItemPostProfile {
  final int id;
  final int createdAt;
  final String? content;
  final int userId;
  final ImagePostProfile? image;
  final int commentsCount;

  ItemPostProfile({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.userId,
    this.image,
    required this.commentsCount,
  });

  factory ItemPostProfile.fromJson(Map<String, dynamic> json) {
    return ItemPostProfile(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      userId: json['user_id'],
      image: json['image'] != null ? ImagePostProfile.fromJson(json['image']) : null,
      commentsCount: json['comments_count'],
    );
  }
}

class ImagePostProfile {
  final String url;

  ImagePostProfile({
    required this.url,
  });

  factory ImagePostProfile.fromJson(Map<String, dynamic> json) {
    return ImagePostProfile(
      url: json['url'],
    );
  }
}

