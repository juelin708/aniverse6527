class CommentDTO {
  int id;
  String username;
  int postId;
  String content;
  DateTime date;

  CommentDTO({
    required this.id,
    required this.username,
    required this.postId,
    required this.content,
    required this.date,
  });

  factory CommentDTO.fromJson(Map<String, dynamic> json) {
    return CommentDTO(
      id: json['id'],
      username: json['username'],
      postId: json['postId'],
      content: json['content'],
      date: DateTime.parse(json['date']),
    );
  }
}
