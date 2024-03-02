class TweetModel {
  String id;
  String title;
  String description;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  TweetModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TweetModel.fromJson(Map<String, dynamic> json) => TweetModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

final List<TweetModel> dummyData = [];
