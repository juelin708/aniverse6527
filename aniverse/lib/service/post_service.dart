import 'package:aniverse/entity/post_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aniverse/config.dart';

class PostService {
  Future<PostDTO> getPost(int postId) async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/post/$postId'),
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
    final String url = '${Config.baseUrl}/post/user/$userId';

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
    final String url = '${Config.baseUrl}/post/animal/$animalId';

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
    final String url = '${Config.baseUrl}/post/likedBy/$userId';

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

  Future<void> commentPost(int postId, int userId, String content) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/post/comment'),
      body: jsonEncode({
        'postId': postId.toString(),
        'userId': userId.toString(),
        'content': content
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to comment on post');
    }
  }

  Future<int> isLiking(int userId, int postId) async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/post/$userId/isLiking/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final data = jsonResponse['data'];
      if (data is int) {
        return data;
      } else {
        throw Exception('Invalid data type: Expected int');
      }
    } else {
      throw Exception('Failed to check like status');
    }
  }

  Future<List<PostDTO>> getAllPosts() async {
    final String url = '${Config.baseUrl}/post/all';

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
