import 'package:flutter/material.dart';
import 'package:aniverse/service/profile_service.dart';
import 'package:aniverse/other_user_profile.dart';
import "package:aniverse/profile_page.dart";

class FollowingPage extends StatefulWidget {
  final int userId;
  const FollowingPage({Key? key, required this.userId}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  late Future<List<String>> _followingFuture;

  @override
  void initState() {
    super.initState();
    _followingFuture = ProfileService().getFollowings(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Following')),
      body: FutureBuilder<List<String>>(
        future: _followingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No followings found.'));
          } else {
            final followings = snapshot.data!;
            return ListView.builder(
              itemCount: followings.length,
              itemBuilder: (context, index) {
                final username = followings[index];
                final userProfile =
                    ProfileService().getUserProfileByName(username);
                final currentUserProfile =
                    ProfileService().getUserProfile(widget.userId);
                return ListTile(
                  title: Text(username),
                  onTap: () async {
                    if (userProfile == currentUserProfile) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OtherProfilePage(username: username),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class FollowerPage extends StatefulWidget {
  final int userId;
  const FollowerPage({Key? key, required this.userId}) : super(key: key);

  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  late Future<List<String>> _followerFuture;

  @override
  void initState() {
    super.initState();
    _followerFuture = ProfileService().getFollowers(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Following')),
      body: FutureBuilder<List<String>>(
        future: _followerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No followers found.'));
          } else {
            final followers = snapshot.data!;
            return ListView.builder(
              itemCount: followers.length,
              itemBuilder: (context, index) {
                final username = followers[index];
                final userProfile =
                    ProfileService().getUserProfileByName(username);
                final currentUserProfile =
                    ProfileService().getUserProfile(widget.userId);
                return ListTile(
                  title: Text(username),
                  onTap: () async {
                    if (userProfile == currentUserProfile) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OtherProfilePage(username: username),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
      ),
      body: ListView(
        children: List.generate(
            20, (index) => ListTile(title: Text('Post ${index + 1}'))),
      ),
    );
  }
}

class LikesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Likes'),
      ),
      body: ListView(
        children: List.generate(
            20, (index) => ListTile(title: Text('Like ${index + 1}'))),
      ),
    );
  }
}
