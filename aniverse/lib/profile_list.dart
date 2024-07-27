import 'package:flutter/material.dart';
import 'package:aniverse/service/profile_service.dart';
import 'package:aniverse/other_user_profile.dart';
import "package:aniverse/profile_page.dart";
import 'package:aniverse/service/post_service.dart';
import "package:aniverse/entity/post_dto.dart";
import "package:aniverse/entity/comment_dto.dart";

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

class PostsPage extends StatefulWidget {
  final int userId;
  const PostsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<PostDTO>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = PostService().getPostsByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder<List<PostDTO>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts found.'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(
                    post.title ?? 'No Title',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(post.content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(post: post),
                      ),
                    );
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

class PostDetailPage extends StatelessWidget {
  final PostDTO post;
  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title ?? 'Post Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('By: ${post.username}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(post.content),
              const SizedBox(height: 8),
              if (post.imageUrl != null) Image.network(post.imageUrl!),
              const SizedBox(height: 8),
              Text('Likes: ${post.likeNum}, Comments: ${post.commentNum}'),
              const SizedBox(height: 8),
              Text(post.date,
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 16),
              const Text('Comments:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (post.comments != null && post.comments!.isNotEmpty)
                ...post.comments!
                    .map((comment) => CommentWidget(comment))
                    .toList()
              else
                const Text('No comments yet.'),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final CommentDTO comment;
  const CommentWidget(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.username,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(comment.content),
          const SizedBox(height: 4),
          Text(comment.date,
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(),
        ],
      ),
    );
  }
}

class LikesPage extends StatefulWidget {
  final int userId;
  const LikesPage({Key? key, required this.userId}) : super(key: key);

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  late Future<List<PostDTO>> _likesFuture;

  @override
  void initState() {
    super.initState();
    _likesFuture = PostService().getLikedPosts(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder<List<PostDTO>>(
        future: _likesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts found.'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(
                    post.title ?? 'No Title',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(post.content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(post: post),
                      ),
                    );
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
