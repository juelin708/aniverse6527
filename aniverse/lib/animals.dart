import 'package:flutter/material.dart';
import 'package:aniverse/map.dart'; 
import 'package:aniverse/profile_page.dart'; 
//import 'package:your_project/setting_page.dart'; 

class Animals extends StatefulWidget {
  const Animals({super.key});

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<Animals> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.location_pin, color: Colors.red), // Use the location pin icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapSample()), // Replace with actual navigation to MapSample
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
              icon: const Icon(Icons.search, color: Colors.black), // Use the search icon
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
                  MaterialPageRoute(builder: (context) => const ProfilePage()), // Replace with actual navigation to ProfilePage
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black), // Use the three dots icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()), // Replace with actual navigation to SettingPage
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Your main content goes here'),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Animals(),
  ));
}
