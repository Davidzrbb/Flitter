class User {
  final int? id;
  final String? name;
  final String? email;
  final int? createdAt;


  const User({
    this.id,
    this.name,
    this.email,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: json['created_at'],
    );
  }
}
