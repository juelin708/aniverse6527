import 'package:flutter/material.dart';

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
        backgroundColor: Color.fromARGB(255, 252, 252, 252), // Custom color example
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {
                    // Handle like action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    // Handle comment action
                  },
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
