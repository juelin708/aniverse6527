import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aniverse/entity/user_profile_dto.dart';

class ProfileService {
  Future<UserProfileDTO> getUserProfile(int userId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/auth/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return UserProfileDTO.fromJson(responseJson['data']);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<int> isFollowing(int fanId, int followedId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/auth/$fanId/isFollowing/$followedId'),
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
      throw Exception('Failed to check follow status');
    }
  }

  Future<UserProfileDTO> getUserProfileByName(String username) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/auth/user/byUsername/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return UserProfileDTO.fromJson(responseJson['data']);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<List<String>> getFollowings(int userId) async {
    final String url = 'http://10.0.2.2:8080/api/auth/followings/$userId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        List<String> followings = List<String>.from(responseBody['data']);
        return followings;
      } else {
        throw Exception(
            'Failed to fetch followings: ${responseBody['message']}');
      }
    } else {
      throw Exception('Failed to fetch followings');
    }
  }

  Future<List<String>> getFollowers(int userId) async {
    final String url = 'http://10.0.2.2:8080/api/auth/fans/$userId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        List<String> followings = List<String>.from(responseBody['data']);
        return followings;
      } else {
        throw Exception(
            'Failed to fetch followers: ${responseBody['message']}');
      }
    } else {
      throw Exception('Failed to fetch followings');
    }
  }
}
