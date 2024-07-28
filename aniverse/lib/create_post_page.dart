// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'dart:io';

// // class ForumMainPage extends StatelessWidget {
// //   const ForumMainPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final TextEditingController _searchController = TextEditingController();

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Row(
// //           children: [
// //             Expanded(
// //               child: TextField(
// //                 controller: _searchController,
// //                 decoration: const InputDecoration(
// //                   hintText: '# putu',
// //                   border: InputBorder.none,
// //                   filled: true,
// //                   fillColor: Colors.white,
// //                   contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
// //                 ),
// //               ),
// //             ),
// //             IconButton(
// //               icon: const Icon(Icons.search, color: Colors.black),
// //               onPressed: () {
// //                 // Implement search functionality here
// //                 String searchText = _searchController.text;
// //                 print('Search text: $searchText'); // For demonstration purposes
// //               },
// //             ),
// //           ],
// //         ),
// //         backgroundColor: const Color(0xFF6200EA), // Custom color example
// //         // backgroundColor: Colors.red, // Another example with a predefined color
// //       ),
// //       body: ListView(
// //         children: const [
// //           PostWidget(title: 'Post 1', content: 'Content of post 1'),
// //           PostWidget(title: 'Post 2', content: 'Content of post 2'),
// //           PostWidget(title: 'Post 3', content: 'Content of post 3'),
// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => const AddPostPage()),
// //           );
// //         },
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }

// // class PostWidget extends StatelessWidget {
// //   final String title;
// //   final String content;

// //   const PostWidget({super.key, required this.title, required this.content});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: const EdgeInsets.all(8.0),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               title,
// //               style: const TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 18,
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(content),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 IconButton(
// //                   icon: const Icon(Icons.thumb_up_alt_outlined),
// //                   onPressed: () {
// //                     // Handle like action
// //                   },
// //                 ),
// //                 IconButton(
// //                   icon: const Icon(Icons.comment_outlined),
// //                   onPressed: () {
// //                     // Handle comment action
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class AddPostPage extends StatefulWidget {
// //   const AddPostPage({super.key});

// //   @override
// //   _AddPostPageState createState() => _AddPostPageState();
// // }

// // class _AddPostPageState extends State<AddPostPage> {
// //   final TextEditingController _titleController = TextEditingController();
// //   final TextEditingController _contentController = TextEditingController();
// //   File? _image;

// //   Future<void> _pickImage() async {
// //     final ImagePicker _picker = ImagePicker();
// //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

// //     if (image != null) {
// //       setState(() {
// //         _image = File(image.path);
// //       });
// //     }
// //   }

// //   void _submitPost() {
// //     final String title = _titleController.text;
// //     final String content = _contentController.text;

// //     if (title.isNotEmpty && content.isNotEmpty && _image != null) {
// //       // Here you would normally send the data to your backend or database
// //       print('Title: $title');
// //       print('Content: $content');
// //       print('Image path: ${_image!.path}');

// //       // Clear the text fields and image after submission
// //       _titleController.clear();
// //       _contentController.clear();
// //       setState(() {
// //         _image = null;
// //       });

// //       // Navigate back to the previous screen
// //       Navigator.pop(context);
// //     } else {
// //       // Show an error message if the form is incomplete
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Please complete all fields and add an image.')),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Add Post'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _titleController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Title',
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             TextField(
// //               controller: _contentController,
// //               decoration: const InputDecoration(
// //                 labelText: 'Content',
// //               ),
// //               maxLines: 5,
// //             ),
// //             const SizedBox(height: 16),
// //             _image == null
// //                 ? const Text('No image selected.')
// //                 : Image.file(_image!),
// //             const SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: _pickImage,
// //               child: const Text('Pick Image'),
// //             ),
// //             const SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: _submitPost,
// //               child: const Text('Submit Post'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // void main() {
// //   runApp(const MaterialApp(
// //     home: ForumMainPage(),
// //   ));
// // }
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // Make sure this import is present
// import 'dart:io'; // For File

// class ForumMainPage extends StatelessWidget {
//   const ForumMainPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _searchController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: _searchController,
//                 decoration: const InputDecoration(
//                   hintText: '# putu',
//                   border: InputBorder.none,
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.search, color: Colors.black),
//               onPressed: () {
//                 // Implement search functionality here
//                 String searchText = _searchController.text;
//                 print('Search text: $searchText'); // For demonstration purposes
//               },
//             ),
//           ],
//         ),
//         backgroundColor: Color.fromARGB(255, 255, 255, 255), // Custom color example
//       ),
//       body: ListView(
//         children: const [
//           PostWidget(title: 'Post 1', content: 'Content of post 1'),
//           PostWidget(title: 'Post 2', content: 'Content of post 2'),
//           PostWidget(title: 'Post 3', content: 'Content of post 3'),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddPostPage()),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class PostWidget extends StatelessWidget {
//   final String title;
//   final String content;

//   const PostWidget({super.key, required this.title, required this.content});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(content),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.thumb_up_alt_outlined),
//                   onPressed: () {
//                     // Handle like action
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.comment_outlined),
//                   onPressed: () {
//                     // Handle comment action
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AddPostPage extends StatefulWidget {
//   const AddPostPage({super.key});

//   @override
//   _AddPostPageState createState() => _AddPostPageState();
// }

// class _AddPostPageState extends State<AddPostPage> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _contentController = TextEditingController();
//   File? _image;

//   Future<void> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });
//     }
//   }

//   void _submitPost() {
//     final String title = _titleController.text;
//     final String content = _contentController.text;

//     if (title.isNotEmpty && content.isNotEmpty && _image != null) {
//       // Here you would normally send the data to your backend or database
//       print('Title: $title');
//       print('Content: $content');
//       print('Image path: ${_image!.path}');

//       // Clear the text fields and image after submission
//       _titleController.clear();
//       _contentController.clear();
//       setState(() {
//         _image = null;
//       });

//       // Navigate back to the previous screen
//       Navigator.pop(context);
//     } else {
//       // Show an error message if the form is incomplete
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please complete all fields and add an image.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Post'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _contentController,
//               decoration: const InputDecoration(
//                 labelText: 'Content',
//               ),
//               maxLines: 5,
//             ),
//             const SizedBox(height: 16),
//             _image == null
//                 ? const Text('No image selected.')
//                 : Image.file(_image!),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: const Text('Pick Image'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submitPost,
//               child: const Text('Submit Post'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     home: AddPostPage(),
//   ));
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import 'dart:io'; // For File

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: '# putu',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Implement search functionality here
                String searchText = _searchController.text;
                print('Search text: $searchText'); // For demonstration purposes
              },
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Custom color example
      ),
      body: ListView(
        children: const [
          PostWidget(title: 'Post 1', content: 'Content of post 1'),
          PostWidget(title: 'Post 2', content: 'Content of post 2'),
          PostWidget(title: 'Post 3', content: 'Content of post 3'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String title;
  final String content;

  const PostWidget({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(content),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {
                    // Handle like action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    // Handle comment action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _submitPost() {
    final String title = _titleController.text;
    final String content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      // Here you would normally send the data to your backend or database
      print('Title: $title');
      print('Content: $content');
      if (_image != null) {
        print('Image path: ${_image!.path}');
      }

      // Clear the text fields and image after submission
      _titleController.clear();
      _contentController.clear();
      setState(() {
        _image = null;
      });

      // Navigate back to the previous screen
      Navigator.pop(context);
    } else {
      // Show an error message if the form is incomplete
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            _image == null
                ? const Text('No image selected.')
                : Image.file(_image!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitPost,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AddPostPage(),
  ));
}
