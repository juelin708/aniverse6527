import 'package:flutter/material.dart';

class AnimalDetailPage extends StatelessWidget {
  final int id;
  final String animalName;
  final String habit;
  final String habitats;
  final String location;
  final String imageUrl;

  const AnimalDetailPage({
    super.key,
    required this.id,
    required this.animalName,
    required this.habit,
    required this.habitats,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animalName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imageUrl),
            const SizedBox(height: 16),
            Text('ID: $id', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Name: $animalName', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Habit: $habit', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Habitats: $habitats', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Location: $location', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
