import 'package:flutter/material.dart';
import 'package:aniverse/profile_list.dart';
import 'package:aniverse/entity/post_dto.dart';
import 'package:aniverse/service/post_service.dart';

class ForumMainPage extends StatefulWidget {
  const ForumMainPage({super.key});

  @override
  _ForumMainPageState createState() => _ForumMainPageState();
}

class _ForumMainPageState extends State<ForumMainPage> {
  late Future<List<PostDTO>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() {
    setState(() {
      _postsFuture = PostService().getAllPosts();
    });
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
            posts.sort((a, b) => b.date.compareTo(a.date));
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
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPosts,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

/*
class ForumMainPage extends StatelessWidget {
  const ForumMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: '# putu',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Implement search functionality here
                String searchText = _searchController.text;
                print('Search text: $searchText'); // For demonstration purposes
              },
            ),
          ],
        ),
        backgroundColor:
            Color.fromARGB(255, 252, 252, 252), // Custom color example
        // backgroundColor: Colors.red, // Another example with a predefined color
      ),
      body: ListView(
        children: const [
          PostWidget(
            title: 'Post 1',
            content: 'Content of post 1',
            imageUrl: 'https://example.com/image1.jpg',
          ),
          PostWidget(
            title: 'Post 2',
            content: 'Content of post 2',
            imageUrl: 'https://example.com/image2.jpg',
          ),
          PostWidget(
            title: 'Post 3',
            content: 'Content of post 3',
            imageUrl: 'https://example.com/image3.jpg',
          ),
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String title;
  final String content;
  final String? imageUrl;

  const PostWidget({
    super.key,
    required this.title,
    required this.content,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 8),
            Text(content),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up),
                      onPressed: _navigateToLikedByPage,
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
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ForumMainPage(),
  ));
}
*/
