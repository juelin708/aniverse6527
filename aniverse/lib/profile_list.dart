import 'package:flutter/material.dart';

class FollowersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
      ),
      body: ListView(
        children: List.generate(20, (index) => ListTile(title: Text('Follower ${index + 1}'))),
      ),
    );
  }
}

class LikesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Likes'),
      ),
      body: ListView(
        children: List.generate(20, (index) => ListTile(title: Text('Like ${index + 1}'))),
      ),
    );
  }
}

class CollectionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collections'),
      ),
      body: ListView(
        children: List.generate(20, (index) => ListTile(title: Text('Collection ${index + 1}'))),
      ),
    );
  }
}

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
      ),
      body: ListView(
        children: List.generate(20, (index) => ListTile(title: Text('Post ${index + 1}'))),
      ),
    );
  }
}

