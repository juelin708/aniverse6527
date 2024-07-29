import "package:aniverse/entity/comment_dto.dart";

class PostDTO {
  int id;
  String username;
  String animalname;
  String content;
  DateTime date;
  String? title;
  String? imageUrl;
  List<String>? likedBy;
  List<CommentDTO>? comments;
  int likeNum;
  int commentNum;

  PostDTO({
    required this.id,
    required this.username,
    required this.animalname,
    required this.content,
    required this.date,
    this.title,
    this.imageUrl,
    this.likedBy,
    this.comments,
    required this.likeNum,
    required this.commentNum,
  });

  factory PostDTO.fromJson(Map<String, dynamic> json) {
    return PostDTO(
      id: json['id'],
      username: json['username'],
      animalname: json['animalname'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      title: json['title'],
      imageUrl: json['imageUrl'],
      likedBy:
          json['likedBy'] != null ? List<String>.from(json['likedBy']) : null,
      comments: json['comments'] != null
          ? List<CommentDTO>.from(
              json['comments'].map((comment) => CommentDTO.fromJson(comment)))
          : null,
      likeNum: json['likeNum'],
      commentNum: json['commentNum'],
    );
  }
}
