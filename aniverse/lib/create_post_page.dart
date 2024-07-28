import 'package:aniverse/service/animal_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aniverse/profile_list.dart';
import 'package:geolocator/geolocator.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  int? _currentUserId;
  String? _selectedAnimal;
  int? _selectedAnimalId;
  List<String> _animalNames = [];
  File? _selectedImage;
  String? _imageUrl;
  String? _currentLocation;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _fetchAnimalNames();
  }

  Future<void> _initializeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentUserId = prefs.getInt('currentUserId');
    });
  }

  Future<void> _fetchAnimalNames() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/animal/all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        setState(() {
          _animalNames = List<String>.from(
              responseJson['data'].map((animal) => animal['animalname']));
        });
      } else {
        throw Exception('Failed to load animal names');
      }
    } catch (e) {
      print('Error fetching animal names: $e');
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8080/api/upload'),
    );
    request.files
        .add(await http.MultipartFile.fromPath('file', _selectedImage!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseString);
      setState(() {
        _imageUrl = responseJson['data']['url'];
      });
    } else {
      throw Exception('Failed to upload image');
    }
  }

  Future<void> _createPost() async {
    if (_currentUserId == null || _selectedAnimal == null) {
      throw Exception('Failed to fetch user or animal');
    }

    if (_selectedImage != null) {
      await _uploadImage();
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/post/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': _currentUserId,
        'title': _titleController.text,
        'content': _contentController.text,
        'animalId': _selectedAnimalId,
        'imageUrl': _imageUrl,
      }),
    );

    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200 && responseJson['success'] == true) {
      final postId = responseJson['data']['id'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PostDetailPage(postId: postId),
        ),
      );
    } else {
      final snackBar = SnackBar(content: Text(responseJson['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Future.error('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = '${position.latitude}, ${position.longitude}';
      });
      await _updateAnimalLocation(_selectedAnimalId!, _currentLocation!);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching location: $e')));
    }
  }

  Future<void> _updateAnimalLocation(int animalId, String location) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8080/api/animal/update/location/$animalId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'location': location,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update animal location');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter the title of the post',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  hintText: 'Enter the content of the post',
                ),
                maxLines: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                value: _selectedAnimal,
                hint: const Text('Select Animal'),
                onChanged: (String? newValue) async {
                  if (newValue != null) {
                    setState(() {
                      _selectedAnimal = newValue;
                    });
                    final animal =
                        await AnimalService().getAnimalByName(newValue);
                    setState(() {
                      _selectedAnimalId = animal.id;
                    });
                  }
                },
                items:
                    _animalNames.map<DropdownMenuItem<String>>((String animal) {
                  return DropdownMenuItem<String>(
                    value: animal,
                    child: Text(animal),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Select Image'),
                      ),
                      _selectedImage == null
                          ? const Text('No image selected.')
                          : Image.file(_selectedImage!),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _fetchCurrentLocation,
                        child: const Text('Current Location'),
                      ),
                      _currentLocation == null
                          ? const Text('No location fetched.')
                          : Text('Current Location: $_currentLocation'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _createPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 207, 39, 123),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Create Post',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
