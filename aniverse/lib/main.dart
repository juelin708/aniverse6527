import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // root of application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AniVerse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      /*appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 238, 226),
        title: Image.asset('images/logo.png', height: 180),
        centerTitle: true,
      ),*/
      body: Stack(
        children: <Widget>[
          // Background image
          Positioned.fill(
            child: Image.asset(
              'images/portal_1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/logo.png',
                  height: 400, // Adjust the height as needed
                ),
                const SizedBox(height: 0), // Space between the logo and button
                ElevatedButton(
                  child: const Text('LOGIN'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
