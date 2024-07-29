import 'package:aniverse/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aniverse/config.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          ListTile(
            title: const Text('Update user profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileUpdatePage()),
              );
            },
          ),
          const SizedBox(height: 300),
          MaterialButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
            color: const Color.fromARGB(255, 207, 39, 123),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            height: 50,
            child: const Center(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final _avatarController = TextEditingController();
  final _bioController = TextEditingController();
  final _passwordController = TextEditingController();

  int? currentUserId;

  Future<int?> _getCurrentUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentUserId');
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserID().then((value) {
      setState(() {
        currentUserId = value!;
      });
    });
  }

  Future<void> _update() async {
    final response = await http.put(
      Uri.parse('${Config.baseUrl}/auth/user/update/$currentUserId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'avatarUrl': _avatarController.text,
        'bio': _bioController.text,
        'password': _passwordController.text,
      }),
    );

    final responseJson = jsonDecode(response.body);
    final snackBar = SnackBar(content: Text(responseJson['message']));

    if (response.statusCode == 200 && responseJson['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update user profile'),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: const Border(
                                top: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                                right: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                                left: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                                bottom: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: _bioController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "write your bio",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: const Border(
                                top: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                                right: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                                left: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                                bottom: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: _avatarController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "new avatar url",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: const Border(
                                top: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                                right: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                                left: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                                bottom: BorderSide(
                                  color: Color.fromARGB(176, 243, 143, 176),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "new password",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MaterialButton(
                      onPressed: _update,
                      color: const Color.fromARGB(255, 207, 39, 123),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
