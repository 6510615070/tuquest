class Post {
  final String id;
  final String topic;
  final String detail;
  final String imageUrl;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.topic,
    required this.detail,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      topic: json['topic'],
      detail: json['detail'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
