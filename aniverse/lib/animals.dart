import 'package:aniverse/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:aniverse/map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aniverse/profile_page.dart';

void main() {
  runApp(const MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  Future<int?> _getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentUserId') ?? 0;
  }

  static final List<Widget> _widgetOptions = <Widget>[
    Animals(),
    PlaceholderWidget(), // Page for calendar
    PlaceholderWidget(), // Page for add button
    PlaceholderWidget(), // Page for chat
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black12,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Animals extends StatefulWidget {
  const Animals({super.key});

  @override
  _AnimalsState createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.location_pin, color: Colors.red),
              onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => MapSample()),
                 );
              },
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: '# putu',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Implement search functionality here
              },
            ),
            IconButton(
              icon: const CircleAvatar(
                child: Text('ID'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            _buildImageButton(context, 'images/dog.jpg', const DogPage()),
            _buildImageButton(context, 'images/cat.jpg', const CatPage()),
            _buildImageButton(context, 'images/monkey.jpg', const MonkeyPage()),
            _buildImageButton(context, 'images/rooster.jpg', const RoosterPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton(BuildContext context, String imagePath, Widget page) {
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
        child: Image.asset(imagePath),
      ),
    );
  }
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
          _buildProfileButton(context, 'Dog1', 'images/dog1.jpg', const DogDetailPage(name: 'Dog1')),
          _buildProfileButton(context, 'Dog2', 'images/dog2.jpg', const DogDetailPage(name: 'Dog2')),
          _buildProfileButton(context, 'Dog3', 'images/dog3.jpg', const DogDetailPage(name: 'Dog3')),
        ],
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, String name, String imagePath, Widget page) {
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
            )
          )
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
          _buildProfileButton(context, 'Putu', 'images/putu.jpg', const CatDetailPage(name: 'Putu')),
          _buildProfileButton(context, 'Ashy', 'images/ashy.jpg', const CatDetailPage(name: 'Ashy')),
          _buildProfileButton(context, 'Plum', 'images/plum.jpg', const CatDetailPage(name: 'Plum')),
          _buildProfileButton(context, 'Fred', 'images/fred.jpg', const CatDetailPage(name: 'Fred')),
        ],
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, String name, String imagePath, Widget page) {
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
            )
          )
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
          _buildProfileButton(context, 'Monkey1', 'images/monkey1.jpg', const MonkeyDetailPage(name: 'Monkey1')),
          _buildProfileButton(context, 'Monkey2', 'images/monkey2.jpg', const MonkeyDetailPage(name: 'Monkey2')),
          _buildProfileButton(context, 'Monkey3', 'images/monkey3.jpg', const MonkeyDetailPage(name: 'Monkey3')),
        ],
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, String name, String imagePath, Widget page) {
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
            )
          )
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
          _buildProfileButton(context, 'Rooster1', 'images/rooster1.jpg', const RoosterDetailPage(name: 'Rooster1')),
          _buildProfileButton(context, 'Rooster2', 'images/rooster2.jpg', const RoosterDetailPage(name: 'Rooster2')),
          _buildProfileButton(context, 'Rooster3', 'images/rooster3.jpg', const RoosterDetailPage(name: 'Rooster3')),
        ],
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, String name, String imagePath, Widget page) {
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
            )
          )
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

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('tbc'),
      ),
    );
  }
}
