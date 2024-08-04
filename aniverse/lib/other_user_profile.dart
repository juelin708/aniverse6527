import 'package:aniverse/profile_list.dart';
import 'package:flutter/material.dart';
import 'package:aniverse/entity/user_profile_dto.dart';
import 'package:aniverse/service/profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aniverse/config.dart';

class OtherProfilePage extends StatefulWidget {
  final String username;

  const OtherProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  late Future<UserProfileDTO> _otherProfileFuture;
  int? currentUserId;
  int? otherUserId;
  int? isFollowing;

  @override
  void initState() {
    super.initState();
    _otherProfileFuture =
        ProfileService().getUserProfileByName(widget.username);
    _initializeProfileData();
  }

  Future<void> _initializeProfileData() async {
    currentUserId = await _getCurrentUserID();
    _otherProfileFuture =
        ProfileService().getUserProfileByName(widget.username);
    final otherProfile = await _otherProfileFuture;
    otherUserId = otherProfile.id;
    isFollowing =
        await ProfileService().isFollowing(currentUserId!, otherUserId!);
    setState(() {});
  }

  Future<int?> _getCurrentUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentUserId');
  }

  Future<void> _followAUser() async {
    final _current = currentUserId!;
    final _other = otherUserId!;
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/auth/$_current/follow/$_other'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200 && responseJson['success'] == true) {
      setState(() {
        isFollowing = 1;
        _otherProfileFuture =
            ProfileService().getUserProfileByName(widget.username);
      });
    } else {
      final snackBar = SnackBar(content: Text(responseJson['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _unfollow() async {
    final _current = currentUserId!;
    final _other = otherUserId!;
    final response = await http.delete(
      Uri.parse('${Config.baseUrl}/auth/$_current/unfollow/$_other'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200 && responseJson['success'] == true) {
      setState(() {
        isFollowing = 0;
        _otherProfileFuture =
            ProfileService().getUserProfileByName(widget.username);
      });
    } else {
      final snackBar = SnackBar(content: Text(responseJson['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: FutureBuilder<UserProfileDTO>(
          future: _otherProfileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final userProfile = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      userProfile.avatarUrl ?? 'assets/logo.png',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    userProfile.username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    userProfile.bio ?? "bio",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (isFollowing == 1) {
                          _unfollow();
                        } else {
                          _followAUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isFollowing == 1 ? Colors.grey : Colors.tealAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(isFollowing == 1 ? 'Unfollow' : 'Follow'),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        _buildProfileItem(
                          icon: Icons.person,
                          context: context,
                          title: 'Following',
                          subtitle: userProfile.followingNum.toString(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FollowingPage(userId: userProfile.id),
                              ),
                            );
                          },
                        ),
                        _buildProfileItem(
                          icon: Icons.people,
                          context: context,
                          title: 'Followers',
                          subtitle: userProfile.fanNum.toString(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FollowerPage(userId: userProfile.id),
                              ),
                            );
                          },
                        ),
                        _buildProfileItem(
                          icon: Icons.post_add,
                          context: context,
                          title: 'Posts',
                          subtitle: userProfile.postNum.toString(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostsPage(userId: otherUserId!),
                              ),
                            );
                          },
                        ),
                        _buildProfileItem(
                          icon: Icons.thumb_up,
                          context: context,
                          title: 'Likes',
                          subtitle: userProfile.likedPostNum.toString(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LikesPage(userId: otherUserId!),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No profile data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
