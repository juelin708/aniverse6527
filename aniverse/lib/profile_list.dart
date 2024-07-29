import 'package:flutter/material.dart';
import 'package:aniverse/service/profile_service.dart';
import 'package:aniverse/other_user_profile.dart';
import "package:aniverse/profile_page.dart";
import 'package:aniverse/service/post_service.dart';
import "package:aniverse/entity/post_dto.dart";
import "package:aniverse/entity/comment_dto.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aniverse/config.dart';

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
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(postId: post.id),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title ?? "No title",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (post.imageUrl != null)
                            Image.network(
                              post.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          const SizedBox(height: 8),
                          Text(post.content),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.thumb_up),
                                      onPressed: () {}),
                                  Text('${post.likeNum}')
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.comment),
                                    onPressed: () {},
                                  ),
                                  Text('${post.commentNum}')
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PostDetailPage extends StatefulWidget {
  final int postId;

  const PostDetailPage({Key? key, required this.postId}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late Future<PostDTO> _postFuture;
  final TextEditingController _commentController = TextEditingController();
  int? currentUserId;
  int? isLiking;

  @override
  void initState() {
    super.initState();
    _postFuture = _initializeData();
  }

  Future<PostDTO> _initializeData() async {
    final post = await PostService().getPost(widget.postId);
    currentUserId = await _getCurrentUserID();
    isLiking = await PostService().isLiking(currentUserId!, post.id);
    return post;
  }

  Future<int?> _getCurrentUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentUserId');
  }

  Future<void> _likePost(PostDTO post) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Config.baseUrl}/post/like?postId=${post.id}&userId=$currentUserId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);

        if (responseJson['success'] == true) {
          final updatedPost = await PostService().getPost(post.id);
          setState(() {
            isLiking = 1;
            _postFuture = Future.value(updatedPost);
          });
        } else {
          final snackBar = SnackBar(content: Text(responseJson['message']));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(
            content: Text('Failed to like post: ${response.statusCode}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text('An error occurred: $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _unlikePost(PostDTO post) async {
    try {
      final response = await http.delete(
        Uri.parse(
            '${Config.baseUrl}/post/unlike?postId=${post.id}&userId=$currentUserId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);

        if (responseJson['success'] == true) {
          final updatedPost = await PostService().getPost(post.id);
          setState(() {
            isLiking = 0;
            _postFuture = Future.value(updatedPost);
          });
        } else {
          final snackBar = SnackBar(content: Text(responseJson['message']));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(
            content: Text('Failed to unlike post: ${response.statusCode}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text('An error occurred: $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _commentPost(PostDTO post) async {
    try {
      final content = _commentController.text;
      final response = await http.post(
        Uri.parse(
            '${Config.baseUrl}/post/comment?postId=${post.id}&userId=$currentUserId&content=$content'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);

        if (responseJson['success'] == true) {
          final updatedPost = await PostService().getPost(post.id);
          setState(() {
            _postFuture = Future.value(updatedPost);
            _commentController.clear();
          });
        } else {
          final snackBar = SnackBar(content: Text(responseJson['message']));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(content: Text('Failed to comment on post'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text('An error occurred: $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _navigateToLikedByPage(List<String> likedBy) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LikedByPage(likedBy: likedBy),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: FutureBuilder<PostDTO>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No post found.'));
          } else {
            final post = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OtherProfilePage(username: post.username),
                          ),
                        );
                      },
                      child: Text('By: ${post.username}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    const SizedBox(height: 8),
                    Text(post.content, style: const TextStyle(fontSize: 17)),
                    const SizedBox(height: 15),
                    if (post.imageUrl != null) Image.network(post.imageUrl!),
                    const SizedBox(height: 8),
                    Text(post.date.toString(),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 8),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.thumb_up),
                                onPressed: () =>
                                    _navigateToLikedByPage(post.likedBy!),
                              ),
                              Text('${post.likeNum}')
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.comment),
                                onPressed: () {},
                              ),
                              Text('${post.commentNum}')
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLiking == 1) {
                              _unlikePost(post);
                            } else {
                              _likePost(post);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isLiking == 1 ? Colors.grey : Colors.tealAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(isLiking == 1 ? 'Unlike' : 'Like'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: 'Add a comment',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => _commentPost(post),
                        ),
                      ),
                    ),
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
            );
          }
        },
      ),
    );
  }
}

class LikedByPage extends StatelessWidget {
  final List<String> likedBy;

  const LikedByPage({Key? key, required this.likedBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Likes')),
      body: ListView.builder(
        itemCount: likedBy.length,
        itemBuilder: (context, index) {
          final username = likedBy[index];
          return ListTile(
            title: Text(username),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtherProfilePage(username: username),
                ),
              );
            },
          );
        },
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
          Text(comment.date.toString(),
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
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(postId: post.id),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title ?? "No title",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (post.imageUrl != null)
                            Image.network(
                              post.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          const SizedBox(height: 8),
                          Text(post.content),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.thumb_up),
                                      onPressed: () {}),
                                  Text('${post.likeNum}')
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.comment),
                                    onPressed: () {},
                                  ),
                                  Text('${post.commentNum}')
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
