class Post {

  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  // Factory constructor to create a Post from JSON
  factory Post.fromJson(dynamic json) {
    return Post(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
    );
  }
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  // Method to convert a Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
