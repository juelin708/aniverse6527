import 'package:aniverse/profile_list.dart';
import 'package:flutter/material.dart';
import 'package:aniverse/entity/user_profile_dto.dart';
import 'package:aniverse/service/profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserProfileDTO> _userProfileFuture;
  int? userId;

  Future<int?> _getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentUserId');
  }

  @override
  void initState() {
    super.initState();
    _getUserID().then((value) {
      setState(() {
        userId = value;
        if (userId != null) {
          _userProfileFuture = ProfileService().getUserProfile(userId!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: userId == null
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<UserProfileDTO>(
                future: _userProfileFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userProfile = snapshot.data!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              userProfile.avatarUrl ?? 'assets/logo.png'),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          userProfile.username,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userProfile.bio ?? "write something",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              _buildProfileItem(
                                icon: Icons.person,
                                context: context,
                                title: 'Following',
                                subtitle: userProfile.followingNum.toString(),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FollowingPage(userId: userId!),
                                    ),
                                  );
                                },
                              ),
                              _buildProfileItem(
                                icon: Icons.people,
                                context: context,
                                title: 'Followers',
                                subtitle: userProfile.fanNum.toString(),
                                onTap: () {
                                  // Handle navigation to Followers Screen
                                },
                              ),
                              _buildProfileItem(
                                icon: Icons.post_add,
                                context: context,
                                title: 'My Posts',
                                subtitle: userProfile.postNum.toString(),
                                onTap: () {
                                  // Handle navigation to Posts Screen
                                },
                              ),
                              _buildProfileItem(
                                icon: Icons.thumb_up,
                                context: context,
                                title: 'Likes',
                                subtitle: userProfile.likedPostNum.toString(),
                                onTap: () {
                                  // Handle navigation to Likes Screen
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  // Display a loading indicator while fetching data
                  return const Center(child: CircularProgressIndicator());
                },
              ),
      ),
    );
  }

  Widget _buildProfileItem(
      {required BuildContext context,
      required String title,
      required String subtitle,
      required VoidCallback onTap,
      required IconData icon}) {
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

/*
void main() async {
  runApp(const MaterialApp(
    home: ProfilePage(),
  ));
}
*/