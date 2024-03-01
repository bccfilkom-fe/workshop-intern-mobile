class User {
  final String token;
  final int userId;

  User({required this.token, required this.userId});

  Map<String, dynamic> toMap() {
    return {'token': token, 'userId': userId};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(token: map['token'], userId: map['userId']);
  }
}
