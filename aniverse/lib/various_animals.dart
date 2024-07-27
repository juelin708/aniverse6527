import 'package:flutter/material.dart';

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
              const DogDetailPage(name: 'Dog1')),
          _buildProfileButton(context, 'Dog2', 'images/dog2.jpg',
              const DogDetailPage(name: 'Dog2')),
          _buildProfileButton(context, 'Dog3', 'images/dog3.jpg',
              const DogDetailPage(name: 'Dog3')),
        ],
      ),
    );
  }

  Widget _buildProfileButton(
      BuildContext context, String name, String imagePath, Widget page) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(height: 20),
            Text(name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}

class DogDetailPage extends StatelessWidget {
  final String name;
  const DogDetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text('This is the detail page for $name'),
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
          _buildProfileButton(context, 'Putu', 'images/putu.jpg',
              const CatDetailPage(name: 'Putu')),
          _buildProfileButton(context, 'Ashy', 'images/ashy.jpg',
              const CatDetailPage(name: 'Ashy')),
          _buildProfileButton(context, 'Plum', 'images/plum.jpg',
              const CatDetailPage(name: 'Plum')),
          _buildProfileButton(context, 'Fred', 'images/fred.jpg',
              const CatDetailPage(name: 'Fred')),
        ],
      ),
    );
  }

  Widget _buildProfileButton(
      BuildContext context, String name, String imagePath, Widget page) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(height: 20),
            Text(name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}

class CatDetailPage extends StatelessWidget {
  final String name;
  const CatDetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text('This is the detail page for $name'),
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
              const MonkeyDetailPage(name: 'Monkey1')),
          _buildProfileButton(context, 'Monkey2', 'images/monkey2.jpg',
              const MonkeyDetailPage(name: 'Monkey2')),
          _buildProfileButton(context, 'Monkey3', 'images/monkey3.jpg',
              const MonkeyDetailPage(name: 'Monkey3')),
        ],
      ),
    );
  }

  Widget _buildProfileButton(
      BuildContext context, String name, String imagePath, Widget page) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(height: 20),
            Text(name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}

class MonkeyDetailPage extends StatelessWidget {
  final String name;
  const MonkeyDetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text('This is the detail page for $name'),
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
              const RoosterDetailPage(name: 'Rooster1')),
          _buildProfileButton(context, 'Rooster2', 'images/rooster2.jpg',
              const RoosterDetailPage(name: 'Rooster2')),
          _buildProfileButton(context, 'Rooster3', 'images/rooster3.jpg',
              const RoosterDetailPage(name: 'Rooster3')),
        ],
      ),
    );
  }

  Widget _buildProfileButton(
      BuildContext context, String name, String imagePath, Widget page) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(height: 20),
            Text(name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}

class RoosterDetailPage extends StatelessWidget {
  final String name;
  const RoosterDetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text('This is the detail page for $name'),
      ),
    );
  }
}
