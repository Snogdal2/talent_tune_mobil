import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../shared_state.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _cvController = TextEditingController();
  final List<String> _messages = [];
  var _isButtonPressed = false;
  var chatid;

  void _sendMessage() {
    setState(() {
      String message = _messageController.text;
      _messages.add(message);
      _messageController.clear();
    });
  }

  Future<String> Chatgpt() async {
    final token = SharedState.bearerToken();
    final Chatgpt = await http.post(
      Uri.parse('http://localhost:3001/assistant/initialize'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'resume': _cvController.text,
        'jobDescription': _jobDescriptionController.text
      }),
    );
    if (Chatgpt.statusCode == 200) {
      var temp = Chatgpt.body;
      chatid = Chatgpt.headers['x-assistant-id'];
      setState(() {
        _messages.add(temp);
      });
      return '';
    } else {
      // If the profile request failed,
      // then throw an exception.
      throw Exception('Failed to get user profile.');
    }
  }

  Future<String> Chatgptresponse() async {
    final token = SharedState.bearerToken();
    final Chatgpt = await http.post(
      Uri.parse('http://localhost:3001/assistant/chat/$chatid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'message': _messageController.text,
      }),
    );
    if (Chatgpt.statusCode == 200) {
      var temp = Chatgpt.body;
      setState(() {
        _messages.add(temp);
      });
      return '';
    } else {
      // If the profile request failed,
      // then throw an exception.
      throw Exception('Failed to get user profile.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _cvController,
                decoration: const InputDecoration(
                  hintText: 'Insert your CV...',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _jobDescriptionController,
                decoration: const InputDecoration(
                  hintText: 'Insert job description...',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_cvController.text.isNotEmpty &&
                    _jobDescriptionController.text.isNotEmpty) {
                  setState(() {
                    _isButtonPressed = true;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text('Loading'),
                        content: CircularProgressIndicator(),
                      );
                    },
                  );
                  await Chatgpt();
                  Navigator.of(context).pop(); // Close the loading dialog
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Form Incomplete'),
                        content: const Text(
                            'Please fill out the form before starting the chat.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('start chat'),
            ),
            const SizedBox(height: 16),
            const Text(
              'What job are you trying to get',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                      ),
                      enabled: _isButtonPressed ? true : false,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _isButtonPressed
                        ? () {
                            Chatgptresponse();
                            setState(() {
                              _sendMessage();
                            });
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
