import 'package:aniverse/animals.dart';
import 'package:aniverse/register_page.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:aniverse/config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late SharedPreferences _prefs; // Late-initialized SharedPreferences

  @override
  void initState() {
    super.initState();
    _initializePrefs(); // Call initialization method
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance(); // Await the future
  }

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200 && responseJson['success'] == true) {
      _prefs.setInt('currentUserId', responseJson['data']['id']);

      // Navigate to profile page
      final snackBar = SnackBar(content: Text(responseJson['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      // Show error message
      final snackBar = SnackBar(content: Text(responseJson['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(
                top: 20, bottom: 0), // Add padding to shift the logo downwards
            child: Image.asset('images/logo.png', height: 150),
          ),
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('images/portal_2.jpg'), // Background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromARGB(255, 238, 63, 121),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.5),
                          border: Border.all(
                              color: const Color.fromARGB(255, 243, 143, 176)
                                  .withOpacity(0.7)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 20,
                              offset: Offset(0, 5),
                            )
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromARGB(
                                            176, 243, 143, 176)))),
                            child: TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1700),
                      child: Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                );
                              },
                              child: const Text(
                                "Create Account",
                                style: TextStyle(
                                    color: Color.fromRGBO(230, 121, 176, 1)),
                              )))),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1900),
                    child: MaterialButton(
                      onPressed: _login,
                      color: const Color.fromARGB(255, 207, 39, 123),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
