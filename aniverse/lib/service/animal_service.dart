import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aniverse/entity/animal_dto.dart';
import 'package:aniverse/config.dart';

class AnimalService {
  Future<Animal> getAnimal(int animalId) async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/animal/$animalId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return Animal.fromJson(responseJson['data']);
    } else {
      throw Exception('Failed to load animal profile');
    }
  }

  Future<Animal> getAnimalByName(String animalname) async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/animal/byAnimalname/$animalname'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return Animal.fromJson(responseJson['data']);
    } else {
      throw Exception('Failed to load animal profile');
    }
  }

  Future<List<Animal>> getAnimals() async {
    final String url = '${Config.baseUrl}/animal/all';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        List<Animal> animals = (responseBody['data'] as List)
            .map((animal) => Animal.fromJson(animal))
            .toList();
        return animals;
      } else {
        throw Exception('Failed to fetch animals: ${responseBody['message']}');
      }
    } else {
      throw Exception('Failed to fetch animals');
    }
  }
}
