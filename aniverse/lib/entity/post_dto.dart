import "package:aniverse/entity/CommentDTO.dart";

class PostDTO {
  int id;
  String username;
  String animalname;
  String content;
  String date;
  String title;
  String imageUrl;
  List<String> likedBy;
  List<CommentDTO> comments;
  int likeNum;
  int commentNum;

  PostDTO({
    required this.id,
    required this.username,
    required this.animalname,
    required this.content,
    required this.date,
    required this.title,
    required this.imageUrl,
    required this.likedBy,
    required this.comments,
    required this.likeNum,
    required this.commentNum,
  });

  factory PostDTO.fromJson(Map<String, dynamic> json) {
    return PostDTO(
      id: json['id'],
      username: json['username'],
      animalname: json['animalname'],
      content: json['content'],
      date: json['date'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      likedBy: List<String>.from(json['likedBy']),
      comments: List<CommentDTO>.from(json['comments']),
      likeNum: json['likeNum'],
      commentNum: json['commentNum'],
    );
  }
}
