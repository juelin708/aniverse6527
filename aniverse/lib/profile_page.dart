import 'package:aniverse/profile_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.png'), // Placeholder profile picture
            ),
            const SizedBox(height: 20),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'johndoe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                ' Write something.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildProfileItem(
                    icon: Icons.person,
                    context: context,
                    title: 'Following',
                    subtitle:'200',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersScreen()),
                      );
                    },
                  ),
                  _buildProfileItem(
                    icon: Icons.post_add,
                    context: context,
                    title: 'My Posts',
                    subtitle: '50',
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => PostsScreen()),
                      );
                    },
                  ),
                  _buildProfileItem(
                    icon: Icons.thumb_up,
                    context: context,
                    title: 'Likes',
                    subtitle: '1200',
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => LikesScreen()),
                      );
                    },
                  ),
                  _buildProfileItem(
                    icon: Icons.collections,
                    context: context,
                    title: 'Collections',
                    subtitle: '100',
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => CollectionsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildProfileItem({required BuildContext context, required String title, required String subtitle, required VoidCallback onTap, required IconData icon}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

  Widget _buildProfileItem(IconData icon, String title, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: ListTile(
          leading: Icon(icon, size: 40, color: Colors.blue),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            count,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }


void main() {
  runApp(const MaterialApp(
    home: ProfilePage(),
  ));
}
