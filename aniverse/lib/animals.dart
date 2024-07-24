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
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
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
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                  'images/dog.jpg'), // Replace with your image asset
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                  'images/cat.jpg'), // Replace with your image asset
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                  'images/monkey.jpg'), // Replace with your image asset
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                  'images/rooster.jpg'), // Replace with your image asset
            ),
          ],
        ),
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
