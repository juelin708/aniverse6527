import 'package:aniverse/entity/post_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostService {
  Future<PostDTO> getPost(int postId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/post/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return PostDTO.fromJson(responseJson['data']);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<PostDTO>> getPostsByUserId(int userId) async {
    final String url = 'http://10.0.2.2:8080/api/post/user/$userId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        List<PostDTO> posts = (responseBody['data'] as List)
            .map((post) => PostDTO.fromJson(post))
            .toList();
        return posts;
      } else {
        throw Exception('Failed to fetch posts: ${responseBody['message']}');
      }
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<List<PostDTO>> getPostsByAnimalId(int animalId) async {
    final String url = 'http://10.0.2.2:8080/api/post/animal/$animalId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        List<PostDTO> posts = (responseBody['data'] as List)
            .map((post) => PostDTO.fromJson(post))
            .toList();
        return posts;
      } else {
        throw Exception('Failed to fetch posts: ${responseBody['message']}');
      }
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<List<PostDTO>> getLikedPosts(int userId) async {
    final String url = 'http://10.0.2.2:8080/api/post/likedBy/$userId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        List<PostDTO> posts = (responseBody['data'] as List)
            .map((post) => PostDTO.fromJson(post))
            .toList();
        return posts;
      } else {
        throw Exception('Failed to fetch posts: ${responseBody['message']}');
      }
    } else {
      throw Exception('Failed to fetch posts');
    }
  }
}
