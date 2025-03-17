class User {
  final String? id;
  final String name;
  final String username;
  final bool isVerified;
  final String? profilePicture;

  User(
      {this.id,
      required this.name,
      this.isVerified = false,
      required this.username,
      this.profilePicture});

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    return User(
      id: documentId,
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      isVerified: data['isVerified'] ?? false,
      profilePicture: data['profilePicture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'isVerified': isVerified,
      'profilePicture': profilePicture,
    };
  }
}
