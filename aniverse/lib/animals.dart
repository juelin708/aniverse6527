import 'package:flutter/material.dart';
import 'package:aniverse/create_post_page.dart';
import 'package:aniverse/forum_main_page.dart';
import 'package:aniverse/setting_page.dart';
import 'package:aniverse/map.dart';
import 'package:aniverse/profile_page.dart';
import 'package:aniverse/various_animals.dart';
import 'package:aniverse/chats.dart';

/*
void main() {
  runApp(const MaterialApp(
    home: MainScreen(),
  ));
}
*/

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Animals(),
    ForumMainPage(),
    CreatePostPage(),
    ChatPage(), // Page for chat
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    // Returning false means the back button will do nothing
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Forum',
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
            const Expanded(
              child: SizedBox(),
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
            _buildImageButton(
                context, 'images/rooster.jpg', const RoosterPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton(
      BuildContext context, String imagePath, Widget page) {
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
