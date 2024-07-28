import 'package:aniverse/entity/animal_dto.dart';
import 'package:flutter/material.dart';
import 'package:aniverse/profile_list.dart';
import 'package:aniverse/service/animal_service.dart';
import 'package:aniverse/service/post_service.dart';
import 'package:aniverse/entity/post_dto.dart';
import 'package:aniverse/map.dart';

Widget _buildProfileButton(
    BuildContext context, String name, String imagePath, Widget page) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Container(
        height: 180,
        child: Column(
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(height: 15),
            Text(name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}

class DogPage extends StatelessWidget {
  const DogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dog Page'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildProfileButton(context, 'Dog1', 'images/dog1.jpg',
              const AnimalDetailPage(name: 'Dog1')),
          _buildProfileButton(context, 'Dog2', 'images/dog2.jpg',
              const AnimalDetailPage(name: 'Dog2')),
          _buildProfileButton(context, 'Dog3', 'images/dog3.jpg',
              const AnimalDetailPage(name: 'Dog3')),
        ],
      ),
    );
  }
}

class CatPage extends StatelessWidget {
  const CatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Page'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildProfileButton(context, 'Putu', 'images/putu.png',
              const AnimalDetailPage(name: 'Putu')),
          _buildProfileButton(context, 'Ashy', 'images/ashy.png',
              const AnimalDetailPage(name: 'Ashy')),
          _buildProfileButton(context, 'Plum', 'images/plum.png',
              const AnimalDetailPage(name: 'Plum')),
          _buildProfileButton(context, 'Fred', 'images/fred.png',
              const AnimalDetailPage(name: 'Fred')),
          _buildProfileButton(context, 'Callie', 'images/callie.png',
              const AnimalDetailPage(name: 'Callie')),
        ],
      ),
    );
  }
}

class MonkeyPage extends StatelessWidget {
  const MonkeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monkey Page'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildProfileButton(context, 'Monkey1', 'images/monkey1.jpg',
              const AnimalDetailPage(name: 'Monkey1')),
          _buildProfileButton(context, 'Monkey2', 'images/monkey2.jpg',
              const AnimalDetailPage(name: 'Monkey2')),
          _buildProfileButton(context, 'Monkey3', 'images/monkey3.jpg',
              const AnimalDetailPage(name: 'Monkey3')),
        ],
      ),
    );
  }
}

class RoosterPage extends StatelessWidget {
  const RoosterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooster Page'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildProfileButton(context, 'Rooster1', 'images/rooster1.jpg',
              const AnimalDetailPage(name: 'Rooster1')),
          _buildProfileButton(context, 'Rooster2', 'images/rooster2.jpg',
              const AnimalDetailPage(name: 'Rooster2')),
          _buildProfileButton(context, 'Rooster3', 'images/rooster3.jpg',
              const AnimalDetailPage(name: 'Rooster3')),
        ],
      ),
    );
  }
}

class AnimalDetailPage extends StatefulWidget {
  final String name;

  const AnimalDetailPage({Key? key, required this.name}) : super(key: key);

  @override
  _AnimalDetailPageState createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  late Future<Animal> _animalFuture;

  @override
  void initState() {
    super.initState();
    _animalFuture = AnimalService().getAnimalByName(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animal Details')),
      body: FutureBuilder<Animal>(
        future: _animalFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Animal not found.'));
          } else {
            final animal = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(animal.imageUrl ?? ''),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Text('Name: ${widget.name}',
                  //     style: const TextStyle(
                  //         fontSize: 24, fontWeight: FontWeight.bold)),
                  // const SizedBox(height: 8),
                  // Text('Fun Fact: \n${animal.habit}',
                  //     style: const TextStyle(fontSize: 16)),
                  // const SizedBox(height: 12),
                  // Text('Habitats: \n${animal.habitats}',
                  //     style: const TextStyle(fontSize: 16)),

                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Name: ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: widget.name,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Fun Fact: \n',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: animal.habit,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Habitats: \n',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: animal.habitats,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ), //the end of text.rich

                  const SizedBox(height: 8),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapPage(location: animal.location),
                          ),
                        );
                      },
                      child: Text('View Real-time Location'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnimalPostsPage(animalId: animal.id),
                          ),
                        );
                      },
                      child: const Text('View All Posts'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class AnimalPostsPage extends StatefulWidget {
  final int animalId;
  const AnimalPostsPage({Key? key, required this.animalId}) : super(key: key);

  @override
  _AnimalPostsPageState createState() => _AnimalPostsPageState();
}

class _AnimalPostsPageState extends State<AnimalPostsPage> {
  late Future<List<PostDTO>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = PostService().getPostsByAnimalId(widget.animalId);
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
