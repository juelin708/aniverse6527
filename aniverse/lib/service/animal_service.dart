import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aniverse/entity/animal_dto.dart';

class AnimalService {
  Future<Animal> getAnimal(int animalId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/animal/$animalId'),
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
      Uri.parse('http://10.0.2.2:8080/api/animal/byAnimalname/$animalname'),
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
}