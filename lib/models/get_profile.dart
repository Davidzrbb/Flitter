
class GetProfile {
  final int id;
  final int createdAt;
  final String name;

  GetProfile({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  factory GetProfile.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      return GetProfile(id: json['id'], createdAt: json['created_at'], name: json['name']);
    }

    return GetProfile(id: -1, createdAt: -1, name: '');


  }
}

