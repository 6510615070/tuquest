class Post {
  final String id;
  final String topic;
  final String detail;
  final String imageUrl;
  final bool? isNetworkImage;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.topic,
    required this.detail,
    required this.imageUrl,
    this.isNetworkImage,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      topic: json['topic'],
      detail: json['detail'],
      //imageUrl: json['imageUrl'],
      imageUrl: json['imageUrl'] ?? '',
      isNetworkImage: json['isNetworkImage'] ?? true, // default เป็น true
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
