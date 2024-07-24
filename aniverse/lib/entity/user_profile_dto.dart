class UserProfileDTO {
  String username;
  String? avatarUrl;
  String? bio;
  List<String>? followings;
  List<String>? fans;
  int postNum;
  int fanNum;
  int followingNum;
  int id;
  int likedPostNum;

  UserProfileDTO({
    required this.username,
    this.avatarUrl,
    this.bio,
    this.followings,
    this.fans,
    required this.fanNum,
    required this.followingNum,
    required this.id,
    required this.postNum,
    required this.likedPostNum,
  });

  factory UserProfileDTO.fromJson(Map<String, dynamic> json) {
    return UserProfileDTO(
      username: json['username'],
      avatarUrl: json['avatarUrl'],
      bio: json['bio'],
      followings: List<String>.from(json['followings']),
      fans: List<String>.from(json['fans']),
      postNum: json['postNum'],
      fanNum: json['fanNum'],
      followingNum: json['followingNum'],
      id: json['id'],
      likedPostNum: json['likedPostNum'],
    );
  }
}
