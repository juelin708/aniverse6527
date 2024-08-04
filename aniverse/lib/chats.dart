import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aniverse/config.dart';

Future<int?> _getCurrentUserID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('currentUserId');
}

class ChatPreview {
  final String username;
  final String lastMessage;

  ChatPreview({required this.username, required this.lastMessage});
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatPreview> chatPreviews = [];

  @override
  void initState() {
    super.initState();
    fetchChatPreviews();
  }

  Future<void> fetchChatPreviews() async {
    final currentUserId = await _getCurrentUserID();
    final response = await http
        .get(Uri.parse('${Config.baseUrl}/chat/previews/$currentUserId'));

    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<dynamic> data = responseJson['data'];
      setState(() {
        chatPreviews = data
            .map((item) => ChatPreview(
                  username: item['username'],
                  lastMessage: item['lastMessage'],
                ))
            .toList();
      });
    } else {
      final snackBar = SnackBar(content: Text(responseJson['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: ListView.builder(
        itemCount: chatPreviews.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatDetailPage(username: chatPreviews[index].username),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatPreviews[index].username,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      chatPreviews[index].lastMessage,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchChatPreviews,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class ChatDetailPage extends StatefulWidget {
  final String username;

  ChatDetailPage({required this.username});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<Message> messages = [];
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final currentUserId = await _getCurrentUserID();
    final response = await http.get(Uri.parse(
        '${Config.baseUrl}/chat/${currentUserId}/${widget.username}'));

    final responseJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      List<dynamic> data = responseJson['data'];
      setState(() {
        messages = data
            .map((item) => Message(
                  sender: item['senderName'],
                  content: item['content'],
                  timestamp: DateTime.parse(item['timestamp']),
                ))
            .toList();
      });
    } else {
      final snackBar = SnackBar(content: Text(responseJson['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> sendMessage(String content) async {
    final currentUserId = await _getCurrentUserID();
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/chat/send'),
      body: {
        'senderId': currentUserId.toString(),
        'receiverName': widget.username,
        'content': messageController.text,
      },
    );
    final responseJson = jsonDecode(response.body);
    final snackBar = SnackBar(content: Text(responseJson['message']));

    if (response.statusCode == 200 && responseJson['success'] == true) {
      messageController.clear();
      fetchMessages();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.username)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isCurrentUser = message.sender == widget.username;

                return Align(
                  alignment: isCurrentUser
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isCurrentUser
                          ? Colors.grey[300]
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.content,
                          style: TextStyle(
                            color: isCurrentUser ? Colors.black : Colors.white,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          message.timestamp.toString(),
                          style: TextStyle(
                            color: isCurrentUser ? Colors.black : Colors.white,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration:
                        const InputDecoration(labelText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      sendMessage(messageController.text);
                    }
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

class Message {
  final String sender;
  final String content;
  final DateTime timestamp;

  Message(
      {required this.sender, required this.content, required this.timestamp});
}
